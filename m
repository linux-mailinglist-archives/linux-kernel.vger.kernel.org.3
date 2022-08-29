Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB65A44E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiH2IS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiH2ISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:18:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11985722A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:18:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x23so7253312pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2QZKujPjtkBWYkXnUOgTQaHomGYPSRRsNUAaVRPYFmo=;
        b=XjlvkNLxJIBSm9qs1DUSUgMuMgLILSs0DYrRUK/HoUSesO2OeX0vjKMsXT7Ep7aY8P
         nNt3CWi8bV1m9XVoRZJVEEU2ZEydvzZ4V3FtktM0AkRXo492mcsf+sAszwHd7sXwz6ks
         jB36bF29x75eB3gA5nxbdfHRCj+CSwBBd5H+bxH0JSAvW853GJn7ktenqrr3uNFD4+hp
         5NPVt3OQlfY3+/8bq+H41sglPpQDcsHW97cnzNHnRbDwQtvozasufBLP040is7XxjQUY
         VPnGDti7mEnuDzQfDoE2tdZSSrj+f/LpTqZpdHUTOjYpapeYsFCvivbAWzbJU0GgJs/Y
         o77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2QZKujPjtkBWYkXnUOgTQaHomGYPSRRsNUAaVRPYFmo=;
        b=4XptiE1xMRIpmhdd44QBdBmj72Rf5qvwNWK+aFlnUsw9yqW1q5Vb+H9NtqD9BKMSo5
         cUJAwb+vCHMxF78Xv0gA0aydFtrVicQhau9z2LEz8zCoV1G7SoLkanmprUYvRalgKXsN
         OmeMMe5O2S85d/JNetqBe3lQ5x2lPHr/TTyfJtmcSh9/irTD+2FSg9zs06jAXvsqtxMZ
         +ZUObDsHCO8Ld5NyjDr7htEMp1VWlQuAiDfdSItzNtLm0pYRVJYiNufcyjXWXSXwMrq/
         nStCTE6R72LHLV1FUHTxefvnXqUX6evm10yDaKmf0gPhNfM/yu9MrpyEqalcnnmIn69f
         LUhw==
X-Gm-Message-State: ACgBeo1A+gvljAeMVV6XkJnvvxYbWt1QpS2N+DDqSBdGTl/qNZBZMR9q
        iAXWESaQVhVRSiybF8JNJiI2rg==
X-Google-Smtp-Source: AA6agR7xWObiHeZvPXlzNdhLaj3EUEIrEQSpFNVFbH0mh4Xc+UmHlLobw2C9t4ZEXaTuKG0H+6vkrg==
X-Received: by 2002:a17:90b:c18:b0:1fd:b908:7a43 with SMTP id bp24-20020a17090b0c1800b001fdb9087a43mr5866952pjb.218.1661761130345;
        Mon, 29 Aug 2022 01:18:50 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016cb873fe6fsm4829587pln.183.2022.08.29.01.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2022 01:18:49 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     vbabka@suse.cz
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, corbet@lwn.net,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        mark-pk.tsai@mediatek.com, mhiramat@kernel.org, mhocko@suse.com,
        rostedt@goodmis.org
Subject: Re: [PATCH v4] page_ext: introduce boot parameter 'early_page_ext'
Date:   Mon, 29 Aug 2022 16:18:37 +0800
Message-Id: <20220829081837.38225-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <68133fc4-7034-c07b-f14b-5b4e73e04d2c@suse.cz>
References: <68133fc4-7034-c07b-f14b-5b4e73e04d2c@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Aug 2022 12:49:25 +0200, vbabka@suse.cz wrote:
>On 8/26/22 06:23, Andrew Morton wrote:
>> On Thu, 25 Aug 2022 18:27:14 +0800 lizhe.67@bytedance.com wrote:
>> 
>>> From: Li Zhe <lizhe.67@bytedance.com>
>>> 
>>> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>>> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>>> problem. It seems that we cannot track early page allocations in current
>>> kernel even if page structure has been initialized early.
>>> 
>>> This patch introduce a new boot parameter 'early_page_ext' to resolve this
>>> problem. If we pass it to kernel, function page_ext_init() will be moved
>>> up and feature 'deferred initialization of struct pages' will be disabled
>>> to initialize the page allocator early and prevent from the panic problem
>>> above. It can help us to catch early page allocations. This is useful
>>> especially when we find that the free memory value is not the same right
>>> after different kernel booting.
>>> 
>> 
>> WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)
>> WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)
>
>Hm it's a very small static inline, shouldn't exist separately anywhere.
>Maybe it's due to that new debug info level thing?
>
>Would this work instead?
>
>----8<----
>diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
>index 884282a7f03a..4bf4e58cf2d4 100644
>--- a/include/linux/page_ext.h
>+++ b/include/linux/page_ext.h
>@@ -40,7 +40,7 @@ extern bool early_page_ext;
> extern unsigned long page_ext_size;
> extern void pgdat_page_ext_init(struct pglist_data *pgdat);
> 
>-static inline bool early_page_ext_enabled(void)
>+static inline bool __meminit early_page_ext_enabled(void)
> {
> 	return early_page_ext;
> }

I think this is also a method to solve this problem.
Due to '__meminit', early_page_ext_enabled() can not be an inline function
now. So if we finally choose this method, I suggest we put function
early_page_ext_enabled() into page_ext.c if CONFIG_PAGE_EXTENSION=y, and
we can make 'early_page_ext' a static variable.
