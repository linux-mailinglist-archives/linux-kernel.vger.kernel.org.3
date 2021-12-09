Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A565746F735
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhLIXIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhLIXI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:08:28 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B112C061D76
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:04:50 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r5so6440202pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AM7QLMUWHfMwmQDV/nARvLu6AUqKl6gTrIizSq8pCV0=;
        b=qCUTYflpJD3Ut8S3L9vAdsRCFkfP6S1UK/pYIcT6QfgUqj3IrkrCT4ezn3jaOsf3Cl
         QWXXPUZs+WxnhUjOZmGD3MD+yMr1uQ4MPnml+A3U6sVIr1NuDQjnxAVWqlzhj2iKBJ3v
         UVZc3vL3u8GPqVzXjH8o2LZKH9265/3UW1CVYplUB1MgkH9c5ybvjJIKVXYJvrcLh394
         P90V/cOnkBv/iNu+Q/0tn+tcZb57JKYcdbPJW+sK8l4beDVlSxBGGYj3kX/T4AxOqfIl
         UB/2KhtFPncq+0yKdb9T39Tq3TJiyLrFSDV3H0HYU7qUuLOVeojoQvZgvAswjkqck/q8
         PFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AM7QLMUWHfMwmQDV/nARvLu6AUqKl6gTrIizSq8pCV0=;
        b=6PfAG1kMH+hVWHIe2UhTH9qLYAGS2As1gHVBtxpArFWAdGDSxANGYJUYbiSPisTPJy
         NRbSIqmcznxXqM+y4CTU5FYKQYH2TwZ2NsVXeJDR4ds5zMsMTLly8+4m2ezU8b39I3me
         bbk4ElPzKHIszlPu6yDBH5TkTG9bx0kaGwgLOl2ZjZ4x2njbNyLkKTc06C0uF3dbTXyF
         YUogTFgvw65jj0kY2YxR1ToDD3M4g7K8iVz4hC7pOlWaXmhmzFnycD+BcLpu8PZtAsZj
         uetdgUd1NrHYFqUV8Ww1wMUh9Vm4fW5TsmBW4BdQPmjI4NgGj6IFXe/zAWcFqQ9N/FWC
         dCUQ==
X-Gm-Message-State: AOAM533tJLEofWiXLGXtKoDF5jkSebxQ1ajrEfNo8JeKGOn1iRCr7NhC
        OJvWGCzjUeJp6wFj6i3bX06Fhw==
X-Google-Smtp-Source: ABdhPJwv3BwHdZiLi1ZhC5t+Cp5jkK/HRMF9Ysg4XP1dLe3XT0E5UCPyHw6UtZFq3qUMnwim2AuqFw==
X-Received: by 2002:a63:6dcc:: with SMTP id i195mr35590826pgc.90.1639091089661;
        Thu, 09 Dec 2021 15:04:49 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4686:81c:7840:3f2a])
        by smtp.gmail.com with ESMTPSA id o1sm10610131pjs.30.2021.12.09.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 15:04:48 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:04:42 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Alexandru M Stan <amstan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: mt8183: kukui: Add Type C node
Message-ID: <YbKLiic12TTlCI5K@google.com>
References: <20211209195112.366176-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h0DgCffirGSPqlD0"
Content-Disposition: inline
In-Reply-To: <20211209195112.366176-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h0DgCffirGSPqlD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 11:51:12AM -0800, Prashant Malani wrote:
> Add a node describing the USB Type C connector, in order to utilize the
> Chromium OS USB Type-C driver that enumerates Type-C ports and connected
> cables/peripherals and makes them visible to userspace.
>=20
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>=20
> Changes in v2:
> - Alexandru mentioned that HW specs suggest preferred power role for
>   devices like kukui to be sink, so changed try-power-role to "sink".
>=20
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/=
boot/dts/mediatek/mt8183-kukui.dtsi
> index 94c13c459194..0f9480f91261 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -886,6 +886,20 @@ usbc_extcon: extcon0 {
>  		cbas {
>  			compatible =3D "google,cros-cbas";
>  		};
> +
> +		typec {
> +			compatible =3D "google,cros-ec-typec";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			usb_c0: connector@0 {
> +				compatible =3D "usb-c-connector";
> +				reg =3D <0>;
> +				power-role =3D "dual";
> +				data-role =3D "host";
> +				try-power-role =3D "sink";
> +			};
> +		};
>  	};
>  };
> =20
> --=20
> 2.34.1.173.g76aa8bc2d0-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--h0DgCffirGSPqlD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYbKLigAKCRBzbaomhzOw
wgTfAP0UKw0CIZnkq7XRxizWU1ISWsbA7Fg4wi8F3FRlEtjalgD/RnGrQZDBRr7E
LnQC2+PGRByTSZwMCNTeptgTOh+8IAA=
=fRVO
-----END PGP SIGNATURE-----

--h0DgCffirGSPqlD0--
