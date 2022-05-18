Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1395D52B063
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiERCFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiERCFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:05:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1EE4EDDB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:05:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q18so431478pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LTzZZo8D+5Du0rxBbjk5eF+x+AqMl06jOGEATBS3GLY=;
        b=JuSZkcy7MCyUH66J1RxNC4xEF+Q6KMO5cwdpzZb5goYHQ1EQQiYHyrj+9iVYevbrdz
         r3VImpkpHI6N8FFiPYJlHre9SdPGSukcYARWEn77gpZ6hJfy1HKb2C0eexCLo1dT6f2S
         GW+xnrDipIeASuL8WbgB2isa6z7LZI4gBi4HDZfrjD27U9X9zIYN7/yboMM7bfCjUydV
         GwjuaETv81jPoC1fw/3u5TeHj1j0tj6iwg98kSd+7+BM2TziyfNAI5DQ9cMwI3vXkz2N
         ksocnfjPtkGzMDAU2HoPFN8gEuAI4H0m4w8AsYkrkcZl44KVKOTqhY3b0xf6q/7SFART
         BE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LTzZZo8D+5Du0rxBbjk5eF+x+AqMl06jOGEATBS3GLY=;
        b=P8Hnax1MjObVo2G/3ZBDv+mAzS1ttu71w4gUQnTPKa3kShdLpsGectGXrGYKU/Kg7z
         F2MFSPJmcX54OZSt1Cdz8iebmDeazfHH5NMrP/V2CFwzr4H/8j+w2+w+5GzYJjJo8PQV
         4FE0W0rsyVsu49DDwT23HlwuQSzP3J1TBg58Jf3pptevXvxmgi8wkxhyphnzuPuhnSC+
         fjoUdyetsK3+mW573sP/bDgzUaT9HSDVdr/1fMMm1ZYl9JtBv9C3VjFFnK06ZZi6rJcZ
         WaucL3Uaf/Xv0FqdeV6ZL34ENEZ9zbH+gD6fexiqeO58a08hANsoEHl/xg9KT5VgXoo/
         kUCA==
X-Gm-Message-State: AOAM533UQkePPsnseMgZ5AabX2+GYHhQlZOOiCV9ztx5Z6ynHuackC5I
        Eo1aKQNuMchkmQV6ogYN1in+wg==
X-Google-Smtp-Source: ABdhPJwa0zLrKVZRz/keY4e35GEZGyYydjGhUr97vw4DQ/zSqxYf5fdPcw/2g+HZxl7MjXQ7A49LXA==
X-Received: by 2002:a17:90a:4587:b0:1de:c6ee:80f with SMTP id v7-20020a17090a458700b001dec6ee080fmr36963878pjg.196.1652839536580;
        Tue, 17 May 2022 19:05:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gc10-20020a17090b310a00b001df313f6628sm2324527pjb.21.2022.05.17.19.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 19:05:35 -0700 (PDT)
Message-ID: <a40e75a9-6c18-e859-9850-54f2f5f45c71@kernel.dk>
Date:   Tue, 17 May 2022 20:05:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v11 00/14] Multi-Gen LRU Framework
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        page-reclaim@google.com
References: <20220518014632.922072-1-yuzhao@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220518014632.922072-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 7:46 PM, Yu Zhao wrote:
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.

Where's the changelog since v10?

-- 
Jens Axboe

