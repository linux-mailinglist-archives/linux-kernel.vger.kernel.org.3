Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D95586AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiHAMZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiHAMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C358C8DD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659355501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAFx/nR5JRxzgXY+0POxZcF09LGwe2BEj2vlxuyMKXI=;
        b=byDQGecULH0q/lYUtMAKg4ENf8epoz0ym2mDppRhwUUp7ixdYHyHF8jxQmWYMoeOVTuu5u
        V8kwUx1lCOFLcUrvWgZDOzuKPM1ou7n7zQ7IgUhg80vRhwm1mHqD2lN07fBnQ6GItYSd8G
        4mTIlFEmP+fp6RkOSMwWv7vmd9mxGSk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-1wEvXxh6P-yrQgqA_0UQFQ-1; Mon, 01 Aug 2022 08:05:00 -0400
X-MC-Unique: 1wEvXxh6P-yrQgqA_0UQFQ-1
Received: by mail-wm1-f71.google.com with SMTP id bh18-20020a05600c3d1200b003a32044cc9fso5105338wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nAFx/nR5JRxzgXY+0POxZcF09LGwe2BEj2vlxuyMKXI=;
        b=m/eZt9/4SCcC2t3UIERpavbNHSKl+A8DgOKaqJcDkBgA63Zu5BCI7DJywFfCV1W03D
         2GxtsKaE+gyTjRR1TrU8inySlfxoFKDfcUZzqbR1ducc59poPEI3i5hnKG7zmBvZlpmO
         t2Y5vyVBPVZH+hLIOdhHpeYHvF74f38HIcQhN3X5D/RVAp+6VUmdfH8JVnR+jsi86503
         V96TA/VEa6vHGmcgwubl7soi6yFhZ/Nucby1n9qGFN+bnmpj/lTyGGOgo3pYoOqCX7v+
         Sa5+4tyQpRKIdC8j1yc4dtmfedaiACXMxbSHcbzm3/ZtNRTf/WZOaKyI+PCOtm4n+bQB
         Mb2w==
X-Gm-Message-State: ACgBeo34/OQh5qASbDi7CbFoktvK6pOTSnbJkgttUEEiNWITLLZABULK
        X4JzmhIrpHee2uAhAvjf4ok7wYYaPHdNOLXGGO2571HfkstAoTlWsSR2Eyku2Ntcc1vEtrtF7qg
        q6ZVVd7dW2v2ajlpq2V97QGNF
X-Received: by 2002:a5d:5b18:0:b0:220:63db:c7ca with SMTP id bx24-20020a5d5b18000000b0022063dbc7camr2330062wrb.719.1659355498741;
        Mon, 01 Aug 2022 05:04:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4WhA7Gu8I94G14EK2BGE5HtXyv2sE5bayVydnVs25b6svQ5MUeXsCZln3fHArfJ7k0WuOhYw==
X-Received: by 2002:a5d:5b18:0:b0:220:63db:c7ca with SMTP id bx24-20020a5d5b18000000b0022063dbc7camr2330033wrb.719.1659355498440;
        Mon, 01 Aug 2022 05:04:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00? (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de. [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b003a03185231bsm9034633wms.31.2022.08.01.05.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 05:04:58 -0700 (PDT)
Message-ID: <a6f28a45-ee0a-183f-fa60-28a56e1c506c@redhat.com>
Date:   Mon, 1 Aug 2022 14:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, quic_pkondeti@quicinc.com,
        pasha.tatashin@soleen.com, sjpark@amazon.de, sieberf@amazon.com,
        shakeelb@google.com, dhowells@redhat.com, willy@infradead.org,
        liuting.0x7c00@bytedance.com, minchan@kernel.org,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <6168cf49-bf75-2ebb-ab55-30de473835e3@redhat.com>
 <a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com>
 <3fc8a61b-ad70-8092-9197-4920e0897593@redhat.com>
 <f670c6ee-1c20-570f-68f9-42a3e1e85557@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f670c6ee-1c20-570f-68f9-42a3e1e85557@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.22 13:50, Charan Teja Kalla wrote:
> Thanks David!!
> 
> On 8/1/2022 2:00 PM, David Hildenbrand wrote:
>>> Having said that, I am open to go for call_rcu() and infact it will be a
>>> much simple change where I can do the freeing of page_ext in the
>>> __free_page_ext() itself which is called for every section there by
>>> avoid the extra tracking flag PAGE_EXT_INVALID.
>>>       ...........
>>>         WRITE_ONCE(ms->page_ext, NULL);
>>> 	call_rcu(rcu_head, fun); // Free in fun()
>>>        .............
>>>
>>> Or your opinion is to use call_rcu () only once in place of
>>> synchronize_rcu() after invalidating all the page_ext's of memory block?
>>
>> Yeah, that would be an option. And if you fail to allocate a temporary
>> buffer to hold the data-to-free (structure containing rcu_head), the
>> slower fallback path would be synchronize_rcu().
>>
> 
> I will add this as a note in the code that in future If some
> optimizations needs to be done in this path, this option can be
> considered.  Hope this will be fine for now?

IMHO yes. But not need to add all these details to the patch description
(try keeping it short and precise). You can always just link to the
discussion, e.g., via

https://lkml.kernel.org/r/a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com

-- 
Thanks,

David / dhildenb

