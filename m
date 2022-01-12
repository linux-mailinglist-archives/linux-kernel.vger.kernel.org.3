Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A177F48BEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351193AbiALHY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237408AbiALHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641972266;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/5pK0Zr6DD8A5nn05o+mZc3e8AW7Gue1WA4ZvFpbm8=;
        b=gdcR6TFOwJdBTrz53uY1xPE8F1d6PFlPDuEJO50LUy5FDW+aFRx32UT7TNUExcjIB1PT02
        sy+Ug+jpjUGpTxQdr0UklM1YZo2A5Nxv4gzVfF0QWT1lJtgA6Xo2SLKp0wxR+6VPZKjqjI
        mtFAVH3VLpus6PBkHxfWdB9ohirMlvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-PyQcd5q3MT2vf5hnsOavGw-1; Wed, 12 Jan 2022 02:24:20 -0500
X-MC-Unique: PyQcd5q3MT2vf5hnsOavGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 753E713EA;
        Wed, 12 Jan 2022 07:24:19 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 460D95F92B;
        Wed, 12 Jan 2022 07:24:15 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 00/21] Support SDEI Virtualization
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <eee7eeb2-cedf-e52f-1e5f-403d9edabd94@redhat.com>
 <7f5e86dd-b38d-8699-58bd-35db78ec1b7a@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <cb75497e-6e24-3b9e-36b2-a80a6478c439@redhat.com>
Date:   Wed, 12 Jan 2022 15:24:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <7f5e86dd-b38d-8699-58bd-35db78ec1b7a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 10:29 PM, Eric Auger wrote:
> On 8/15/21 2:19 AM, Gavin Shan wrote:
>> On 8/15/21 10:13 AM, Gavin Shan wrote:
>>> This series intends to virtualize Software Delegated Exception Interface
>>> (SDEI), which is defined by DEN0054A. It allows the hypervisor to deliver
>>> NMI-alike event to guest and it's needed by asynchronous page fault to
>>> deliver page-not-present notification from hypervisor to guest. The code
>>> and the required qemu changes can be found from:
>>>
>>>      https://developer.arm.com/documentation/den0054/latest
>>>      https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>>>      https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
>>>
>>> The SDEI event is identified by a 32-bits number. Bits[31:24] are used
>>> to indicate the SDEI event properties while bits[23:0] are identifying
>>> the unique number. The implementation takes bits[23:22] to indicate the
>>> owner of the SDEI event. For example, those SDEI events owned by KVM
>>> should have these two bits set to 0b01. Besides, the implementation
>>> supports SDEI events owned by KVM only.
>>>
>>> The design is pretty straightforward and the implementation is just
>>> following the SDEI specification, to support the defined SMCCC intefaces,
>>> except the IRQ binding stuff. There are several data structures
>>> introduced.
>>> Some of the objects have to be migrated by VMM. So their definitions are
>>> split up for VMM to include the corresponding states for migration.
>>>
>>>      struct kvm_sdei_kvm
>>>         Associated with VM and used to track the KVM exposed SDEI events
>>>         and those registered by guest.
>>>      struct kvm_sdei_vcpu
>>>         Associated with vCPU and used to track SDEI event delivery. The
>>>         preempted context is saved prior to the delivery and restored
>>>         after that.
>>>      struct kvm_sdei_event
>>>         SDEI events exposed by KVM so that guest can register and enable.
>>>      struct kvm_sdei_kvm_event
>>>         SDEI events that have been registered by guest.
>>>      struct kvm_sdei_vcpu_event
>>>         SDEI events that have been queued to specific vCPU for delivery.
>>>
>>> The series is organized as below:
>>>
>>>      PATCH[01]    Introduces template for smccc_get_argx()
>>>      PATCH[02]    Introduces the data structures and infrastructure
>>>      PATCH[03-14] Supports various SDEI related hypercalls
>>>      PATCH[15]    Supports SDEI event notification
>>>      PATCH[16-17] Introduces ioctl command for migration
>>>      PATCH[18-19] Supports SDEI event injection and cancellation
>>>      PATCH[20]    Exports SDEI capability
>>>      PATCH[21]    Adds self-test case for SDEI virtualization
>>>
>>
>> [...]
>>
>> I explicitly copied James Morse and Mark Rutland when posting the series,
>> but something unknown went wrong. I'm including them here to avoid
>> reposting the whole series.
> I don't see James nor Mark included here either
> 

Yeah, I used the following command to post the series, but I don't know
why James/Mark are missed. I'm not sure it's git-sendemail issue or not
so far. The issue appears some times on my laptop :)

# git-sendemail --to=<mail0> --cc=<mail1> --cc=<mail2> *.patch

Thanks,
Gavin

