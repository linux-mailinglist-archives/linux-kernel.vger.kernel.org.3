Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C09E5933E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiHORLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiHORL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:11:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231AF25E8A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60DF7CE115E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782C0C433D6;
        Mon, 15 Aug 2022 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660583484;
        bh=bRUgZYlvzDD/pptSlNy1eAs06Vr+nJrjAzYkrLulvyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAuaf25b2NdNXWi04fOoG9yv+2Kq5CV/qoRpBT49uScalWi+dIEbl6WXuReYzV9n3
         I2zuTIakQEwypk+02Z+9ewswCdIanzslKzS+RlTbE4thPI1pcdi/eJQt4g6xixQJSe
         NWuXxPju+/fXuqAw6Z51IPXM7Lu1+h+C5eDVmLb8uLzo+yFfy7jKdPr0UVKyQBvfl1
         VqAYrEh95SXG0ROs2UoysTGN2C5EyeK3x1PpIDMarFH0jhah4W4dNZkbUm6iy/spCN
         f8X/L2YRd8sv7W27x3jIlWChIcOKL3cfL7fTBNix9K561L8R4jG+CjuSvwqv0MTQ4/
         xfPvqWy1MCkYg==
Date:   Mon, 15 Aug 2022 10:11:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds
 limit (1024) in 'ntfs_read_folio'
Message-ID: <Yvp+OnhAAQI5Zvj9@dev-arch.thelio-3990X>
References: <202208140835.W6F1j6Da-lkp@intel.com>
 <Yvo8KUKJBlMtoNgI@casper.infradead.org>
 <CAK8P3a3Gx39P90k9ZUMdzHiNpjNn1tdvkTktQyzUqqfG+an4BA@mail.gmail.com>
 <YvpEkYMatTeNvNZa@casper.infradead.org>
 <CAK8P3a3=XC4ez-zeGptQb_9NtX5rVfr8Qq80eGaEckzUzjAxzg@mail.gmail.com>
 <CAK8P3a0TPYs2cbcx+0QGk=y8xjFrspdwnTHDxQCtsSwJmfvF6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0TPYs2cbcx+0QGk=y8xjFrspdwnTHDxQCtsSwJmfvF6Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:37:09PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 15, 2022 at 3:48 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > I have no problems with a patch removing support for 256KB pages if that
> > helps, as Hexagon is the only architecture to support this and there are close
> > to zero Linux users anway. This would leave only three warnings for 64KB

Right, I had brought up at least adjusting the dependencies of 256KB
pages so that it could not be selected with CONFIG_COMPILE_TEST to
reduce the number of warnings that would appear in randconfigs.

https://lore.kernel.org/YoAlvnyjEbYV4T1L@dev-arch.thelio-3990X/

I suspect removing it outright would be fine too.

> > pages in allmodconfig:
> >
> > fs/mpage.c:131:20: error: stack frame size (1128) exceeds limit (1024)
> > in 'do_mpage_readpage' [-Werror,-Wframe-larger-than]
> > fs/mpage.c:447:12: error: stack frame size (1264) exceeds limit (1024)
> > in '__mpage_writepage' [-Werror,-Wframe-larger-than]
> > fs/ext4/readpage.c:223:5: error: stack frame size (1208) exceeds limit
> > (1024) in 'ext4_mpage_readpages' [-Werror,-Wframe-larger-than]
> 
> I looked into these a bit more and found that these are arrays of sector_t,
> which could be either 32-bit or 64-bit wide before 72deb455b5ec
> ("block: remove CONFIG_LBDAF"), but is now always 64-bit, so having
> an array of 128 of these (65536/512) adds a 1KB to the stack and will
> cause a warning. It's only slightly over the limit, and there are very few
> 32-bit systems that allow 64KB pages to trigger that warning.
> 
> I see now that ppc440 also supports 256KB pages and has the same
> problem as hexagon, but also has been broken since the start of the
> git history in this regard:
> 
> fs/mpage.c:638:1: error: the frame size of 4280 bytes is larger than
> 2048 bytes [-Werror=frame-larger-than=]
> 
> I don't know if anyone strongly cares about 256KB pages on
> ppc44x any more, but given this, I'm fairly sure that they are
> not using block based file systems. So we could just make
> CONFIG_BLOCK depend on PAGE_SIZE_LESS_THAN_256KB
> globally instead of dropping 256KB pages everywhere.

That doesn't sound like an unreasonable solution.

Cheers,
Nathan
