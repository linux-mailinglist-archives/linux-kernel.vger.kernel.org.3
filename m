Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC24EA207
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbiC1UyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345570AbiC1UyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B461D6A017;
        Mon, 28 Mar 2022 13:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4245B614D2;
        Mon, 28 Mar 2022 20:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648FAC340ED;
        Mon, 28 Mar 2022 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500745;
        bh=N/Mi+PGWs8OqS2Bvq299hegPxWASce6WbyKYFt4ohE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RySkxh15FrfG49Tr98cWeTF2F0j5cnvMqNChI0B1rHuhSF0nTxwTSAVOzmnItB1MV
         3ST2VUlhjA0fCTWylxJbeIEdqDsrqIq8Fqcxb/reN+5JoXE8NkupmjnAQqOti4rRtM
         KPeU/CshcxAopu1cNtk5OylbIQRuyAcytBfAMi1cmfaydZ+SdPLN2igTZ6N1+C4SS6
         xk9+6IHInqImFtjWRGI1pEmV+2x6+CZC5ILz0uSO8CieYH5R4PdsnGNFJSffeVoB0i
         aq9FnS0NuXBM+H+YNQEznEGVsHC9ZqHCZLPStRPUwwjKE75yDMe8j/uDec4ieLkae2
         6Uiqa8FG83PWg==
Date:   Mon, 28 Mar 2022 22:52:21 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Benjamin =?UTF-8?B?U3TDvHJ6?= <benni@stuerz.xyz>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 16/22 v3] dvb-usb: Replace comments with C99
 initializers
Message-ID: <20220328225221.6543f8f8@coco.lan>
In-Reply-To: <66a2f60d-a23b-b62f-d91a-64538388ae65@stuerz.xyz>
References: <20220326165909.506926-1-benni@stuerz.xyz>
        <20220326165909.506926-16-benni@stuerz.xyz>
        <20220326192454.14115baa@coco.lan>
        <20220326192720.0fddd6dd@coco.lan>
        <63a5e3143e904d1391490f27cc106be894b52ca2.camel@perches.com>
        <bc2d4f83-0674-ccae-71c8-14427de59f96@lwfinger.net>
        <20220326220832.12b4e91b@coco.lan>
        <66a2f60d-a23b-b62f-d91a-64538388ae65@stuerz.xyz>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 28 Mar 2022 20:08:30 +0200
Benjamin St=C3=BCrz <benni@stuerz.xyz> escreveu:

> Replace comments telling the index with explicit designators and make
> the array entries more compact to aid in better readability.

Just using designated initializers is not enough for dvb-usb, as the
big issue there is really the fact that the dvb-usb struct needs to point
to the entries inside the USB ID table.

Also, your patch touches only two of the several dvb-usb drivers. So,
I ended taking some time and writing a series:

	https://lore.kernel.org/linux-media/cover.1648499509.git.mchehab@kernel.or=
g/T/#t

Giving you credits for suggesting it at the dibusb-* patches.

> It was suggested to make the arrays const, but that didn't compile.

Yeah, the struct that points to it is not marked as const, as there
are a couple of drivers that actually change some things there.

As I said, the real fix would be to just migrate the drivers from
the legacy dvb-usb core to the newer dvb-usb-v2.

But, at least with the newer series, the risk of pointing to the
wrong entry is reduced.

Regards,
Mauro

