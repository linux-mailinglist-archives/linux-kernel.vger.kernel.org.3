Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4087B534FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiEZNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiEZNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:04:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9BCCFE3E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:04:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f21so1658729pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pBzDjNM+NIKrQwzz6yoXDKmfszuTKOxi+7+JN/0QvnU=;
        b=RYYRlQm8mMja6NCqEmTYUzwWQzF8s9wysfsvug3GrnVY6UaaQEwJ7hilPDM6zY4Ekz
         NP+VQzOI+ku/PYKSbFsJ7EdcoapEqjDGliUIWWnN0lyR7EvknmBYVVWuTpl0MJmIFkZs
         9UH+r6eyPOXlbJjqIk4JMqpe3nh9qG928VTyNnDEsG/6kEsvPghzIXFb/JIWpk4ipQ8e
         Gk4My12oty0cIGixSF8vPpc5L0EZ2C51j/I6w6pWo0xgZv1GXZL2iZwyBu27UnNzGvWF
         wWtwA3pZv5Aq6TfpBr76ZD/aYnttA04WZuveVZal+HS7Nq8ojp/mhD9vCTO26i/aUevw
         8OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pBzDjNM+NIKrQwzz6yoXDKmfszuTKOxi+7+JN/0QvnU=;
        b=ZwBwfLvId3pBHblMsP+DQdoVv5mi+u3r4S7vjXdhQAvfSlQekV72RUogeC/S7Ra2BZ
         JsZEthK8PL6318h+k+1s8X0K95i6+YG02rB3OsGEDyjjb+6jedF5cWD2vt/QbofWmBEG
         H1SUVrTnHoxFno7v0cwc6WE1QbfiUxn2/KtJof0dUrh8v1nnDt1X7c1NheDPTwaTgzlE
         CMOxMAzl3BMWetQbkzPYsLETBaTuMjTlVJoZRj6e6ZLftmiFOFsLWxRF/y9sw65iBIyL
         ivCbo+PpcHDjXcRGVZZ3CjzAOlfB5GPMmEoPI5ozvKg8P3tSdPAIgQhPunCu6GxcmVvL
         Zh+g==
X-Gm-Message-State: AOAM531EfTqnDs2ktyEX+2xMoxpHiUZWJ/3dx/BvlUbV37fv/i/zIHW7
        BWAOHh/RRjrly6rCPBAKV0Hfdg==
X-Google-Smtp-Source: ABdhPJyI+Gw9YzU040OsLcgsCaXngKdpfhzznfZfcU8k9dTvc3YHSPNd4XgLYgnxtJ/BHuCRqqgbVQ==
X-Received: by 2002:a05:6a00:1a11:b0:512:6f59:f5cf with SMTP id g17-20020a056a001a1100b005126f59f5cfmr25386849pfv.45.1653570297993;
        Thu, 26 May 2022 06:04:57 -0700 (PDT)
Received: from [10.5.103.226] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902b20900b001621ce92196sm1470044plr.86.2022.05.26.06.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 06:04:57 -0700 (PDT)
Message-ID: <09f38cf3-282a-61fa-9916-057b01b57d30@bytedance.com>
Date:   Thu, 26 May 2022 21:04:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        pasha.tatashin@soleen.com
Cc:     rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220526113350.30806-1-linmiaohe@huawei.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20220526113350.30806-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/26 7:33 PM, Miaohe Lin wrote:
> ptep is unmapped too early, so ptep will be accessed while it's unmapped.
> Fix it by deferring pte_unmap() until page table checking is done.

In the beginning, page_table_check only supported x86_64, so there
is no problem. But then the commit 3fee229a8eb9 ("riscv/mm: enable
ARCH_SUPPORTS_PAGE_TABLE_CHECK") added support for riscv-32, it is 
indeed a problem in this case.

So:

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 
> Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_table_check.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 3692bea2ea2c..971c3129b0e3 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -234,11 +234,11 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
>   		pte_t *ptep = pte_offset_map(&pmd, addr);
>   		unsigned long i;
>   
> -		pte_unmap(ptep);
>   		for (i = 0; i < PTRS_PER_PTE; i++) {
>   			__page_table_check_pte_clear(mm, addr, *ptep);
>   			addr += PAGE_SIZE;
>   			ptep++;
>   		}
> +		pte_unmap(ptep);
>   	}
>   }

-- 
Thanks,
Qi
