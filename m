Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A55B09C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIGQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIGQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:08:30 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50086.outbound.protection.outlook.com [40.107.5.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10965838;
        Wed,  7 Sep 2022 09:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INCqpwjTJ6dwYRH0kZZO5sBnc1Rh12f6PdVOMYB5901IXppsnEjLqhClnmbwotLMCW2UcczPfZ5sFpRdkNIdlJ6ZTS3ZY7Sng/DCi/vENOLQ+ouVocMx0WbaN2mIO/fGeRfaVAyvt6h17nyOAsVmhq3QCWYNge1GckL3LgYH2pN3C8jxN55O8sx1hEFIvoZovQCqw4O85Qw/9sw6NxwGDdEZcwSmHKC92hNS/1lxPk23rlxW2qQkEWAPyt/3pCR6lVwrRJL7IapUCluPf0ci4OvqzFvUuz7peVR6HsC79rKt6d8aLKRpVxK1WNrC3MqHJy8q8Jd0mI/wyniUY1L1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GQhqNG8Ab6zcEhkb95PoJt/z734PN62CAjh6xrK47Y=;
 b=jWlAAD6v2Kj91mpwVsBo91yU2USlYebhNUyZZ9F120RYY0mATfPi+fQEEm02BqA2E/6hajL3hLJo8oM7eB3tBtFzSk1t/HnZutZyKuQLUokCmTfnqvOsQC07iuQXQYtATYY6ddhgty0LFbkxlGWFyxQHxHkUkaGHKXNuRU0LsWrXNdLvFEEQAkKZ9BFcgaG7WeU49ctq6ltf5ZgYPrUQhtDbF1EGRZq3Sc5I9AP0P6ODtIcAVmuALboGri4Nui5vkfNAOzIwL8H/+N2cSFyyTmOYPP3JnuDVPHd90Kwsuj0sWQUVzT1PFsXLqoXYyyINR0eOyIYuerZe0VtLdN4BOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GQhqNG8Ab6zcEhkb95PoJt/z734PN62CAjh6xrK47Y=;
 b=EhAGlGsKXUwxUkaXzIluobWjt7yywywT9xGLWn/igLLuEQuGaHs3+zNBe23BoZgag4DArzMy0LJE1+9coZoZ7RUep4Ht8ueb9U+YoEt4azzxe5/VDjKYHnVUq2sp9kf35k4eAQSTIAUFVm2ZI6jJAE2CxlLoYO0DITNpW+f6Ogc=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AM0PR04MB6513.eurprd04.prod.outlook.com (2603:10a6:208:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 16:08:26 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::25b6:d7f1:c25e:24d2%9]) with mapi id 15.20.5588.012; Wed, 7 Sep 2022
 16:08:25 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Thread-Topic: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
