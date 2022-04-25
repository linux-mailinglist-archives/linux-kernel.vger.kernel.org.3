Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0850EBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiDYW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343513AbiDYVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699E23BE5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 066D361479
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37757C385A7;
        Mon, 25 Apr 2022 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650922027;
        bh=kqDjvm3xpzh6Yg4Lxl+rXD0rB2PmW1SLX1gSac7OA38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SH8ca7bwli2JGengyW3Aaj2tn4GzTs25gN4kDLQXD31vIMD4zAdYYXe4RV1Hf+h5r
         4uR7mFW6X/K2RZYuiuWmQo0DmBjI1GKuQNjTirwy0dumX98LE6YPvbvSHserq1ONbL
         7NIYKtsUlaTtN2risNvZjBpIHyzz6tu8hL6EL+cg=
Date:   Mon, 25 Apr 2022 14:27:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Song Liu <song@kernel.org>
Subject: Re: Linux 5.18-rc4
Message-Id: <20220425142706.23e6bea1d5bfdd944e33bc96@linux-foundation.org>
In-Reply-To: <YmZvAUakbWnyQEqa@debian>
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
        <YmZvAUakbWnyQEqa@debian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 10:50:57 +0100 Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Hi Linus,
> 
> On Sun, Apr 24, 2022 at 03:22:59PM -0700, Linus Torvalds wrote:
> > Fairly slow and calm week - which makes me just suspect that the other
> > shoe will drop at some point.
> > 
> > But maybe things are just going really well this release. It's bound
> > to happen _occasionally_, after all.
> 
> My last night's mainline build failed for arm.
> Build was with af2d861d4cd2 ("Linux 5.18-rc4").
> 
> imxrt_defconfig -> failed
> lpc18xx_defconfig -> failed
> mps2_defconfig -> failed
> stm32_defconfig -> failed
> vf610m4_defconfig -> failed
> 
> arm-linux-gnueabi-ld: mm/page_alloc.o: in function `alloc_large_system_hash':
> page_alloc.c:(.init.text+0xe7c): undefined reference to `vmalloc_huge'

Thanks.  oops.  We broke nommu.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/nommu.c: provide vmalloc_huge() for CONFIG_MMU=n

Fixes: f2edd118d02dd ("page_alloc: use vmalloc_huge for large system hash")
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/nommu.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/mm/nommu.c~a
+++ a/mm/nommu.c
@@ -226,6 +226,12 @@ void *vmalloc(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc);
 
+void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
+{
+	return vmalloc(size);
+}
+EXPORT_SYMBOL(vmalloc_huge);
+
 /*
  *	vzalloc - allocate virtually contiguous memory with zero fill
  *
_


I don't see any point in copy-n-pasting the kerneldoc over.  Perhaps we
should just delete all the copy-n-paste kerneldoc from nommu.c and say
"go look at the MMU version of this function".

