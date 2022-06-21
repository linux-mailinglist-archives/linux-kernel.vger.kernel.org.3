Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A2553201
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350429AbiFUM0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350406AbiFUM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:26:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541926110;
        Tue, 21 Jun 2022 05:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeCkLHwD5L0hvHXyPJuggTruUrMGyaGMDJWBzy9OvJBORrKKnfPIpQH41lTXr+ufuNSIorRKnKHpP5eN1nvWIU4AqcLPaPR/pMEqIIawJnYYZj/xa0s4bREnKEZD2hgWQmcJ25uh+Gl4eh2hq2hY/6Dbb3RjOOGrnIjjcjiVrLxmP+Ub6ko6jy5z/WhNx/cD9eyWBI2XYA9vgtcd2M0zsLaJPjg0cJYPImJ3OWJ5py2PDksmGz6t5QjO9M9XkJMBVqZh3XjccVolQ1H/3w8lggPQIaXmflE9XUdgfQ0k46Q4PBy6OfsYOlXgLlJZphMu9SrNvj0cTsU/rjSnmcp+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4SLMVOKDR7qIiIXJFw91ij8OTX9GI4oi8URSH3PKjo=;
 b=OGkMjS57VbSb5W6INALt4scR56qNIZPi0mfUZQ9HtBIZ1MKsUJCb/4Sk0Feu41jpkEzMEeoCO7ilWTlhgqd8Um54OWSB0CRhUFDznlX4iFUHYuOQK0sC+lgvV1eZJwCrAYjOsGzvLIVKzF4sJ5jBDr85VArnSniOJgbzqsXdAimiWMasFssj7uZJNnUSPsT95x8V+EOv3E3y8fdJG/sTY4DxNF0v3GU4unx2RWcyn2lZ8++dO8rnPztdnE606M6jMFHY9nKzu06K3S2vJNteIom8TekhEf2gh/gI0U6dDbRZFX/tQbI9Oo/3N3qS0PtNjKnRHJJTTzg/FTco0iMYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4SLMVOKDR7qIiIXJFw91ij8OTX9GI4oi8URSH3PKjo=;
 b=0RwsKBDa8SMOtG+C3UD29VViL2diCKOC7K+o63nl+Asv/CRTpdjzQBHLtwrQ/aOw5a37b5AubRrRgEHgwVONmNjQ4SVmO8fe3GNff09n1VN5F5Y6E9SibkgAIFhhYa44JHVEGPWXklxQ8r86TXRblZ4P4ctYFBVcnOaPcIGUbaM=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 12:26:26 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::19a8:7702:20a7:de72]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::19a8:7702:20a7:de72%9]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 12:26:25 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Piyush Mehta <piyush.mehta@xilinx.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
