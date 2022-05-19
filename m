Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF952DDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbiEST2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiEST2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:28:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA06996BC;
        Thu, 19 May 2022 12:28:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m6so7406198ljb.2;
        Thu, 19 May 2022 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvLDd8wcJFaP4wZyvv4PEwUuTP3SB9YVSkYVMPVbzng=;
        b=Uc22x0NuV1MkOVz0+q7VLbrtNVzEVaPlEPu3pEhpU7LqfUx9jvflGzbiYKOBjQ75Nl
         7VAnBHEm9RfJk2ExH9HbaYlWGEgdnBspOXY+CoAJWgn32j6WiY8Ew2A532ksAWLZtyqD
         C50PQ3WXXMw0cvivqkROWDW7F9rQ3XY2qX/vWWOIdxVOWyVtXaKusQvl3o6PNJaEXCLI
         rd1zSWev0Wmj8W9tZ1TSAOrrEs5lmyHFhQla6ikf2Am/fiLO2iE3KTCLbtskuetpLExV
         3h6x2d/pb13i+Pn3M6gp+UxtGq73frFVbuPWITK8sUoY3hdl4Gistpkzlb2YgXKKfD+O
         fLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvLDd8wcJFaP4wZyvv4PEwUuTP3SB9YVSkYVMPVbzng=;
        b=3/oxbt/YuM1JWbLnhQ7COxiGDf8xPoF7oXCFjPlYiI16LRLgyF320223Vcv5uVVchJ
         /1uR2YJnRX0IxThlGcGj7JLBMMsCmb2qc42zcEcrUuNnPyhoGvYPHElhyGr112GaUXhP
         P+MrtR/r4fAytTrTxci33B0Nvj+PenC55yHuyJBu0l+aSozBIrKVJ+dJ5oW4uLhqj16w
         8xxk1JLUY8CQvfR/ioQnbFjLDdk6fitEZP9ZcDCJ2KE5n13ygrGqcBFOk363ooMNBuyP
         G/fe0FmP8zBBRJnCMqw/xVpBZaY6HJX6ihWHk/y13gaXvxDWKsrEhOdLzWw1BjCd0PiD
         HWVg==
X-Gm-Message-State: AOAM530CCNRueBAJr64uN2secWFNbzKSdrbfcpthU67S8lsNSDdkgCcS
        JC10nJ1Bc063iH/XORIpL50=
X-Google-Smtp-Source: ABdhPJxuxey6xeuyOaq/PdkiNBWjHJmK9mtssV6mSSRvv0EZysXovJkSn7t3gEN0fYV8lzwSLqrJdQ==
X-Received: by 2002:a05:651c:102c:b0:253:d15e:dd12 with SMTP id w12-20020a05651c102c00b00253d15edd12mr3392798ljm.220.1652988492002;
        Thu, 19 May 2022 12:28:12 -0700 (PDT)
Received: from pc ([104.28.198.246])
        by smtp.gmail.com with ESMTPSA id y27-20020ac255bb000000b0047255d21132sm378876lfg.97.2022.05.19.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:28:11 -0700 (PDT)
Date:   Thu, 19 May 2022 22:27:55 +0300
From:   Boris Lysov <arz65xx@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     arzamas-16@mail.ee, mturquette@baylibre.com, sboyd@kernel.org,
        matthias.bgg@gmail.com, wenst@chromium.org,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] clk: mediatek: Fix unused 'ops' field in mtk_pll_data
Message-ID: <20220519222755.127ebbb8@pc>
In-Reply-To: <ead37cb0-c841-df1a-ca10-a396b5e9951c@collabora.com>
References: <20220515122409.13423-1-arzamas-16@mail.ee>
        <ead37cb0-c841-df1a-ca10-a396b5e9951c@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Angelo! 

