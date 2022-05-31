Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744D953959B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346682AbiEaRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbiEaRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:52:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0FF5A09C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C005BB8116B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E06C385A9;
        Tue, 31 May 2022 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654019521;
        bh=OEffCozNQpohIH5eyJLNtoMpjRKcnRWUeID9VGyaAnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OxCWkOU/KlRTYWJIU77tH7DqxetqA3KFACMH/TOXjqVqEk57kgpF3O26zUfycCHWE
         0XYuBliVm13YxzKcZun2fxq2A7DNTiLDxFBiJVJtOrM35PmN6mal9g9Pk4AOxBxEeq
         QHLAVyMduwHx2dCypmsfubYv34RV1vZiaR6MK9HM=
Date:   Tue, 31 May 2022 10:52:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 2/3] mm: introduce clear_highpage_tagged
Message-Id: <20220531105200.587db61db99f19e308a05c5e@linux-foundation.org>
In-Reply-To: <d6ba060f18999a00052180c2c10536226b50438a.1654011120.git.andreyknvl@google.com>
References: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
        <d6ba060f18999a00052180c2c10536226b50438a.1654011120.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 17:43:49 +0200 andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a clear_highpage_tagged() helper that does clear_highpage() on a
> page potentially tagged by KASAN.

clear_highpage_kasan_tagged() would be a better name, no?

--- a/include/linux/highmem.h~mm-introduce-clear_highpage_tagged-fix
+++ a/include/linux/highmem.h
@@ -243,7 +243,7 @@ static inline void clear_highpage(struct
 	kunmap_local(kaddr);
 }
 
-static inline void clear_highpage_tagged(struct page *page)
+static inline void clear_highpage_kasan_tagged(struct page *page)
 {
 	u8 tag;
 
--- a/mm/page_alloc.c~mm-introduce-clear_highpage_tagged-fix
+++ a/mm/page_alloc.c
@@ -1311,7 +1311,7 @@ static void kernel_init_pages(struct pag
 	/* s390's use of memset() could override KASAN redzones. */
 	kasan_disable_current();
 	for (i = 0; i < numpages; i++)
-		clear_highpage_tagged(page + i);
+		clear_highpage_kasan_tagged(page + i);
 	kasan_enable_current();
 }
 
_

