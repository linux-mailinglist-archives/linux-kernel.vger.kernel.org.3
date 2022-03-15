Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0757F4D9E50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiCOPEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiCOPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED4C932ED9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647356611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSX+faho8xqDoVPijM+rIMu9Kx34W1Ic4d6/tlFnRWo=;
        b=M73Ex80s9SgLc1C+3Brye3BLi/eD7dl+PVOItGUeIkErrXJ1Wuxdg1Qjz8mPSaNjtgRCx+
        fH7NXhJpHWfYg8CQqDuwOD9qulpjMeTiVemy8vBqLbbhNWaBXNQsyaAp1rQl6KIlC9oi8b
        W9Cq3Mzoh0JZFjsQ0VQjsFIcHVQ3gbE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-9hHA8st6Ma2mkR3m_jbFsQ-1; Tue, 15 Mar 2022 11:03:30 -0400
X-MC-Unique: 9hHA8st6Ma2mkR3m_jbFsQ-1
Received: by mail-oi1-f198.google.com with SMTP id x15-20020a54400f000000b002d9be4bd8a2so14327076oie.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mSX+faho8xqDoVPijM+rIMu9Kx34W1Ic4d6/tlFnRWo=;
        b=upEdSxHyojeIQaQY6K/+692z6k5iLHReVaQ5nb9zpuvfTdsEj1ET+JLNkndLHnbWco
         4a0pu1ABwUqZVYD9cbWwHRTCwaDIyuwRJpNaJWsZ/eHoo6uSCcnHhHFuh8+4dHhm7kAi
         LdMmUu67PEJD3nzSeZnGveCyXrCHTCkvBGXn1eko50KHmgICO0/h4qr9/8/N7DYgNNb3
         BDWmW+ZfS4rPTZihomMsf8LyWpmTS2fN4cvFeJRon86Y7zqLtBCD6qbX9UfyxTf024p7
         cJibcNNRlwPm0+C3Sw5g+n5pHCwUmoAGc54xNRwJ41N5J1nQzMi/AJphIn1bEIKle4vR
         ZuHg==
X-Gm-Message-State: AOAM533+EOk6EgxUcldrpOyXla88xX/Q2e6uDNsQ9tIuZzvkSoxXHciU
        CBw70jQpnZJxcS6/j8wAXKFelIWl8UJwqd462qToQYCKSHg5AyeAddo9MaDlo3tMsUamqJcYNZs
        TgjxoZ/rypoCkTtFMKJbrPq4U
X-Received: by 2002:a05:6808:11c4:b0:2d9:c395:f15e with SMTP id p4-20020a05680811c400b002d9c395f15emr1878770oiv.47.1647356609724;
        Tue, 15 Mar 2022 08:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVPIWyooT0FFEBTsFQHrT1xW8in3OhVEUH8z6AQbt6iwYxScdXWDH/MZW/GaJHAs02XRhdeg==
X-Received: by 2002:a05:6808:11c4:b0:2d9:c395:f15e with SMTP id p4-20020a05680811c400b002d9c395f15emr1878750oiv.47.1647356609398;
        Tue, 15 Mar 2022 08:03:29 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x17-20020a056870b1d100b000d9f73ce6e7sm7911766oak.52.2022.03.15.08.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 08:03:29 -0700 (PDT)
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        lingshan.zhu@intel.com, sgarzare@redhat.com,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220315124130.1710030-1-trix@redhat.com>
 <20220315092656-mutt-send-email-mst@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <512a392d-23d7-c25b-7576-571001f28288@redhat.com>
Date:   Tue, 15 Mar 2022 08:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220315092656-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/22 6:28 AM, Michael S. Tsirkin wrote:
> On Tue, Mar 15, 2022 at 05:41:30AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this issue
>> ifcvf_main.c:49:4: warning: Called function
>>    pointer is null (null dereference)
>>    vf->vring->cb.callback(vring->cb.private);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> The check
>>    vring = &vf->vring[i];
>>    if (vring->cb.callback)
>>
>> Does not match the use.  Change dereference so they match.
>>
>> Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")
> Thanks a lot! I squashed this into the offending patch - no point in
> breaking bisect. Pushed to linux. However I'm now
> having second thoughts about applying that patchset - I'd like
> soma analysis explaining how this got through testing.

static analysis is something i do treewide.

There are currently ~2500 issues in linux-next, do not panic! many are 
false positives.

It is pretty easy to setup and once you have a baseline you can filter 
only your files.

Tom

>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index 3b48e717e89f7..4366320fb68d3 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
>>   	for (i = 0; i < vf->nr_vring; i++) {
>>   		vring = &vf->vring[i];
>>   		if (vring->cb.callback)
>> -			vf->vring->cb.callback(vring->cb.private);
>> +			vring->cb.callback(vring->cb.private);
>>   	}
>>   
>>   	return IRQ_HANDLED;
>> -- 
>> 2.26.3

