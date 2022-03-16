Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931DD4DAFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355777AbiCPM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355751AbiCPM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:27:38 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D16661B;
        Wed, 16 Mar 2022 05:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyI+310yWaFcU5Jd746lgJddB9tenR8tt9HtNr2qeK7xT5n2uYbUltFgDmah2J8WZp4QlqlsoJCmW9Wyjxqnp/XPYVHOS60TDfCWn0e680nBrF11FOhS8LDwau/hdDqzgV5vG5l3JfMUkJXEs+yeYp24VaUPlTm0tw3WrJ1weFKuJRAT5PSTMdVRgsT/cJkZW1MYnS84Mfc7VDzB1S48MfyGmIeQ9sFNGA5tT7fzUJ0+h8X89CA9zXxIk3nvjjbUN8YPdKUGpAwiaH+briYW5w/SgMd+lgS91GGWLEBn6BFVW/rtxU/WC20nKT6ZvMdNeWM4Pojq9Qm825KSWnrC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjGP0jfZZUGys5c7n5R8ExBHWwo0N9aT+qdxOs/yhb4=;
 b=TVnqILnNpJPFZjudtfSso6HFoITI4X6KzpUDtSgWCiPmCF0IgKnIaQMj2vsSEezfXVDr2ZLMZUD48zG0qeIAww0Fg1U7SMLUpvzH3DLAyB0CLprS/tDl+SI+tzdPz9uy22weLEwhSdxb0BzZ3ANO12+9ZLikwe1tWrgm/xFKwhvdb0ym77o7eMkIBcJxDH7QXQIEmDpuSr+mDmeTtDojl1YVDV+cGtu0sYtcNutIrU4uhqU2t55mqoy00weKFBztkx5d+NNehXt3n3Pu1syP55ni+WcEgcaPN/UGHe9nOwCrnm8+MmVEU8/fpL9OCWvuK+K9TCE7zHdNOSLcIcgsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjGP0jfZZUGys5c7n5R8ExBHWwo0N9aT+qdxOs/yhb4=;
 b=BnjsQH9huwsJwKbRQCsamTXZRvwvI09/xWLMGgQgsKHqn07MRWGnkrPKaHFsrPEr9270O4vTg61typ16rDtpt4yUCSNv1pLQIF4Ckj/Ro8u/GhNImeXfeqf1skiCSgKPCOpX9JRkILx2Qgs+8kb28dODXgnfvc9ZKb2csNiCmqM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4622.eurprd04.prod.outlook.com (2603:10a6:803:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Wed, 16 Mar
 2022 12:26:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 12:26:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko.thiery@gmail.com" <heiko.thiery@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: RE: [PATCH v2] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
Thread-Topic: [PATCH v2] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
Thread-Index: AQHYOSJY50JmnziszU+ilfW0jLgn56zB77Vg
Date:   Wed, 16 Mar 2022 12:26:20 +0000
Message-ID: <DU0PR04MB94174894AA93F42CCD3BC89E88119@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220316104100.783068-1-michael@walle.cc>
In-Reply-To: <20220316104100.783068-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dab3118-db2a-48cc-2537-08da07482d2d
x-ms-traffictypediagnostic: VI1PR04MB4622:EE_
x-microsoft-antispam-prvs: <VI1PR04MB4622E674BD43D83C3C91339288119@VI1PR04MB4622.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcTNG0YWBHw4J5OQOfmc8SeGVnycOptuq+xrJMlDj0CbuKksDlA0Dwnu15RHuCDOutSBGPtiM/IjPzIvzfrQ40mRFi+s+U0osgVKWZ4YRRFtu+78gMSRuWl9QKdjvErBBRKPxb2YnY9mgl4/Wx5N+JhHk7lWJQErz0Ezj0Rv4pAHhMrq9j/E/sleH12eHhz41OgtulXE8g6BGQ6P9JyeqW/3HPYbbsgUSDtTdeAAoDdQqA6+AXHlz+Jp7C+U4K+gcXv0/xLAV3sCWepAF+HweOxjtxKIMlLoXQzguwoOVvCCuCPc2PcX4S1XvMtSTu/3lsZoMU889Itl+LRqW2cFjWTfUg40XpHoLA5CVbSOHMFzhiKeRTfiIH0eoj7DYr3arzGU+ngk5W9UFAfLMgTgEGLEHErvqrtv13Kp0ps8v6lQnABTLuvMAqMsT4Wmn7vy5M9uyNn1CmIapdq1qjMemjGikSioQGRnBxyVtf8w6lKCGor88R/v+IqdwsdVeE7l6z0MBJVr602eRPGilFMKdfC6GGIOBOet/kdJAILgTs78olzvBRoyHpuLD6xjOOp25bMrt374thW//5YulMbZQMGqGA6PfWvwjvT8+xQD2frbHgZots0dtN4WJbEBEFXoRZY04PgIzmhvU39Z1qaw7Q+LePLewRg3nJFAQt3f6p3b6iT8LXnjBJ8zCMkUhFDjZtyRvBU6ocMTyMeNbbgH3cbkWWZ5CRbQNBKqNtrx/iE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(5660300002)(38100700002)(122000001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(508600001)(8676002)(33656002)(55016003)(83380400001)(2906002)(316002)(54906003)(71200400001)(38070700005)(8936002)(186003)(110136005)(6506007)(44832011)(52536014)(86362001)(26005)(7696005)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L+0oLHsmGb3MNLA4XEFMiCgr01HGfw4KVMGnoiWc8wQzFYiqPpm2JSCbuQt4?=
 =?us-ascii?Q?uahQcFyyA/MsEH3jaT2f2mBSyrbO6uBUW6lTUoHbVCwwah9zSTREvb/0IvMW?=
 =?us-ascii?Q?zTAIQ6AJAU6bfu++lHnUbuS6nol3n/n9QPOMGEO53T9u+kmhXJzyTGFSzjFw?=
 =?us-ascii?Q?QcJDWGDXz/nFBBFcQW13CLhkMSzERNxqxg2m9D5OZF6sia8sFVPJBs7ILnoo?=
 =?us-ascii?Q?BnOxrbUet10AustKtus5NY5dqgne89jSW0WcgmFNGalfltwgUFJEOFVpCCzn?=
 =?us-ascii?Q?VdeYkvtJ/9LRef3FveFV/SykpKKVL4jIkwUL9PevmyOZZ4A/2Ql0ODevWs94?=
 =?us-ascii?Q?DwTmoY8KthuTFT7oh8EWiAFJyZs7kX9jG3jwDkFqJ+yup5/V0b/k3DX+js16?=
 =?us-ascii?Q?RUVdl6pg8xIdW1z7HSrPx5lMOyFtV3t3w4TVnsrPg2izQ0Lb1AYTN3LrlXAH?=
 =?us-ascii?Q?kh+wSV234Y64BJRDEXPGEkis1pqUNXvBgCYIDplcOL14NSZaHT5gIX/v0l2a?=
 =?us-ascii?Q?18lXELA7d5GFj9A5njUtLBJicCiw5qKRqD8Jl7+w8SISYOUOZLWbONKY8HGw?=
 =?us-ascii?Q?aFVejyDtLgyKwe6efD1kOPDpU2paEGbUf4gH4MBnIgjJRFjzrXrKOjW8BJSM?=
 =?us-ascii?Q?WfK4EuakUpU8pKqijDuiVEJN3HMKqV2jeOvvxUbi4Nyc6H5LbSb1IpIKJD6s?=
 =?us-ascii?Q?wkKGQ9IxQHqTIRhtxgzLWTdA+GMtY/dVo+J2SXi7b1lG01lYjVE9Q+5XFIgV?=
 =?us-ascii?Q?tgdU3zxW7EmNOA2UzQrwmRMlzJtqS8rN1CXa4rUQnAmSyFnDnIMvvRlHG8+I?=
 =?us-ascii?Q?QM2/DH2MJwrV3aVhynEyS3poT8iJPcULNNRJ9bR1J+5U7j+rL2w9lDcKhZZX?=
 =?us-ascii?Q?rkOWoVqr7IywPC79boIfCy/xOeJ2/iI+bUFNuZH4IwIQ0nR45fBoIqRmp9g1?=
 =?us-ascii?Q?CmN86BYgKtRNWhcuCvKCCoN1x2C4ckv6U6hvZq+GaAGFh1yW9Num7H8IXTHv?=
 =?us-ascii?Q?qQQLgst9LazlHuljSWos4N+NuHrArSOrEeHs332bWmcam4b8nW7X1MI57ZcK?=
 =?us-ascii?Q?fKBaiM15Ti3bRNGqvHZ1xDsx8vpBMLvFSsHWrDeaBDJH4CQZnzyvpltZ677C?=
 =?us-ascii?Q?9GTLapKhy9/xVdt9USGfKQl5GSAKzz8Kg9eZyDIuluJvis9IzahMK+oR0esy?=
 =?us-ascii?Q?5KEitMVwLPxeFzV88RfIup0C2T/UMmWXLH+CWr0NgHDjDAEujM+ABY81Ckxi?=
 =?us-ascii?Q?7HP9x0K6nBSDcDwxeRx7k+b+vzjBuHLgmNMtPLJyAJNqTC8vYWjgdaRZiWe9?=
 =?us-ascii?Q?nSkmsCAT8AnpqdIPfc+RaETldK6cUBY+qB1bEzK6ONDPIjKVp0h63uZQ6gY+?=
 =?us-ascii?Q?hOju+7pauf1OVGPxhaFyFoG8o6UxxmK7kLgx8tmYoNrkVFPiaokX8tBjwLy+?=
 =?us-ascii?Q?EBATf2JX4fo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dab3118-db2a-48cc-2537-08da07482d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 12:26:20.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37H9lYNI5AW4Umu/o187VOReIyfCWNkHR7muQiiEZDvByzcce9cmi3Cl6cZw9yyXFZHnX2bHH5KuqM40opvdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
>=20
> This eval board features an IMX8MN UltraLite and has DDR3L RAM. The
> product part number is 8MNANOD3L-EVK.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Peng Fan <peng.fan@nxp.com>

> ---
> changes since v1:
>  - order entries alphabetically
>=20
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 08bdd30e511c..37da3a267c94 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -834,6 +834,7 @@ properties:
>                - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon
> Development Kit
>                - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH
> SystemMaster S2
>                - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH
> SystemMaster S2 PRO
> +              - fsl,imx8mn-ddr3l-evk      # i.MX8MN DDR3L EVK
> Board
>                - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK
> Board
>                - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK
> Board
>                - gw,imx8mn-gw7902          # i.MX8MM Gateworks
> Board
> --
> 2.30.2

