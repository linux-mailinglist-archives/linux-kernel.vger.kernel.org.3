Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C654F8C34
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiDHBpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiDHBpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:45:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2830360CD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:43:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 313121F42799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649382210;
        bh=Kgjk0PMTnxKr4o7yne9XJVv+nnOoS8+3S6jBLjJ/RhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgTfyumEKjt0cCM/ZqjoWMw4qAfPE810ZDss67mhG4U3BZwSRIPPbZeYBpHzpsonD
         SBrX0+vXz4qsGEHj9UsJKH5bl+f/YQs8/7jx3DB84uQHk7lWPmkEa+8WCA7QrtbhNN
         z4a4n7r77ZC3DR+u2DpHDsHRjSzJS17WAJu1AdRFxdjXrgQuzRaRXyNIKC2KfDaOkr
         uq1nujFa8JTATay3Tdr64cYzm/9ytAWEyACWIiEW2DNnocsX2shBRjfUghTUwwHClX
         u1K+BvaU0iQRkNz6D3PCrWcPHtRaP5gaweQniGubIE4kJ2x6VBKT02tn2btTEFF9+4
         pt5+O3BKOX3PQ==
Date:   Thu, 7 Apr 2022 21:43:23 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        jitao.shi@mediatek.com, rex-bc.chen@mediatek.com,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek: dpi: Use mt8183 output formats for mt8192
Message-ID: <20220408014323.k5imykh7btbqc4c2@notapiano>
References: <20220408011907.672120-1-nfraprado@collabora.com>
 <6afe7366ceffb77674d34c48f84aa85b1c088bc3.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6afe7366ceffb77674d34c48f84aa85b1c088bc3.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 09:36:17AM +0800, CK Hu wrote:
> Hi, Jitao & Rex:
> 
> Please help to comment on this patch.

Hi Chuang,

I already sent a v2 of this patch [1] because I forgot to add the Fixes tag.
Sorry for the noise.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220408013950.674477-1-nfraprado@collabora.com/

> 
> On Thu, 2022-04-07 at 21:19 -0400, Nícolas F. R. A. Prado wrote:
> > The configuration for mt8192 was incorrectly using the output formats
> > from mt8173. Since the output formats for mt8192 are instead the same
> > ones as for mt8183, which require two bus samples per pixel, the
> > pixelclock and DDR edge setting were misconfigured. This made
> > external
> > displays unable to show the image.
> > 
> > Fix the issue by correcting the output format for mt8192 to be the
> > same
> > as for mt8183, fixing the usage of external displays for mt8192.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 4554e2de1430..e61cd67b978f 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -819,8 +819,8 @@ static const struct mtk_dpi_conf mt8192_conf = {
> >  	.cal_factor = mt8183_calculate_factor,
> >  	.reg_h_fre_con = 0xe0,
> >  	.max_clock_khz = 150000,
> > -	.output_fmts = mt8173_output_fmts,
> > -	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> > +	.output_fmts = mt8183_output_fmts,
> > +	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
> >  };
> >  
> >  static int mtk_dpi_probe(struct platform_device *pdev)
> 
