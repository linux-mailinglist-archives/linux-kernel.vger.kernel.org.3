Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380914F6B61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiDFU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiDFU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:28:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4838413D09;
        Wed,  6 Apr 2022 11:48:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k21so5687961lfe.4;
        Wed, 06 Apr 2022 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9395K+P3ckPAEpp0VngX/lMlS/mSO7/OiLA6T9rii8=;
        b=AdiupK0f5tH3mzh81yMw74TNiqYSKhpRq5BV6vNWimIJM65sCmwtO0VGTLEIQSkjg/
         xHomBGdi80pYAOjj2DuUq1oWwtOlgDYUspbmgS50UQ2XpWmFvFb64rmVAjIspPHu8v/N
         raKCDBS81RRn+l35CiP8V9s15SZMqyc+I6CC6eNFaX7SY9jCEODu+ODqKQrEXvDnNfW9
         06BmSYAMjoFA6bYLj+hs4lTp1VvofM5xzi/2yOrMuJgyl5vhhS2Qt0VQ3ZrZxNRi+m2Y
         ZVJqXmFHD7We6zWDIH1c5jJ/5vx6iC0vE5/vmSAzew0dRX0CYnl+53PUQ+FMuZ066+V3
         5MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9395K+P3ckPAEpp0VngX/lMlS/mSO7/OiLA6T9rii8=;
        b=C9xni2Se3KsxJ/qA93W+xT20Lw3+mTceU3wgH16Dve2CQ7nmCmvrtOUmZD0avnYS2S
         YmqpjEb78NypbSAU+0QDfalhlbm7FtQnPIlFdG/05lAYnVqgSslrUyVzNxG5yHzUXbtT
         5TUZYkFpCdtJwRYIvdGa4Mx+fmCErSMshhNppBLX2HnXOMvylHXA5DgldxXFZ8Mw32/b
         RZ9UKjpvY8iAEM3wSAylA1/cwa3L6vBrcRLV5ILiJq4shdrvxaFjGIoU9E/buKc4gkVP
         kFZOU3CpMbZF+yCcvcX4+GLM8S+4Kp5lBqTmCd8noPP9LVf2QoKGRzIAFN6HnTxNcc44
         6Hzw==
X-Gm-Message-State: AOAM532pgeNnve5fE9O4raZl5zCCcOeWUnFsS38sUmEVI1sjGjGMNMMv
        J99BOXbnijdY3dBwS55rfaP1ZIb57nLf9boT
X-Google-Smtp-Source: ABdhPJzNADicM+sXa4roBFQ7B2f4eH3VnwkH5xkwOrMbesUL+8GJo8yXhHvLj4BO2Bo5WHfPEDGStA==
X-Received: by 2002:a05:6512:39c1:b0:44a:e25d:47fd with SMTP id k1-20020a05651239c100b0044ae25d47fdmr6907751lfu.580.1649270897430;
        Wed, 06 Apr 2022 11:48:17 -0700 (PDT)
Received: from dell.intranet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id e14-20020a19500e000000b0044a16931c7csm1912219lfb.97.2022.04.06.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:48:16 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-mmc@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ARM: OMAP1: Prepare for conversion of OMAP1 clocks to CCF
Date:   Wed, 06 Apr 2022 20:48:14 +0200
Message-ID: <1888452.PYKUYFuaPT@dell>
In-Reply-To: <20220406132149.GC594699@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-3-jmkrzyszt@gmail.com> <1810824.tdWV9SEqCh@dell> <20220406132149.GC594699@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia =C5=9Broda, 6 kwietnia 2022 15:21:49 CEST Aaro Koskinen pisze:
> Hi,
>=20
> On Sat, Mar 26, 2022 at 10:17:49PM +0100, Janusz Krzysztofik wrote:
> > Dnia wtorek, 22 marca 2022 20:07:53 CET Aaro Koskinen pisze:
> > > On Tue, Mar 22, 2022 at 06:36:48PM +0200, Aaro Koskinen wrote:
> > > > Something is still broken. When doing kexec (using CCF kernel), the
> > > > kexec'ed kernel now hangs early (on 770):
> > > [...]
> > > > [    0.928863] calling  omap1_init_devices+0x0/0x2c @ 1
> > >=20
> > > It hangs in omap_sram_reprogram_clock() (<- omap1_select_table_rate()
> > > <- omap1_clk_late_init()).
> >=20
> > I've reviewed my changes but haven't found anything suspicious.
>=20
> The below change is fixing the kexec boot. Based on the comment in the
> code, it seems this clock is needed for the SRAM to work.
>=20
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock=
_data.c
> index e33e11f826af..b8b4876ff935 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -285,7 +285,7 @@ static struct omap1_clk tc1_ck =3D {
>   */
> =20
>  static struct omap1_clk tc2_ck =3D {
> -	.hw.init	=3D CLK_HW_INIT("tc2_ck", "tc_ck", &omap1_clk_gate_ops, 0),
> +	.hw.init	=3D CLK_HW_INIT("tc2_ck", "tc_ck", &omap1_clk_gate_ops, CLK_IS=
_CRITICAL),
>  	.ops		=3D &clkops_generic,
>  	.enable_reg	=3D OMAP1_IO_ADDRESS(ARM_IDLECT3),
>  	.enable_bit	=3D EN_TC2_CK,
>=20
> A.
>=20

Thank you Aaro.  Will you submit this as a separate fix, or should I submit=
=20
v2 of my patch 4/4 with your fix included?

Thanks,
Janusz



