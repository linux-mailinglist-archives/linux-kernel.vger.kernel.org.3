Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AE571BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGLOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiGLOAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:00:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA3E02B;
        Tue, 12 Jul 2022 07:00:17 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13E0B66016F8;
        Tue, 12 Jul 2022 15:00:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657634415;
        bh=mbcA91S5p6wcOQpchlxMqQs99CbpqYRQB8T7w4Nci6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJoOAEjRo3DgflaYetEXXTahyQ9YbJxeMhcsLOru17+VQSWm9crnflya6zAuO169F
         PNDsaEQuwqqiFB1VNtKUVJcj0YtMGihuCBjJI4vA9cMWj4XT94jEaQWzqUB3IiUidy
         SIWEei97AJus7Ya3q2UC3HRAuFhK7iAImVhCf+C3+m9SHKJbiXTKuM5NvrXIc1bcTN
         3jLhUWa6zb7yjqru4RzRLzkt1aWIhr3fE1cA/c5rjSpsF0tgwT/0cQYJFLL8m00bow
         woUWTYKMRB/Ad+/KIX962tsD1G5jnbxDqG1VGF+E6g64HOPDRv4pLMimjAJlfdDAXT
         VWZ/kAd0IUP2Q==
Date:   Tue, 12 Jul 2022 10:00:10 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        kernel@collabora.com, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] clk: mediatek: Don't check HW status for mt8192/5's
 imp_iic_wrap clocks
Message-ID: <20220712140010.nfxo42td3zzy3iqp@notapiano>
References: <20220711205733.203963-1-nfraprado@collabora.com>
 <CAGXv+5Enkz20o8BLXmnCUBmB930sH+20U=XvTWA82neaiqqc2A@mail.gmail.com>
 <473aa749-fcfe-bd38-0d83-95375aeef8a3@collabora.com>
 <CAGXv+5E+HVi2kxkRrwhWhq2XgbmfCxj+ZywPT4orBXTxtJ7X1Q@mail.gmail.com>
 <9102680e-2c4c-6c62-0255-5f3f669dd16c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9102680e-2c4c-6c62-0255-5f3f669dd16c@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:57:47PM +0200, AngeloGioacchino Del Regno wrote:
> Il 12/07/22 12:56, Chen-Yu Tsai ha scritto:
> > On Tue, Jul 12, 2022 at 6:55 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > > 
> > > Il 12/07/22 12:44, Chen-Yu Tsai ha scritto:
> > > > Hi,
> > > > 
> > > > On Tue, Jul 12, 2022 at 4:57 AM Nícolas F. R. A. Prado
> > > > <nfraprado@collabora.com> wrote:
> > > > > 
> > > > > The imp_iic_wrap clocks on mt8192/mt8195 require that the i2c_sel parent
> > > > > clock be enabled before their hardware status can be checked. Since this
> > > > > wasn't taken into account, reading from the clk_summary debugfs file
> > > > > would cause the system to completely freeze.
> > > > > 
> > > > > Assuming that this clock is managed only by the kernel, and not by any
> > > > > firmware, simply drop the is_enabled() optional callback and instead
> > > > > rely on the enable count for the imp_iic_wrap clocks.
> > > > 
> > > > That's the wrong way to go about it.
> > > > 
> > > > The I2C clocks already have the CLK_OPS_PARENT_ENABLE flag set. So the
> > > > issue is that somewhere in the clk core, a piece of code is not honoring
> > > > that flag.
> > > > 
> > > > And it seems that's in more than one place.
> > > > 
> > > 
> > > Uhm, you're right. I gave my Tested-by, but not a Reviewed-by because I
> > > wasn't really convinced about this solution being the best.
> > > 
> > > Now that I think of it, the solution may be as simple as:
> > > 
> > > clk.c
> > > 
> > > static bool clk_core_is_enabled(struct clk_core *core)
> > > {
> > >          bool ret = false;
> > > 
> > >          /*
> > >           * If this clock needs parent enabled, but its parent is
> > >           * off, we directly return false for two reasons:
> > >           * 1. This clock being enabled would be impossible
> > >           * 2. The platform may crash for unclocked access while
> > >           *    reading the status of this clock (where a .is_enabled
> > >           *    callback is provided).
> > >           */
> > >          if (core->flags & CLK_OPS_PARENT_ENABLE &&
> > >              !clk_core_is_enabled(core->parent))
> > >                  return false;
> > > 
> > >          ... etc etc etc ...
> > > }
> > > 
> > > Nícolas, did you try this approach?

From reading the core clock code, it's mentioned that CLK_OPS_PARENT_ENABLE is
used "during gate/ungate, set rate and re-parent", there's no mention of
"checking the gate state", so I assumed this operation was intentionally not
handled by this flag. That's why I went for this solution.

But from the discussion sounds like the flag should indeed be caring about the
is_enabled() operation as well, so let's go with Chen-Yu's patch.

Thanks,
Nícolas

> > 
> > I have a patch ready, but I got distracted by other stuff today.
> > 
> 
> Let's just wait for your patch then, seems like being the most sensible option.
> 
> Cheers!
