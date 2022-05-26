Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B155351B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347781AbiEZPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbiEZPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9970232075
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653580369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSb/31fWao51fuvQhRU5QL5Gj3VrxjiuEBRl0z2YmX0=;
        b=eIlusbQIg1HGC9D9g6VZseoQcITCYvlXtpYnRGKjJNR5hGum10QkdT0s5A+0xd0cjdqvqu
        uaNC5x/d9pgPDGuKpRNOLJWz2pzzK5qxEGOaawmtixLVCgIb7y63sIdh//8rAUPOAs7YDD
        Ptvg7PO7x6Csu9YE54X2deGej18SGzI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-ahkW7HgKOnm9MQGoWtDGHA-1; Thu, 26 May 2022 11:52:48 -0400
X-MC-Unique: ahkW7HgKOnm9MQGoWtDGHA-1
Received: by mail-ed1-f72.google.com with SMTP id e3-20020a056402330300b0042b903637bbso1327931eda.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rSb/31fWao51fuvQhRU5QL5Gj3VrxjiuEBRl0z2YmX0=;
        b=S6S0nA/34ZqCy8CwaiB0Er//qHtBUU4HtbXHtwmJqENqow5DPWYsuRc5XZQI9LNGKy
         0beKFk17+4L5NP0fZRxII82Ekel8MKXC6ykYQB4F8TFqNk2YayLyW3lo04Yb9I9CMOso
         CAKUQjw7slhiS+bibIYw15wQmWcd5fBe5WmPlC2t7Z0eCTDL8Zg8xaUDRj3evSK1Yc7Y
         R4/Z6heMSTOlyAg1CFY38r93noT0xUvV1h9t1pOH62S+9BW/PTk0k6BPEGhlCmcsrsSa
         nsmQzg9MkkZa7fvLB9kaXr5HnInYpG74hKLqUdhjbMmBKp1pGdfI1mJdGI0hACXmLDSt
         fmeg==
X-Gm-Message-State: AOAM530C3bMVSjs2JpmWUNA4qEcwF32PKbue3GA9GKyNnoBjknQ8sNBn
        WeCfs7nidLwLDqyM1kDPqflSifUEOj5Hrzxhtyz21HZ7RCaMDwXW4ISiZrg3MFObeXLHihK8XBE
        EBOVycxDcBjae5eWmEeup/gKf
X-Received: by 2002:a17:907:7b8f:b0:6fe:fcae:615a with SMTP id ne15-20020a1709077b8f00b006fefcae615amr15729289ejc.658.1653580367257;
        Thu, 26 May 2022 08:52:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYhN/upHIsj/j2UEamiuyv1JioyxHM/yRSgGRL8HEX8U32cH0n4xTzIeNkrc6lCiN/uK/20w==
X-Received: by 2002:a17:907:7b8f:b0:6fe:fcae:615a with SMTP id ne15-20020a1709077b8f00b006fefcae615amr15729271ejc.658.1653580367005;
        Thu, 26 May 2022 08:52:47 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id w15-20020a17090652cf00b006fed8dfcf78sm619667ejn.225.2022.05.26.08.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 08:52:46 -0700 (PDT)
Message-ID: <a1fbab86-ece9-82e3-64fe-0a19a125513b@redhat.com>
Date:   Thu, 26 May 2022 17:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86/MMU: Zap non-leaf SPTEs when disabling dirty
 logging
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
References: <20220525230904.1584480-1-bgardon@google.com>
 <a3ea7446-901f-1d33-47a9-35755b4d86d5@redhat.com>
 <Yo+O6AqNNBTg7BMY@xz-m1.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yo+O6AqNNBTg7BMY@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 16:30, Peter Xu wrote:
> On Thu, May 26, 2022 at 02:01:43PM +0200, Paolo Bonzini wrote:
>> On 5/26/22 01:09, Ben Gardon wrote:
>>> +		WARN_ON(max_mapping_level < iter.level);
>>> +
>>> +		/*
>>> +		 * If this page is already mapped at the highest
>>> +		 * viable level, there's nothing more to do.
>>> +		 */
>>> +		if (max_mapping_level == iter.level)
>>> +			continue;
>>> +
>>> +		/*
>>> +		 * The page can be remapped at a higher level, so step
>>> +		 * up to zap the parent SPTE.
>>> +		 */
>>> +		while (max_mapping_level > iter.level)
>>> +			tdp_iter_step_up(&iter);
>>> +
>>>    		/* Note, a successful atomic zap also does a remote TLB flush. */
>>> -		if (tdp_mmu_zap_spte_atomic(kvm, &iter))
>>> -			goto retry;
>>> +		tdp_mmu_zap_spte_atomic(kvm, &iter);
>>> +
>>
>> Can you make this a sparate function (for example
>> tdp_mmu_zap_collapsible_spte_atomic)?  Otherwise looks great!
> 
> There could be a tiny downside of using a helper in that it'll hide the
> step-up of the iterator, which might not be as obvious as keeping it in the
> loop?

That's true, my reasoning is that zapping at a higher level can only be 
done by first moving the iterator up.  Maybe 
tdp_mmu_zap_at_level_atomic() is a better Though, I can very well apply 
this patch as is.

Paolo

