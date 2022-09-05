Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E95AC85D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 02:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiIEA6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 20:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIEA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 20:57:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F424BE7;
        Sun,  4 Sep 2022 17:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az3d5yLNbqs5rQqGE7B6GUMYWz1+SDRgMbxvx/G5maxWxLJY8XoZTBmjWG0GAOA1/NBdHygG931lhL29pDEv5yGe3Mw5JQr/UZ5ATVGPE+Zg8t+EkrtDLfVH9ZZHBXgkxmVHk85rpOSrA079upY/F0cbAd8FZJh4ytykM/1iLBOPPqOemGLr2lqb4cAbMKJBDfoRNpcEKLzRDwWL4cfevD8ruPJBoNzWVZKpmm9jOM9EReYkDl6BPu1rLF80S/AKhmAN7P6O8S4xVgbQpc/VO/uEw+uBYDwbM6TeqBLaarqdm21boebbhJ+o/16OIRSzbRJna+KGe5kEqarQFcr4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifmd9oib4mskvhVJzY8pL5bsfWf3mGOZKF/1iiYxxPQ=;
 b=njxgs7OkKZZLOL5j4W4IFz8QdnKkAJmFWYecggl1qYZKvgsk/Uk24FODajPdN1z9lIer2Ch67eQ5yeUc56bXdljdtEOTUqOIqTD6sOtjJ8rGmyjkr+cP2Y2flSxa8ds4J1WWOV2h+Ccg3pLAmTiYM8S1tFNRGUfq2s/tVGu1dVt0XBAwadjSGwkGA+Bkh7onfMSx9dAJLE4c2d7p537607AGksxtWggF2Pz3JRcRv7JTy8lpC1niz0o1m939M32zM09ghkogL+SjoC2fd3OVOI16zYTySTEFOrN6X7PgLBcRdaPdmNx1F4WBdEjomSyx6lsg64LsoCI/6rofBQPchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifmd9oib4mskvhVJzY8pL5bsfWf3mGOZKF/1iiYxxPQ=;
 b=lX66JYZzlmbmIblciylqVPrfLXZvfcri2g9r3U8OZIMxVH/7x1C69zo2vYlEX81FRfSH15FW7zFhf6JS+6lzkID8SZQfYd+UsiZeufWsc6fKXkjwO2IrOhgVeZJJSlYFd8spSAkHIjhMMipvtfahDHg1E3HvpoqO0Pd1mlpP5nE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 00:57:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 00:57:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 1/8] dt-bindings: soc: imx: add binding for i.MX93
 syscon
Thread-Topic: [PATCH V3 1/8] dt-bindings: soc: imx: add binding for i.MX93
 syscon
Thread-Index: AQHYvUO+WN9zC6gQlk2h4UEkedKcoa3MoqiAgANnibA=
Date:   Mon, 5 Sep 2022 00:57:43 +0000
Message-ID: <DU0PR04MB941764EE0415F4F8F059D5C0887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
 <20220831141418.38532-2-peng.fan@oss.nxp.com>
 <20220902205721.GA399775-robh@kernel.org>
