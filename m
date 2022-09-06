Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB65AF89F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIFXvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIFXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C791D25
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C760B6172B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16470C433D6;
        Tue,  6 Sep 2022 23:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662508271;
        bh=s5BbSOf7vTI4irIrXkD4q9QZHbJOc45Qg/cPspgqhvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vYxC1/RK1zGBe+x4CiX/TaGNHBbSpo1J+dK1qh2g1KzJFep/Uyp3CWi+bqOJAL9wU
         JWrBvkJVSCoPoQvXJuWzp5GWhCzD3RdKClLdl3B9R+HNLxumuHDdldx4bzInywPDGO
         3ZXUkKA4urdHjqyTNPGmeDtAYkhb8WVlNk6vPXxI=
Date:   Tue, 6 Sep 2022 16:51:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 00/70] Introducing the Maple Tree
Message-Id: <20220906165110.07cad9a730c630af4425ca33@linux-foundation.org>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 19:48:38 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> This is the v13 + fixes and still based against mm-unstable
> v6.0-rc1-140-geb22a5b1b495

I merged up this version, thanks.

One fix was missed:

--- a/mm/memory.c~mm-remove-the-vma-linked-list-fix
+++ a/mm/memory.c
@@ -1697,6 +1697,7 @@ static void unmap_single_vma(struct mmu_
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlb: address of the caller's struct mmu_gather
+ * @mt: the maple tree
  * @vma: the starting vma
  * @start_addr: virtual address at which to start unmapping
  * @end_addr: virtual address at which to end unmapping
_

OK, tiny, but worrisome.  This is one of the reasons why I dislike
replacing patch series like this.  Hopefully we can get to the finish
line just with little fixups from now on?