Thread-Index: AQHYwsihZnSWdyGvYEiiheIFncU2x63UHe0w
Date:   Wed, 7 Sep 2022 16:08:25 +0000
Message-ID: <PA4PR04MB9640CB3CA93301CA1571D85789419@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37596fee-af7d-4e84-b2ea-08da90eb3203
x-ms-traffictypediagnostic: AM0PR04MB6513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YsjE0kWaqn3pyMAEQUCHWrcPFX9ciXxAzcShv/sQ5+TTJm9Y2r6hdo91Ze3Io4s2cGJrJ7ReI8D55uWNZY4wYkqQiLqakx/fs2bJTbmnQLNfjk3im62IszguuKA9C/F2LhOI2jPLkZvnFDRfb/xiAqvJLdfU1KbNUfTVMC7MWZZjdKkmX4uv3kCh7njeFy6Pyd9t49FyGUMOeluhJLJDfCGjh5rDZ82GkWZ5p2F/tTQhC2lx2k/r/bD9a/nmgPnfkCKtefEJpPJx+n0n4doY4tQ/pT/Ue67iFWzN11wULW3WO24Pn+52mU/CZ9QanxyVZIawhDc9otdKQSDrmw6TIqjGWPapY8r21d/8dCwYxNbGoecwIagxfYk37deTB3xvaWi66PFr1jTz88az4460SKkZM1oel60uJ2JBbuZjvzCcv39UO8dLpeE7eEkxjjZJ4lnkXLB4YKN8IHUm8MoEt2B+97HdTMkkmQY+0eFARoHfeC/mesTyVAWPlude0gLZOdnl81OOtRjhoj36o4NcbbBiB5qixp5MgpyVxQj+2dkzKwc4bUL8a1/s5WyiM1zCLNKAm+9QbKymLsCDcvJ/wiGi59R5lZwaFl6YnDHHVP+BnMd2OQIK3IJuWDV8MvTc+ZtSrQpPbBnxwmhgjuyxWReXwKKlyxag+RLhN9msYvHpM5GWBkOIvcVEBq/bSZi68LZ0/r2ZL4UaJ9MNj99ct8Au10dAvFWYsRh9KU1A6pGzz4YNdx7oeWZCMtxYK/6i8iVGqKhrKyqZ6DkyCpUPcnErUBQwkXGoIpVfixb8ntIo8Wd6NT2NYUWFbUB4xIyzHiTZmNS8ciqwIG3v2atJl7G9lqMGqq4yiYU4cu0PBrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(186003)(6636002)(478600001)(316002)(7416002)(83380400001)(8936002)(5660300002)(33656002)(2906002)(52536014)(44832011)(9686003)(122000001)(4326008)(6506007)(53546011)(8676002)(26005)(7696005)(66446008)(66476007)(66556008)(76116006)(38100700002)(66946007)(55016003)(64756008)(38070700005)(86362001)(41300700001)(71200400001)(110136005)(966005)(45080400002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMNV+I82kz3cBMZyhrSQl5SLV/FcqAcDdSUG4QcAAKuF/mYc4CBAj+vRFdPP?=
 =?us-ascii?Q?gPt07RXvsOY1TBIMf/lxPUD/bW3ookbrt/GpqA0FpnrPeu8i9hhuPu0bHkh4?=
 =?us-ascii?Q?7Z/1F1PMzZWj/BPcBdYGZKa4s0OtXZGQAgtad3oHuZpq7S0oXyI/NDahEhH0?=
 =?us-ascii?Q?3hUdOy5J2wCoyfjolhrQsOYROdtPFHN2H8GlrMPBkLhzd0vkM3c42fH4vlfN?=
 =?us-ascii?Q?h6yzb8Ekq0D3hwDge01UPTjx2/jMoH0LGGyFdPOGbVBxX5SDMRnsFV3FwHar?=
 =?us-ascii?Q?MhRR9wTrvexDMp7gKdb6Sn7+svr8frfRRjEx3R9qXIeCQ7j8uFmaaf2rzMRw?=
 =?us-ascii?Q?oUZvn5ba3+12ATRBMGPPFERcULNZSeohEimRcTzXL0Y6tGjlm+RP9SWlOUeL?=
 =?us-ascii?Q?TPOHmK5rSDKFiAcAtuVfm3bViu84dEYaBsFFLKaEpP6zUZROqkct6YlTLlja?=
 =?us-ascii?Q?15DCWaPK04x/Sn7NEsI68n1mxKA4BHCK3QqbVuc60gYtcim8SPlwHpIR0X9d?=
 =?us-ascii?Q?L8lxWbIfphel2nCdeiTIqlVsaEABe+usdifieXwsJETR1NlVI047ZJHKJz0D?=
 =?us-ascii?Q?i6ECnbxPRky7/HUW/fycTtwtE94sOhl4ve3XVzJwauHhyI7L8mpfX/I8ntNy?=
 =?us-ascii?Q?t0YyVuO2we8GSthdkk0z2pMXYd38sRF5D5N00Olju0zLC4X9zBOc2Gpl8Y3i?=
 =?us-ascii?Q?a1teqAgcudNYxTAPlWycX9KlAmjVGr4th8GHx0odPTphjw8akbZg5U+1tEZx?=
 =?us-ascii?Q?TXI8xDrrR01c4yfToDN5w4WOQJqvqIeEtf95p8fQ9V6/6Ly1QHORvjI5hCJR?=
 =?us-ascii?Q?OgtISE4VL6mkczBvu3jzS6ekdiIdEE+blVTYsVnOiqXTw9YLENI/wJes/t1K?=
 =?us-ascii?Q?urUEmSjvz0U8eihoyWyLFJb040mQ/bUSJyhmTcHF+wPQF1zBLDSEHcFJy0rq?=
 =?us-ascii?Q?38QEhLmh6WAlHrM5PlMZTNpX1ajUcniAqYIqrxJCLcTdApVx68xPJ9YoZnu+?=
 =?us-ascii?Q?1V/RHO4LGLG5qkGd37XSpm4CcNNGzq4T9K0qrVkqkoONgSJVNACCdf5uZlEF?=
 =?us-ascii?Q?znztUqIwhzEVijX0FxN+BEIS61F5h5jVBg6CJGlv9DyWeAIg/rJDDV6Dt2pN?=
 =?us-ascii?Q?bQinWp74WLJeVHdjRduBMJEC4P95SovFewVaNqyMBWF/1/tBSX3SaEzkZkm7?=
 =?us-ascii?Q?jxhk+4umihsw0Q8kxgnC8M39SPlczaCVpONv1KooGT7xo3CLBcqOZ+T5pUol?=
 =?us-ascii?Q?O671w+nU0KwnJRzus4qFLlM/cj8UCCSh9RRByXuxhE228jDFYAvlYuo8KYJ1?=
 =?us-ascii?Q?YpRoCjmktaLTgxV06gD5El+FYzE7qXSVLOE+Y4JTWAxZw7xMAGPfLMCoQvgz?=
 =?us-ascii?Q?xu/zJfspnNgDh6HJmke90q7eSIMg6HS0Grcw/FTatWgQPk6/IAk0GFuqGae8?=
 =?us-ascii?Q?/s7fxFDQ2NMnlhD9bpq8dOnBALY0G0cr2mDqebwLizgjfTmuDSW7OgHaLmfY?=
 =?us-ascii?Q?ZEOsBDTtms6v40XHbByT8RBNFof/PUAz5q5M/A6vf6QO/NtLmfg8aQiexqRv?=
 =?us-ascii?Q?NHPAurcYGMUCuDiv6JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37596fee-af7d-4e84-b2ea-08da90eb3203
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 16:08:25.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0VRWx85zmJygw26OzhH8/ldGal9VYwHBzl1H9KOTMxB3hoXvki+YfxvRs/P553a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> -----Original Message-----
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> Sent: Wednesday, September 7, 2022 10:46 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-imx
> <linux-imx@nxp.com>; Jun Li <jun.li@nxp.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>;
> linux-usb@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH 0/4] USB host support for TQMa8MPxL + MBa8MPxL
>=20
> Hi everybody,
>=20
> this is a series based on the RFC at [1] for USB host support on TQMa8MPx=
L
> + MBa8MPxL. The main difference is that USB DR support has already been a=
dded
> and has been removed from this series.
>=20
> The DT configuration itself (patch 4) is rather straight forward, but lea=
ds
> to the following dmesg errors regarding superspeed ports:
> > [    8.549243] hub 2-1:1.0: hub_ext_port_status failed (err =3D -110)
> > [   22.885263] usb 2-1: Failed to suspend device, error -110
>=20
> This hardware works fine using the downstream kernel, because for imx8mp
> this ITP sync feature is enabled conditionally [2] & [3].
> Hacking this into mainline resulted in a working superspeed setup as well=
.
> I also noticed that on some android kernel [4] depending in IP core versi=
on
> either GCTL.SOFTITPSYNC or GFLADJ.GFLADJ_REFCLK_LPM_SEL is enabled
> unconditionally.
> So I opted for the latter one using some quirk (patch 1-3).
>=20
> I have to admit I do not know what this is actually about, nor why my set=
up
> does not work without this change or why this fixed my problem. So maybe
> someone with more knowledge can say if this is the way to go or what this
> is about.

