Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276954B81D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354713AbiFNRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356919AbiFNRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:53:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9128708
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D25D2B81A37
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D0CC3411B;
        Tue, 14 Jun 2022 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655229215;
        bh=G/lcWPcoHG6GNeBQyVpLJLWsmCGZ5b1ZTmaVba5rfNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QSN3eV1n7jL0Y1bVnNbhgZYlfu3R1GnCHARyRdypeklxXbgwIxxc5URKNt3D2GbGt
         YEikdDVeONv66XVtKczVqeMCzbNFtR1DDyA3a8J8f9KlDIaOR7NePgiKru/GjcISGF
         ZWCUcfdrb1PDu2Z31vww2qZr91NvZ1MY7Qk3HnhE=
Date:   Tue, 14 Jun 2022 10:53:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     chi wu <wuchi.zero@gmail.com>
Cc:     alexs@kernel.org, sjhuang@iluvatar.ai, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/genalloc: Set chunk size to real size which
 gen_pool managed.
Message-Id: <20220614105334.ec0227452f8639c7515f97aa@linux-foundation.org>
In-Reply-To: <CA+tQmHDFMJq1DH7Kmzp13vxvZoiKzRokt_TeF0w5Eboi6VaaJQ@mail.gmail.com>
References: <20220612105937.30862-1-wuchi.zero@gmail.com>
        <20220613111404.5253fe6ac69f5fd145dd437c@linux-foundation.org>
        <CA+tQmHDFMJq1DH7Kmzp13vxvZoiKzRokt_TeF0w5Eboi6VaaJQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 13:20:08 +0800 chi wu <wuchi.zero@gmail.com> wrote:

> > If we're going to do this then gen_pool_add_owner() no longer needs its
> > `size' argument.
> >
> >
> Sorry, What point did I misunderstand？

I mean we can now do this:

--- a/lib/genalloc.c~lib-genalloc-set-chunk-size-to-real-size-which-gen_pool-managed-fix
+++ a/lib/genalloc.c
@@ -181,13 +181,14 @@ EXPORT_SYMBOL(gen_pool_create);
  *
  * Returns 0 on success or a -ve errno on failure.
  */
-int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt, phys_addr_t phys,
-		 size_t size, int nid, void *owner)
+int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt,
+		       phys_addr_t phys, int nid, void *owner)
 {
 	struct gen_pool_chunk *chunk;
 	unsigned long nbits = size >> pool->min_alloc_order;
 	unsigned long nbytes = sizeof(struct gen_pool_chunk) +
 				BITS_TO_LONGS(nbits) * sizeof(long);
+	size_t size;
 
 	chunk = vzalloc_node(nbytes, nid);
 	if (unlikely(chunk == NULL))
_

and fix up all the callers, prototype, kerneldoc, etc.  Probably as a
second followup patch.


Please take a look at that, add the additional details to the changelog
and resend?

