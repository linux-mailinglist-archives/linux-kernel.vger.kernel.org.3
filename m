Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C130053D9E2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 06:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348805AbiFEE2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 00:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiFEE22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 00:28:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9881958B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 21:28:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so10074075pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 21:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cwL2wHcA34X3qXSJRLp9vC/RDXcQCiZVTt+d5U9lstk=;
        b=2VOwiJZp5DrIJXyOlgpB6VfK40D/XqlM2qapqxtFAZMjZMOMHTJFFkULcMMCP6JArV
         87gJxVxrXOesZpMAzFjvBoZNfijEo6hJbiWSYNwhTxcfUJF4V3dVGMaKax7nChHJabyX
         UMUYGw90KXmANZKYS886MNSWBEJPgITEhpSgfiVKJ5NqSzto8yjP0IwUSTYz0OohkL88
         BMWiGS3MYCEoAKKMAt+edZZJlkOX9PoMuP12bSKAEDeIk6r5TwF4RK/mC4P8jRPThBIm
         E0TkMyZpGS1/e76IsxNQ1A6tCp7MMhyU/lp6xThIH8z7iv3HJCmmDq0l+G2PwjmWEnqx
         SnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cwL2wHcA34X3qXSJRLp9vC/RDXcQCiZVTt+d5U9lstk=;
        b=Ab2criPKiATQrPYzx/9H9iYLQAEIBB7OiZek2FCc8VXNCxjdV7kPGn476Q81KHirOD
         zXdhGbgEx81e0O0kkpiAN2RQyY+2LcKnVJh0m8rvoOyi7D1wvyqeqSXR1tqV9T/SLSFA
         ejlYKr/irDKesVpxmeTueTt2XUnXmdcBENXCrrBOlARupI0P3A359o8AuLRuLB2Xd/RG
         MJVORrItRKmXGCtN4jGz1NJ8r/tNWwykg2f3jTWd8S+xom4rbI+p9mqxnafd0pHxlvmQ
         GBcx8fwUvzqLt0V5Vo1LvYzb7NPTe9xU+KdfT/Fxzr3pRyZGSZKt7VcPQTEZbllYQN6u
         PjSw==
X-Gm-Message-State: AOAM533SLN5hbmu9jF14S6hrpDrIXTlGQfiQtqVWTVAP0fOAE5PGAZA4
        tV6PINGcF6SYwMEGR9FU5wVBVU8wOvsSWQ==
X-Google-Smtp-Source: ABdhPJwwme7JJVfs5BR6bWdb7PU9V2aWDGFRO/Qd+1CJvHyMOMIPgOQ5SnHjMPt2rjR5Fm2enliMHA==
X-Received: by 2002:a17:90a:17c9:b0:1e8:5e58:f658 with SMTP id q67-20020a17090a17c900b001e85e58f658mr4940749pja.239.1654403306417;
        Sat, 04 Jun 2022 21:28:26 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b0015e8d4eb2adsm7927589pll.247.2022.06.04.21.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 21:28:25 -0700 (PDT)
Message-ID: <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
Date:   Sun, 5 Jun 2022 12:24:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
 <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/22 02:56, Andrew Morton wrote:
> On Sat,  4 Jun 2022 18:32:29 +0800 zhenwei pi <pizhenwei@bytedance.com> wrote:
> 
>> Currently unpoison_memory(unsigned long pfn) is designed for soft
>> poison(hwpoison-inject) only. Unpoisoning a hardware corrupted page
>> puts page back buddy only, this leads BUG during accessing on the
>> corrupted KPTE.
>>
>> Do not allow to unpoison hardware corrupted page in unpoison_memory()
>> to avoid BUG like this:
>>
>>   Unpoison: Software-unpoisoned page 0x61234
>>   BUG: unable to handle page fault for address: ffff888061234000
> 
> Thanks.
> 
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2090,6 +2090,7 @@ int unpoison_memory(unsigned long pfn)
>>   {
>>   	struct page *page;
>>   	struct page *p;
>> +	pte_t *kpte;
>>   	int ret = -EBUSY;
>>   	int freeit = 0;
>>   	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>> @@ -2101,6 +2102,13 @@ int unpoison_memory(unsigned long pfn)
>>   	p = pfn_to_page(pfn);
>>   	page = compound_head(p);
>>   
>> +	kpte = virt_to_kpte((unsigned long)page_to_virt(p));
>> +	if (kpte && !pte_present(*kpte)) {
>> +		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
>> +				 pfn, &unpoison_rs);
>> +		return -EPERM;
>> +	}
>> +
>>   	mutex_lock(&mf_mutex);
>>   
>>   	if (!PageHWPoison(p)) {
> 
> I guess we don't want to let fault injection crash the kernel, so a
> cc:stable seems appropriate here.
> 
> Can we think up a suitable Fixes: commit?  I'm suspecting this bug has
> been there for a long time?
> 

Sure!

2009-Dec-16, hwpoison_unpoison() was introduced into linux in commit:
847ce401df392("HWPOISON: Add unpoisoning support")
...
There is no hardware level unpoisioning, so this cannot be used for real 
memory errors, only for software injected errors.
...

We can find that this function should be used for software level 
unpoisoning only in both commit log and comment in source code. 
unfortunately there is no check in function hwpoison_unpoison().


2020-May-20, 17fae1294ad9d("x86/{mce,mm}: Unmap the entire page if the 
whole page is affected and poisoned")

This clears KPTE, and leads BUG(described in this patch) during 
unpoisoning the hardware corrupted page.


Fixes: 847ce401df392("HWPOISON: Add unpoisoning support")
Fixes: 17fae1294ad9d("x86/{mce,mm}: Unmap the entire page if the whole 
page is affected and poisoned")

Cc: Wu Fengguang <fengguang.wu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>.

-- 
zhenwei pi
