Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A35A4563
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiH2IqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH2IqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:46:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA085852A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3751B80D8F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535DDC433C1;
        Mon, 29 Aug 2022 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661762765;
        bh=mgVwGZEizzRLcCal5uavQ7yEy2IwtS+YRh5v/25aCFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyrmGCYORjB9tZKKC0Lk2sakIdGI4zwO8nRBeqn3k+b1N+ygOuzRK0Sk3CIjp35Af
         iCUXDAhVYJIlO6G2jzbcicjSyGUcjP3pn4MBKTeCOKUwwbXohB0WRHoynmTQN6H5uu
         QRv7tDsVEqMZ18dW54OFLs6pZaIXalBlW2UVHW4TJMXNRu4Nyvml3pwjExR3U2h/JH
         var9HyNFHSQR8AWW4YtirdZ2XaB+C/E+9+skWl+D+V5UT7Re1C0/7yuaTXN8DW4+f4
         eKaEFl+irOrkThS0qSkDD98tQESPDN+77+uVguVaDfShy67EMLxo/TSDoltAHQUi37
         diQ3liJLUYArw==
Date:   Mon, 29 Aug 2022 11:45:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     karolinadrobnik@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] tools/testing/memblock: define pr_warn_ratelimited
Message-ID: <Ywx8vutn0b8iN2hX@kernel.org>
References: <1661755140-3331-1-git-send-email-chensong_2000@189.cn>
 <Ywx32C4/kE2WgR75@kernel.org>
 <520fb512-8d2f-15e1-fd00-a7343e136d1c@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <520fb512-8d2f-15e1-fd00-a7343e136d1c@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:32:47PM +0800, Song Chen wrote:
> Hi,
> 
> 
> 在 2022/8/29 16:24, Mike Rapoport 写道:
> > On Mon, Aug 29, 2022 at 02:39:00PM +0800, Song Chen wrote:
> > > Commit 14d9a675fd0d("mm: Ratelimited mirrored memory related warning
> > > messages") introduced pr_warn_ratelimited in memblock.c, which breaks
> > > tools/test/memblock, below is the message:
> > > 
> > > /usr/bin/ld: memblock.o: in function `memblock_find_in_range.constprop.0':
> > > memblock.c:(.text+0x4603): undefined reference to `pr_warn_ratelimited'
> > > /usr/bin/ld: memblock.o: in function `memblock_alloc_range_nid':
> > > memblock.c:(.text+0x786a): undefined reference to `pr_warn_ratelimited'
> > > collect2: error: ld returned 1 exit status
> > > 
> > > A fake pr_warn_ratelimited needs to be defined in printk.h like other
> > > prink functions.
> > 
> > This is fixed by commit 0a7e91528202 ("memblock tests: fix compilation errors")
> 
> Is there a commit taking care of 902c2d91582c(mirrored_kernelcore) ? it
> brakes memblock test too. If not, i have fixed it and will send a patch
> soon.

Yes, the same commit that fixed pr_warn_ratelimited() issue.

Please work with recent version of the kernel tree to avoid work
duplication.
 
> Song
> 

-- 
Sincerely yours,
Mike.
