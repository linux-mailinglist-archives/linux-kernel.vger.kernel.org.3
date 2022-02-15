Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8844B6033
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiBOBv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:51:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBOBvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:51:25 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2102.outbound.protection.outlook.com [40.107.114.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584811405EF;
        Mon, 14 Feb 2022 17:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNhv8yZuw5F1ekupvLO/H4vB2Q2237O4fdTLpmqXbFOsnvLd5eAZmFq9QdZNUXlVK2sDrKcEqe/Np2sNcOooY3mSQNN1Sl8oE75pC5ojE0Rbi9OFXM6fzX6mLU622RN5fw0i/vjkaZZJniLbw7ClfpmYuZLrg1AtTmwTlvObbFz5DWZ57e7lyvFOgsITZ6XCS0ThJZ9soVsH1Ebuzunnqb5AbTr9TOvs5+WLWW7b88g1/oQZ5/bWnqJxTCF1L/2vvLc/ChdJhusTWjHLCP/1Yj4rBPrPPjG47CaOJjTaDgiauk7Acb6bJjnmEuCfIhMyUXoRoYyLlYKyPG91vt5KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40pY2QTKxhgwm7axt+IpQawPHc04+dXbuATV9LZkbTc=;
 b=ZZQXk7sl5S3wx/vRhXzxsxf5E6Grulma99XKzRew7gOsjD51tgSj+cQHTf0/eOo9JVblmzKnvji88Veu03gsM52/0gC3B/QYC1+fsSfkfRAv+Rs6VyTR8mh+MGbDp+2Ui14dip6svLg7fMv4ikMdrgvmRJrLrFfwQH7V6pURyJA2JZei8Do1pEMrdmbi5oPeADQTeTBR5UepBMFxKEgiyNLbs/xLcl7Mjw2kpNfGeNfPSm+nhDHlg5nWopXzDju0ItryFTw81fSYfTP0PeH8vwaBEdbFxhxVRNSPnTSUvWGeaxdoyV2rMTQnbDbgcvpuA/Fy/uXm8hTn+dxrqhG95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40pY2QTKxhgwm7axt+IpQawPHc04+dXbuATV9LZkbTc=;
 b=FNqDu5AG+qCoeT3YdCYzedNupa1liHduTs1hUY76MpY2/Dz/6R2NnNcRmVz/9HxgMjI5q1psyXuNTHJsYcIKNGUzsLuuVjSuqTwdBdD0d4XBNmlQDu/Mc5BEl7VQKvwdA4wGtiPTgcW390ze/w5fAZjFapLmsbqO9hLEyurGLDw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS0PR01MB6082.jpnprd01.prod.outlook.com
 (2603:1096:604:cb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 01:51:14 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::346f:1a56:ff4d:8c0a]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::346f:1a56:ff4d:8c0a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 01:51:14 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 15/15] dt-bindings: pwm: renesas,tpu: Do not require
 pwm-cells twice
Thread-Topic: [PATCH v2 15/15] dt-bindings: pwm: renesas,tpu: Do not require
 pwm-cells twice
Thread-Index: AQHYIej/xMkVKFS6d0iJGD2GVJguDKyT2OuA
Date:   Tue, 15 Feb 2022 01:51:14 +0000
Message-ID: <TYBPR01MB53417D89BA0AF94D30C52256D8349@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
 <20220214212154.8853-16-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214212154.8853-16-krzysztof.kozlowski@canonical.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c545c57-899b-4628-2ff5-08d9f025a676
