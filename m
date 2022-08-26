Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F285A1FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbiHZEXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHZEXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F4C6FD6;
        Thu, 25 Aug 2022 21:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F021A60C8A;
        Fri, 26 Aug 2022 04:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3326C433D6;
        Fri, 26 Aug 2022 04:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661487819;
        bh=jcg147D1yDM5q55rbfjcwOEpR6Qg0owFbIE79hxnzdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=swRBl+cyscwpbrkmIlJVa2MyakZTR2Xj5+P98F6XCQZ8AmmqwbgR2wcJlW2edLZ5U
         yQN1WMR68osbCltgUgpxR1+M1PhAAM2NHtlTWrgSnAoxeWGTCkxrIwExVBq31sUkzP
         WrTk9NO76jkek3Rw2BV+oSvjEDCer18TgD8Hkkho=
Date:   Thu, 25 Aug 2022 21:23:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     lizhe.67@bytedance.com
Cc:     mhocko@suse.com, vbabka@suse.cz, mhiramat@kernel.org,
        keescook@chromium.org, Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        rostedt@goodmis.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com
Subject: Re: [PATCH v4] page_ext: introduce boot parameter 'early_page_ext'
Message-Id: <20220825212338.e541d29ca3c4d602221f4925@linux-foundation.org>
In-Reply-To: <20220825102714.669-1-lizhe.67@bytedance.com>
References: <20220825102714.669-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 18:27:14 +0800 lizhe.67@bytedance.com wrote:

> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
> we call page_ext_init() after page_alloc_init_late() to avoid some panic
> problem. It seems that we cannot track early page allocations in current
> kernel even if page structure has been initialized early.
> 
> This patch introduce a new boot parameter 'early_page_ext' to resolve this
> problem. If we pass it to kernel, function page_ext_init() will be moved
> up and feature 'deferred initialization of struct pages' will be disabled
> to initialize the page allocator early and prevent from the panic problem
> above. It can help us to catch early page allocations. This is useful
> especially when we find that the free memory value is not the same right
> after different kernel booting.
> 

WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)
WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)

I did this, but it was lazy - perhaps there's a better-optimized
combination of section tags.  Please check?

--- a/mm/page_ext.c~page_ext-introduce-boot-parameter-early_page_ext-fix
+++ a/mm/page_ext.c
@@ -91,7 +91,7 @@ unsigned long page_ext_size = sizeof(str
 static unsigned long total_usage;
 static struct page_ext *lookup_page_ext(const struct page *page);
 
-bool early_page_ext __meminitdata;
+bool early_page_ext;
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
_

