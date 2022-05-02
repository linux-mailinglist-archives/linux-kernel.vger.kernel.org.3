Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84310516B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358966AbiEBHzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiEBHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DA502C643
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651477898;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rl14DS8awHFv+JBdruHpEbheLcyZwCqVXY9Y6bJisC4=;
        b=IwxWBoeOkp14VZWZMWpKar2zy0dfLYl7pkFduSTGjv3cMvmogwiGTmeRv3+JWbG+Ld5saf
        OVacg93u4xb4+bxOkh04ZzYyyD6C91J2xV3e65mYtRuujbnEhHC6figHf9x1RTc3YTyjiR
        8y8X8ss+Ez+uxh2Czvpkfcz0xutjtJk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-F1M6lgvkOWmiCTPp9K9jMA-1; Mon, 02 May 2022 03:51:33 -0400
X-MC-Unique: F1M6lgvkOWmiCTPp9K9jMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5BC21C05148;
        Mon,  2 May 2022 07:51:32 +0000 (UTC)
Received: from [10.72.12.86] (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 745B6C52C80;
        Mon,  2 May 2022 07:51:26 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 13/18] KVM: arm64: Support
 SDEI_EVENT_{COMPLETE,COMPLETE_AND_RESUME} hypercall
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-14-gshan@redhat.com> <Ym4tzRL0iMxyumJe@google.com>
 <ba094956-2e58-4913-527a-af79475ee949@redhat.com>
 <Ym+KdY2y2vzMeDOL@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <e5b527a6-2774-20ef-5a04-43abb43c4812@redhat.com>
Date:   Mon, 2 May 2022 15:51:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Ym+KdY2y2vzMeDOL@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 5/2/22 3:38 PM, Oliver Upton wrote:
> On Mon, May 02, 2022 at 02:19:30PM +0800, Gavin Shan wrote:
>> On 5/1/22 2:50 PM, Oliver Upton wrote:
>>> On Sun, Apr 03, 2022 at 11:39:06PM +0800, Gavin Shan wrote:
>>>> This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
>>>> They are used by guest to notify the completion of event in its
>>>> handler. The previously interrupted or preempted context is restored
>>>> like below.
>>>>
>>>>      * x0 - x17, PC and PState are restored to what values we had in
>>>>        the interrupted or preempted context.
>>>>
>>>>      * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
>>>>        is injected.
>>>
>>> I don't think that's how COMPLETE_AND_RESUME works. The caller specifies an
>>> address at which it would like to begin execution within the client
>>> exception level.
>>>
>>> SDEI spec suggests this behaves like a synchronous exception. DEN 0054C
>>> 5.2.2 'Event Resume Context' speaks more about how it is supposed to
>>> work.
>>>
>>
>> It's actually the linux convention. If the event handler, which was
>> specified in previous hypercall to EVENT_REGISTER, returns success,
>> the (linux) client calls into COMPLETE_AND_RESUME and the resume
>> address is specified with FIQ vector offset. More details can be
>> found from arch/arm64/kernel::sdei.c::do_sdei_event().
> 
> Right -- but look at what its doing. It returns the address at which it
> wants to resume execution.
> 
> arch/arm64/kernel.entry.S::__sdei_asm_handler winds up passing this as
> an argument to COMPLETE_AND_RESUME. Also, what would happen if we run
> something that isn't Linux inside of KVM? This is why I suggested
> implementing COMPLETE_AND_RESUME in line with the specification, not
> based on what the kernel is presently doing.
> 

Indeed. The address for the resumed execution is passed by x1 when
COMPLETE_AND_RESUME is called. I will figure this out in next revision.
I don't think we can have the assumption that the guest is linux.

Thanks again for your review and comments :)

Thanks,
Gavin