x-ms-traffictypediagnostic: OS0PR01MB6082:EE_
x-microsoft-antispam-prvs: <OS0PR01MB6082ADC75505396ABEDD4EE9D8349@OS0PR01MB6082.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Szk5122zacJr6G71Yp8zV4y4+/QASh/Sw8eiw+wmviHNc0odmZdesdRWYmAVCXeqPegr+kEtVm+50TZedalDplrWtkTS11paupGnNwNJGGd7dbYNQb6jAM0/UG+PNLW7Y60HOhY/YYHoHfP3piZlzylf1k3vQgoaguaMvD7+SbTjVuF8Yk1SVgJsv4Nbr23ypJbZIkaOzUgUR21kDmcLvHaQ+JoyIXSCXTQRytlimnBX6G7mg6yCbTsJYE3QsRbZUxQfAo4/dU3b5By2qGrZl4nYB7MZ6uWz/BQEOsbq2HLZEAHWnIsqN7Esj7uP2e7LhQ60/jH3ozkfddJakhWdXmkf9D3rDmVr/g5o4toTRtZVlrhDYfF0UKiX4mMKudYIn1riKDGlRxzXpR9ZGI5MA5HoegoKJX3ELVBFE+tR/yV6VRNyNpuReo2rkKOr2ruLBs4QJSD/BOKUWRNgZM75zFZPvqxFsMUC3xuMpoqls9J1JXnQIlKZ22fCH1AeieXMzIf9Ua3SMB3GOFvGMFXbJEU6KpAmdGhJnifTgT4rLOhFvGcfcru+lg0xvJ1VfKIlTrT9HH1/NQUF341PUobZnmZQMWW3STIMMMzD4c93Sz4EeL6znetBibCScnQO3+0kUPj1vEmaFz9vRDoums2JswaZMmjDHoaTQ5p5WJfDnN2s2AJyynARmMaItZQJoT/PDmXrTcN/6FXHYWhdtumYMKG6QDODInL/zg1Du4VPJ8o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7406005)(7416002)(5660300002)(186003)(6506007)(2906002)(921005)(86362001)(8936002)(33656002)(38070700005)(52536014)(316002)(122000001)(76116006)(8676002)(66446008)(55016003)(66476007)(66556008)(64756008)(558084003)(66946007)(110136005)(508600001)(71200400001)(9686003)(7696005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D9FbRFF+tFyp6C2MAQMn3+uAxWeZEaU8TmvLyIU03hmFncTC319PfzeD+t?=
 =?iso-8859-1?Q?PFOvW9lMcAbyqBGxOzEwYAaUiUpfd0gVipzIYr75F8GtAeUQ8XTJfvKISN?=
 =?iso-8859-1?Q?7fnvYvkJAAaj+mg3GCE/zPyhu5qJLjvnjtsWJdsX+jPScf735HUHVN+13d?=
 =?iso-8859-1?Q?SqKSBb24PgJ2dTkno2EtGuLumcfGl+Eja8LDpTv1iRS9mjllvbrQ6z0rTo?=
 =?iso-8859-1?Q?c+z7AckpNV4LUt7STrgpz9Cmoz8WbQrNI76W9vI3s+DhyCyfNgppJz1Jo5?=
 =?iso-8859-1?Q?GjswZLmtpCYp+O6DL7gxJRbs3DfPBje9tTrsZq3egOKpy8HYb6vE6iefxb?=
 =?iso-8859-1?Q?d04hppwUR8UgcY3cjX+IFz6QbwrxMQpV+iWe12DohcfavV6JUvahSUkf7j?=
 =?iso-8859-1?Q?RayufOPL+xeB7mhaQKtK9ZY3kZQpnG5j5jpU8NnGSAyzLHcERJTn8m8/8g?=
 =?iso-8859-1?Q?KxUFmi3jr7Gi0pAszBL2O78o071j5a7cepUXb6Af+/vEOO7HROsyMEpc4J?=
 =?iso-8859-1?Q?KQBWgGn7mCsUXLio+BPXiuH8gb9k0Xo8zXn9JpQfMmt3QzZwPSCjRcglPB?=
 =?iso-8859-1?Q?kyq6n75PRkKuJI1603U5o7RywJaZkLM9KEgwsTtKxheHRgYKMnlpQH1mMf?=
 =?iso-8859-1?Q?m7iuB542gjL4odETxD2o0S6QoNT8qS8icAUg8T8YKF3iIq/mz6nb8+1qoR?=
 =?iso-8859-1?Q?1rEcx7M13RPbIxKnGX9lWFDM5tvO1Zk1fTMEL7A4cvQtFRoE2yhkDuh47H?=
 =?iso-8859-1?Q?h1DQaMIy4SPAgJ98HX3YvCjrgRBS559jBi5qIwYDG03sp/uw06tVeLeCMH?=
 =?iso-8859-1?Q?lzM5djahGa7iWc3cyqkYPfQM/mWZVDKUK4eaiu1SnYcGPz+VLq+zkJ1w5V?=
 =?iso-8859-1?Q?KGIGzjMH800nWQAiHVxXezETNwGmgageNxMC2bkDD47SGarDNvnr5mO8Ym?=
 =?iso-8859-1?Q?NjILDT/EbrSsBEavpzdoAPkaXVKypHudHoOcXkJw47+SHqtgnXlkM2Yf5O?=
 =?iso-8859-1?Q?f9/27PXuY1UsLAPrmlhJw4piXakw27rRhd2Qqb9yuc7Ppytnl8HBTBU7yg?=
 =?iso-8859-1?Q?aadr9De9CL0RhghHoAW/g073ci+chjiWB/ZR5TCPUX+fWrTG0SNU75fuQa?=
 =?iso-8859-1?Q?9IbVb2oAEvTfr6tFc1I97J70oLcrseJ7jNN3rgMzcwD1PdAsahjAz7VUIf?=
 =?iso-8859-1?Q?UogWnCoZA1bCHsLeT3+cgQVdoFjJ0DW7nidl7sjMwFj0Ik0En7lBG9uB4G?=
 =?iso-8859-1?Q?KiEPQZU8nqwDWNymag8hUVMOObFDAeDJfxf/GWg4dC1fn+bdaUEMUUONah?=
 =?iso-8859-1?Q?fx3LmPCK5/EiN8Xvd9+gNmFtFNcKLYydWZLYldVeOSsTaIrG0k/8ONkVoR?=
 =?iso-8859-1?Q?1vzhT99jOoQtrSDn9xjg+Qi2OLJE6s/hCat36IppqtVVsW5KMtnRJEZrV/?=
 =?iso-8859-1?Q?4OEqKkZpmgRotaj2lsjzSrcuiPso+Lr+TCHrxeHoOfhoI86esFWCxYmmn5?=
 =?iso-8859-1?Q?otrOWM8gquwaqoOVvEDe/eVyePo1uDr4klTkL3hwH1yHOJDPVfkV77MkVw?=
 =?iso-8859-1?Q?munnpeDTtw9Pl+A3VLLmJeNQO7SmD2UQ04Cxx5jQ1fh/8ZIwf0AF2tNrLY?=
 =?iso-8859-1?Q?OKpDKpUXxbiP2speXCdBbOkP9XzMc31T8pt3Mj6IKycOHlFhXAf/z6CrF6?=
 =?iso-8859-1?Q?UkircNwQOFxfxbAU2KFqGeFXDaopvw7fvGYgU3h2prSeGzA/qDW62vErbj?=
 =?iso-8859-1?Q?NEjUdLjTsx90BZES7BR0N6yghVUkIUoi3U1rjIxZhNC9S+RIOGLJS+YAj/?=
 =?iso-8859-1?Q?K0DCxREu/UsB1axEfZjfn8nRI5Ni5WRU8xcclTEE2M6RanXz9whs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c545c57-899b-4628-2ff5-08d9f025a676
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 01:51:14.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pspydgUMDCBjpFdsJWnefiw3jFAecXRWbvnRJ2wyvikp3Zbj4FKPqESxl29Yp8iW8oteAApfS6gs/HdjD9ygz93QH1fIO52dwaMT4Ud1KyHWHiuKuvkmHobatVlayMKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> From: Krzysztof Kozlowski, Sent: Tuesday, February 15, 2022 6:22 AM
>=20
> pwm-cells property is already required by pwm.yaml schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