In-Reply-To: <20220902205721.GA399775-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 768e8116-4edc-4175-0b9d-08da8ed9a3db
x-ms-traffictypediagnostic: DB9PR04MB9626:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xrhcjBuDy9y2GTxPuhPGGStAZO2pZm6EDVwRzf+I4+ONb5B5cMkxGXRJ5+2MDV6iTG5gsLSQGLq2yZVM+DgLyD0BtNIiWAqNWk3JfOZeHgim0HPJ7r2Ag9b0ESIEjrHfaHE+0qu4Nv4YuwB7HtWv4bQMwg3Kw+YAWjIBZeJcTcwdyXnD74DHA5GcRVNkPS0+TXYMCuZMwd8dsY/wjCsKzOl5HXOAMlCod7WEl8Vr77eE1L4Drir4ePKdaz7/axtu0ehUDMcw42EDD2/NtHRxd5If3LbJVO0e7XPBseCssoZY753Sg2E/jp0QhtaIOjGzgoQeMxfDMRhujNMWjLcsOfxIWh91y1WnWqsnzG6encjgF6CiKHxnTSOH2JPy48clv/OM3iLAtlEUsOhxraNN3prQ/FFq80/sirmp65CTcMQ7QTEzkJn8+k0PE+KgulUzoRUfaLuKMt6Ic5HDp5ne2/l5Q/UwgNRClwGuON6R2o7LC51iQvRpUKWPrqZlAneJKtDExQap/elnjbwbLhcITM3Ym5l3bDPGbLgQEMZDMBmXP8ptfck934spZJXIpxoSxxSgcE8c3FEtT2QGVLCRP6sZQiEdARSO5+/jDETR3QCr626S8gWa8ro9MB0Pfet5Vh7n7FhCS+RuYrwnIdRx558ojidl92vqxFEhLI2Twt3M+wPnLN0WDtJl2hXtOVPHt3TDh5yPLlB02MTCcAZNLR4GGAIW3dIQ2ism0/uCkPhSEyLP7mODlkKjzibL58FBoVRFOJU6IlzGCIStANCWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(66556008)(86362001)(66446008)(7696005)(122000001)(38070700005)(8676002)(66476007)(76116006)(8936002)(316002)(64756008)(4326008)(26005)(71200400001)(6506007)(52536014)(110136005)(55016003)(478600001)(38100700002)(54906003)(41300700001)(186003)(2906002)(66946007)(4744005)(9686003)(44832011)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kjAwMPNwN6wHmEP4p/C0cJUxbupcnum4mCaH+V4KcRFoddL5n+YYnCuoaIhH?=
 =?us-ascii?Q?Shss7buZIkXbjmK1KuI+LUzGiAgT3egpTktCsNyrsdjVSgD1YcIGDyUur7G9?=
 =?us-ascii?Q?bMlgWQ20FkGxIVgm4HqPROh+1c7QQw6myJLTAGZFANJgOqbY3DX2yVMZ98Cn?=
 =?us-ascii?Q?dC4+vwOCCQgac10AxU+co/G+Dd1bT664GPm9R7WN+UFPVF43Z8IQP59ywcBM?=
 =?us-ascii?Q?cwXHn9nSgOXMerzQRy+HK2jeDbrHyraa1BRV74Fe0hhRyuZAH4dM8S1EbdMl?=
 =?us-ascii?Q?1Vak6p9pHX8VppE75xlMs5gRLXXXktOgK7/ZFkVHfCkO4LuN1wQSf36w1Gnq?=
 =?us-ascii?Q?S8+B9rjpcMdFztPoEhmAL9MM9f59u7X+LVp+dMfq+unB7D3OhtJ0YKeHuZ0+?=
 =?us-ascii?Q?+rUfxnRCbXXoApGnEkpp5cKT8e4MaEfTEAG9BZmzLs1LRfBJX1ZJhKPTPm4V?=
 =?us-ascii?Q?8JWNY9dZpfwQbe+CK0+XXvyg1TGZSf+3uRXj3nzsaxNlq8YGkfIoKkED3Yvf?=
 =?us-ascii?Q?2d7AAyjOHBnIHLcjbVV+9Zmh3zSjF/+NQ+35zeaSDvfsvAXd9FYKT/j1QUcG?=
 =?us-ascii?Q?G0Ra9uzgbJhQGAqOXYt/9SBmDCz0/ojaI+War5QWsCukfoAXE4Zk+J5L4AXg?=
 =?us-ascii?Q?x5uHDrZkDKS7T3fLhcdVnt09u+TYgC88NUA2FbIZ9cR3PGjg++6ew9yQoY6L?=
 =?us-ascii?Q?D+i0J+zy/tKrUChmbVpyljvExAMc6xochwuEeo+mpNHI7U9TUBOJD1kgzfXD?=
 =?us-ascii?Q?F8Go8KYTNNGSDbKqB+p922qVDPNuxtigH1TJ/Vg7YnrMJJjgXJTCD/Uu3Eyg?=
 =?us-ascii?Q?kMaV0hDcSvXNThIDkrT3mouTYuOlCZ2eZdZ23WgsuwlgD86je6hrTlfuZnt8?=
 =?us-ascii?Q?9eqKKNX1gwsiql9Zka5BQ/tGrbI6l9YF2Wn8mNNYZzQ4NMJ3ep3xmgkXZbp2?=
 =?us-ascii?Q?CI/vvO7REB0wsfyG6oulRX0Mg5W1HdrElEk0tBKh1KOMz29yvMLaoTwfbLj3?=
 =?us-ascii?Q?Yi4/1iQpHTZmMqOSNhF67kj+105W52Xlxcem3Tw7QTR32fXUwmtVGsjPQKfA?=
 =?us-ascii?Q?fgJ2upqIogtlxvIFhvJV8rCZylxRpTtCQ+b8CvNa9zjULLXIGHcTPv1djxQW?=
 =?us-ascii?Q?O6GjbbPq8Ig9+hN0BfeB2xo7T37h6sDjZLunD0iyQqZkS4cc+VcFPCZNkJMl?=
 =?us-ascii?Q?ju6rLeTlM2uXgbLN+ObOiNPXXfbNsJxmjNgj/Cm2Sja9xOBRDC1r1st9DX6N?=
 =?us-ascii?Q?DGWj/zYLywwYDbrIh5syzwJExdftyJi+jV6vJxLBql485lCaCwIw3SMNGwIJ?=
 =?us-ascii?Q?5O7RknTfmqbbvMVf8PO/TIRlfEniIY+3qLJIrqEgkGO+wNTcN6PRYMV5lLTk?=
 =?us-ascii?Q?G/9he5+X5DRoQaqCgHn/DORQ+uda59Lgda/ZfUoZZ41duFgW+FNF1Yza5eg4?=
 =?us-ascii?Q?20bCBuBzXiCsLub7cKhOi7xCicc8T8F/cUcHTBVn3f1kmV3XzDEhpHzxSAOV?=
 =?us-ascii?Q?214iUqQbRKFTeLWDeNyjIdhXqQxvDxpv26FpR6RT509XzG/oKOGvUqzPdG5n?=
 =?us-ascii?Q?DlkehMTleXxXAg+camM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768e8116-4edc-4175-0b9d-08da8ed9a3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 00:57:43.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWWcsNPMgUCQtR7IgI61mN7GhKEUHpqicGglx06CxOvoVDgCXT9aM2eQVkvFZ4SP2htcwuedoCyAHH8gQCxCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 1/8] dt-bindings: soc: imx: add binding for i.MX93
> syscon
>=20
> On Wed, Aug 31, 2022 at 10:14:11PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add binding doc for i.MX93 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
>=20
> Is this complete or you expect to add to it? If complete, just add the
> compatible strings to syscon.yaml. If not complete, why not?

I was not aware i.MX93 blk ctrl could be added to common syscon.yaml.
Fix in V4.

Thanks,
Peng.
>=20
> Rob