>=20
> Signed-off-by: Benjamin St=C3=BCrz <benni@stuerz.xyz>
> ---
>  drivers/media/usb/dvb-usb/dibusb-mb.c | 69 ++++++++++++++-------------
>  drivers/media/usb/dvb-usb/dibusb-mc.c | 39 ++++++++-------
>  2 files changed, 59 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/media/usb/dvb-usb/dibusb-mb.c
> b/drivers/media/usb/dvb-usb/dibusb-mb.c
> index e9dc27f73970..ec1fb30c5665 100644
> --- a/drivers/media/usb/dvb-usb/dibusb-mb.c
> +++ b/drivers/media/usb/dvb-usb/dibusb-mb.c
> @@ -120,42 +120,45 @@ static int dibusb_probe(struct usb_interface *intf,
>  	return -EINVAL;
>  }
>=20
> +#define DIB_DEVICE(vid, pid)	\
> +	{ USB_DEVICE(USB_VID_##vid, USB_PID_##pid) }
> +
>  /* do not change the order of the ID table */
>  static struct usb_device_id dibusb_dib3000mb_table [] =3D {
> -/* 00 */	{ USB_DEVICE(USB_VID_WIDEVIEW,=09
> USB_PID_AVERMEDIA_DVBT_USB_COLD) },
> -/* 01 */	{ USB_DEVICE(USB_VID_WIDEVIEW,=09
> USB_PID_AVERMEDIA_DVBT_USB_WARM) },
> -/* 02 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
> -/* 03 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_WARM) },
> -/* 04 */	{ USB_DEVICE(USB_VID_COMPRO_UNK,
> USB_PID_COMPRO_DVBU2000_UNK_COLD) },
> -/* 05 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_COLD) },
> -/* 06 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_WARM) },
> -/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_COLD) },
> -/* 08 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_WARM) },
> -/* 09 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_COLD)=
 },
> -/* 10 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_WARM)=
 },
> -/* 11 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_COLD) },
> -/* 12 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_WARM) },
> -/* 13 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,
> USB_PID_UNK_HYPER_PALTEK_COLD) },
> -/* 14 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,
> USB_PID_UNK_HYPER_PALTEK_WARM) },
> -/* 15 */	{ USB_DEVICE(USB_VID_VISIONPLUS,	USB_PID_TWINHAN_VP7041_COLD) },
> -/* 16 */	{ USB_DEVICE(USB_VID_VISIONPLUS,	USB_PID_TWINHAN_VP7041_WARM) },
> -/* 17 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_COLD) },
> -/* 18 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_WARM) },
> -/* 19 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_COLD) },
> -/* 20 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_WARM) },
> -/* 21 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
> -/* 22 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
> -/* 23 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_COLD) },
> +	[0]  =3D DIB_DEVICE(WIDEVIEW,		AVERMEDIA_DVBT_USB_COLD),
> +	[1]  =3D DIB_DEVICE(WIDEVIEW,		AVERMEDIA_DVBT_USB_WARM),
> +	[2]  =3D DIB_DEVICE(COMPRO,		COMPRO_DVBU2000_COLD),
> +	[3]  =3D DIB_DEVICE(COMPRO,		COMPRO_DVBU2000_WARM),
> +	[4]  =3D DIB_DEVICE(COMPRO_UNK,		COMPRO_DVBU2000_UNK_COLD),
> +	[5]  =3D DIB_DEVICE(DIBCOM,		DIBCOM_MOD3000_COLD),
> +	[6]  =3D DIB_DEVICE(DIBCOM,		DIBCOM_MOD3000_WARM),
> +	[7]  =3D DIB_DEVICE(EMPIA,		KWORLD_VSTREAM_COLD),
> +	[8]  =3D DIB_DEVICE(EMPIA,		KWORLD_VSTREAM_WARM),
> +	[9]  =3D DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB_COLD),
> +	[10] =3D DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB_WARM),
> +	[11] =3D DIB_DEVICE(GRANDTEC,		DIBCOM_MOD3000_COLD),
> +	[12] =3D DIB_DEVICE(GRANDTEC,		DIBCOM_MOD3000_WARM),
> +	[13] =3D DIB_DEVICE(HYPER_PALTEK,		UNK_HYPER_PALTEK_COLD),
> +	[14] =3D DIB_DEVICE(HYPER_PALTEK,		UNK_HYPER_PALTEK_WARM),
> +	[15] =3D DIB_DEVICE(VISIONPLUS,		TWINHAN_VP7041_COLD),
> +	[16] =3D DIB_DEVICE(VISIONPLUS,		TWINHAN_VP7041_WARM),
> +	[17] =3D DIB_DEVICE(TWINHAN,		TWINHAN_VP7041_COLD),
> +	[18] =3D DIB_DEVICE(TWINHAN,		TWINHAN_VP7041_WARM),
> +	[19] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_COLD),
> +	[20] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_WARM),
> +	[21] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_AN2235_COLD),
> +	[22] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_AN2235_WARM),
> +	[23] =3D DIB_DEVICE(ADSTECH,		ADSTECH_USB2_COLD),
>=20
>  /* device ID with default DIBUSB2_0-firmware and with the hacked
> firmware */
> -/* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
> -/* 25 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_COLD) },
> -/* 26 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_WARM) },
> +	[24] =3D DIB_DEVICE(ADSTECH,		ADSTECH_USB2_WARM),
> +	[25] =3D DIB_DEVICE(KYE,			KYE_DVB_T_COLD),
> +	[26] =3D DIB_DEVICE(KYE,			KYE_DVB_T_WARM),
>=20
> -/* 27 */	{ USB_DEVICE(USB_VID_KWORLD,		USB_PID_KWORLD_VSTREAM_COLD) },
> +	[27] =3D DIB_DEVICE(KWORLD,		KWORLD_VSTREAM_COLD),
>=20
> -/* 28 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_USB2_COLD) },
> -/* 29 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_USB2_WARM) },
> +	[28] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_COLD),
> +	[29] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_WARM),
>=20
>  /*
>   * XXX: As Artec just 'forgot' to program the EEPROM on some Artec T1
> devices
> @@ -166,13 +169,15 @@ static struct usb_device_id dibusb_dib3000mb_table
> [] =3D {
>   */
>=20
>  #ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
> -/* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD)=
 },
> +	[30] =3D DIB_DEVICE(ANCHOR,		ULTIMA_TVBOX_ANCHOR_COLD),
>  #endif
>=20
> -			{ }		/* Terminating entry */
> +	{ }		/* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE (usb, dibusb_dib3000mb_table);
>=20
> +#undef DIB_DEVICE
> +
>  static struct dvb_usb_device_properties dibusb1_1_properties =3D {
>  	.caps =3D  DVB_USB_IS_AN_I2C_ADAPTER,
>=20
> diff --git a/drivers/media/usb/dvb-usb/dibusb-mc.c
> b/drivers/media/usb/dvb-usb/dibusb-mc.c
> index e2689977c8c8..703c2a7df369 100644
> --- a/drivers/media/usb/dvb-usb/dibusb-mc.c
> +++ b/drivers/media/usb/dvb-usb/dibusb-mc.c
> @@ -23,28 +23,33 @@ static int dibusb_mc_probe(struct usb_interface *intf,
>  				   NULL, adapter_nr);
>  }
>=20
> +#define DIB_DEVICE(vid, pid)	\
> +	{ USB_DEVICE(USB_VID_##vid, USB_PID_##pid) }
> +
>  /* do not change the order of the ID table */
>  static struct usb_device_id dibusb_dib3000mc_table [] =3D {
> -/* 00 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_COLD) },
> -/* 01 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_WARM) },
> -/* 02 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_USB2_COLD) },
> -/* 03 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
> USB_PID_ULTIMA_TVBOX_USB2_WARM) }, // ( ? )
> -/* 04 */	{ USB_DEVICE(USB_VID_LITEON,		USB_PID_LITEON_DVB_T_COLD) },
> -/* 05 */	{ USB_DEVICE(USB_VID_LITEON,		USB_PID_LITEON_DVB_T_WARM) },
> -/* 06 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_DIGIVOX_MINI_SL_COLD) },
> -/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_DIGIVOX_MINI_SL_WARM) },
> -/* 08 */	{ USB_DEVICE(USB_VID_GRANDTEC,
> USB_PID_GRANDTEC_DVBT_USB2_COLD) },
> -/* 09 */	{ USB_DEVICE(USB_VID_GRANDTEC,
> USB_PID_GRANDTEC_DVBT_USB2_WARM) },
> -/* 10 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ARTEC_T14_COLD)=
 },
> -/* 11 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ARTEC_T14_WARM)=
 },
> -/* 12 */	{ USB_DEVICE(USB_VID_LEADTEK,		USB_PID_WINFAST_DTV_DONGLE_COLD)=
 },
> -/* 13 */	{ USB_DEVICE(USB_VID_LEADTEK,		USB_PID_WINFAST_DTV_DONGLE_WARM)=
 },
> -/* 14 */	{ USB_DEVICE(USB_VID_HUMAX_COEX,
> USB_PID_DVB_T_USB_STICK_HIGH_SPEED_COLD) },
> -/* 15 */	{ USB_DEVICE(USB_VID_HUMAX_COEX,
> USB_PID_DVB_T_USB_STICK_HIGH_SPEED_WARM) },
> -			{ }		/* Terminating entry */
> +	[0]  =3D DIB_DEVICE(DIBCOM,		DIBCOM_MOD3001_COLD),
> +	[1]  =3D DIB_DEVICE(DIBCOM,		DIBCOM_MOD3001_WARM),
> +	[2]  =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_COLD),
> +	[3]  =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_WARM), // ( ? )
> +	[4]  =3D DIB_DEVICE(LITEON,		LITEON_DVB_T_COLD),
> +	[5]  =3D DIB_DEVICE(LITEON,		LITEON_DVB_T_WARM),
> +	[6]  =3D DIB_DEVICE(EMPIA,		DIGIVOX_MINI_SL_COLD),
> +	[7]  =3D DIB_DEVICE(EMPIA,		DIGIVOX_MINI_SL_WARM),
> +	[8]  =3D DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB2_COLD),
> +	[9]  =3D DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB2_WARM),
> +	[10] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ARTEC_T14_COLD),
> +	[11] =3D DIB_DEVICE(ULTIMA_ELECTRONIC,	ARTEC_T14_WARM),
> +	[12] =3D DIB_DEVICE(LEADTEK,		WINFAST_DTV_DONGLE_COLD),
> +	[13] =3D DIB_DEVICE(LEADTEK,		WINFAST_DTV_DONGLE_WARM),
> +	[14] =3D DIB_DEVICE(HUMAX_COEX,		DVB_T_USB_STICK_HIGH_SPEED_COLD),
> +	[15] =3D DIB_DEVICE(HUMAX_COEX,		DVB_T_USB_STICK_HIGH_SPEED_WARM),
> +	{ }					/* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE (usb, dibusb_dib3000mc_table);
>=20
> +#undef DIB_DEVICE
> +
>  static struct dvb_usb_device_properties dibusb_mc_properties =3D {
>  	.caps =3D DVB_USB_IS_AN_I2C_ADAPTER,
>=20



Thanks,
Mauro
