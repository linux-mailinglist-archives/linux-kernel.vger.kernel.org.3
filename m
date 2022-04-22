Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFAC50BDB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiDVQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiDVQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:58:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B660041;
        Fri, 22 Apr 2022 09:55:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so15324277lfb.3;
        Fri, 22 Apr 2022 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2pYMeHUvcayBz/9UI4GynHSCHFwlqj2AHLeRRSA2YCs=;
        b=krXyhcne24yR9Gh9Zw9iW5pAPfymD6ScOTFGCbwgAiEfrdkto4s0WJKBkiyMT9wS8U
         qiZ7Jeg4UtHkQycTkuZGLLXyhFIg28tnP4MQtX6j3dYWYo+1EYN3FDI1O4FjoZpL63r7
         QuM0xTeyJ5IS0MuRNgZGFlo4BSax11D4NhIfsyHR51g700L3yGXcPgJHkP2wbd6Eor5n
         rU3y/q11XVacnnOn7FMunwUUEC1z4BWbibkdKs4mGKjzBnft6qUcb0lgGy0thSIrv+h3
         VDLdceA8c369rBPYYPT2F5w8MsDASgxJ3u15mtaP8SWcxy8OPYBCl/mj19AmQKdFPS2A
         3TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2pYMeHUvcayBz/9UI4GynHSCHFwlqj2AHLeRRSA2YCs=;
        b=wiWuArXZaLbxkN1NamDR7yBhy2ujn5vdVaFp+qv1MVnTaxdQ3EhgMTAaAB4tL1rQ+p
         JPkYRx5K966Kx0XIMnF/YdVCMiOFsmLeymW0CUtgDje8Oa6jRIARET2WUCyUTPoIFCrx
         X5fYOxdsMLNS3meioOiX2xpgTOegkJlvKHR4MBQdvSefAtPcK1rblur0e0D2++KVuAuA
         XAw0uIpx7mrbUkRpb4bZ4RFU8w3pmaqE610RnLqVk8OBIeHozcCekKOg6fGbNLTfNfi9
         772kICuE050BddmZh1jL40VZ7FyXF6jJM/R9gizCc7B5yo45WsQX6+gEclMbs2Sqgq4/
         LnVA==
X-Gm-Message-State: AOAM532L8Mv/8MaUa8Hp0RjTO8cpJORvg/QR+/eQ/w3c/1EqxXtR6gXk
        w2WchsXRpiILAlLxJNLfT1A=
X-Google-Smtp-Source: ABdhPJyCViL6TK3OhUnGEKGOgIn1Xu+YgBPckSSxDddGfTZMPnPildVIxagVVGzqWFFbTgRd6cy4kg==
X-Received: by 2002:a19:5f0e:0:b0:44b:111:1622 with SMTP id t14-20020a195f0e000000b0044b01111622mr3758916lfb.161.1650646557381;
        Fri, 22 Apr 2022 09:55:57 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a2-20020a19e302000000b00471988e79cdsm282219lfh.180.2022.04.22.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:55:56 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:55:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     xinlei.lee@mediatek.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rex-bc.chen@mediatek.com,
        jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6,0/5] Convert pwm-mtk-disp.txt to mediatek,
 pwm-disp.yaml format
Message-ID: <YmLeGaZ0hX1kj9+v@orome>
References: <1650284456-16407-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LcAPuwLqmWX+Fefx"
Content-Disposition: inline
In-Reply-To: <1650284456-16407-1-git-send-email-xinlei.lee@mediatek.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LcAPuwLqmWX+Fefx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2022 at 08:20:51PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
>=20
> Change since v5:
> 1.Add interrupts property.
>=20
> Changes since v4:
> 1.Base on Linux-next.
> 2.Cancel removal of mt8167 compatiable patch.
>=20
> Changes since v3:
> 1. Combine multiplexed socs into one entry
>=20
> Changes since v2:
> 1. Modify the PWM name to DISP_PWM.
> 2. Include pwm.yaml.
> 3. Separate conversion files and add/remove operations.
>=20
> Changes since v1:
> 1. Fixed formatting issues mentioned in the v1.
> 2. Delete pwm-mtk-disp.txt.
> 3. Add mtk_pwm dt_maintainers.
> 4. Add "#pwm-cells" & power-domains properties.
> 5. Make dt_checking successful.
>=20
> Xinlei Lee (5):
>   dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
>     format
>   dt-bindings: pwm: Add compatible for MediaTek MT8192
>   dt-bindings: pwm: Add compatible for MediaTek MT8195
>   dt-bindings: pwm: Add compatible for MediaTek MT8186
>   dt-bindings: pwm: Add interrupts property for MediaTek MT8192
>=20
>  .../bindings/pwm/mediatek,pwm-disp.yaml       | 75 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 45 -----------
>  2 files changed, 75 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,pwm-di=
sp.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

Applied, thanks.

Thierry

--LcAPuwLqmWX+Fefx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi3hkACgkQ3SOs138+
s6Huww/+LcxzjgeWvFFCu2uvAQB4pL5HxJI4grLWEbFg0ZLeOWl664dx3po5VI65
cMvtk+MVuoHjnUC4OWUXHIzrj0S9dGtyvMzD0XfeANgoS0j/+5HJ4ywhkRyhjd/k
SOFBE9f46qErRtUub+9XlH5v5CnpjVraYhlhHPYUEYEAhUzX8XC+4AzpJIY1hb8C
D/rOhvyjAPzk8OzGlNpRwM3N1qH7jZI2PIF336N3TU1yMo270dNroGVPEIm/k1bC
ToO6cYUWNsduq+i2n1d38CqDPwrhEvqvL05vvLZO05zlBCevqFsR1fTO3cE9nD5c
cv0MWGU7hSsxJaMdu8V7f65vVtTyeshyo4RYSGlBRfNCTccYTTjl5NU3brICfx7x
Sbp2KbpF1/+xdHYRLPor+G/gTJUuFuSujl/G3W2ZtCoQOIwrs8I/8jFv5HsHzkZU
AZTzahQ1YbmILSDJ0wwxAHDT1/+NwQs7f3X5JosyLmM4I0Admbdx89XIUCszVruc
dVn6CqNbLcJFXvyuKDauTjzYXYBgNwHq65d1qiy724VnkfJ8vnmCa6G+XEyM6oeJ
5WSIq9As3pv47IjTPf7esxka9YQLAMVis4wxFTXGkjTEx809Rxz5KXr2ZwKBke+5
Tw64dlGnIGEdXu0nklgQDJLJDG6fUN76A6KxE8oRr4eK9mcbV3Q=
=KqxN
-----END PGP SIGNATURE-----

--LcAPuwLqmWX+Fefx--
