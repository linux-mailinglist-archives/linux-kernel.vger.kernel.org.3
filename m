Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91C553B8E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiFBMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiFBMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:19:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BCBE0D0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=spjc1NV0tUcIwlyH3r+o1pjArgZsS0mBD5aKUtZaglY=; b=a8cqrPdTs/qxidHZhDFLhcaUr+
        rWxaXcKx6i+s1vcq8M7kVMAxI7iOCkQJv1b9eR59IFfXAhvJBtSMMmCe6GY3dYGLlYpd4PC5ZB4SY
        NdFZ7oVhQD6ELNWiK62a2SS4CeAXaQ2VAzHa+Vk1+TfaeGRoZ2gQjOkO66YR+sULeV4SYyfSq2nBh
        ljG7J1vhQWz/RNshKWkiNipOOJkRNvJZ6oqIDTtzBTA2ZKxX7Ok7jfPzTbAXk/G/KhfkS8R8S2+IY
        Hhe0KVRJgiGnaAx6aM4FaWN3AAOJtgVVSxQVtlc1mZCdJa/r12d55dMaVQlIgVtMpfSYJ98FQMVot
        7tx/UdJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwjnE-003B8U-45; Thu, 02 Jun 2022 12:19:12 +0000
Date:   Thu, 2 Jun 2022 05:19:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Jani Nikula <jani.nikula@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
Message-ID: <YpiqwDjCP0Am8kZV@infradead.org>
References: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
 <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr>
 <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
 <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com>
 <d971a684-ccd9-3839-1e30-c166fd55cf49@inria.fr>
 <CAHk-=wiViikY0szsJGipSxFmMwdsvxjm7SwDfwNfMHYvQ64kAA@mail.gmail.com>
 <CAK8P3a1m80u+eVnoSJ-APihjNQ1se9=FG+E6tKBb-hRJx5FAVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1m80u+eVnoSJ-APihjNQ1se9=FG+E6tKBb-hRJx5FAVg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 09:38:56AM +0200, Arnd Bergmann wrote:
> - dma_addr_t/phys_addr_t are sometimes put into hardware data
>   structures in coherent DMA allocations.

Putting a dma_addr_t into a hardware data structure is broken.
dma_addr_t is the in-memory type, for the hardare it should always
be a __le/__be type of the actual width that the particular piece
of hardware uses.