Thread-Topic: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
Thread-Index: AQHYb2cEXoSLgZPquEiCXVJMPsCDdq1Z9UIw
Date:   Tue, 21 Jun 2022 12:26:25 +0000
Message-ID: <MN2PR12MB4333C64FE8A53F960EA5A84588B39@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20220524120802.9394-1-piyush.mehta@xilinx.com>
In-Reply-To: <20220524120802.9394-1-piyush.mehta@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77c209ce-cedb-43d6-99f3-08da5381426f
x-ms-traffictypediagnostic: CH2PR12MB4037:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4037D68B516D090A1199FEE388B39@CH2PR12MB4037.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljEtbMMxWPOB4CtgbcoeY0y99VpsB2dbONYUE3RUBjEDgKQdVigegdExCNGc1QbiGO6aGsYVoVJWiOTYO1D5x3CiBreA55UPTVHdJzqMUpCa3hkEa3bjCF1+5h/Eq7maS8+Q/rs/PYcuwIsYcNiD9+DFWUrlONnGjfUbuJR2xdKmIXTrduVPnyK7OZq/UtERQZMeLSlJTcGky2A2QqD6V2NRVm1KzlKUHAdSZ8IxYczKj3J19A7fYxZkToAHmtzYAYuqGwIr0wgw8scpJRRxFZm8MV1v6A7pfGFNz5QQ+DooY+TrULFwxjbhuQFI943Y/iac20kbq5PzD3hQN5bcNjPhE2LHX2Ik/adHP1pLEDa3GeoJ9kSjDSDeEo0Ji+wNrB7lg8z2E69qQ3Q47rXyygRhExW/HcEq9yBbVL7PYy1lJQqOz23MLPeL/9FzxH/ijtTmjNVR/Sg45rllgDc7Mihf6WL9M4mYE8JxEy4C+HphuxnIu/4tWUszv6wwUIPTaGUvXsoJKmIrTGfUSNGMP6088Xv7xanmHr/6kK9zf+/01gkOfln1ibuYnDiWA2nxR/3ZGXr24ajyS5R8rQIjYxNUbeUa7VjHNVK3o+pauNMeKtJvJC4F6beWOWGWPSy+WgfYaNGoSBTKRut1ocggBLdQBdJeE7lMxqRlHo10JOx2uHfSzkFfSEycU3nOhEsbplSLYADq92t7TPTSwuqyFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(41300700001)(53546011)(9686003)(55016003)(33656002)(7696005)(38100700002)(6506007)(5660300002)(8936002)(52536014)(2906002)(71200400001)(8676002)(4326008)(66946007)(83380400001)(66446008)(86362001)(6636002)(64756008)(76116006)(38070700005)(122000001)(478600001)(186003)(66556008)(66476007)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tzJAk2ykoSnOTsWjaWQj/YKV4fKEYBavNjQ2ISU+toqaw8f4+4CqIfO3bUCK?=
 =?us-ascii?Q?+8ygsV3BtPT7cWDuZw7VCsyYjFxLLb0eS/UV0mUQ5zM/8N2+obsh6G8D0P7C?=
 =?us-ascii?Q?c2Zk3Or2I8qNVn3Ky94ETKjIJGWilpr8wZBOfQE7gcUYR1Diis3UDi0IyQUD?=
 =?us-ascii?Q?TWXS8GX9g7fR+uqxBLhAAlMST3oabMuKEcXvx9hJOiVqD1sJ8O7H+FG+otVq?=
 =?us-ascii?Q?SiU6irZC1poOac3HoTBeAk/XSG82vVzWtD2DQkaSMNi6JtYcWhJbYCXvbBnJ?=
 =?us-ascii?Q?2QwXdHwANM4gBcmVQ1DbsFUw9WjuSvxWScXSEGrzoxz2+5gMYpDSTmQEz7Va?=
 =?us-ascii?Q?Kp6WuxZFAegtv6/UlGuWnq2z6mWENN+LmuP9EP6cfdS0W2rXJUVlOcaPR6ZS?=
 =?us-ascii?Q?zJyvn1ZskFNvvLMxAXpbi6/irwFfuCOWQzSa6FNPOT9A5faAyLbxqG49fVgJ?=
 =?us-ascii?Q?ifaIYr2sz9IOh6kA2BGAEXnA6eDs4azDzWOQITq3Uici2W0pjEa56Rv8ntKE?=
 =?us-ascii?Q?vsVdY+uIOs2K78QbLaEzdhvCEGsM3+xIVc8EwXdBg19c+BqOmFagsVLk+ACi?=
 =?us-ascii?Q?pyvEEpVr7s4kQ1HYvCGx4gGhS/wFTGVER7Q1hYZgTAWTPI14isMi8H7dlZcx?=
 =?us-ascii?Q?vHPXB5OZArQQ9maqvuurJl7OiPEocq4XWPVDWG1izS/3XoffXYSeVXerodMK?=
 =?us-ascii?Q?eAPRW9c/GlmPNwLItMidrVd38zep+cgaIaMr0YCPeaxfpmYCQIk4UUSAL4ek?=
 =?us-ascii?Q?DEWsH+7oXyFihyqWXKqsP4Lm++77SFwGQl5AyTLGf9Kf4KChYAZWxlg5P60v?=
 =?us-ascii?Q?Qj6SljIDQ3AhpBtL4Z504L7V9glESI71hiBhVlrLN0grZH0JceMrl0fm6GxH?=
 =?us-ascii?Q?dbQnanXv2hLcWRRGQuwhHtKBjOFmA9kRpsfGanQDkL7FGH47D3eEj1L6WLV0?=
 =?us-ascii?Q?NlDS15Af7A9G3wSxso9Jhje22gWHdE3u69LUZA2l922+f49/Vh0unIBMe7H9?=
 =?us-ascii?Q?OToKcSinndmpfG/9jetttw+MthlGgYT0x+bh1SLaJHY4W3//yl848KIcovGO?=
 =?us-ascii?Q?mUAOLzCQ3fXJPOBmoHu9AH43hsOXzkpm4m3AVNVusL6/WXyCj3vvjEdp8TVc?=
 =?us-ascii?Q?r31vnqeIGP/fQMeWssqquBHVpbfyXhmo1PlJ3UqQ3mEvTQWue+l5eWIM96Bs?=
 =?us-ascii?Q?/TOXciwzJDZ2yDequiIxHcbwPIi/oxpsLuDvNpWBwquc1New+++u985YgRJ9?=
 =?us-ascii?Q?efOrTz5CbaAqqfbbrOOffgrt0EDXYchN9XYkm6AEinnC+NiPevffObyAS+Bp?=
 =?us-ascii?Q?SzPgCoEzcCVrk7KBSUPTpF6ekz1OlQnAoT4AOjyeV0b+ailuD/SdWfUMqZUC?=
 =?us-ascii?Q?hnQqfDyOAxXgEtLa/tYf9KhR4mNsaLS/u8hmfAoUPwHgyNcBH1XwUjR2dH99?=
 =?us-ascii?Q?Ud7mJ0K/3IEUzD4aNo+SUDrWC8xfzaFtJwGDrs4KeDwoBekE9TqGyRuv1WCw?=
 =?us-ascii?Q?CrpFP84KVmXzKwMNur+C1xE8glfAmyKczPrzeLaQYpyxdrwVSQlPB7pBEyh5?=
 =?us-ascii?Q?ZNsiXghqu80uZu7o2Lz+lcGS+tDjyQ7ztgcAb4xLYRu4WTONbtnmJ9mhqlXM?=
 =?us-ascii?Q?H2LVQmSpU3Be40OM4h+GU3b/5FWa3U+q5AwzzYE+CBrWxyCGollTKiFs0pMm?=
 =?us-ascii?Q?+ra8sj+ChUAeDU5Ov871alqrYQXY8CZteJFahp7gnIkI9F1gAX0aItvdMBSx?=
 =?us-ascii?Q?FCJgoF2Xsk4VPDZZprJo9uyI9GIjQtZdRCK8eEgZDHYvQFjGyyAH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c209ce-cedb-43d6-99f3-08da5381426f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 12:26:25.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpuUmmX2PmAKB7flSpfFyvoeO4YSqLe2B0bals0BIM1c9InUMmQWy2K45QidRFVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

