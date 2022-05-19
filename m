Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD63C52D583
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiESODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiESODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:03:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1571C2673;
        Thu, 19 May 2022 07:03:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id f9so10270269ejc.0;
        Thu, 19 May 2022 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=qWNcKlbHWt+buYUPc86j5JlNPnGvKXkUMAum0oQSfJ0=;
        b=LcE9bEgfBwTo+FP+bLoachNEfeucJ1OepYalzxu7uc6jEmRley8APjmdkai6m/XVAc
         Ya75wYu2NMpfUANb1K7kUDHYWCcXkmTEbT8b7eC6obk6nmJdBqKhFhrN0XlEGUOS38va
         4ldMm/u49lHcF+2IBH75a8sAghe0xurqgbWccyAqO4mLCKlrctVwIpqpzjLDyGQzcirk
         n7m5dGw5dWTOgBJbZYpl3B7KJMFjTe8NedjJ7o/o2Y1HzA1yOOepTTvUkxg1N4L8fNYZ
         ifLUQ4h2MYsaO+czOwRsRl85AqrCFL8vjJcLLAtxcS5VB2E6d1Yw/qOO6W6fRmbYAr3h
         YCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=qWNcKlbHWt+buYUPc86j5JlNPnGvKXkUMAum0oQSfJ0=;
        b=hXvo/VbUtzxSL6sVLt76fyjkVbZxLiIulA3mRfno9nEuiEFXOKK04zNlv/7DNw02ce
         XhTS1FVSIlmkHytydT9ZGFbr2HKbEqWqkcz7YAbbuhK8rsqFdao3Pkzq9W2M4TSH2vns
         +B0RGAE/JzEfwXj8WPFyXvhJj00vIV3MAUlOucLOWngAdL32tfMcI3/ZnWFenvQgTjYX
         MMeljGh8vutU0zxTUAv3leE83Tj8bkC04HR5lfKM+W0+/Y4eGDAV9wl1leTTY0Q4hVY9
         VG3+mkhZGgd+R8QjUylJH4EFmT/Uesn5KyAeoUZba/6NSCmwh/c8tKrcASyXHrtVFreg
         GA7Q==
X-Gm-Message-State: AOAM530Xpm9u/3N+O66JQl9RBabWWBjGxGjfWLoKXKyUwb6U4+x6TGGw
        t0YrGBhjpBgr+L52hchNa4k=
X-Google-Smtp-Source: ABdhPJyhieqoXKbfvsM8fh2dawCAGVx37vJQhD8YjDO0OoeyTXCFh58t3tmMrLP80r47m9bY8FV3oQ==
X-Received: by 2002:a17:907:7b85:b0:6fd:d799:ef4e with SMTP id ne5-20020a1709077b8500b006fdd799ef4emr4492401ejc.319.1652969017544;
        Thu, 19 May 2022 07:03:37 -0700 (PDT)
Received: from [192.168.52.247] ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090672cd00b006f3ef214e3esm2097890ejl.164.2022.05.19.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:03:37 -0700 (PDT)
Date:   Thu, 19 May 2022 18:03:14 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 0/6] clk: mediatek: Improvements to simple probe/remove
 and reset controller unregistration
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?iso-8859-1?q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Message-Id: <E1V4CR.LC9T17R2IY1M2@gmail.com>
In-Reply-To: <20220519134728.456643-1-y.oudjana@protonmail.com>
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 19 2022 at 17:47:22 +0400, Yassine Oudjana 
<yassine.oudjana@gmail.com> wrote:
> This series started as part of an earlier series adding support for 
> the main
> clock controllers on MediaTek MT6735[1]. It has since been split off 
> and
> expanded. It adds a new function to unregister a reset controller and 
> expands
> the mtk_clk_simple_probe/remove functions to support the main 5 types 
> of clocks:
> - PLLs		(new)
> - Fixed clocks	(new)
> - Fixed factors	(new)
> - Muxes		(new)
> - Gates		(supported previously)
> This should allow it to be used in most clock drivers, resulting in 
> reduced
> code duplication. It will be used in MT6735 clock drivers in the 
> upcoming v2
> of the MT6735 main clock controller series.
> 
> Dependencies:
> - clk: mediatek: Move to struct clk_hw provider APIs (series)
>   
> https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/
> - Cleanup MediaTek clk reset drivers and support MT8192/MT8195 
> (series)
>   
> https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
> - Export required symbols to compile clk drivers as module (single 
> patch)
>   
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/
> 
> Yassine Oudjana (6):
>   clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
>   clk: mediatek: Use mtk_clk_register_gates_with_dev in simple probe
>   clk: mediatek: reset: Return reset data pointer on register
>   clk: mediatek: reset: Implement mtk_unregister_reset_controller() 
> API
>   clk: mediatek: Unregister reset controller on simple remove
>   clk: mediatek: Add support for other clock types in simple
>     probe/remove
> 
>  drivers/clk/mediatek/clk-gate.c   |   1 +
>  drivers/clk/mediatek/clk-mt8192.c |   7 +-
>  drivers/clk/mediatek/clk-mtk.c    | 123 
> +++++++++++++++++++++++++-----
>  drivers/clk/mediatek/clk-mtk.h    |  22 +++++-
>  drivers/clk/mediatek/reset.c      |  41 ++++++----
>  drivers/clk/mediatek/reset.h      |  20 +++--
>  6 files changed, 167 insertions(+), 47 deletions(-)
> 
> --
> 2.36.1
> 

Replying since there is a missing reference:

[1] 
https://patchwork.kernel.org/project/linux-clk/cover/20220504122601.335495-1-y.oudjana@protonmail.com/


