Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6158FC96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiHKMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiHKMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:42:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09161D46;
        Thu, 11 Aug 2022 05:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1txRSi45kWVvz80uAqOAKVZ5Gq4zJ7Bs1eU9e36kv/3blD2fvq5EF/GWKLhKhj1I+YfSmMmDZqcvCQSsMDo+4zXBJzkrV7S9bsPdJSJCSeq/ugSuTnPpg6YkPyJZ3syr7X2EIKPnHHTIgq7+07oVmsuAPGlYL2jQgZC2TOuaoXCS/tGiKJ4lvMIyc46mwLPNcKMdSnxZ01+KfB88gePOJBNvBdU7oKyaMzv8TmmQ08ppArz6EFDRTFpPZDCXp0FfjRrub7wOZ2I04a00R7mc/l04OtWv8DNyMT/RfuiBs/Ica2YCcVWskMfHG8PCALXy4/3+IeDcoKDIhDjHcelQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BFQ3vp1z03uHsrBhwhXM13bhA4+Fl0wA4Ro6FrX6Ks=;
 b=VNSRmV+1+QJtgL0sGtmUXj2/Ohs2LLSO1K0pCxCL72CQugtUqBE98aN52b87MCWeAffkFDi+nCppExT+Ahoj3m+I31KiAU3FmkyYvqHDrPKYHO0pVHuUaf2zSrr4AxXRSyPX2PdtkCuF7Ehf5v1373tpjcCcq9BOstUG6C+GLh2sRC5qhdmI4M88rLpTqERT+gi2t6/walZgRUZs10Dmq563rJOhMD8tUPmHRZYnTbppd1k3jkSHSAKsbM+WFU/73Y8AKtFanpQdZ4McYCvyGm0825o/oKuvNc6WjQHVxIp/x4JBXwl/DTt/4D8gc1GKNsnErSnPhJct63rUb7m9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BFQ3vp1z03uHsrBhwhXM13bhA4+Fl0wA4Ro6FrX6Ks=;
 b=SQpCOaZvzUQgoXk+5ifJxN1urLSW0iostbAruSGfD0xoBIU4xtMaQCCdzgUrbf+JVzqdowBxA4cA5db5c1wD7tjSfT/d+EMK0bXUYSRPJeIpLS3DttNFNw2aqBERMIiQWoIhhBe1evZZRlSy8h5itYBvhh/uCrMoonjMhELVn2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR0402MB2832.eurprd04.prod.outlook.com (2603:10a6:800:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 11 Aug
 2022 12:42:45 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 12:42:45 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v4 0/3] Add IMX8 SCU GPIO support
