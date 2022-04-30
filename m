Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6A515A02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 05:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376378AbiD3DMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 23:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiD3DMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:12:42 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB71C92A;
        Fri, 29 Apr 2022 20:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1651288161; x=1651892961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+FhrTvrmgWsdoimTGOQvO3IpYD3NdD3NdAWR0lsodHg=;
  b=ryjyoX0JdDL0hgikQLfbu3Lk/BN9HTXgfNW6xFAjZyStP99G/z7t8H9L
   2ZYj+IrbUnNscno4NiQNXRGK39/3rjm5qNPrDo7MV3lHgiwvfH8g6DHkh
   bZMYgji1Os9cH6BUGydzL+LaLrLaJrvzaLAINzrjSrJYeawROKiz3OXcB
   8=;
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 03:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQM3c6IO1kDkLz/1x8APPCUrW9PYDLxLcn9N7nEvn7w0K5B0uxMxdt4bMiooKmfV2OyZNwAxNqofHZEsosvfrDBl9YXZUch2BvMmJZ0auTheivY/SUcpmmoicd0N7QGpvu4sD2GVMfee0IklFoecESW2IfaDiTloZGg39O6kaB/r7DxncJjpk+VPe/SXGbZpudtIagaADMSNirMGU4Cg+Uj1KjZJ+CrsDIrdAGybv/dI8bHbtK2jwlFUjEe23lQCnPhc+lvGnBzP9Ny6oKXMwtT0rnbGoaeQSVU6/jtf12VpKdy691QOpmEY6sZ5tHomUAp/8sKCBPrW2tdepTU0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FhrTvrmgWsdoimTGOQvO3IpYD3NdD3NdAWR0lsodHg=;
 b=JS/TMrRcMeW3RfnK0aKGfA+9iMBaob+9lDERIGJWbivzCE/pMbrqXjTpUIIalPDf6B3ss9wMDU98drNFE++0iSW8P8ToKXOhHNvWNmjuZI2TNJ7xCfjw/rCcVXkpWymM4Wdo2Fsd7Ay94HhmDi5TS46EFZxCaYtNIDPAeYUCf72IBZw2q1jQBZ9tFg6Ec/v7wavvN5i+CLdjmM6oq9NNigCyDZeJYfJ6qp+O6c0s5IQABJhQOkSWPtWYFXQGLlGiB0QNXvCkok784hL/R5gk8o9XNnvJ+Bwz2WmxHy7wVqBr6TYBFCF1BMvF8E8IZghxcJ6O1P1+HChUOPYcZFJKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB7135.namprd02.prod.outlook.com (2603:10b6:a03:298::16)
 by BY5PR02MB6369.namprd02.prod.outlook.com (2603:10b6:a03:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sat, 30 Apr
 2022 03:09:14 +0000
Received: from SJ0PR02MB7135.namprd02.prod.outlook.com
 ([fe80::b8d0:d109:cc6c:1034]) by SJ0PR02MB7135.namprd02.prod.outlook.com
 ([fe80::b8d0:d109:cc6c:1034%9]) with mapi id 15.20.5206.014; Sat, 30 Apr 2022
 03:09:14 +0000
From:   "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        quic_rjliao <quic_rjliao@quicinc.com>,
        "mcchou@chromium.org" <mcchou@chromium.org>
Subject: RE: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
Thread-Topic: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW
 issue
Thread-Index: AQHYW7ySCA0NvGHfjEC8q8sCBgrRua0G+o+AgADNSyA=
Date:   Sat, 30 Apr 2022 03:09:14 +0000
Message-ID: <SJ0PR02MB713538E5BBB40CDEF2E050A0F8FF9@SJ0PR02MB7135.namprd02.prod.outlook.com>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
 <0D3D8346-0F64-4CAF-8BED-940F189A3E97@holtmann.org>
In-Reply-To: <0D3D8346-0F64-4CAF-8BED-940F189A3E97@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 696bbcca-4c96-487a-8102-08da2a56ce5a
x-ms-traffictypediagnostic: BY5PR02MB6369:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB6369396B0E9256A25988EFFD84FF9@BY5PR02MB6369.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UnU692rGaw5coOirloXC4vtUV1w3Z3FDWOQDT9qNUjz8uXhYAM5p+PDixy3qZUw2OrMVCqg2tHgjFSoI9WR8IqOnMcjdVAmgHgp3AJZURycTHMVjRuL8e/6kdJeWF/34KjB47ynl68xTFEtN+icRuPCoNmaH0ohRe82mhp56cyMSkM2og7JiRvRzuGrOPeMs8vaquRg3mcFrK/vcWMNmfnyue6qr+rROXmPgCamY/SZU2LT4SuexucPWRAOGx5D2uu/ptL30ctNnoLzlsjVVm0pma4lGbob7VR5x8qaK2zn2HbdF3wIBWkZcZFhg3dw4MS1qfyStUiNKEfiWemQP7TCi7Xpmpay0WkzbixPX7G1xeEs+hfxZ4qb3/36UeVQCqXP3bEmr544ql9ZY3yJUKByiOLjqo5+ehcxWjaQ6ZYMVZLuKz9wSMhgQpvVwEZbPUXPpt+VhkN0nIHA4nx+PfioU9HdyUudnJM0lKsMQ55OTKa3JQrSOWRqbYad7/c5Bw2OTwaMdbJGZCzzfbq5lVh3K6iNciyBUrKh1hilHZekJwXMt6Ugc6KHVrcslOAp0aZ2DE8Gagf3r1kkF9lme4NJ5R9OHn9eghccUkCbHY4A3qWtDKydqAfkFs29NeFa712UDxcllgS7oev7WbeucXjpi5F4YAD0GhkbTU8DFtjH1dHJ0gAfHfb35Fc8FrcGt9ilBUs23Def0QtubLanAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7135.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(122000001)(7416002)(38100700002)(508600001)(8936002)(55016003)(66476007)(71200400001)(64756008)(4326008)(66946007)(66446008)(8676002)(76116006)(316002)(38070700005)(54906003)(9686003)(6506007)(33656002)(2906002)(7696005)(26005)(53546011)(186003)(52536014)(83380400001)(5660300002)(86362001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c8I0BMyGFutlh+6MWwJ+DhUa/qM/XSUpJWnUjQv0aRjTButsLu9RsuTM08Ji?=
 =?us-ascii?Q?N3AYWfoCDl7gFiHUh49MPcnMymGzi3SjQ6f/2CNgAdC6AqP45eFveosaIEUW?=
 =?us-ascii?Q?rNElTapzZB+zjHj29AfFwdUeaCnrXfeRnVciZol7SA0z2UtxjWt6vO4FUfdb?=
 =?us-ascii?Q?2JP+fFNgR2EcLG4IfUDiNT+K9CvgzkUS0PLi80VAwm/RTyMADEYNx321Mn3s?=
 =?us-ascii?Q?yL9hFC/k0oRfRY7T6p08Xzh34mCMadkyCaldOpbvTxOE4qLwtkYs+Sp1j1L+?=
 =?us-ascii?Q?KtXv6EaYUIPPLY6wEtAB9/yixjGHM4QjQFikL/RAwLZLr2C25l0yd26D3jVt?=
 =?us-ascii?Q?OvdmjfYui8BjH6dcxfkcjbz2uxkE8x5bjOa/+0LA3zbzZfWx/Hh1b0zoJx1S?=
 =?us-ascii?Q?7NNzKtdeeY19ORZ6aqclZt02dSWrP3PNR5qzo6QEPLom5am2DZF0dxLsCYrN?=
 =?us-ascii?Q?h6sTXgyfnIstJJCKfiDaaemAyR1l2LCpDIifExVa6KE7ZBchvyy9vVAEtkTh?=
 =?us-ascii?Q?wTB0jHfLXFRoy9WUfmTLeS/R45kuWBTgrrDy34oK3CuOtzR9t+mwQuXRa4UI?=
 =?us-ascii?Q?g4+WbhkUBz8M/ibQL/GGCv6qn+Et4GGPFD7XKGlKkMYe0hsRW1VUwqmxlIoo?=
 =?us-ascii?Q?a0XtOn+9luVp8YT9U+1Lhn07ZHC6k0+FRP8A50I142D7M5b+/0A7lUcbLLIu?=
 =?us-ascii?Q?6/M8cHUVtn2yVZbE0R5t1LArHs+/A/h/+FnYBIq9esD93m7HyhOtk5YAmfwN?=
 =?us-ascii?Q?EL2FVWXMyIODZeB5NrM8xDQAse+9IITr2WPx08mmT6YGlcSw4Jx3oEfLJ3RN?=
 =?us-ascii?Q?LpuQvJyF37XM8RkkR2D/N3bjn7h+xgLKmhus0j1NZ6rYIJmn4MNs3PFDwizG?=
 =?us-ascii?Q?gGIrmUR1nhcbfCr3DyURnH9VltZrl23FCtaNkEmekbYcp8Ow5qnxq8ezW9Au?=
 =?us-ascii?Q?r+T2NPsBKHNrRJxJxcKHFoagSTRC+erxfUT1OpnRhxF8Va/AclJMUa7sKIq+?=
 =?us-ascii?Q?dLkayOdT+YPseCDLYKZ3gSkafxjrHslSvwBmRPU7L9wdv3LFQRmPjV6JzkEh?=
 =?us-ascii?Q?45EEifiY9/E/93QYOZUgL5lsUBS9tj8hRT2xZBmtLs7T0mjFPLSFGbkVgH0v?=
 =?us-ascii?Q?YH9+8K9lfiFRumTwROKzCiNdml827bC/bvVOr8EGCeZVdyrWTthkHEOW9r89?=
 =?us-ascii?Q?eOwd696s+HYV5I/RoqLwh3atM+62y049JFgRTkO7dOLA04cXqCb/lt1CPkor?=
 =?us-ascii?Q?PKiA2Paf2OYs5+hWz0pEfMLPysXVhnAtJ7r31hs/PlpTfNF8+t5LrzDuRnTL?=
 =?us-ascii?Q?5dBCgPCisLU+s7YpUMxTemgwEnVxaWAB/Q+oKT15mTDKaD9IDLNAndETtTHI?=
 =?us-ascii?Q?0JL6OytY9SdahJwTuwHLCEXNGgi6HDlNQq1CX7laedHNfyKbWGoaAHHneisM?=
 =?us-ascii?Q?/g82B++BhfD5nRImD1WeG1F3JN5S9dGDA/+Jgwdg+jO88CAUpXhRW8pLPpia?=
 =?us-ascii?Q?Ggc94gR8+Uunau78lIDto0kj619L8773t8HxZ7evyM1HvvIqF88kUvdddyS4?=
 =?us-ascii?Q?3ll79N8PuAwMGx2Wr9T+cObjMBkU5UY7i3H0ekr70MNaU9EjR0P6l2rx5fJE?=
 =?us-ascii?Q?t1bd/+1JJzcyccUTycVpLzC3Khjyi93gLkUCk7NGaypeJRDih4qfzTLe6u+m?=
 =?us-ascii?Q?CjtNK2MrPiLZw3GnExHVKrBX5him9N3pBv/nf9eNN50BG7TjVs/Ryp7ioWve?=
 =?us-ascii?Q?PkcCM7xY5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7135.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bbcca-4c96-487a-8102-08da2a56ce5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2022 03:09:14.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94zx8/nSYfJPqJC7GUTv8tl6U39/9NWByWZKbVcVzAeUvxTex7uWksdywDL0yf6l3+YYqdqmTlZE5mSICDe/WItMCIkc2AMWKgJv7bOtrvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6369
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann <marcel@holtmann.org>=20
Sent: Friday, April 29, 2022 8:24 PM
To: Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>
Cc: Andy Gross <agross@kernel.org>; robh+dt@kernel.org; bjorn.andersson@lin=
aro.org; linux-arm-msm@vger.kernel.org; devicetree@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Johan Hedberg <johan.hedberg@gmail.com>; mka@chromiu=
m.org; linux-bluetooth@vger.kernel.org; Hemant Gupta (QUIC) <quic_hemantg@q=
uicinc.com>; Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>; qu=
ic_rjliao <quic_rjliao@quicinc.com>; mcchou@chromium.org
Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW is=
sue

Hi Balakrishna,

> The patch is workaround for hardware issue on WCN6750.
> On WCN6750 sometimes observed AON power source takes 100ms time to=20
> fully discharge voltage during OFF. As WCN6750 is combo chip for WLAN=20
> and BT. If any of the tech area ON is triggered during discharge=20
> phase, it fails to turn ON.
> To overcome this hardware issue, During BT ON, driver check for=20
> WLAN_EN pin status. If it high, it will pull BT_EN to high immediately=20
> else it will wait for 100ms assuming WLAN was just powered OFF and=20
> then BT_EN will be pulled to high.
>=20
> Fixes: d8f97da1b92d2 ("Bluetooth: hci_qca: Add support for QTI=20
> Bluetooth chip wcn6750")
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> ---
> drivers/bluetooth/hci_qca.c | 30 ++++++++++++++++++++++++------
> 1 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c=20
> index eab34e2..c3862d1 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -219,6 +219,7 @@ struct qca_serdev {
> 	struct hci_uart	 serdev_hu;
> 	struct gpio_desc *bt_en;
> 	struct gpio_desc *sw_ctrl;
> +	struct gpio_desc *wlan_en;
> 	struct clk	 *susclk;
> 	enum qca_btsoc_type btsoc_type;
> 	struct qca_power *bt_power;

I am really against these intermixing of Bluetooth and WiFi details. There =
is work ongoing to do some sequence power procedure. Maybe that is somethin=
g you should look into. This is a mess.

And again, we are still hacking around hci_qca.c instead of writing a clean=
 serdev only driver for this hardware. I have the feeling that nobody liste=
ns to review comments these days. It is just hacking patches together to ge=
t hardware enabled somehow and then disappear.

[Bala]: We are working on serdev like driver for our QCA platform.  We are =
in initial stages of discussion, and soon we will start the driver developm=
ent work.=20
In mean to stop stability or functional issues we are trying to add these H=
ACKs in QCA driver.

Regards

Marcel