On Wed, 18 May 2022 14:15:13 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 15/05/22 14:24, Boris Lysov ha scritto:
> > From: Boris Lysov <arzamas-16@mail.ee>
> > 
> > Allow to specify optional clk_ops in mtk_pll_data which will be picked up in
> > mtk_clk_register_pll. So far no already supported Mediatek SoC needs
> > non-default clk_ops for PLLs but instead of removing this field it will be
> > actually used in the future for supporting older SoCs (see [1] for details)
> > with quirky PLLs.
> > 
> 
> Hello Boris,
> 
> I disagree about this change and would rather see the ops pointer removed
> with fire.
> 
> I got that you're trying to do something about "quirky PLLs", but is it
> really about the PLLs that you're mentioning being "quirky", or are they
> simply a different IP?

To be honest I don't know exactly. mt6577 seems to share some common IP
patterns such as splitting the entire clock system into few smaller subsystems
such as apmixed (PLLs), topckgen (mux control), infra- and pericfg (internal
and peripheral gate control). On the other hand, mt6577 is quite an old SoC
(more on that in the end) and there are some differences about its operation
compared to modern SoCs and their drivers.

> Also, if it's just about a bit inversion and a bigger delay:
> 1. Bigger delay: Depending on how bigger, we may simply delay more by default
>     for all PLLs, even the ones that aren't requiring us to wait for longer...
>     ...after all, if it's about waiting for 10/20 *microseconds* more
> { snip }

According to the mt6577 datasheet the largest settling time is 10
*milli*seconds for AUDPLL [1]. In my opinion this is way too much to be set as
default for all mediatek devices.

> 2. Bit inversion: that can be solved simply with a flag in the
> prepare/unprepare ops for this driver... and if you want something that
> performs even better, sparing you a nanosecond or two, you can always assign
> an "inverted" callback for managing that single bit;

Not all mt6577 PLLs need bit inversion. 2 PLLs follow the common flow (set a
CON0_PWR_ON bit to start). 6 PLLs set this bit to 0 to start. And 1 PLL (which
is actually a DDS) needs to write a magic value to specific register (in
apmixed region) to start.
Is very unfortunate that I can't directly link the vomit-inducing downstream
code to prove the PLL situation due to its licensing but it's publicly
available on the internet [2] as a part of device manufacturers' obligations to
publish source code.

> 3. Different IP: mtk_clk_register_(name-of-the-new-ip)_pll() - I don't think
> that there's anything to explain to that one.
In my opinion this would introduce more duplicate code than just letting a
developer set custom clk_ops for a specific platform.

Huge thanks for your feedback!

P.S As I said above, mt6577 is old and in its current state [3] it's closer to
being a personal project than a serious mainlining attempt. I share and agree
with your opinion [4] on e-waste and is why I'm trying to put an effort into it.
What I don't have enough of is time and, sadly, expertise. Maybe it'd be better
for me to stay on github.

[1] MT6577 HSPA Smartphone Application Processor Datasheet v0.94, page 1200
[2] any linux v3.4 mt6577 kernel on github, see the 'enable_pll_op' function in
mediatek/platform/mt6577/kernel/core/mt6577_clock_manager.c 
[3] https://github.com/arzam16/linux-mt6577
[4] https://lists.infradead.org/pipermail/linux-mediatek/2022-May/041498.html

> Regards,
> Angelo
> 
> > This patch depends on series "clk: mediatek: Move to struct clk_hw provider
> > APIs" [2] by Chen-Yu Tsai.
> > 
> > [1]
> > https://lists.infradead.org/pipermail/linux-mediatek/2022-February/035093.html
> > [2]
> > https://lists.infradead.org/pipermail/linux-mediatek/2022-May/040921.html
> > 
> > Signed-off-by: Boris Lysov <arzamas-16@mail.ee>
> > ---
> >   drivers/clk/mediatek/clk-pll.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index cabdf25a27f3..509959a325f0 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -347,7 +347,10 @@ static struct clk_hw *mtk_clk_register_pll(const
> > struct mtk_pll_data *data, 
> >   	init.name = data->name;
> >   	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
> > -	init.ops = &mtk_pll_ops;
> > +	if (data->ops)
> > +		init.ops = data->ops;
> > +	else
> > +		init.ops = &mtk_pll_ops;
> >   	if (data->parent_name)
> >   		init.parent_names = &data->parent_name;
> >   	else
> > 
> 

