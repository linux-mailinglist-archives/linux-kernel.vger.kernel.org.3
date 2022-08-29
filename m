Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8985A4501
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiH2IZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH2IZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D491C126
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6300160DF8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B9EC433D6;
        Mon, 29 Aug 2022 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661761510;
        bh=hHALztWivQBNH4N4zzMDPUp5mHUfdWji+XMB1erl5G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlT+KGX8bp6SKLvI26qUDpHQAzdxTDNmnyx44XM/wkF9Vn/REfOGnDPnv5kO150Hj
         ak9KEGjqJRuTIaU1tSll5KYaBjCgFJlS7Ugd/ZV4i9fACmloDO8lRT46fOjJRls7Kd
         NzdIE5M0G0se8V+k+kDnWEea6XNApuqBw6tZvDMV0PWlvhriuU6ZQVBiywmdvz1sf0
         t6G3kYkTIO3Z1lyKHu+pyFeGGSFkU1hZ9/F6rGC4psAqaoIS4tF22lbQ+2AqvM7JY9
         hq5+aSq1gcwar8R1moAf9JkwL+jfk7xedTP2pv1DFGttT4KUE6A1zE+d0FYhDPaELu
         Qam41bd2GMDAQ==
Date:   Mon, 29 Aug 2022 11:24:56 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     karolinadrobnik@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] tools/testing/memblock: define pr_warn_ratelimited
Message-ID: <Ywx32C4/kE2WgR75@kernel.org>
References: <1661755140-3331-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661755140-3331-1-git-send-email-chensong_2000@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:39:00PM +0800, Song Chen wrote:
> Commit 14d9a675fd0d("mm: Ratelimited mirrored memory related warning
> messages") introduced pr_warn_ratelimited in memblock.c, which breaks
> tools/test/memblock, below is the message:
> 
> /usr/bin/ld: memblock.o: in function `memblock_find_in_range.constprop.0':
> memblock.c:(.text+0x4603): undefined reference to `pr_warn_ratelimited'
> /usr/bin/ld: memblock.o: in function `memblock_alloc_range_nid':
> memblock.c:(.text+0x786a): undefined reference to `pr_warn_ratelimited'
> collect2: error: ld returned 1 exit status
> 
> A fake pr_warn_ratelimited needs to be defined in printk.h like other
> prink functions.

This is fixed by commit 0a7e91528202 ("memblock tests: fix compilation errors")
 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---

-- 
Sincerely yours,
Mike.