Regards,
Piyush Mehta

> -----Original Message-----
> From: Piyush Mehta <piyush.mehta@xilinx.com>
> Sent: Tuesday, May 24, 2022 5:38 PM
> To: peter.chen@kernel.org; gregkh@linuxfoundation.org; Michal Simek
> <michals@xilinx.com>
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; Siva Durga Prasad Paladugu <sivadur@xilinx.com>; Radhey
> Shyam Pandey <radheys@xilinx.com>; Piyush Mehta <piyushm@xilinx.com>
> Subject: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
>=20
> Some platforms make use of VBUS control over PHY which means controller
> driver has to access PHY registers to turn on/off VBUS line.This patch ad=
ds
> support for such platforms in chipidea.
>=20
> Flag 'CI_HDRC_PHY_VBUS_CONTROL' added to support VBus control feature.
>=20
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> We have created this patch as RFC, as I introduced a new flag
> (CI_HDRC_PHY_VBUS_CONTROL) and would like to get comment if it's the
> proper way to check for VBus support for zynq.
> ---
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
>  drivers/usb/chipidea/host.c         | 7 +++++++
>  drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
>  include/linux/usb/chipidea.h        | 1 +
>  4 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c
> b/drivers/usb/chipidea/ci_hdrc_usb2.c
> index 89e1d82..dc86b12 100644
> --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> @@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data
> ci_default_pdata =3D {
>=20
>  static const struct ci_hdrc_platform_data ci_zynq_pdata =3D {
>  	.capoffset	=3D DEF_CAPOFFSET,
> +	.flags          =3D CI_HDRC_PHY_VBUS_CONTROL,
>  };
>=20
>  static const struct ci_hdrc_platform_data ci_zevio_pdata =3D { diff --gi=
t
> a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c index
> bdc3885..bc3634a 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -63,6 +63,13 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int
> portnum, bool enable)
>  		priv->enabled =3D enable;
>  	}
>=20
> +	if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL) {
> +		if (enable)
> +			usb_phy_vbus_on(ci->usb_phy);
> +		else
> +			usb_phy_vbus_off(ci->usb_phy);
> +	}
> +
>  	if (enable && (ci->platdata->phy_mode =3D=3D
> USBPHY_INTERFACE_MODE_HSIC)) {
>  		/*
>  		 * Marvell 28nm HSIC PHY requires forcing the port to HS
> mode.
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fs=
m.c
> index 6ed4b00..5ed9164 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int
> on)
>  				return;
>  			}
>  		}
> +
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +			usb_phy_vbus_on(ci->usb_phy);
> +
>  		/* Disable data pulse irq */
>  		hw_write_otgsc(ci, OTGSC_DPIE, 0);
>=20
> @@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int
> on)
>  		if (ci->platdata->reg_vbus)
>  			regulator_disable(ci->platdata->reg_vbus);
>=20
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +			usb_phy_vbus_off(ci->usb_phy);
> +
>  		fsm->a_bus_drop =3D 1;
>  		fsm->a_bus_req =3D 0;
>  	}
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index edf3342..ee38835 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_REQUIRES_ALIGNED_DMA	BIT(13)
>  #define CI_HDRC_IMX_IS_HSIC		BIT(14)
>  #define CI_HDRC_PMQOS			BIT(15)
> +#define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
>  	enum usb_dr_mode	dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> --
> 2.7.4

