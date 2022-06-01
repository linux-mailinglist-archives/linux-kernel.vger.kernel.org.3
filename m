Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022D53A3F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbiFALY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348576AbiFALYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0225843AD8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654082690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4PUs9ob3rFRXOUJ6pAeCT9mkJKPX7P0n2Y5sGg8O1A=;
        b=g1aQKsadw8svg0bl1MIbUypk500VMOAOZcL7BtjnPAickCZEryRVVCgtQzCQVbtDm7wvCu
        yOpmpfa7eLaZ0N5cFfZ1w0dNPWwrgjxa+wRUiS5LtInTO6NJnBMzAjpJ9geXOLWX1Wyqg9
        Tg+vvBW2wFowXu0pELGf2XbGpNf+Jx0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-nW7EATt6PnuTStIH1ULTVg-1; Wed, 01 Jun 2022 07:24:41 -0400
X-MC-Unique: nW7EATt6PnuTStIH1ULTVg-1
Received: by mail-ed1-f69.google.com with SMTP id k7-20020aa7d8c7000000b0042dd4a5a393so1049838eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L4PUs9ob3rFRXOUJ6pAeCT9mkJKPX7P0n2Y5sGg8O1A=;
        b=YXWqJAUa8pPApb+DTtTA0wmFZNvCJu0wOfmJcmQPulu31aZ3bEpHUji8s/2t0C2T9Y
         fX6QcYp0GJWNn4h2NdDZoASlOc4N+7EeiNh0rlbtxJDz3UoKyif5dwkgRhRo1eX8N6Rl
         UU14PRnwu/R9QS6tmLlFL7Au1qgR2eDTpeNBvKTvaT+o9lqo0E6wfKv2lvyF5kWv8eGu
         mGFiJeep5tN6W4U48nDZper1DJax395FoUXB5UUh6ROJ6csA1pHb34X74+Oe5oOFptKa
         jP3T2KkTb/UCCzeSxK3e3WkuqQrryY1FKGf6M6okDN9jqItl4qykZTdctHXXEk54zVM+
         gCbg==
X-Gm-Message-State: AOAM531910g9oTUVnOU1+TIAurNVnNz5lmk3IojF1Qz3hV17eBQFI9Z4
        JFpQ6UPeXoKqxWSZd1INRY9RC1abwNjfT5Bwd5UtQS6hMznCVbJpa6PX0iYcrsvDunBMExEYQW2
        BR01Eq1xB039QrHV2cx9rBwoB
X-Received: by 2002:a17:907:8a1a:b0:6fe:b42f:749a with SMTP id sc26-20020a1709078a1a00b006feb42f749amr51574668ejc.451.1654082680324;
        Wed, 01 Jun 2022 04:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn52Ijj5hP478lDBchZorMAll8IKCqIKjCbJOb16jqi9eSneK8Ys/MFnMax8iBFrJNBl0dVw==
X-Received: by 2002:a17:907:8a1a:b0:6fe:b42f:749a with SMTP id sc26-20020a1709078a1a00b006feb42f749amr51574658ejc.451.1654082680140;
        Wed, 01 Jun 2022 04:24:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id my16-20020a1709065a5000b006fecf74395bsm606230ejc.8.2022.06.01.04.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:24:39 -0700 (PDT)
Message-ID: <bb40cfa3-0125-c733-e4fd-da861c068f2c@redhat.com>
Date:   Wed, 1 Jun 2022 13:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86: events: Do not return bogus capabilities if PMU is
 broken
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        Like Xu <likexu@tencent.com>
References: <20220601094256.362047-1-pbonzini@redhat.com>
 <YpdIgm8c5YEFLCCH@worktop.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YpdIgm8c5YEFLCCH@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 13:07, Peter Zijlstra wrote:
> On Wed, Jun 01, 2022 at 05:42:56AM -0400, Paolo Bonzini wrote:
>> From: Like Xu <likexu@tencent.com>
>>
>> If the PMU is broken due to firmware issues, check_hw_exists() will return
>> false but perf_get_x86_pmu_capability() will still return data from x86_pmu.
>> Likewise if some of the hotplug callbacks cannot be installed the contents
>> of x86_pmu will not be reverted.
>>
>> Handle the failure in both cases by clearing x86_pmu if init_hw_perf_events()
>> or reverts to software events only.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> No SoB from Like,

And hardly any code from him either except for a single memset, :) but 
I'll add

	Signed-off-by: Like Xu <likexu@tencent.com>
	Co-developed-by: Like Xu <likexu@tencent.com>

(I have hooks that notice this when pushing, but they don't help with 
git-send-email...).


>> @@ -2982,6 +2985,11 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
>>   
>>   void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>>   {
>> +	if (!x86_pmu.name) {
> 
> We have x86_pmu_initialized(), the implementation is a bit daft, but
> might as well use it here too, no?

Yes, thanks.

Paolo

