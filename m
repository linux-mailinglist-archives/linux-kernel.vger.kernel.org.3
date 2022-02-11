Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C64B204C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348074AbiBKIkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:40:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiBKIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:40:50 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64547E5E;
        Fri, 11 Feb 2022 00:40:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POJcFeHkGh04pO0wZGAxRiB4BM5nzdgWXABdOiLD53Mzhgqu4RQVEsko921YJkGlacYgVeN/aAkMBHP7ARI8/qIoYemf7dTHqQcJ1Ov/7233zE77vUO5W5CP3gnwxYhJeTg5FGFDcz+PXLh+e/eKGqHHMVePPHcrONubQfU2GOUOs5WexHFQ1bh8jljGWhHZfAkfzCIPhYed3EnBx7l2GFlMLiuCtEZYz2QoqOQigmlEubEIWdBNL3NLe7EsVdzooleElE7GwgJdpjIZ2uh48fL8byImkvnAdY4+ZNbCCOfJIkTbtqfBCc18w9sZ9lICgu7w6KogUmlSFGEb7BnqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3CSJV5m0lSMrPBs5vdF4euLqpDPpws4cgf9Zv0rUWI=;
 b=dfO/J9AEO7NRIjmSLJMSW3bCQo1x0L+irHuBt/BZQ/ik8A8+rXFwMlLecx5gipJQz6MMfOw5NmoYSrNJinJXmVccHiQUVi//zWiKJXZZ+DaXA9btwqKLg3n6sAPnldy55sReRgB41P6sJHu6V5dfeEb7Hi32wQMW4W/KI0Oy5Wg8nZR3Su35/KDeLN0igZ755ulNlni89VYj8X0xy43flyVORbjwWmNiJ6WRXmwjU3/vr9weWWkEYfjxL4aGDLQ4+9EtUyurDg20VXD5BjEfOtV1I8QKb7BGo4pm4bkEb478mbAGrZ3oyqQQQevYiL4fl8TQFKZFz9Yog92Rx9FPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3CSJV5m0lSMrPBs5vdF4euLqpDPpws4cgf9Zv0rUWI=;
 b=QZnveJjftN91HOA93SaoAsDRZYl9iJas9JNAQVy2A52LbFByD42L0FRkYzEXJRHyFPayAiNEefeAKN9eslOS/go+RvDJAffyZbg+F6IPNQKNJ2o4cRMRrO6SW+VgtqBaBWWkHBIw0gUkAapr1BkTQWitS64hZmnJoBgflJ22M/4=
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com (2603:10a6:10:af::27)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 08:40:45 +0000
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409]) by DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409%3]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 08:40:45 +0000
From:   Kane Jiang <jian.jiang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 3/3] Add i.MX8MM GPT input capture example.
Thread-Topic: [EXT] Re: [PATCH 3/3] Add i.MX8MM GPT input capture example.
Thread-Index: AQHYHlpfGpURtShQ2kKyWxo1ealzxqyM3acAgAEqYEA=
Date:   Fri, 11 Feb 2022 08:40:45 +0000
Message-ID: <DB8PR04MB5771F8F410BF86F66F04E97C9A309@DB8PR04MB5771.eurprd04.prod.outlook.com>
References: <20220210084335.1979778-1-jian.jiang@nxp.com>
 <20220210084335.1979778-4-jian.jiang@nxp.com>
 <1644504472.335356.2624783.nullmailer@robh.at.kernel.org>