Date:   Thu, 11 Aug 2022 07:41:32 -0500
Message-Id: <20220811124135.95299-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d87dd3e-b1f4-4ec7-0165-08da7b96fd32
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8R8fAx5vsJSw0/NXDOGrcEXWsoqf6S+ofm5doaQzGqzzDW3pvOtK4bFSg28jaBorlHOaXbagEMqpwq7Xh384bLd1khzySTFRtIE4S9YmkBLL7+eXWMZgcm5bpEKQFZ2jv8dHZDyBU/mLta2qLeZtMIEFtTrz2RLGpB7G4/6Q9MQffjxe8MSP6QXx8MBkCAVNmv/iLF2/WmfKuo87Z0Xv7tEbArrQmoZvVcam5hI2c4BU24WsZ/KwQ8gWVPEGX3XoBvTOzx+ydnnMQggwQsmdb4GMRNOcMLChGeyhn2MB3gWh3E1h887/EZ0zD0CprcAaVw214wgE8gksvYIbLI/hW7Pu2Hy4QaIPLSg74G9Ah4n21qflNOGwoC77zNeCZ/Nuwi8ZHBwW7OHdbluZypLd1JO+VyXCwjtaIADgJRYKumbBgdxQOjmuHIsM4w0AYrltHs/xwbRczq2Ja+IAogJq0vnhIdFQbtOvERnxwX+ZVUUFfJS8uTAju4oh1EA+Dv3ynkOjo+9wN5RnPqRMfCNAJqHVgp2Y8L66Oo0MDvg9SSflDVr4JuMUlmOZFrRtMPBelaVHzST1C+BC3f7FU63k1c5oSl13mS/fsbGAf+6tghTbKYd32hZIp9LHpW0aynbX/67j3gNbh28p4GdGEzozR/XUT2oPc21I9N2Qg4diBH/6xz0UldHyOOsQUmzFUyWmI9lBrwj4sdGQp/tsYpJA/kPR/G4Lq7DYYRGVIh6gs9JRbsDfH3Qq9vTZjSJNFmomJyB9SUxvF7ejKXWCdCuWyy2r7SzBE3Rq4C0Uenk8o0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(6666004)(186003)(6636002)(41300700001)(478600001)(1076003)(83380400001)(2906002)(36756003)(316002)(26005)(7416002)(38350700002)(8936002)(6512007)(52116002)(6506007)(44832011)(2616005)(5660300002)(55236004)(86362001)(66476007)(8676002)(66556008)(66946007)(4326008)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SpiyRspKY/OTbxn8+m/yXcrg/dNIzKOUEpYN2nZqUKumda9ff/YZ4TPEQ0Sw?=
 =?us-ascii?Q?oX0sMP4vDH/1VkuZxD3JauMyjSVslEI48VCmfubkxpuFwd4gvoDmITdFWQO5?=
 =?us-ascii?Q?sj8ks/zajdTyvHyhAF67Z3NBkmEZID8Ab+9Syv4gXo0O8FqxDNpWtsTadsJo?=
 =?us-ascii?Q?HA8CYeFXCU5Fal56YTiYoBFEL8jC4R0SWpkMRtQqxt6i38wCdx5HYU0ckBEO?=
 =?us-ascii?Q?TmcgvB09fl7ot7Wjy4dDObdTGS3e+HZyAwxspsxKtkqgUyf6E1JaST6kg6A6?=
 =?us-ascii?Q?BBxVmfZsvd7T4kMSf5XwgtGCluIFDwjBsYYiKfN6Vgn2BfOiKXKOJSxFhxed?=
 =?us-ascii?Q?Ku/aPJv7MiV3lEXa3j0J07Vowk2sK+N0U4Ki473/HaD9qn1yv5z27pVShD+z?=
 =?us-ascii?Q?XLZUirNeqgWtIngXgHfE8SZyvmQ4IQiZGVxnBfIIJ2c7kNMSA+tlxKvZtRzF?=
 =?us-ascii?Q?LPR2n8ws5+hyH7COQ6GnbNLRvc4ETrNckgaxq1AABBoinPg3Ad6aENv7Jz28?=
 =?us-ascii?Q?xvOV1NKnG1H/TGw2dVHlzpFqMDIsbOuvaFyNXE6jmzae/TtTpbQMcsXuW0ZN?=
 =?us-ascii?Q?lO8gPCxJcufb4cQb7VOmXfzNl/R/j9vFqtp/Nwb3FM1xcmuYxSSdRPS976Wx?=
 =?us-ascii?Q?hbkMOr6sLkqDwpHh/g/cSAyGdILzj1C5xoalL1mfTkYi3SDTGi9oUmR3yAXe?=
 =?us-ascii?Q?pg3FY/kJLvdVbcEdafzYBMTbJogp9djoDF0/bCFG1Q6kzSsPKhVNlTc3i1HK?=
 =?us-ascii?Q?cP1BNNQcS1LO615QOVkb73rfz0IokUUFYk0FuHcSZ90odDWHcNCM6VQPtYa/?=
 =?us-ascii?Q?8FC6ElWbPbKVT5iJKNX68ek1LYHAigXhT/Zusmc1V28Z1BzVcKMQGl9B96I1?=
 =?us-ascii?Q?AzyftYLdN53jxGana4X3fZ2wkUu7bZe3dyyc+WZqxWE6W5CIzWeyMdrPUWla?=
 =?us-ascii?Q?Q1lTNIad4j6cvmYqHw6MdWUoWiXHBwOeivbIegoqe3yGxI3X+2g+uTlGJeU2?=
 =?us-ascii?Q?+inMbL8etAI14+c618oQxU6AME+U2qNxsii+ZhtPhPr5ZW/qXCZlXQupFxFD?=
 =?us-ascii?Q?hWSLtNUczjO/no0zm557oOZPM+zULlTdnlOpZkxN7a4Bx3SECh6aR2xgpFpi?=
 =?us-ascii?Q?olqhF1/IPcgfHO9focjCg9gRGws9vZb5njXvw2UCWg98Ki0VTcN+jEeO/tgA?=
 =?us-ascii?Q?le8WK+6r+uQVIdEeF56+WcC0LH32rbVj7Pb16dcDZX/qKuI5rueLogKgDuHr?=
 =?us-ascii?Q?9Z7BNP112UsG5HRkn3EZBz5rWBp4TZYzY7J0M8eqwZdjsdOWAqbrWDkQ6ZgA?=
 =?us-ascii?Q?nnjT8KcfvOJbsQjvrA8vnSLvBn2eH+ZbqoKe184epF0BO0/GAHzhxiVxb0nQ?=
 =?us-ascii?Q?o6B0CFqslRnJaJw8krPt4iEhSO2lZHMoLmm/9nqN6fFyv1GC6CQ+5Xh6qf8g?=
 =?us-ascii?Q?X9zJY2pkKtqYMUgV6e3fBt5RR5aLA9urV4cUMVNrdThAhlbpliSj/E+eTpYI?=
 =?us-ascii?Q?lzpLIBKaoGctm71MRjvS6mTnYBCa2dMd7sfysJem2VVDvNkFih0+IgLxj/jl?=
 =?us-ascii?Q?39rKnig5CNeO2JQDyyvAq3JQasryG1HfY+j0Z2Qd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d87dd3e-b1f4-4ec7-0165-08da7b96fd32
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:42:45.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue3geQgTfSCX6vupQYVqU7sFxnrZDlgXJzzKPI8w+52BVk1H/raTjfH7N65PfF8Zcz5DC9Aa0mgpj6yRnm06IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system controller (SCU) is the central unit to manage the resources
on i.MX8 platforms. The SCU firmware provides a set of APIs to access
the GPIO PINs on the SCU domain.

