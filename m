Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C084E6E79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356894AbiCYHBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354451AbiCYHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A648566AD9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648191604;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsouGytxzF/421Vl9Qb6fg1tOCzthwpBsJFvMy8Q+wg=;
        b=ezKQ6yhj8jQfIwyxa22AuxH2yX53x3umoGFaWq/MmKHeWx7JPOozH/jTvfMOD6SekjCgU0
        ccn4wbE4L1qeUhS23aH9wo+adIb/ayPVgbTpfJ8ey00MIUrNMchFrSzV68sgZGnhnqbR3h
        XegtQssCv9sBOOvKMlU/pmXKNlnRZzU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-NPp4tiUiMC6YdeRmVNPoEg-1; Fri, 25 Mar 2022 03:00:01 -0400
X-MC-Unique: NPp4tiUiMC6YdeRmVNPoEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6BB0802803;
        Fri, 25 Mar 2022 07:00:00 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C32A454B976;
        Fri, 25 Mar 2022 06:59:55 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 18/22] KVM: arm64: Support SDEI ioctl commands on VM
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-19-gshan@redhat.com> <YjtYuk+Jx1dFPQQ9@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <eae10132-a02d-b341-bdf5-be1b2096be4c@redhat.com>
Date:   Fri, 25 Mar 2022 14:59:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjtYuk+Jx1dFPQQ9@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 3/24/22 1:28 AM, Oliver Upton wrote:
> On Tue, Mar 22, 2022 at 04:07:06PM +0800, Gavin Shan wrote:
>> This supports ioctl commands on VM to manage the various objects.
>> It's primarily used by VMM to accomplish migration. The ioctl
>> commands introduced by this are highlighted as below:
>>
>>     * KVM_SDEI_CMD_GET_VERSION
>>       Retrieve the version of current implementation. It's different
>>       from the version of the followed SDEI specification. This version
>>       is used to indicates what functionalities documented in the SDEI
>>       specification have been supported or not supported.
> 
> Don't we need a way to set the version as well? KVM is very much
> responsible for upholding ABI of older specs. So, if a VMM and guest
> expect SDEI v1.1, we can't just forcibly raise it to something else
> during a migration.
> 
> The PSCI implementation is a great example of how KVM has grown its
> implementation in line with a specification, all the while preserving
> backwards compatibility.
> 

The only information feed by VMM is the exposed events. The events
can't be registered from guest kernel, and raised from host to guest
kernel until it's exposed by VMM. Besides, the exposed events will
be defined staticly in host/KVM as we discussed on PATCH[02/22]. We
also discussed to eliminate those ioctl commands. So I think we needn't
to add KVM_SDEI_CMD_SET_VERSION. Further more, the version is only a
concern to host itself if the migration can be done through the
firmware pseudo system registers since the migration compatibility
is the only concern to VMM (QEMU).

Yes, Currently, 0.1/0.2/1.0 versions are supported by PSCI. 0.1 is
picked until VMM asks for 0.2 and 1.0 explicitly. However, it seems
QEMU isn't using 1.0 PSCI yet and maybe more patch is needed to enable
it.

>>     * KVM_SDEI_CMD_GET_EXPOSED_EVENT_COUNT
>>       Return the total count of exposed events.
>>
>>     * KVM_SDEI_CMD_GET_EXPOSED_EVENT
>>     * KVM_SDEI_CMD_SET_EXPOSED_EVENT
>>       Get or set exposed event
>>
>>     * KVM_SDEI_CMD_GET_REGISTERED_EVENT_COUNT
>>       Return the total count of registered events.
>>
>>     * KVM_SDEI_CMD_GET_REGISTERED_EVENT
>>     * KVM_SDEI_CMD_SET_REGISTERED_EVENT
>>       Get or set registered event.
> 
> Any new UAPI needs to be documented in Documentation/virt/kvm/api.rst
> 
> Additionally, we desperately need a better, generic way to save/restore
> VM scoped state. IMO, we should only be adding ioctls if we are
> affording userspace a meaningful interface. Every save/restore pair of
> ioctls winds up wasting precious ioctl numbers and requires userspace
> take a change to read/write an otherwise opaque value.
> 
> Marc had made some suggestions in this area already that Raghavendra
> experimented with [1], and I think its time to meaningfully consider
> our options. Basically, KVM_GET_REG_LIST needs to convey whether a
> particular register is VM or vCPU state. We only need to save/restore a
> VM state register once. That way, userspace doesn't have to care about
> the underlying data and the next piece of VM state that comes along
> doesn't require an ioctl nr nor VMM participation.
> 
> [1]: http://lore.kernel.org/r/20220224172559.4170192-3-rananta@google.com
> 

Thanks for the pointer to Raghavendra's series. The firmware pseudo
system registers have been classified into VM and VCPU scoped in the
series. I think it fits the SDEI migration requirements very well.
The shared events can even be migrated through the VM scoped firmware
pseudo system registers. However, I don't plan to support it in next
revision (v6) as currently needed events are all private. I may
spend more time to go through Raghavendra's series later.

Thanks,
Gavin

