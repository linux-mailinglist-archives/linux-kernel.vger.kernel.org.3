Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340484A3C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357015AbiAaAX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:23:29 -0500
Received: from mail-os0jpn01on2137.outbound.protection.outlook.com ([40.107.113.137]:62275
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233085AbiAaAX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:23:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiBQ13RkbtFiCf4WuxOKtcItHAIcMAz6voaCiTjz34VfJ7G1jDb99H4n77ggn+KQpQT3tIkNQF41Ta2bxyBCK2gJyYEHSP33+dhiDw7emQcwKIn4g046qG4018t4vx0z2ew982cZU6c3ACIpD9O+EaV4ANmrXl4BdrArpwDC1xxcLDKpOnvr02aBoYa0vdExfrmdnQzjicAM5ZHw8l4k9DoMlivcmQtYo4VQeS7yW+LVtL8E2WOzxYPKZXJIlH+sk64zrgglJG5dwaXTAL8+YxZCplnbTk/Jc76lB6iXH1O4aO5IqWIRk3uzEToRifdtPq69QPQ2dNfWkZp/4xpkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJrNLkQj1tBwr5KSD/c7uAg8PTQ8w2CMnTJ5PRIkUPI=;
 b=VPGjZQC9a6DXwneSeDJlqt2lokM71PBoXB9ovKKFYcye9hj4feAD6z0+nQpSmK8+AZnKHb6zsy7qQaAJXNIBxAdNO2FuYdmd1dkToLL4J+2NlvxhgCesEQMXVs/9L60NUweGLoVA6wradR16S0ZT7ctyd4ZgKEE2L6FOpLdotVw8ah7nDGA3cjxtgUfZsRSn6Qtkdh+1EcYmBOnact94MUztOSoiJE9u7ne+XPZ/07aLV9uZMETtIkB2mBT+WrtvOaDCY6oh2RNnlwVnsHuE+4DeJXMPpYIvgRwm70/x/adJW1zg4mIvEy7qKCVO7wK/edxZO5aq+AcDrNZEBtmFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJrNLkQj1tBwr5KSD/c7uAg8PTQ8w2CMnTJ5PRIkUPI=;
 b=ab2oqQmqSfC2wWWoKrhkxq8vSuam6LF5rLiP4SCKDd3K4KpojR+Ils0DEeP3ERj8C4hg8CA6xMc1lEJLO5utOj/1LLcr1BypPe9wJfyCS7fYjfddNgd7itm+lenBrCY/vUOtuN+XxbIy6e/JA+BBGnI2jzCxERp4so9smQzG58M=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5183.jpnprd01.prod.outlook.com
 (2603:1096:404:128::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Mon, 31 Jan
 2022 00:23:25 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7%4]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 00:23:25 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Adam Ford <aford173@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "cstevens@beaconembedded.com" <cstevens@beaconembedded.com>,
        "aford@beaconembedded.com" <aford@beaconembedded.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix host to USB_ROLE_NONE
 transition
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix host to
 USB_ROLE_NONE transition
Thread-Index: AQHYFJd9+7LdO0NmmU+VXClGrRksuqx8RUaQ
Date:   Mon, 31 Jan 2022 00:23:25 +0000
Message-ID: <TYBPR01MB53418BE9FC9E11B901DF561DD8259@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220128223603.2362621-1-aford173@gmail.com>
In-Reply-To: <20220128223603.2362621-1-aford173@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35360bf1-9398-424f-f6a6-08d9e44fe581
x-ms-traffictypediagnostic: TYAPR01MB5183:EE_
x-microsoft-antispam-prvs: <TYAPR01MB518321385EEE49E36BD28A39D8259@TYAPR01MB5183.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oIvyxSorH8WIc6vD1b+5cIv/S0skVfkP2sIBFhy9WJZF/8nWgERixV344Y6MBC6Gr7teyIWFjuEA1mEUI4gCCX9qcUD2hd4ixsuebNs3aFTEyyTw5x/0unJIWjLgo2f7QEaHAwBisVLUWWG7YkQuGGLOs8KhRYVtaNKwFt1vhNt2zfkgT/zAftQvvBHmgOflg+/aRcSCjGnkb2GH8bBs9vcGMcWZ8IPn2DqoJ6pQQG2AEKpgDKjZurQlcIrx4/ipRxUaxbRzJQhCJQlkEZFFhfRcV/oG/XtyUTQHk2+UqicmsJVWkCBVCXvy0DR8yS+XcxiYJjzcr2CLfzcaVwCSX7vcDBozHTdi3CNMpzIIbwuRtWM3hpvxFK4Rn4TGYUVakAyoUp87O9eOFTE/EnW2M4gI9vK/C/7UDZUJl3MQ4WrCNr4A9ElRUNxMEOCqcvCHp7i2vbsqdIgS/vRYJjOQxHzv5Uzpp4o2S88aFZN5S6s1S5co3cug0UiI+EXfmwfC5ZW6+nnIb9hEvrGLRf25mv7x51KBOwq3vWs6/i2q7zK8/W+ErPsNs3po9QWBICMS2P+Jy+dobcEcCaaioPhdSzYcBL5FyoljdwpjaVVT4aWbCQ0kKRoZeDWzEFVsGjZnudrZreOot/+9Y2QcX8KUPqF6UDuc2bF/Wl2MCMl+Wjv7HFFZKYqZ2RKI1+Het4JVGT9qVhIQR/jE2BR/t0C6sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(186003)(9686003)(86362001)(38100700002)(7696005)(5660300002)(8676002)(8936002)(64756008)(38070700005)(66446008)(76116006)(508600001)(4326008)(66946007)(66476007)(66556008)(2906002)(6506007)(110136005)(316002)(54906003)(55016003)(122000001)(83380400001)(52536014)(71200400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gGLE2tsqUr9uw0tq1ZP/ywP7ghZpBEq84/3PA3vbmcX07nuVDoFYSCOHPGFF?=
 =?us-ascii?Q?ZiiesCZSF6wF8JIvlQ9sfsAqlU7Tgz+upjgxGq202F14SRDuShRS5O38KQSe?=
 =?us-ascii?Q?HOPUtBzQ7lNt6mT1BFJkAIikM0CqM0A4+NyIuIChnWnxc3AV9IW3ZTXxLrW9?=
 =?us-ascii?Q?XDUSy0FM/lYF7RJRslgFzVdocPO1I6kK+HZbOX1VO7LZuPgAF+vqJXQdf4H3?=
 =?us-ascii?Q?E3wlJWVCnJqW3XZq9x859gRMTB2h+cfolC+SQV3dLWExKjoblhJigradOPJe?=
 =?us-ascii?Q?H9LlVRpCqFkcv87ITQM3iAFUKXwPFu1AYNzMUJgf13/mRsU8KK0hYGbRDXE6?=
 =?us-ascii?Q?57t0Tm+cMLdnDWnK0zARJp8CMRQyT7v1GpUVvjaxztPHgGVrlvVM5M22g16u?=
 =?us-ascii?Q?EsEe7Yte4kM0GCFQnV+BUlawGVgxMjtlRfCZFHxOzAvhhOoaOV+bW0L58BIK?=
 =?us-ascii?Q?kF+SOAWV+DJpUrmLk9ksRDT7VieR5tGE/P11wb6vVmvbgpFbLUv1S8Vq4WJK?=
 =?us-ascii?Q?rBGW6Dj2D98RJD7xVyMCr0pfe6Kgm/taRd6kBUm5mhopnbgrmNnhj4xJW4a7?=
 =?us-ascii?Q?CA9XGTa0xe5judc6Y3Pj7aypy8MXK2xQktsEW+RVZATTo1zsw/GmvU6u8l02?=
 =?us-ascii?Q?8dKaLDbZxTC5DpOXx/Wh2NOvANjfPo5pQ9aqVgQ+PTcsnqDq0IjgAYne+DI0?=
 =?us-ascii?Q?USHW9kBl6qZsR+vjSg2jT3hk3l+Z6nKJfqKKOLlGQH+il7niRfWv/kuSaot4?=
 =?us-ascii?Q?PVBvAQUGqPBgHqscTpKOHtu/buoT7awXbFdlJdx0kZ36zJB33xNgr37GoIsH?=
 =?us-ascii?Q?IymHRSj6yKEcEaDoSZ8aztzARPqOoSrLsh3bWVf6C0c/SKzrfXEU06e6Rrrr?=
 =?us-ascii?Q?v1bMZEUbcqudEEw2JQI3yDfRP3Eaq5gF8d5424P4C2Yocpaznh4RLvV2rGow?=
 =?us-ascii?Q?ok4X0w+bsB9OR72Z5CXqi7ajl/LyRryFpTK87uo7dotRQu+yAtY4xSf7cCcj?=
 =?us-ascii?Q?5rUyCPmZussFA1+uJmleKTUx9UToAuKuDM9z3jMvpBnqa2+ce/+4oLWtJG2o?=
 =?us-ascii?Q?5RYVrW8MWyHxwx41yDwMKqGI8aZ7KsRmkLvDeU1YiBiXF//cgsDWWdzCjQ+H?=
 =?us-ascii?Q?31xCvWkW0BdZkPhjr5OPo3VQ7pRxC2z14lagRiruj1uMjz2waUdce07Ny2gO?=
 =?us-ascii?Q?MGO5jNLdtOMOC/GGJ1fn/g2tIq/5ELwyNf5jJO76XAwJLNZMBRO0acK9QFq8?=
 =?us-ascii?Q?+7jpG5RqPPRhi7rvH48YIU++GfgD6D5P6pv9iwCA4V7AwB2zFbbd1ZCaoWtb?=
 =?us-ascii?Q?l0UeaeV1Wy78+DT+iHaKAjp/Sjbt4Du0gJ6EDQbGua7+oRf76PAbsgwr1f1W?=
 =?us-ascii?Q?iq5UWAWBbEt36YeNKhBTzrxuNl/KcFFIsoXA8Wq87C7XNpnu7KapDBChkvCn?=
 =?us-ascii?Q?tEeNLIDWEoUC6q6PaFvFSfqV793l1BNSZm2AH7JBYBk38vMWl3x/K1ZDUzEc?=
 =?us-ascii?Q?lGdUPfRlzEPD8XFxheb52oMNbcGvBQmYKroxe5EdfBkDmpsLlDN0/jHt5sPf?=
 =?us-ascii?Q?RUNQmm/My/8BW6HVd0sALbbEenaVL1lHoYNcGdMQUrtevGzXp/XWcmE/OtV3?=
 =?us-ascii?Q?Jdfh8EOQ8aJ6mrVNlifYtIzEByjJDkpgtEmDcza/3XNpieVkFp6LGdcIaS5J?=
 =?us-ascii?Q?lU39S1NqRbBb3evW02ZwUGS3RiMeNafxNdqaZOLplIyMnfyQg22JjAsOMk7a?=
 =?us-ascii?Q?s4jNP6tEXyjLQL7vcg9JT57wgfXJ42zNc3+OFBGIsEAirF1IKWCD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35360bf1-9398-424f-f6a6-08d9e44fe581
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 00:23:25.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFmKWjIDFS+1XC8QxmvGhU1Sc1e8Hrr7MrFAwuAi3ITZFgl4p/86Xq5L6RHxesKnTWI0D5ikncU+l7PnFoJrwWML2y6V07Jhvd8VGhAEQCaIyvoKUv0/4nsCtnFKmOGe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam-san,

Thank you for the patch!

> From: Adam Ford, Sent: Saturday, January 29, 2022 7:36 AM
>=20
> The support the external role switch a variety of situations were
> addressed, but the transition from USB_ROLE_HOST to USB_ROLE_NONE
> leaves the host up which can cause some error messages when
> switching from host to none, to gadget, to none, and then back
> to host again.

I think so. An external role switch in this driver is possible to
enter the role to USB_ROLE_NONE. (Just a record for me: in other words,
the "internal" role switch didn't enter the role to USB_ROLE_NONE.)

>  xhci-hcd ee000000.usb: Abort failed to stop command ring: -110
>  xhci-hcd ee000000.usb: xHCI host controller not responding, assume dead
>  xhci-hcd ee000000.usb: HC died; cleaning up
>  usb 4-1: device not accepting address 6, error -108
>  usb usb4-port1: couldn't allocate usb_device
>=20
> After this happens it will not act as a host again.
> Fix this by releasing the host mode when transitioning to USB_ROLE_NONE.
>=20
> Fixes: 0604160d8c0b ("usb: gadget: udc: renesas_usb3: Enhance role switch=
 support")
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/u=
dc/renesas_usb3.c
> index 57d417a7c3e0..601829a6b4ba 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2378,6 +2378,8 @@ static void handle_ext_role_switch_states(struct de=
vice *dev,
>  	switch (role) {
>  	case USB_ROLE_NONE:
>  		usb3->connection_state =3D USB_ROLE_NONE;
> +		if (cur_role =3D=3D USB_ROLE_HOST)
> +			device_release_driver(host);

The handle_ext_role_switch_states() with role =3D USB_ROLE_NONE seems
to be called multiple times. So, we have to avoid multiple calling of
device_release_driver() somehow.

Best regards,
Yoshihiro Shimoda

>  		if (usb3->driver)
>  			usb3_disconnect(usb3);
>  		usb3_vbus_out(usb3, false);
> --
> 2.32.0

