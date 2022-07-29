Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947B584958
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiG2BiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:38:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AF46A9FC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 817F3B82596
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE234C433C1;
        Fri, 29 Jul 2022 01:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659058681;
        bh=jtgZViSVTrJWuFA/FbVauguHSM/s1zXeAgY+DlzeQHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EyN5DPL4n9qE0A0lfvgCabvtNYmWkgDu3prE/prFyNgS+ndOsrEz+3Td3a3aeZSTY
         7q7TsKk9HrVQx9RdMVDkIQSwqa0KTWuOpsJ8W7jfT8OkQzdr6xnRl8Ze1MIPc3ZfFB
         zXpbQO0RPPcw4FRbCEF+logzxtRz46yOI6702u8Q=
Date:   Thu, 28 Jul 2022 18:37:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memory-failure: convert to pr_fmt()
Message-Id: <20220728183759.6a3eaab13b1b122a5810af58@linux-foundation.org>
In-Reply-To: <20220727032511.145506-1-wangkefeng.wang@huawei.com>
References: <20220727032511.145506-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 11:25:11 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Use pr_fmt to prefix all pr_<level> output, but unpoison_memory()
> and soft_offline_page() are used by error injection, which have
> own prefixes like "Unpoison:" and "soft offline:", meanwhile,
> soft_offline_page() could be used by memory hotremove, so undef
> pr_fmt before unpoison_pr_info definition to keep the original
> output for them.
> 
> ...
>
> @@ -2289,6 +2285,7 @@ static int __init memory_failure_init(void)
>  }
>  core_initcall(memory_failure_init);
>  
> +#undef pr_fmt
>  #define unpoison_pr_info(fmt, pfn, rs)			\
>  ({							\
>  	if (__ratelimit(rs))				\

This change makes the build fail.

In file included from ./include/linux/kernel.h:29,
                 from mm/memory-failure.c:39:
mm/memory-failure.c: In function 'unpoison_memory':
./include/linux/printk.h:537:26: error: expected ')' before 'pr_fmt'
  537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
      |                          ^~~~~~
./include/linux/printk.h:388:42: note: in definition of macro '__printk_index_emit'
  388 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
      |                                          ^~~~
./include/linux/printk.h:464:26: note: in expansion of macro 'printk_index_wrap'
  464 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
./include/linux/printk.h:537:9: note: in expansion of macro 'printk'
  537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
mm/memory-failure.c:2292:17: note: in expansion of macro 'pr_info'
 2292 |                 pr_info(fmt, pfn);                      \
      |                 ^~~~~~~
mm/memory-failure.c:2326:17: note: in expansion of macro 'unpoison_pr_info'
 2326 |                 unpoison_pr_info("Unpoison: Disabled after HW memory failure %#lx\n",
      |                 ^~~~~~~~~~~~~~~~

[1500 lines of the same]
