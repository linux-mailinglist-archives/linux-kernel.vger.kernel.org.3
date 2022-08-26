Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4235A25E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiHZKcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiHZKcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:32:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C045D2768
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:32:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 199so1117920pfz.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wuqOv6Q2WHJryeaZo/bgjwLA2C78VwpKJa5KV+Zo29w=;
        b=5G0gjatnKWvLD6IiMZqkJDH3vBec1+BPrqWG5JRapFkq2SQELWs8bdoBDr3zLQ4O2m
         ToUORBLokZzfB5Zr2MqBrJtaQ7ywCPZJsjcdDyrgk3+DiCDTFWV9j1pSZF+fGuQmGosn
         Z6maqpnLdrjDEdwrMlpig7s06F8Nt/+rnqlLKevC6P+CwS/HiyQoiEGud03Ykdsuy2HZ
         MFSa8HUy6lka2IZwEot7Uv5ZjJpY+lO0M8r4nBXGU8SF2Ao2wBN/44WxOaAff5id93/p
         /Mxi7EX9VAFh+gz4DrTTfKXoxQWCDGIYuzRUSQ0k5ajkoe3e3PYtw6MnMzTfnqOh+4yV
         viWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wuqOv6Q2WHJryeaZo/bgjwLA2C78VwpKJa5KV+Zo29w=;
        b=lVihvN1LhaIxB+k61Y31HRu0kFJbNPV/9HWRmuZj8n2ixa0rEVLNyD3gy+UIrbaqX+
         dvQ5GZbTHmz3YFMe1zkZR3i+K3XFoa3TjQRIqnUBztSQkgODIihYNvOfjvQYoFbpD/dv
         4HojIaR3kzKZH+8gSg8LNFmXpNU5eHZW3eybCa7iwucrS1hLivYlaM6MpGkYecG0W5YI
         EgZ3bfNbK8S+EQQaJFdu/2510pGoTde8Bi3vbz8QU59uBR0LrTCMSsY+1CIbjtJlHf7d
         6WuGUywmRX1UzXp/JIOcg7gxK3ushL/8WXHaz+VDOkalHLJr5ine7hal5tic9pWMi9kA
         YH9w==
X-Gm-Message-State: ACgBeo0SvGTaV06hGNmIGeZ8UemwgW431J2FVE5xVXC9XDfn04mfcJcl
        D6mxvH3/5wAMX48xiApc0qTLahQI6cf2VAoZ
X-Google-Smtp-Source: AA6agR7oM+ZOvnrqUme89chVvcTd9tAj5vskzDUlg5MF6QeOoOQ+AFvBN5KReA7YQ4/gpqtmQq4VWQ==
X-Received: by 2002:aa7:8393:0:b0:537:701d:e7f3 with SMTP id u19-20020aa78393000000b00537701de7f3mr3297443pfm.50.1661509950855;
        Fri, 26 Aug 2022 03:32:30 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id r27-20020aa7963b000000b0052aaff953aesm1357008pfg.115.2022.08.26.03.32.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:32:30 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     akpm@linux-foundation.org
Cc:     Jason@zx2c4.com, corbet@lwn.net, keescook@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com, mark-pk.tsai@mediatek.com,
        mhiramat@kernel.org, mhocko@suse.com, rostedt@goodmis.org,
        vbabka@suse.cz
Subject: Re: [PATCH v4] page_ext: introduce boot parameter 'early_page_ext'
Date:   Fri, 26 Aug 2022 18:32:17 +0800
Message-Id: <20220826103217.17393-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220825212338.e541d29ca3c4d602221f4925@linux-foundation.org>
References: <20220825212338.e541d29ca3c4d602221f4925@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 21:23:38 -0700, akpm@linux-foundation.org wrote:
>On Thu, 25 Aug 2022 18:27:14 +0800 lizhe.67@bytedance.com wrote:
>
>> From: Li Zhe <lizhe.67@bytedance.com>
>> 
>> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>> problem. It seems that we cannot track early page allocations in current
>> kernel even if page structure has been initialized early.
>> 
>> This patch introduce a new boot parameter 'early_page_ext' to resolve this
>> problem. If we pass it to kernel, function page_ext_init() will be moved
>> up and feature 'deferred initialization of struct pages' will be disabled
>> to initialize the page allocator early and prevent from the panic problem
>> above. It can help us to catch early page allocations. This is useful
>> especially when we find that the free memory value is not the same right
>> after different kernel booting.
>> 
>
>WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)
>WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)

Sorry for introducing this WARNING. I did multiple checks before submitting
the patch but unluckily I didn't trigger this WARNING. Maybe there are some
differences of config in our compilation environment. I have tried gcc 8.3
and gcc 11.2.1.

>
>I did this, but it was lazy - perhaps there's a better-optimized
>combination of section tags.  Please check?
>
>--- a/mm/page_ext.c~page_ext-introduce-boot-parameter-early_page_ext-fix
>+++ a/mm/page_ext.c
>@@ -91,7 +91,7 @@ unsigned long page_ext_size = sizeof(str
> static unsigned long total_usage;
> static struct page_ext *lookup_page_ext(const struct page *page);
> 
>-bool early_page_ext __meminitdata;
>+bool early_page_ext;
> static int __init setup_early_page_ext(char *str)
> {
> 	early_page_ext = true;
>_

Thanks for the fix.
I try '__initdata', it triggers another WARNING below.

WARNING: modpost: vmlinux.o: section mismatch in reference: memmap_init_range (section: .meminit.text) -> early_page_ext (section: .init.data)

I check the section tags in include/linux/init.h. It seems that we don't have
a better choise. So in my opinion, your patch is the best solution.
