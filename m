Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302C4F6CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiDFVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiDFVeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D7F10C1;
        Wed,  6 Apr 2022 13:46:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so6686668ejd.9;
        Wed, 06 Apr 2022 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3pN8iVk9eTtSjL65Ae9eDGs0McwPoBu0Laz3ZR/1MA=;
        b=IHXz1wUkKCmRJ1GjOREIJcNyfWmglOtNLI958+1ELRwj1TMr+UqeAJl+j6zvajmfyJ
         kDSjsLE4dAisAOmn2SF7dZAEC0yfBhK3TmN+ui24XsLhR11WuMsOEDyaFvCo5cAOiJTt
         lvf79qjM1j95pWgykfX14/CKOd7bnp135vKElX7oHmgelwQqHzdooSp4XH7D7igvJrdd
         Nov/Imj6QXxhg0uxnsislCyMWeKMnai9IqGOgtGy4STH+EJCOBXVV+iwU6REb+MGTm6C
         1SLY0948h5eAIXv9gtOHMq+G0WFLMiR9x3uW8h9SAppR8XnDQa14xYC3HDEjdNrsMdcl
         vEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3pN8iVk9eTtSjL65Ae9eDGs0McwPoBu0Laz3ZR/1MA=;
        b=d0Dn9l+zCTCFsoVZHwrTDTgJESyHdjbOzk5VBqpyQ8Qf6P+1eRGbFc06hMRYTg1By2
         VzEzBoJQblWofxADQiiH0FhVQXISkVzizmK7xG+lFW38NMiT9xiQl6D2o1P6Tv46fx13
         0FdYom+e7Zur/6fPBtij+tM4MpDX3PsmAbsqtKzhvNTvGsWA0Y2HXDh8oW9Z0Em7I65H
         Bi+FOoR60Az4ewmVF8z7kaz1en7EZq+NsqsnAFrNvygTwNSM8Y53kgYXAR0PA8esvwD0
         kX8+sfgKXUsCpftyepIA6L4Ewbdu2mT5GGFOWncp+cKcfxxugAocaJWsZC6EKomm72cZ
         6bjQ==
X-Gm-Message-State: AOAM532nwQkzYie+wo/fLmrnqNplUKfVr8ZKwigG4Lgkl75m1tESOYcN
        O+kVZBCxnpCJAN8jksOgT4E=
X-Google-Smtp-Source: ABdhPJzOs3gO5TtSASWFaPiSWsHGEoBTpf1ZqwG+HSVkjfw89HKEpezUIlS1qPi5CVyHvUd+Z9sTQA==
X-Received: by 2002:a17:907:7d8d:b0:6df:f3a6:b0d9 with SMTP id oz13-20020a1709077d8d00b006dff3a6b0d9mr10371596ejc.13.1649277984635;
        Wed, 06 Apr 2022 13:46:24 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm8286808edu.96.2022.04.06.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:46:24 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wan Jiabing <wanjiabing@vivo.com>
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: Re: [PATCH] clk: sunxi-ng: fix not NULL terminated coccicheck error
Date:   Wed, 06 Apr 2022 22:46:23 +0200
Message-ID: <5554257.DvuYhMxLoT@kista>
In-Reply-To: <2621623.mvXUDI8C0e@jernej-laptop>
References: <20220328073931.36544-1-wanjiabing@vivo.com> <2621623.mvXUDI8C0e@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 28. marec 2022 ob 18:57:28 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne ponedeljek, 28. marec 2022 ob 09:39:31 CEST je Wan Jiabing napisal(a):
> > Fix the following coccicheck error:
> > ./drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:348:1-2: sun6i_rtc_ccu_match is
> > not NULL terminated at line 348
> >=20
> > Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC=20
clocks")
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>=20
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied to sunxi/fixes-for-5.18, thanks!

Best regards,
Jernej

>=20
> Best regards,
> Jernej
>=20
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> > b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c index 8a10bade7e0d..ffb72d9a9c36
> > 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> > @@ -346,6 +346,7 @@ static const struct of_device_id sun6i_rtc_ccu_matc=
h[]=20
=3D
> > { .compatible	=3D "allwinner,sun50i-r329-rtc",
> >  		.data		=3D &sun50i_r329_rtc_ccu_data,
> >  	},
> > +	{},
> >  };
> >=20
> >  int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
>=20
>=20
>=20
>=20
>=20


