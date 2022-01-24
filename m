Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1350497915
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiAXHEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:04:02 -0500
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:22611
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235642AbiAXHEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:04:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXVzZgdyVp74IA3bvjbLA+CP3cIWmZHo0hyjPEi0UemLszIquyazm/1ze8BZ9CEkK+SaGeTaqapDH/ZDe29odkieP4u1svYLTjZwXCxxN4PpMEuncB6lAqYzLrv9DNBoLUojZwF/feNx14NtSE4iZFDQ2aYCT0oxmZoYpuYkwahDHuO1Ku9GVtRMX5rEkQS3Ruq2BkkjjBIA3UY1tK1sHXvj+TUzTfdWxB27tXxH+Lc45S7NlxtvFZoHelcYP5bDx22lah765mYhx45wor5/xhbMHRtIh+Vv7l2h/PD8ZrKsQxJCvuKVvkACUHJqj/Ro4XVubr5gO8bgKFXJFOXP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo50id+3dD23nZjycA/aMPACMEZTY1TY6SJRJN6MZxI=;
 b=ThFB1bIGEduK6msI5JjvJzoCTUtCs7cMrRhQyZWGCUpyAy30viffoehaP0SCBfliqg/cUnnel4IQ0WCTWiSJPPZw8a7thaMylsBGT10F/zXrOawkIc4dMsXt5M4Cze0g2wzBoBBO5D6dwbIzDz6uu+p2xpQMACH0k/fA8AiaNh8/x2Pt3zCrfKNYFivbtIxuN8cZvfkB8plo+/6m7w4c99xvtxd2LyKp4sRxUanri2nP2qV5cwGr8WNFr53OAjuE/9boNzvWypega8FGZWC+d0bG+pAPAO0pbEADq9WOet/HlCveCg8m4Lu9yeTlqJ0aUzy5KuV0bvuIqs2KaXCaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skidata.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo50id+3dD23nZjycA/aMPACMEZTY1TY6SJRJN6MZxI=;
 b=VkqN0eJIS53MN+62UhConUnN2ayyl3TdwJYVdCAlYAHDoD45iK1k4sGktxKS64imTr9pypEugTTcqfw6+B0DnK57LtylUtaqmriT87JpRWEGWsvbGNht4C6zu4oqO/C64FFrlk6W/QFGwdl7g5VyjupoFPPpWGR7apPv1GITf7NRRcXtK2A65brltGczNRwr1F1d9Jd6Jsf7Sx6v2xlAFn2vt6VTV5PrBSfMcpnQmMjCTZh6GLTDAtzqNPD3++RWG33Qc7ItfKIj9LFNSAi8HdQ8J9ZyRTPaGSnoIZ0tSMKyoauavcxxBNlwDX0FZrZJ295hUQuEDxNJ8xcV/bGt2g==
