Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8787506409
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiDSFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiDSFvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:51:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B08F27CFA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:48:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g34so29239282ybj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMJ889Dz0Epk94th8NM3EDZyolTDHRMoctXfRSXxfd0=;
        b=Vx5iJ070v0mFXMFcDOjxZ8J6MVVAEYWG73pK/G8UxwB8GDV0NpdBihuTD+dxl9Tx11
         jA4hOZA9+5GSkKipnXhENUttTKNoejkJjvBQoofj1XjfhYhkbX2W2dxAysPpLeTh3Atn
         61tUCHd474/nb+6j3Muh9EnQYmm9BcBwVWqFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMJ889Dz0Epk94th8NM3EDZyolTDHRMoctXfRSXxfd0=;
        b=TiLvKZMK5/M7UzCOVB/i3cHTazRV0cduNGcqaLRdPvTyFU5dogQp7t5jeiA9wVS0R3
         RqeChAFZ10+ccryPUgHNI1nS20FbXanNlF7bJg9oUbDLWWSj4jeENoHt4jAUccSENxQU
         zMBbMa522JKbeIWWfwxUkPnvGGkc+zqRZkeKMS0qXFutI5MFSSfanIxWVcjfwBsI1tNd
         1Tem08tFUGEfhbvl2oRJwKePLMkrl3u7jf0Tgiw0TRHZGE3dxNM87QExqsTCaX/2E2XM
         Ou4LIdfkmIx1soFpwdh1cdm5S/iHrXh1ele7Qx/zmp6OlPZ87LOF1j3NqiHL6AclLVrG
         HQ0A==
X-Gm-Message-State: AOAM5317WaD5BDS7uG8r93wvJImDFb6+TO6HmT4eJv2PUMv5Pi9VDHJy
        j5/WeF2l+wGnl0ftRiv/E8CDjuzqzb3zoOsV88sQ2w==
X-Google-Smtp-Source: ABdhPJxCrtHIsV7KofTQzS7x17ALKuUB39G39gb4IwHCx6860d625lxMWoMCGDPQwz11vBINp5tlTNP0b8aQpGFQwm8=
X-Received: by 2002:a25:8d90:0:b0:634:7136:4570 with SMTP id
 o16-20020a258d90000000b0063471364570mr13323397ybl.582.1650347335888; Mon, 18
 Apr 2022 22:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com> <20220418132154.7401-2-rex-bc.chen@mediatek.com>
In-Reply-To: <20220418132154.7401-2-rex-bc.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Apr 2022 13:48:45 +0800
Message-ID: <CAGXv+5FXTft7-E5LnuZdNo8Tq6OKOKwt58GgJD_+z1N5u6B8yw@mail.gmail.com>
Subject: Re: [PATCH 1/7] clk: mediatek: reset: Correct the logic of setting register
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, yong.liang@mediatek.com,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 9:22 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>

The subject could be written as "Fix written reset bit offset" to make it
more specific.

> Original assert/deassert bit is BIT(0), but it's more resonable to modify
> them to BIT(id % 32) which is based on id.
>
> This patch will not influence any previous driver because the reset is
> only used for thermal. The id (MT8183_INFRACFG_AO_THERM_SW_RST) is 0.
>
> Fixes: 64ebb57a3df6 ("clk: reset: Modify reset-controller driver")
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
