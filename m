Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A05768AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiGOVJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiGOVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7470E55
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ED6061760
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 21:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31454C34115;
        Fri, 15 Jul 2022 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657919357;
        bh=jDRTvdwY8R1xATb4PJAsxJ5AKoErEZjvC/CdZJc17aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6FBC2PWHOSMyUsQ/hGpp77j0S5w4T0pP5QtN9oUZVbn9j4/yI19fqG7nkdKITybP
         Jk5hEQdBxVlEaYH3JS/hu1cKnkKU4rRpv1JymfhhTIr2N607kIrbFeXH15B348QVFQ
         8qtIi9+7IlO1D/uvlbVRfWut1dN1hV3JFXH3vjkf8Pz/t7ldEgq2Vq0zttBt/7zz/S
         51dvMhlBiZx5B1iuMjLIFFXsFMVAega0s25WGzmYBFDYCZ4KnQRL7y5VrTsdt+1liv
         XIOlSC7QX1VYE0blt+cUqHD0VJ4XI5bqOKCEnpd+RIlBvVidrYNLh4SrCO7OMhLSuH
         i689AruIGEWDg==
Date:   Fri, 15 Jul 2022 14:09:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm fixes for 5.19-rc7
Message-ID: <YtHXe4PcWXfihF9Q@dev-arch.thelio-3990X>
References: <CAPM=9twM75GDM9t+9-CSCPDZG3QdcEpQ-X+FzQ4CLUCM7cKLkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twM75GDM9t+9-CSCPDZG3QdcEpQ-X+FzQ4CLUCM7cKLkw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:36:17PM +1000, Dave Airlie wrote:
> Matthew Auld (1):
>       drm/i915/ttm: fix sg_table construction

This patch breaks i386_defconfig with both GCC and clang:

  ld: drivers/gpu/drm/i915/i915_scatterlist.o: in function `i915_rsgt_from_mm_node':
  i915_scatterlist.c:(.text+0x1a7): undefined reference to `__udivdi3'

  ld.lld: error: undefined symbol: __udivdi3
  >>> referenced by i915_scatterlist.c
  >>>               gpu/drm/i915/i915_scatterlist.o:(i915_rsgt_from_mm_node) in archive drivers/built-in.a

It was reported by Stephen in -next [1] and there is a fix [2] that
works for me but it doesn't appear to be applied yet (at least, it is
not in drm-intel-fixes at the moment). It is a little disappointing to
see new build errors being introduced before -rc7, especially when
visible with a defconfig...

[1]: https://lore.kernel.org/20220713221454.67bb20df@canb.auug.org.au/
[2]: https://lore.kernel.org/20220712174050.592550-1-matthew.auld@intel.com/

Cheers,
Nathan