This can be updated:)

>=20
> I also added snps,dis_u3_susphy_quirk to the board level as for some reas=
on
> USB Superspeed U3 does not work. Detecting the onboard hub takes much lon=
ger
> and once all devices are diconnected from the hub it is put into runtime
> suspend (U3) and new attached devices are not detected at all. Until the
> cause is known and fixed runtime suspend has to be disabled.

For this issue you are reporting, I am not sure if this is caused by a USB
clock change merged on v5.19, if you use latest kernel, can you try with
below patches applied to see if U3 can work for you?

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1662547028-=
22279-1-git-send-email-jun.li@nxp.com/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1662547028-=
22279-2-git-send-email-jun.li@nxp.com/
[3] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1661328612-=
3932-1-git-send-email-jun.li@nxp.com/

Li Jun
>=20
> Thanks and best regards,
> Alexander
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20220622130440.955465-1-alexander.stein%40ew.tq-grou
> p.com%2F&amp;data=3D05%7C01%7Cjun.li%40nxp.com%7Cd1bdfb58b364464e957d08da
> 90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63798158796971424
> 0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DWSQHERVO9SCWk%2B%2Fmq8g
> K78yluy5VE7T%2BhUaDMlNhbWk%3D&amp;reserved=3D0
> [2]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsourc
> e.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Ftree%2Fdrivers%2Fusb%2F
> dwc3%2Fdwc3-imx8mp.c%3Fh%3Dlf-5.10.y%23n134&amp;data=3D05%7C01%7Cjun.li%4
> 0nxp.com%7Cd1bdfb58b364464e957d08da90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C637981587969870477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&amp;sdata=3D9%2FxYZoZSelekGcWIZZNwRQqy8LTGPnnn13Rf4L5a0iY%3D&amp;reserv
> ed=3D0
> [3]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsourc
> e.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Ftree%2Fdrivers%2Fusb%2F
> dwc3%2Fcore.c%3Fh%3Dlf-5.10.y%23n333&amp;data=3D05%7C01%7Cjun.li%40nxp.co
> m%7Cd1bdfb58b364464e957d08da90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637981587969870477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;s
> data=3DOr9hvtM%2F9DhPZbfv%2BKzwAm8QTyXg4y0ddVbMFqOM67Q%3D&amp;reserved=3D=
0
> [4]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fandro
> id.googlesource.com%2Fkernel%2Fmsm%2F%2B%2F87a6b154766907020cc74c7726e8
> a68aaa9d7f6b%255E%2521%2F%23F0&amp;data=3D05%7C01%7Cjun.li%40nxp.com%7Cd1
> bdfb58b364464e957d08da90dfc29f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C637981587969870477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D3
> tjAzUL81SwFkaoUh56CND%2B27FHqdo6TbY7Z66ldE8Q%3D&amp;reserved=3D0
>=20
> Alexander Stein (4):
>   dt-bindings: usb: dwc3: Add gfladj-refclk-lpm-sel-quirk
>   usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
>   arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes
>   arm64: dts: tqma8mpql: add support for 2nd USB (host) interface
>=20
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 +++
>  .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   | 42 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +
>  drivers/usb/dwc3/core.c                       |  8 +++-
>  drivers/usb/dwc3/core.h                       |  2 +
>  5 files changed, 58 insertions(+), 1 deletion(-)
>=20
> --
> 2.25.1

