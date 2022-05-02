Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B60516B49
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383566AbiEBHcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383588AbiEBHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1A3B580F8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651476517;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EywQlrSHGmaFztkZ6nGxOyoDkOWNb3RCFHAorrh5itE=;
        b=efIw1PXTrPTf7FjTeosoLAFbiyfv7W3g62lYAd41v/jXdxsSANho2S7OS+sIUHZgKltmq2
        2+KEpo8IDMgDdIBLGAp5MVfIZN/jVFkUKhY5CeWCesvrzpIkEWrck67fxU/Bm8He6j4wLm
        lHTpjniLWr/SG8jZRGfOZD1yKRG35f8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-29NrMOZXMyqurb0Nic8wWA-1; Mon, 02 May 2022 03:28:34 -0400
X-MC-Unique: 29NrMOZXMyqurb0Nic8wWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2689F1014A67;
        Mon,  2 May 2022 07:28:34 +0000 (UTC)
Received: from [10.72.12.86] (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19C92112D165;
        Mon,  2 May 2022 07:28:27 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 04/18] KVM: arm64: Support SDEI_EVENT_REGISTER
 hypercall
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-5-gshan@redhat.com> <Ym1Nsaq/ERUx/ebD@google.com>
 <6e7cb20d-24c4-b357-8830-a68ff05638fe@redhat.com>
 <Ym9TarUE6+lJ0izt@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <a6122234-907a-4ede-26fc-872c196c5912@redhat.com>
Date:   Mon, 2 May 2022 15:28:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Ym9TarUE6+lJ0izt@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
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

On 5/2/22 11:43 AM, Oliver Upton wrote:
> On Mon, May 02, 2022 at 10:55:51AM +0800, Gavin Shan wrote:
>>>> +	unsigned long route_mode = smccc_get_arg(vcpu, 4);
>>>
>>> This is really 'flags'. route_mode is bit[0]. I imagine we don't want to
>>> support relative mode, so bit[1] is useless for us in that case too.
>>>
>>> The spec is somewhat imprecise on what happens for reserved flags. The
>>> prototype in section 5.1.2 of [1] suggests that reserved bits must be
>>> zero, but 5.1.2.3 'Client responsibilities' does not state that invalid
>>> flags result in an error.
>>>
>>> Arm TF certainly rejects unexpected flags [2].
>>>
>>> [1]: DEN0054C https://developer.arm.com/documentation/den0054/latest
>>> [2]: https://github.com/ARM-software/arm-trusted-firmware/blob/66c3906e4c32d675eb06bd081de8a3359f76b84c/services/std_svc/sdei/sdei_main.c#L260
>>>
>>
>> Yes, This chunk of code is still stick to old specification. Lets
>> improve in next respin:
>>
>>     - Rename @route_mode to @flags
>>     - Reject if the reserved bits are set.
>>     - Reject if relative mode (bit#1) is selected.
>>     - Reject if routing mode (bit#0) isn't RM_ANY (0).
> 
> Bit[0] is ignored for private events, actually. So we really just reject
> if any of bit[63:1] are set.
> 

It makes sense to me. Thanks for your confirm :)

Thanks,
Gavin

