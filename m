Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F314D7433
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiCMKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiCMKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:14:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32953DEAC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 03:13:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g17so22289797lfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m2Ai362wiP1vbbI9s63xOoA0fn/s0S5gwcjrtQUOdC0=;
        b=Xb2KG/qzbCzKWRqqkFkNLDfgZbNIdJq0K48cH98toOKzlr++cToOqHLTfu6dONqa9n
         E4l0UR2UGi2dW6U+ARQf6VscmLDjBYT3A6EBOGd34QBivuhQ9RVHylgsSjxO/MvlUgdt
         CkidXajy0njCyepY4aBdXlDLMRXsIf+1ufVPdpqE4qiu6v9tkMMfyW8I9CM1D0bUDg9A
         aXq1TrhMc8QyQSkfuf9tSJE5U4fJQanWybZm1Y8VW3ZDIilhUPWz2ho+TYbdl9cEDdVj
         gfW3YiVi62q8A8osD/oTlUEZVcwCH0A0RJuIqiH6blQyygQsyjDbr/zvU0m2Zjjngrow
         S/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m2Ai362wiP1vbbI9s63xOoA0fn/s0S5gwcjrtQUOdC0=;
        b=1mtGyjMShMwzuCfGOFHMu7bP17lFK1CjQ9dqm03onKZxrIfL5fJ9BpLoxfecfghmOy
         x6J4V5C4T/OdG9gYwot5sr6HxSQWKyA9GjNVQ+befjKCZpXGG9kOghTlYXI1nQR2+YZe
         r6vx8l0226v8HFGbq2ZWUXG7zkTbWxD+HAlEvOPogU6wHVMiqqjNKrtzhVZT1GTCpGMJ
         eLF/jOfZhgtHIWWAwuugC4GKzMcCtW63V8drSaFJbovX3wVXTjHMlS70xYZLGjKCuLrO
         6sQAx79xOTjsScLYFBXJlUuTMKmJtWJwVDAHW63lYA1KRBtkL/vAnJ+/GVYcXjMASwso
         g1eQ==
X-Gm-Message-State: AOAM531SFwqb4CgN+BUXuk5EY54qNkVQEYnneX/WNJ5OmX9gMHoNXD9P
        iB4U7LWN1yDO7XHcvbVtjZ0=
X-Google-Smtp-Source: ABdhPJyCp5AaYs+cO005a0E86TOpIdIPyD2467a87+CRiH9PN/jRXTTSeStgacBI42adrU6kiqdj6g==
X-Received: by 2002:a05:6512:e90:b0:448:6d41:c736 with SMTP id bi16-20020a0565120e9000b004486d41c736mr7125972lfb.453.1647166381462;
        Sun, 13 Mar 2022 03:13:01 -0700 (PDT)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id bp4-20020a056512158400b0044332792f30sm2649522lfb.175.2022.03.13.03.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 03:13:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20220126202427.3047814-1-pgwipeout@gmail.com>
Date:   Sun, 13 Mar 2022 11:12:59 +0100
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre-Hugues Husson <phh@phh.me>,
        Archit Taneja <architt@codeaurora.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AFD1DD4-AF0A-4ECC-B4F5-E6BD6B9F1BB7@gmail.com>
References: <20220126202427.3047814-1-pgwipeout@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w =
dniu 26.01.2022, o godz. 21:24:
>=20
> The hdmi-cec clock must be 32khz in order for cec to work correctly.
> Ensure after enabling the clock we set it in order for the hardware to
> work as expected.
> Warn on failure, in case this is a static clock that is slighty off.
> Fixes hdmi-cec support on Rockchip devices.
>=20
> Fixes: ebe32c3e282a ("drm/bridge: synopsys/dw-hdmi: Enable cec clock")
>=20
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c =
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 54d8fdad395f..1a96da60e357 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -48,6 +48,9 @@
>=20
> #define HDMI14_MAX_TMDSCLK	340000000
>=20
> +/* HDMI CEC needs a clock rate of 32khz */
> +#define HDMI_CEC_CLK_RATE	32768
> +
> enum hdmi_datamap {
> 	RGB444_8B =3D 0x01,
> 	RGB444_10B =3D 0x03,
> @@ -3347,6 +3350,10 @@ struct dw_hdmi *dw_hdmi_probe(struct =
platform_device *pdev,
> 				ret);
> 			goto err_iahb;
> 		}
> +
> +		ret =3D clk_set_rate(hdmi->cec_clk, HDMI_CEC_CLK_RATE);
> +		if (ret)
> +			dev_warn(hdmi->dev, "Cannot set HDMI cec clock =
rate: %d\n", ret);
> 	}
>=20
> 	/* Product and revision IDs */
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Peter,

On my 5.17-rc7 with applied rk356x VOP2 v8 series - this patch makes CEC =
working on rk3566.
Unfortunately it breaks working ok CEC on rk3399 rockpi-4b.

Reverting this patch brings back CEC on rk3399 - but rk3366 becomes with =
non working CEC
=20
I'm not sure how to move forward with this....
=20
br=