This patch series implements the standard GPIO driver over the SCU
firmware APIs, so that the GPIOs on the SCU domain could be accessed
like a local GPIO PINs.

Changes in V4:
 - remove the generic compatible of "fsl,imx-sc-gpio"
 - update the gpio $ref in "fsl,scu.yaml" as the file name is changed
 - update the commit comment for 0003 because the driver is moved to the
   directory of "drivers/gpio"

Changes in V3:
 - follow the other imx8 SCU binding rule and rename the compatible string
   from fsl,imx8-scu-gpio to fsl,imx8qxp-sc-gpio
 - rename the doc file from fsl,imx8-scu-gpio.yaml to fsl,imx-sc-gpio.yaml

Changes in V2:
 - move the driver into the gpio directory per Krzysztof's feedback
 - change the subnode description in file fsl,scu.yaml
 - fix the dt_binding_check error

Shenwei Wang (3):
  dt-bindings: gpio: Add imx scu gpio driver bindings
  dt-bindings: firmware: imx: Add imx-scu gpio node
  gpio: imx-scu: add imx-scu GPIO driver

 .../devicetree/bindings/firmware/fsl,scu.yaml |   5 +
 .../bindings/gpio/fsl,imx-sc-gpio.yaml        |  39 +++++
 drivers/gpio/Kconfig                          |   4 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-imx-scu.c                   | 139 ++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
 create mode 100644 drivers/gpio/gpio-imx-scu.c

--
2.25.1