Received: from VE1PR05MB7376.eurprd05.prod.outlook.com (2603:10a6:800:1b3::19)
 by VI1PR05MB4702.eurprd05.prod.outlook.com (2603:10a6:802:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 07:03:57 +0000
Received: from VE1PR05MB7376.eurprd05.prod.outlook.com
 ([fe80::f4af:914e:469b:9d8d]) by VE1PR05MB7376.eurprd05.prod.outlook.com
 ([fe80::f4af:914e:469b:9d8d%7]) with mapi id 15.20.4909.013; Mon, 24 Jan 2022
 07:03:57 +0000
From:   Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
CC:     "linuxfancy@googlegroups.com" <linuxfancy@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
Subject: Re: [PATCH] usb: usb251xb: add boost-up property support
Thread-Topic: [PATCH] usb: usb251xb: add boost-up property support
Thread-Index: AQHYDx5q1AjLtgKN40yeFGB3Voog7KxxwtcA
Date:   Mon, 24 Jan 2022 07:03:57 +0000
Message-ID: <Ye5PUpp9eMX9jSRe@ltleri2>
References: <20220121232612.7283-1-tomm.merciai@gmail.com>
In-Reply-To: <20220121232612.7283-1-tomm.merciai@gmail.com>
Accept-Language: en-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skidata.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 067a7669-30a4-4431-5511-08d9df07b0f1
x-ms-traffictypediagnostic: VI1PR05MB4702:EE_
x-microsoft-antispam-prvs: <VI1PR05MB4702D290980226ECACAC0826F05E9@VI1PR05MB4702.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2IRKIdfYJAPpbCP8yewqkq3ll+Sm7YSWjyrWq8BfAbYY+Ud4GfreMEp9VusAa+7lNoK3uAmW7L8EapEZlsRg59AG0evov+y3Q3uFQguyh5XHt4H6XHgRjSvtfmcGgG1xi3ISbUqkx2V70rObM9igyPZLcF3khl8k/dWjIGqtH2jEamzgglbmoalHZPzfAo7y4hQ2iqg9LliSAQ5cYMGzgOa2RTpwbDMoI7NTkX+mIA5agz9rVJ8viknDYt0dPmtxgUgtNeT9+lkdI1CgfhkUesz0tdNC7/EFFmhyHCGL5RRQfHTOGbnMNsn+sW62c5Nolpworksr6Gr6gUHKrdtkMQx/XtIAKJLkwg46Je+6ev7Wa0LljqVfQfTrIlxrRkae0E0BrEzU+M55zafEPKb68Emn1FzmyTmEox28p7GhqquqLvHUzlkOBYNFwyFyaaMFoV+40yPJTJgQmfxQPgI7xqtT/fCeeOlwjyr01rNSjLEF/uMkcg+fpyC9xwSu9cF/l9sDA0k9GiJrXiJqe8humrq6fCq+71wTiCOswgP2DcEXG3L4P3MrMvV0sw9y6kTy9ip0R5EXRfPivTFxqKgPqiSLEnmVWQHgYjQg3TRPX1hQ4YsdPs70CjFicYImB6xR3bslVt2IqBU5zGg5JWOZjgb7JHAgz4ZdR5TiDYPgINjTYkXQpL3HIYzc+kJGrQjCpS3VV+ktNUa+WTmV+ru6Wigkd8+gYQ/uS/1LbZe7b/DaCqz3gmg3c89s7SIhYG5PXWSgdyv05uPdhFI3JSUn0XA4/ViC0y4f2XwYSnUyBRgcER9eyPF7ONiE5W8l+Qf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR05MB7376.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(66476007)(8676002)(54906003)(6916009)(91956017)(76116006)(64756008)(66446008)(66556008)(66946007)(5660300002)(4326008)(38070700005)(38100700002)(6512007)(6486002)(86362001)(316002)(8936002)(33716001)(26005)(2906002)(9686003)(186003)(508600001)(122000001)(6506007)(966005)(71200400001)(83380400001)(562404015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hURAXG52R/PC5LPNmoLDYpzQGnn0f9t2vyQCvR0U9M29HgpWMgMlvXmEIxZd?=
 =?us-ascii?Q?OHiBfy3WxLw3l9Zxfs+rwnV+DzRbX6l1Buq9yWHW1eUL1nsv64BEZSPxFqyg?=
 =?us-ascii?Q?ml6yHcJbBEo0pjzp6FM42CUXyHXpAqbv8evXl5pwzSDZQbYvX0HFSk2DmNrQ?=
 =?us-ascii?Q?fuiIHnUt/dq/oTa/wCvaqSW8heYVOnLHi4LQntcIw9sro7+5qxba93QMkYrl?=
 =?us-ascii?Q?z9LIkdq2Phu9+GJ2gCrxBfl6SgdtOWzMYIwQRQNfGn/0uT4758XK46dmM9dr?=
 =?us-ascii?Q?CYuHPAeSsZLdO/6iDapaUhlQqOjBsYJpyX9prWCTH5orKG2/eq14w5RONnLw?=
 =?us-ascii?Q?ULgdtALIpdQTYKUVGDOiiQTwUIPXTwfA+i5ZmH97LIXwtCWojpsxIOlSgP/o?=
 =?us-ascii?Q?720zMHeIrsRHMvubiFEO2u8YELQdRgzISp2CWDvLOW5z2+Dxzn6ntWY/dp5l?=
 =?us-ascii?Q?qZdTNfPZCdJpP5IxBc9/HLWzJwAoAfEGPNYJJquxRyDxvlUDVwPEqXkl7R2z?=
 =?us-ascii?Q?gcf6HvcZnUAAzjB3mYCBmpvOVCRw+1e2rDPrmPThEW3yna+3SEfTYCqS8+oM?=
 =?us-ascii?Q?eOoiKJlE9ZKgri4d6YIibcxqyb5qGtAhp++hK73f6cj8nc5XYPxQLaPocecO?=
 =?us-ascii?Q?Lni25IhTBcM8SEhRS7yHxfEUb6T/s6ce613K1rjPNI70T6PwZvtdStUhl5lf?=
 =?us-ascii?Q?i8QU4r/jqe0LP5CFtk/HKanqj3fgHalrxa6YIX5t+YDbqkEJdP/4xWYxi+wa?=
 =?us-ascii?Q?37gSsUIIZzY2SxFYxMR1ZRY33kokS6MIEIJfI7c8qjidhJ0oYlgeZulY3Lg1?=
 =?us-ascii?Q?5hnvLtMfUpsOehyrtTJ8U1Bzy2kNkeBMQRcqcHvnV+eBnRmBCDTVrZ9/ACVz?=
 =?us-ascii?Q?3jQ7zsBH5kcbS/Pu3uTI3eYz63d3Cnvdb/2nxmbn9m7pkiNYWsmBwpAOJU35?=
 =?us-ascii?Q?e571uTBeyvCzUpuYyM+1CL7Fi+ie/LWsj/a1BeERx0IXw4B0esoDj9b0A0T6?=
 =?us-ascii?Q?g6U4drTYlNc5HrHgSkUdCrGssKqQcdHh7AfKseuctLyK5yniURLT1VXNixK1?=
 =?us-ascii?Q?+9fAKtKc3zwuoRbVipJwkUcww8JHJfbPx7YKNSgvTACkka4ZPegR7HiyrQRa?=
 =?us-ascii?Q?WUxOXu5xbZ/Jkp0edP5NASc274xDQ4VGFvJ2M5Pd8xZCXik4aTHTHxwe4L8r?=
 =?us-ascii?Q?q8M7adlQ8YozmpAjL3sNEigdoU6GvOoS7y4tdBqCcv0alYGw/JGxndPFoJsp?=
 =?us-ascii?Q?s+sTO3cTKTkZYX8M8zTx9kd30YdkhORTVBc5VbliR64Jv+/c9MJNJNuA3U6w?=
 =?us-ascii?Q?jnQwO3kXYlVlgVxMzUuTwxQVGA2wdDXQPPk252Dt+Oly9INs43NVI4Xl1jGE?=
 =?us-ascii?Q?d7ZI8D5l1zOsqZ+tcSA9Q950JUVdk1s7P2Kz/ox3ZrQTJQgTyGDWtjY06jmv?=
 =?us-ascii?Q?ykbTbIVrG6HUP51FZtkrC9BBaUIHADnv78rk8c8PjLEQxmk/L6oPAYE2nGgb?=
 =?us-ascii?Q?eBJdQzGcO14OcmGRfhVOfltrjmqPWOKCUdltTWSYt1dZ6r6XkbhaSpalgoIt?=
 =?us-ascii?Q?VtIZ2ObCuHRamCzxFQGqYvhSFexWkflyPTxPt67EtEOYze2lU9x2W8+lERTL?=
 =?us-ascii?Q?IJ7tlM5L5Q8AZkYhSJb/yl6l87jfxfNIqi3DgAgipuwHFVRZ435yfsXlfAJe?=
 =?us-ascii?Q?r6xEMLuqgwc+hgPWiCI0wqXuB1o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3BAA30692F48142B70BB94722813B3E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: skidata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR05MB7376.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a7669-30a4-4431-5511-08d9df07b0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 07:03:57.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5733095-4425-4f08-b6ba-487b9a46a425
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qo5IDNHdt2OildJRHCvBzBKI8OMzrmgAnrG1Io5gDSDiHVHGaGZIwiah3X/xUl5X95Grn3O0ZRIMejWeZmnLZEHy9p89eU/pp745+Nj+7a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4702
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

thanks for implementing the boost up register.

On Sat, Jan 22, 2022 at 12:26:12AM +0100, Tommaso Merciai wrote:
> Add u8 property to support boost-up register of usb251xb hub.
> boost-up property control USB electrical drive strenght
> This register can be set:
>=20
>  - Normal mode -> 0x00
>  - Low         -> 0x01
>  - Medium      -> 0x10
>  - High        -> 0x11
>=20
> (Normal Default)
>=20
> References:
>  - http://www.mouser.com/catalog/specsheets/2514.pdf p29
>=20
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/usb/misc/usb251xb.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 507deef1f709..74fd8ac0c303 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -402,6 +402,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  	struct device_node *np =3D dev->of_node;
>  	int len, err;
>  	u32 property_u32 =3D 0;
> +	u8 property_u8 =3D 0;
>  	const char *cproperty_char;
>  	char str[USB251XB_STRING_BUFSIZE / 2];
> =20
> @@ -543,6 +544,12 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>  	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
>  		hub->lang_id =3D USB251XB_DEF_LANGUAGE_ID;
> =20
> +	if (!of_property_read_u8(np, "boost-up", &property_u8)){
> +		hub->boost_up =3D property_u8;

IMHO we don't need the property_u8 var here as you could pass
&hub->boost_up directly to of_property_read_u8() ?

regards;rl=