In-Reply-To: <1644504472.335356.2624783.nullmailer@robh.at.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 580884b3-455b-446a-dcc7-08d9ed3a3211
x-ms-traffictypediagnostic: AM9PR04MB8571:EE_
x-microsoft-antispam-prvs: <AM9PR04MB8571ED47DB5950338D8170469A309@AM9PR04MB8571.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXy/OjNGXvsbv2OJAbxkG7YAIxTWlNnRE2GdE9QHAg4wH0tTluBPmWt+jchcJbVPkSuIBjw4Ye/WQTLwvOGcESU74q5s0nF5ubGjiYxrxgieE07NmcO6/20WLSP1jiUuRg8BX8UjV5rpCYeW31FrxxJHFB9RFsAHdSQXLSimo8AkJwd40fhx8EhIBfDjiQiqscMBsH5swo6VPTay4CRevWYqJm82UUJjX3bXSW8EP2TwqOI9nKGOdFNf8B3br0nywNqF1vveCO8bxpimW04hoBgaL5Wev+mML26Lflvbb0a34zm0HQgpdaJuBWPJURQhQZynUku3lWmjdxqW60JGneK4dO+K09U927QQvEeLKaur7pnkYg8+rwwCk+7C45VaU9HsNtE7O8wMVEVTNO2gDpFrrqIjJQboBkel6UCtgc765QWTA+q3Shnu+qM/nUnTwj+zivIF1v9ot5cwffCdxImBvOnoeCi8gUNJpfXVEUBnqR8ZqAApJCgidL0Nq9QdDCOGedwiHh7sOvtHgmV6twnI1g6/Am+yId2epaqMkwoo2cJptXlTSRvWVLF5APEzVtg/7Uq12VlTblmme21Z5ilisdq8c2oQ4AXDt3soAyiqfzoFlXzJzJl1vjfHtZKXRVE2Cj1RbtjoTGu20lYek4ekzRK6xcbYaEf2StgrYDZZ2nRDPJWzSIGHFSb2VP/hMuXXokaan0ARNaLXAwJOToOc9izQn0wefd3Nomtak/x4VrvavjSlCUX4BbIDLHOS4wCarNC17tx3FJaaz5D4pklYhwnxwb6R1zd9xLsnCQPNEQP5eLXUyYkU8m7eFr51
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB5771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(30864003)(7696005)(6506007)(2906002)(508600001)(45080400002)(38070700005)(83380400001)(966005)(71200400001)(6916009)(54906003)(316002)(38100700002)(76116006)(122000001)(186003)(5660300002)(66476007)(66556008)(66946007)(66446008)(9686003)(86362001)(52536014)(64756008)(4326008)(8676002)(33656002)(7416002)(26005)(53546011)(8936002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qTnaKbjorsTLhtrnbAaJ6NjuPMecDoYZGjYONmYX/AtQRzxVeAfpsh4g22vN?=
 =?us-ascii?Q?AzJmnLeQhqCQ9SQkplPWmhBorIC1nBP/+GJEHDx+mVdMw8iO2mpVPTJMAQve?=
 =?us-ascii?Q?56KJluh/fI10JOqf7sPkCuF5lY1bX93Z3bBJ3MMrWpXtkYKZ3ETcz/08Erzv?=
 =?us-ascii?Q?YCp5OoLmBAUwQVf2XR7T9AwkwwxIm30yhTjvp7GB6edcBsepXBwhguApxnVt?=
 =?us-ascii?Q?9cKn1+l6BCj/32NtUR4Q7XjJY5yLK5l9EZ0DKntbvqB1FOG7WQj84XM3bl3J?=
 =?us-ascii?Q?9kt/4nEmxGiI40r4LpQwLMmdaOVTvlgx+a57e6qASLACferZWNkTFnQfhmnF?=
 =?us-ascii?Q?5YfP/YZkraqK0YqPFGQhaJN+tHV6JoXiAez9CYvuRWrm/2yyCOSDUj8abRzV?=
 =?us-ascii?Q?ne1qL14UC+oUCg30xx4ErUqf+vAfABTD6lzqhRPfu/QwbnXyrGLeW8INgYuI?=
 =?us-ascii?Q?svF6FZf1PO0TCMoe5P6Pdy3H+HKyEAYUw5KwOi04qFdaNklTfvoy9qLGIL5T?=
 =?us-ascii?Q?KJk5ay3I3B894k4berTteG9/2rnvLtA2VeAUVfNh8QIj4WgDdNlFPvyUq/72?=
 =?us-ascii?Q?tmwImxXWrrEr6QBk3B7xyLNOQ8WgC/CdlpBS409lA6bgcmBG0kVdqsFlQm5u?=
 =?us-ascii?Q?S28K1cc9O2glqWjyBlzsKnuVJGALuu7rbT/eZNOCLZh/bzzgrGujROSE9C1v?=
 =?us-ascii?Q?QVMSDGYURrfve+4fjWdLZpijKv6yxMocuvq/RQqkuWZgrUv29GrmFidSu3Pw?=
 =?us-ascii?Q?Q8BYrX9jU3L3zU7HBsCBlSBUsPpOX58R9NeBxKHt5l8zl02AjsdfXXN4PCWu?=
 =?us-ascii?Q?82v8a3YVZ80fYYyK63ezwQn8PY48mH+46PSVwcKkU5nrqRQ78w9dGKX0jv+Y?=
 =?us-ascii?Q?H2UuqMtT/Tf8tIJDquo9giGYU/6zK4vVhx+EsQBykkBE6IjCi2mUFxzloBIX?=
 =?us-ascii?Q?nB3non+F2/vADY6lyCocIrG+JatUWidhRClbV8JmeK9av9JZj+mVx4kOLWqL?=
 =?us-ascii?Q?IKSGpTfCADWwYqpy0UlUkuTdh/GViWzMe9yyaIoGR0lFipg9son6a6qKsEuR?=
 =?us-ascii?Q?uahBFC1nv8Xfd8uuAd/jC1JgRtPpkRMG2+36OQbgaeayamMDd33si3eGWHLK?=
 =?us-ascii?Q?pLE6iWGmU1I7zpeR8bJOWX2NSfhsS6RBBMKGEQRCV3al1rx4O9nqik+sfDKq?=
 =?us-ascii?Q?Xb4kAKc2Wqp126sReBmkthCp/DO/gBKpSfLXPW2fX9e3ucHgn62d2DhJsFXu?=
 =?us-ascii?Q?ee07h36ZcEzlMA4nu/7pRw8M91TVgMCvFzSI/tsiohXvG0UGC+G4k3EJGIZT?=
 =?us-ascii?Q?1J0UedTnKVF/6S21sHSaau7Gw8guCDXaYDfHolfljT1xGYu688KFCHgSJ9CZ?=
 =?us-ascii?Q?8XW/dGrgZZloKK/xYrKz/rH5qwiEyF83jFXbAnXOLptzLtfFeBVlFj6l1IKf?=
 =?us-ascii?Q?YDW1FtUjRSx2TkLVBmCvxooSWiaG28+ItlfGnVlvgOJwbSORzl6Lo0TIu7g1?=
 =?us-ascii?Q?uQAT0rLC2w6GwcvRif+IWNUe+I3/wJ+u+V4LXlByhv9J8M1ibGD41/MMlz8j?=
 =?us-ascii?Q?Ef8JPYAne8hDjkL5kOBtDLr+djIZLe6FjHb4a0+tbJ0DM+Y2QzX+W+j3jhRA?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5771.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580884b3-455b-446a-dcc7-08d9ed3a3211
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 08:40:45.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: so3rSuS0Qwfho97pY/f4thu1HajMwl0k4C3jU1D+1t9bQhcjpoHCLpiYCnFKSxjF2Mq7nikxYh4cFoBZg28qnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your check.
These warnings were not caused by my patches. They were there without my pa=
tch, fsl,imxgpt.yaml misses lots of i.MX chips.
How about I remove the compatible string change in 0002 patch and remove th=
e 0003 patch? Later I may update the fsl,imxgpt.yaml totally.=20

All the Best
Kane Jiang

-----Original Message-----
From: Rob Herring <robh@kernel.org>=20
Sent: Thursday, February 10, 2022 22:48
To: Kane Jiang <jian.jiang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>; Steve Longerbeam <slon=
gerbeam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer <s.hauer=
@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Rob Herring <robh+dt@ker=
nel.org>; devicetree@vger.kernel.org; Daniel Lezcano <daniel.lezcano@linaro=
.org>; Fabio Estevam <festevam@gmail.com>; Thomas Gleixner <tglx@linutronix=
.de>; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: [EXT] Re: [PATCH 3/3] Add i.MX8MM GPT input capture example.

Caution: EXT Email

On Thu, 10 Feb 2022 16:43:35 +0800, Kane Jiang wrote:
> Cause i.MX GPT dts example cannot match i.MX8 chip series.
> So add NXP i.MX8MM chip GPT input capture function example to yaml=20
> file.
>
> Signed-off-by: Kane Jiang <jian.jiang@nxp.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.yaml | 48=20
> +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>

Running 'make dtbs_check' with the schema in this patch gives the following=
 warnings. Consider if they are expected or the schema is incorrect. These =
may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://eur01.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F1590920&amp;data=3D04%7=
C01%7Cjian.jiang%40nxp.com%7C393dc52f32cf4ef317f008d9eca4546f%7C686ea1d3bc2=
b4c6fa92cd99c5c301635%7C0%7C0%7C637801012814081451%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a=
mp;sdata=3Dnl0FYBbRdqpHTKcz7i9dReTOXjY8NiQDEhsvudfKoug%3D&amp;reserved=3D0


timer@2098000: clock-names: ['ipg', 'per', 'osc_per'] is too long
        arch/arm/boot/dts/imx6dl-alti6p.dt.yaml
        arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos2_4.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos2_7.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos_4.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos_7.dt.yaml
        arch/arm/boot/dts/imx6dl-b105pv2.dt.yaml
        arch/arm/boot/dts/imx6dl-b105v2.dt.yaml
        arch/arm/boot/dts/imx6dl-b125pv2.dt.yaml
        arch/arm/boot/dts/imx6dl-b125v2.dt.yaml
        arch/arm/boot/dts/imx6dl-b155v2.dt.yaml
        arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6dl-cubox-i.dt.yaml
        arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dt.yaml
        arch/arm/boot/dts/imx6dl-dhcom-picoitx.dt.yaml
        arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dt.yaml
        arch/arm/boot/dts/imx6dl-emcon-avari.dt.yaml
        arch/arm/boot/dts/imx6dl-gw51xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw52xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw53xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw54xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw551x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw552x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw553x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw560x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5903.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5904.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5907.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5910.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5912.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5913.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard2.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-icore.dt.yaml
        arch/arm/boot/dts/imx6dl-icore-mipi.dt.yaml
        arch/arm/boot/dts/imx6dl-icore-rqs.dt.yaml
        arch/arm/boot/dts/imx6dl-lanmcu.dt.yaml
        arch/arm/boot/dts/imx6dl-mamoj.dt.yaml
        arch/arm/boot/dts/imx6dl-mba6a.dt.yaml
        arch/arm/boot/dts/imx6dl-mba6b.dt.yaml
        arch/arm/boot/dts/imx6dl-nit6xlite.dt.yaml
        arch/arm/boot/dts/imx6dl-nitrogen6x.dt.yaml
        arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6dl-phytec-pbab01.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-pi.dt.yaml
        arch/arm/boot/dts/imx6dl-plybas.dt.yaml
        arch/arm/boot/dts/imx6dl-plym2m.dt.yaml
        arch/arm/boot/dts/imx6dl-prtmvt.dt.yaml
        arch/arm/boot/dts/imx6dl-prtrvt.dt.yaml
        arch/arm/boot/dts/imx6dl-prtvt7.dt.yaml
        arch/arm/boot/dts/imx6dl-rex-basic.dt.yaml
        arch/arm/boot/dts/imx6dl-riotboard.dt.yaml
        arch/arm/boot/dts/imx6dl-sabreauto.dt.yaml
        arch/arm/boot/dts/imx6dl-sabrelite.dt.yaml
        arch/arm/boot/dts/imx6dl-sabresd.dt.yaml
        arch/arm/boot/dts/imx6dl-savageboard.dt.yaml
        arch/arm/boot/dts/imx6dl-skov-revc-lt2.dt.yaml
        arch/arm/boot/dts/imx6dl-skov-revc-lt6.dt.yaml
        arch/arm/boot/dts/imx6dl-solidsense.dt.yaml
        arch/arm/boot/dts/imx6dl-ts4900.dt.yaml
        arch/arm/boot/dts/imx6dl-ts7970.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6dl-comtft.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8034.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8035.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-801x.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-8033.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-811x.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-udoo.dt.yaml
        arch/arm/boot/dts/imx6dl-victgo.dt.yaml
        arch/arm/boot/dts/imx6dl-vicut1.dt.yaml
        arch/arm/boot/dts/imx6dl-wandboard.dt.yaml
        arch/arm/boot/dts/imx6dl-wandboard-revb1.dt.yaml
        arch/arm/boot/dts/imx6dl-wandboard-revd1.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-draco.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-hydra.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-orion.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-ursa.dt.yaml
        arch/arm/boot/dts/imx6q-apalis-eval.dt.yaml
        arch/arm/boot/dts/imx6q-apalis-ixora.dt.yaml
        arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dt.yaml
        arch/arm/boot/dts/imx6q-apf6dev.dt.yaml
        arch/arm/boot/dts/imx6q-arm2.dt.yaml
        arch/arm/boot/dts/imx6q-b450v3.dt.yaml
        arch/arm/boot/dts/imx6q-b650v3.dt.yaml
        arch/arm/boot/dts/imx6q-b850v3.dt.yaml
        arch/arm/boot/dts/imx6q-cm-fx6.dt.yaml
        arch/arm/boot/dts/imx6q-cubox-i.dt.yaml
        arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-cubox-i-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-dfi-fs700-m60.dt.yaml
        arch/arm/boot/dts/imx6q-dhcom-pdk2.dt.yaml
        arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dt.yaml
        arch/arm/boot/dts/imx6q-dmo-edmqmx6.dt.yaml
        arch/arm/boot/dts/imx6q-dms-ba16.dt.yaml
        arch/arm/boot/dts/imx6q-ds.dt.yaml
        arch/arm/boot/dts/imx6q-emcon-avari.dt.yaml
        arch/arm/boot/dts/imx6q-evi.dt.yaml
        arch/arm/boot/dts/imx6q-gk802.dt.yaml
        arch/arm/boot/dts/imx6q-gw51xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw52xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw53xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw5400-a.dt.yaml
        arch/arm/boot/dts/imx6q-gw54xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw551x.dt.yaml
        arch/arm/boot/dts/imx6q-gw552x.dt.yaml
        arch/arm/boot/dts/imx6q-gw553x.dt.yaml
        arch/arm/boot/dts/imx6q-gw560x.dt.yaml
        arch/arm/boot/dts/imx6q-gw5903.dt.yaml
        arch/arm/boot/dts/imx6q-gw5904.dt.yaml
        arch/arm/boot/dts/imx6q-gw5907.dt.yaml
        arch/arm/boot/dts/imx6q-gw5910.dt.yaml
        arch/arm/boot/dts/imx6q-gw5912.dt.yaml
        arch/arm/boot/dts/imx6q-gw5913.dt.yaml
        arch/arm/boot/dts/imx6q-h100.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard2.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-icore.dt.yaml
        arch/arm/boot/dts/imx6q-icore-mipi.dt.yaml
        arch/arm/boot/dts/imx6q-icore-ofcap10.dt.yaml
        arch/arm/boot/dts/imx6q-icore-ofcap12.dt.yaml
        arch/arm/boot/dts/imx6q-icore-rqs.dt.yaml
        arch/arm/boot/dts/imx6q-kp-tpc.dt.yaml
        arch/arm/boot/dts/imx6q-logicpd.dt.yaml
        arch/arm/boot/dts/imx6q-marsboard.dt.yaml
        arch/arm/boot/dts/imx6q-mba6a.dt.yaml
        arch/arm/boot/dts/imx6q-mba6b.dt.yaml
        arch/arm/boot/dts/imx6q-mccmon6.dt.yaml
        arch/arm/boot/dts/imx6q-nitrogen6_max.dt.yaml
        arch/arm/boot/dts/imx6q-nitrogen6_som2.dt.yaml
        arch/arm/boot/dts/imx6q-nitrogen6x.dt.yaml
        arch/arm/boot/dts/imx6q-novena.dt.yaml
        arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dt.yaml
        arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6q-phytec-pbab01.dt.yaml
        arch/arm/boot/dts/imx6q-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx6q-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx6q-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx6q-pico-pi.dt.yaml
        arch/arm/boot/dts/imx6q-pistachio.dt.yaml
        arch/arm/boot/dts/imx6qp-mba6b.dt.yaml
        arch/arm/boot/dts/imx6qp-nitrogen6_max.dt.yaml
        arch/arm/boot/dts/imx6qp-nitrogen6_som2.dt.yaml
        arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6qp-prtwd3.dt.yaml
        arch/arm/boot/dts/imx6q-prti6q.dt.yaml
        arch/arm/boot/dts/imx6q-prtwd2.dt.yaml
        arch/arm/boot/dts/imx6qp-sabreauto.dt.yaml
        arch/arm/boot/dts/imx6qp-sabresd.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8037.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8137.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dt.yaml
        arch/arm/boot/dts/imx6qp-vicutp.dt.yaml
        arch/arm/boot/dts/imx6qp-wandboard-revd1.dt.yaml
        arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dt.yaml
        arch/arm/boot/dts/imx6qp-zii-rdu2.dt.yaml
        arch/arm/boot/dts/imx6q-rex-pro.dt.yaml
        arch/arm/boot/dts/imx6q-sabreauto.dt.yaml
        arch/arm/boot/dts/imx6q-sabrelite.dt.yaml
        arch/arm/boot/dts/imx6q-sabresd.dt.yaml
        arch/arm/boot/dts/imx6q-savageboard.dt.yaml
        arch/arm/boot/dts/imx6q-sbc6x.dt.yaml
        arch/arm/boot/dts/imx6q-skov-revc-lt2.dt.yaml
        arch/arm/boot/dts/imx6q-skov-revc-lt6.dt.yaml
        arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dt.yaml
        arch/arm/boot/dts/imx6q-solidsense.dt.yaml
        arch/arm/boot/dts/imx6q-tbs2910.dt.yaml
        arch/arm/boot/dts/imx6q-ts4900.dt.yaml
        arch/arm/boot/dts/imx6q-ts7970.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1010.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1020.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1036.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1110.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dt.yaml
        arch/arm/boot/dts/imx6q-udoo.dt.yaml
        arch/arm/boot/dts/imx6q-utilite-pro.dt.yaml
        arch/arm/boot/dts/imx6q-var-dt6customboard.dt.yaml
        arch/arm/boot/dts/imx6q-vicut1.dt.yaml
        arch/arm/boot/dts/imx6q-wandboard.dt.yaml
        arch/arm/boot/dts/imx6q-wandboard-revb1.dt.yaml
        arch/arm/boot/dts/imx6q-wandboard-revd1.dt.yaml
        arch/arm/boot/dts/imx6q-yapp4-crux.dt.yaml
        arch/arm/boot/dts/imx6q-zii-rdu2.dt.yaml
        arch/arm/boot/dts/imx6s-dhcom-drc02.dt.yaml

timer@2098000: clocks: [[2, 119], [2, 120], [2, 237]] is too long
        arch/arm/boot/dts/imx6dl-alti6p.dt.yaml
        arch/arm/boot/dts/imx6dl-apf6dev.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos2_4.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos2_7.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos_4.dt.yaml
        arch/arm/boot/dts/imx6dl-aristainetos_7.dt.yaml
        arch/arm/boot/dts/imx6dl-b105pv2.dt.yaml
        arch/arm/boot/dts/imx6dl-b105v2.dt.yaml
        arch/arm/boot/dts/imx6dl-b125pv2.dt.yaml
        arch/arm/boot/dts/imx6dl-b125v2.dt.yaml
        arch/arm/boot/dts/imx6dl-b155v2.dt.yaml
        arch/arm/boot/dts/imx6dl-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6dl-cubox-i.dt.yaml
        arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dt.yaml
        arch/arm/boot/dts/imx6dl-dhcom-picoitx.dt.yaml
        arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dt.yaml
        arch/arm/boot/dts/imx6dl-emcon-avari.dt.yaml
        arch/arm/boot/dts/imx6dl-gw51xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw52xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw53xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw54xx.dt.yaml
        arch/arm/boot/dts/imx6dl-gw551x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw552x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw553x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw560x.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5903.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5904.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5907.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5910.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5912.dt.yaml
        arch/arm/boot/dts/imx6dl-gw5913.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard2.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dt.yaml
        arch/arm/boot/dts/imx6dl-icore.dt.yaml
        arch/arm/boot/dts/imx6dl-icore-mipi.dt.yaml
        arch/arm/boot/dts/imx6dl-icore-rqs.dt.yaml
        arch/arm/boot/dts/imx6dl-lanmcu.dt.yaml
        arch/arm/boot/dts/imx6dl-mamoj.dt.yaml
        arch/arm/boot/dts/imx6dl-mba6a.dt.yaml
        arch/arm/boot/dts/imx6dl-mba6b.dt.yaml
        arch/arm/boot/dts/imx6dl-nit6xlite.dt.yaml
        arch/arm/boot/dts/imx6dl-nitrogen6x.dt.yaml
        arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6dl-phytec-pbab01.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx6dl-pico-pi.dt.yaml
        arch/arm/boot/dts/imx6dl-plybas.dt.yaml
        arch/arm/boot/dts/imx6dl-plym2m.dt.yaml
        arch/arm/boot/dts/imx6dl-prtmvt.dt.yaml
        arch/arm/boot/dts/imx6dl-prtrvt.dt.yaml
        arch/arm/boot/dts/imx6dl-prtvt7.dt.yaml
        arch/arm/boot/dts/imx6dl-rex-basic.dt.yaml
        arch/arm/boot/dts/imx6dl-riotboard.dt.yaml
        arch/arm/boot/dts/imx6dl-sabreauto.dt.yaml
        arch/arm/boot/dts/imx6dl-sabrelite.dt.yaml
        arch/arm/boot/dts/imx6dl-sabresd.dt.yaml
        arch/arm/boot/dts/imx6dl-savageboard.dt.yaml
        arch/arm/boot/dts/imx6dl-skov-revc-lt2.dt.yaml
        arch/arm/boot/dts/imx6dl-skov-revc-lt6.dt.yaml
        arch/arm/boot/dts/imx6dl-solidsense.dt.yaml
        arch/arm/boot/dts/imx6dl-ts4900.dt.yaml
        arch/arm/boot/dts/imx6dl-ts7970.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6dl-comtft.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8034.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8035.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-801x.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-8033.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-811x.dt.yaml
        arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dt.yaml
        arch/arm/boot/dts/imx6dl-udoo.dt.yaml
        arch/arm/boot/dts/imx6dl-victgo.dt.yaml
        arch/arm/boot/dts/imx6dl-vicut1.dt.yaml
        arch/arm/boot/dts/imx6dl-wandboard.dt.yaml
        arch/arm/boot/dts/imx6dl-wandboard-revb1.dt.yaml
        arch/arm/boot/dts/imx6dl-wandboard-revd1.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-draco.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-hydra.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-orion.dt.yaml
        arch/arm/boot/dts/imx6dl-yapp4-ursa.dt.yaml
        arch/arm/boot/dts/imx6q-apalis-eval.dt.yaml
        arch/arm/boot/dts/imx6q-apalis-ixora.dt.yaml
        arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dt.yaml
        arch/arm/boot/dts/imx6q-apf6dev.dt.yaml
        arch/arm/boot/dts/imx6q-arm2.dt.yaml
        arch/arm/boot/dts/imx6q-b450v3.dt.yaml
        arch/arm/boot/dts/imx6q-b650v3.dt.yaml
        arch/arm/boot/dts/imx6q-b850v3.dt.yaml
        arch/arm/boot/dts/imx6q-cm-fx6.dt.yaml
        arch/arm/boot/dts/imx6q-cubox-i.dt.yaml
        arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-cubox-i-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-dfi-fs700-m60.dt.yaml
        arch/arm/boot/dts/imx6q-dhcom-pdk2.dt.yaml
        arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dt.yaml
        arch/arm/boot/dts/imx6q-dmo-edmqmx6.dt.yaml
        arch/arm/boot/dts/imx6q-dms-ba16.dt.yaml
        arch/arm/boot/dts/imx6q-ds.dt.yaml
        arch/arm/boot/dts/imx6q-emcon-avari.dt.yaml
        arch/arm/boot/dts/imx6q-evi.dt.yaml
        arch/arm/boot/dts/imx6q-gk802.dt.yaml
        arch/arm/boot/dts/imx6q-gw51xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw52xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw53xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw5400-a.dt.yaml
        arch/arm/boot/dts/imx6q-gw54xx.dt.yaml
        arch/arm/boot/dts/imx6q-gw551x.dt.yaml
        arch/arm/boot/dts/imx6q-gw552x.dt.yaml
        arch/arm/boot/dts/imx6q-gw553x.dt.yaml
        arch/arm/boot/dts/imx6q-gw560x.dt.yaml
        arch/arm/boot/dts/imx6q-gw5903.dt.yaml
        arch/arm/boot/dts/imx6q-gw5904.dt.yaml
        arch/arm/boot/dts/imx6q-gw5907.dt.yaml
        arch/arm/boot/dts/imx6q-gw5910.dt.yaml
        arch/arm/boot/dts/imx6q-gw5912.dt.yaml
        arch/arm/boot/dts/imx6q-gw5913.dt.yaml
        arch/arm/boot/dts/imx6q-h100.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard2.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-hummingboard-som-v15.dt.yaml
        arch/arm/boot/dts/imx6q-icore.dt.yaml
        arch/arm/boot/dts/imx6q-icore-mipi.dt.yaml
        arch/arm/boot/dts/imx6q-icore-ofcap10.dt.yaml
        arch/arm/boot/dts/imx6q-icore-ofcap12.dt.yaml
        arch/arm/boot/dts/imx6q-icore-rqs.dt.yaml
        arch/arm/boot/dts/imx6q-kp-tpc.dt.yaml
        arch/arm/boot/dts/imx6q-logicpd.dt.yaml
        arch/arm/boot/dts/imx6q-marsboard.dt.yaml
        arch/arm/boot/dts/imx6q-mba6a.dt.yaml
        arch/arm/boot/dts/imx6q-mba6b.dt.yaml
        arch/arm/boot/dts/imx6q-mccmon6.dt.yaml
        arch/arm/boot/dts/imx6q-nitrogen6_max.dt.yaml
        arch/arm/boot/dts/imx6q-nitrogen6_som2.dt.yaml
        arch/arm/boot/dts/imx6q-nitrogen6x.dt.yaml
        arch/arm/boot/dts/imx6q-novena.dt.yaml
        arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dt.yaml
        arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6q-phytec-pbab01.dt.yaml
        arch/arm/boot/dts/imx6q-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx6q-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx6q-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx6q-pico-pi.dt.yaml
        arch/arm/boot/dts/imx6q-pistachio.dt.yaml
        arch/arm/boot/dts/imx6qp-mba6b.dt.yaml
        arch/arm/boot/dts/imx6qp-nitrogen6_max.dt.yaml
        arch/arm/boot/dts/imx6qp-nitrogen6_som2.dt.yaml
        arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6qp-prtwd3.dt.yaml
        arch/arm/boot/dts/imx6q-prti6q.dt.yaml
        arch/arm/boot/dts/imx6q-prtwd2.dt.yaml
        arch/arm/boot/dts/imx6qp-sabreauto.dt.yaml
        arch/arm/boot/dts/imx6qp-sabresd.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8037.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8137.dt.yaml
        arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dt.yaml
        arch/arm/boot/dts/imx6qp-vicutp.dt.yaml
        arch/arm/boot/dts/imx6qp-wandboard-revd1.dt.yaml
        arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dt.yaml
        arch/arm/boot/dts/imx6qp-zii-rdu2.dt.yaml
        arch/arm/boot/dts/imx6q-rex-pro.dt.yaml
        arch/arm/boot/dts/imx6q-sabreauto.dt.yaml
        arch/arm/boot/dts/imx6q-sabrelite.dt.yaml
        arch/arm/boot/dts/imx6q-sabresd.dt.yaml
        arch/arm/boot/dts/imx6q-savageboard.dt.yaml
        arch/arm/boot/dts/imx6q-sbc6x.dt.yaml
        arch/arm/boot/dts/imx6q-skov-revc-lt2.dt.yaml
        arch/arm/boot/dts/imx6q-skov-revc-lt6.dt.yaml
        arch/arm/boot/dts/imx6q-skov-reve-mi1010ait-1cp1.dt.yaml
        arch/arm/boot/dts/imx6q-solidsense.dt.yaml
        arch/arm/boot/dts/imx6q-tbs2910.dt.yaml
        arch/arm/boot/dts/imx6q-ts4900.dt.yaml
        arch/arm/boot/dts/imx6q-ts7970.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1010.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1020.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1036.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-1110.dt.yaml
        arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dt.yaml
        arch/arm/boot/dts/imx6q-udoo.dt.yaml
        arch/arm/boot/dts/imx6q-utilite-pro.dt.yaml
        arch/arm/boot/dts/imx6q-var-dt6customboard.dt.yaml
        arch/arm/boot/dts/imx6q-vicut1.dt.yaml
        arch/arm/boot/dts/imx6q-wandboard.dt.yaml
        arch/arm/boot/dts/imx6q-wandboard-revb1.dt.yaml
        arch/arm/boot/dts/imx6q-wandboard-revd1.dt.yaml
        arch/arm/boot/dts/imx6q-yapp4-crux.dt.yaml
        arch/arm/boot/dts/imx6q-zii-rdu2.dt.yaml
        arch/arm/boot/dts/imx6s-dhcom-drc02.dt.yaml

timer@2098000: compatible: 'oneOf' conditional failed, one must be fixed:
        arch/arm/boot/dts/imx6sl-evk.dt.yaml
        arch/arm/boot/dts/imx6sll-evk.dt.yaml
        arch/arm/boot/dts/imx6sll-kobo-clarahd.dt.yaml
        arch/arm/boot/dts/imx6sll-kobo-librah2o.dt.yaml
        arch/arm/boot/dts/imx6sl-tolino-shine2hd.dt.yaml
        arch/arm/boot/dts/imx6sl-tolino-shine3.dt.yaml
        arch/arm/boot/dts/imx6sl-tolino-vision5.dt.yaml
        arch/arm/boot/dts/imx6sl-warp.dt.yaml
        arch/arm/boot/dts/imx6ul-14x14-evk.dt.yaml
        arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dt.yaml
        arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dt.yaml
        arch/arm/boot/dts/imx6ul-geam.dt.yaml
        arch/arm/boot/dts/imx6ul-isiot-emmc.dt.yaml
        arch/arm/boot/dts/imx6ul-isiot-nand.dt.yaml
        arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dt.yaml
        arch/arm/boot/dts/imx6ul-kontron-n6310-s.dt.yaml
        arch/arm/boot/dts/imx6ull-14x14-evk.dt.yaml
        arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6ull-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6ul-liteboard.dt.yaml
        arch/arm/boot/dts/imx6ull-jozacp.dt.yaml
        arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dt.yaml
        arch/arm/boot/dts/imx6ull-opos6uldev.dt.yaml
        arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dt.yaml
        arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6ul-opos6uldev.dt.yaml
        arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dt.yaml
        arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6ul-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx6ul-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx6ul-pico-pi.dt.yaml
        arch/arm/boot/dts/imx6ul-prti6g.dt.yaml
        arch/arm/boot/dts/imx6ul-tx6ul-0010.dt.yaml
        arch/arm/boot/dts/imx6ul-tx6ul-0011.dt.yaml
        arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dt.yaml
        arch/arm/boot/dts/imx6ulz-14x14-evk.dt.yaml
        arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dt.yaml

timer@20e8000: compatible: 'oneOf' conditional failed, one must be fixed:
        arch/arm/boot/dts/imx6ul-14x14-evk.dt.yaml
        arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dt.yaml
        arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dt.yaml
        arch/arm/boot/dts/imx6ul-geam.dt.yaml
        arch/arm/boot/dts/imx6ul-isiot-emmc.dt.yaml
        arch/arm/boot/dts/imx6ul-isiot-nand.dt.yaml
        arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dt.yaml
        arch/arm/boot/dts/imx6ul-kontron-n6310-s.dt.yaml
        arch/arm/boot/dts/imx6ull-14x14-evk.dt.yaml
        arch/arm/boot/dts/imx6ull-colibri-emmc-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6ull-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dt.yaml
        arch/arm/boot/dts/imx6ul-liteboard.dt.yaml
        arch/arm/boot/dts/imx6ull-jozacp.dt.yaml
        arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dt.yaml
        arch/arm/boot/dts/imx6ull-opos6uldev.dt.yaml
        arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-emmc.dt.yaml
        arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6ul-opos6uldev.dt.yaml
        arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-emmc.dt.yaml
        arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dt.yaml
        arch/arm/boot/dts/imx6ul-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx6ul-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx6ul-pico-pi.dt.yaml
        arch/arm/boot/dts/imx6ul-prti6g.dt.yaml
        arch/arm/boot/dts/imx6ul-tx6ul-0010.dt.yaml
        arch/arm/boot/dts/imx6ul-tx6ul-0011.dt.yaml
        arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dt.yaml

timer@302d0000: compatible: 'oneOf' conditional failed, one must be fixed:
        arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
        arch/arm/boot/dts/imx7d-mba7.dt.yaml
        arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
        arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
        arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
        arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
        arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-sdb.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7s-mba7.dt.yaml
        arch/arm/boot/dts/imx7s-warp.dt.yaml

timer@302e0000: compatible: 'oneOf' conditional failed, one must be fixed:
        arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
        arch/arm/boot/dts/imx7d-mba7.dt.yaml
        arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
        arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
        arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
        arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
        arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-sdb.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7s-mba7.dt.yaml
        arch/arm/boot/dts/imx7s-warp.dt.yaml

timer@302f0000: compatible: 'oneOf' conditional failed, one must be fixed:
        arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
        arch/arm/boot/dts/imx7d-mba7.dt.yaml
        arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
        arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
        arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
        arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
        arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-sdb.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7s-mba7.dt.yaml
        arch/arm/boot/dts/imx7s-warp.dt.yaml

timer@30300000: compatible: 'oneOf' conditional failed, one must be fixed:
        arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-aster.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator.dt.yaml
        arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dt.yaml
        arch/arm/boot/dts/imx7d-mba7.dt.yaml
        arch/arm/boot/dts/imx7d-meerkat96.dt.yaml
        arch/arm/boot/dts/imx7d-nitrogen7.dt.yaml
        arch/arm/boot/dts/imx7d-pico-dwarf.dt.yaml
        arch/arm/boot/dts/imx7d-pico-hobbit.dt.yaml
        arch/arm/boot/dts/imx7d-pico-nymph.dt.yaml
        arch/arm/boot/dts/imx7d-pico-pi.dt.yaml
        arch/arm/boot/dts/imx7d-remarkable2.dt.yaml
        arch/arm/boot/dts/imx7d-sbc-imx7.dt.yaml
        arch/arm/boot/dts/imx7d-sdb.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-reva.dt.yaml
        arch/arm/boot/dts/imx7d-sdb-sht11.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rmu2.dt.yaml
        arch/arm/boot/dts/imx7d-zii-rpu2.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-aster.dt.yaml
        arch/arm/boot/dts/imx7s-colibri-eval-v3.dt.yaml
        arch/arm/boot/dts/imx7s-mba7.dt.yaml
        arch/arm/boot/dts/imx7s-warp.dt.yaml

timer@53f90000: compatible: 'oneOf' conditional failed, one must be fixed:
        arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dt.yaml
        arch/arm/boot/dts/imx35-pdk.dt.yaml

