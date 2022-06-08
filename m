Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99201543997
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiFHQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiFHQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:46 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD2948304;
        Wed,  8 Jun 2022 09:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps2jHjuX3mvj7qi68MlJFoI1RXUFffDIehCk7WxCjet/fugm9MUXFLDsbJMGt4tOX3Ioxu6A/PjY87IQgteZg9+pzNy6Wi2n9WQQX7kwddSujR0EkAlVHPVfCjVfo98II9gijG72IB/jm9F4+xgoCuwMl5+qagHAFyfYfWv+LVN6DAbcLKm/3o09bJMaEHFAoqbukfxzku+Fws/u18yK3UmKPUYWeap6rFpUKRIbzpAub2ZPeGYES1YUVBOVJlHlZHXBjf6T5LPOWpoJRTGsI177JY/Mz0ABNFClcDZejwvXa74cF4UwSqQg/F14CGhx+7Mw6hCXg1GTgXUiVaLu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhZW2AFTHY4rqbf6J+eVWiaRQZNFplaVou38q0MTxBw=;
 b=AfBbzSwVhM8jey5ZudsoINJjo9XKRF4w+17gf6hVT5ZkJXPHE07mbsMNs4l/TzWfWlArN/QSCKDCOeOglvvMpv4VT9tEZGOW7+6IUBOCByoA7h086iG73Q2QAdUGgQ6aWQgnDUW9waOUFNhKoHiVva7VSGTKdIMUhLXWoJ9EhKkfNbfA3sbVEtfjsJWvKlBGlM/0YMIHQJj2W5kpX12Woxo3qu3Vh4/1eUYYUn/nZh/P9c//AZlFmIddM6BWzgVm0I1EAGXQErjxcpTi72WP5f1IZ5iN3ZioI5GUIOWkpSFltgYVCXKutXMJlTku6GWEflJYpUdLG6Sb7hgvoAAYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhZW2AFTHY4rqbf6J+eVWiaRQZNFplaVou38q0MTxBw=;
 b=VGpHm/3jzNZM0syINDSZJfTttvjE7f2rcGhwHGy0r7dyG6jUpuK7QzsPQHm+8PM/U5an9iBLu+DCJGlH54iLdGAqgOavV300aGA7JdrcCLZYXQXBXIPwgErVVEH2iKqQNDc/+4C0bhudr9lzmVOrAji5DZNFO0CrEpmdVuQ5drU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:42 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:42 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 00/10] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Wed,  8 Jun 2022 19:49:18 +0300
Message-Id: <20220608164928.2706697-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 043b9ed9-ab9e-4f72-d039-08da496ee244
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB74315CB44F4363D5437ABA0CF6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbOuF2TMnk3FIafup6yLYvWHwFlWBv7Ul+SllGVaN3oMoJT+NqCoOZ3SN9fg5EuwvIUflaaVGSC9br4AcopDU7Cp59OJXkWyPQMFQfPmIuNl6yuA5YMz0kB6ISIEnmLGb3XuYKEJP15NGlczFTqB9ZnF87Z0GDQzX7sS656B4ozePw2e43F9V3eWs/pHDF4yYsN8FkJaMNJVL5sA9Hr0gSpg2Egfbc1iVh5BB3rJl7SypdzuLLSae7gmQ7MEPpHt+qJU/Va+8eT4K/Eiq42Iuuxo19jIumGV75ik3NcI/CZ3I/OzPjogWmqaSZperyaBvEy0EhRTT3Vh1iWmNXbOyyd72I+6ZZmX8EYlqQcjdsteFYIKD31bckpZPbd47Hr3N08gKzoELUThuKNbTLKd3z7hZbz9nQKf5Kd0jqpfEBaXItg6SQPe6QzJaSXy2P+0d1fZDnGt3I9BdnGcURu5CLPCT1RXbuy1ehnIAzwBzkGlGlmY1okl0rD2p+mkRn/Et0Nf4st0oU2W/lIs/X2iDszff04tMuhADhJorAdbUOT9o6NtjN+7KvshjsXgcdhSeENm6vAY42mpGNc0tdMvWvrjmmjDJpLMYmPZ/1cNTM3+1QYLIBAr1B5H+O0IpL3Sj1L7wkCYRYBGQZQj9rHGL15VA5XGhy7RBVc0QmlYsAkCKh9x/GvAWFBxUwM4PAXbuT3bVu6xxrR7VVS6yWDmTpLYPq6XGFB4ow5Qp/Um5/tsq5eZx+hbmrG6IZY/ARgpDoEmmNS6MSXckhYzR94s8iVeHX4uBJp5YhcoK2d++PcVKrCmjWTreBw54ypCC84U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(498600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOrbDQM6hH33hWmhc/jRUebIHBlD3ausNjN19dUmmxgT/ogSO4w15PREbMJr?=
 =?us-ascii?Q?//eujSFNTdK+Dukx7cxfNVnPDnQ9Oy015TEqDKBNGIUOmKXb/fbswf7lB3M8?=
 =?us-ascii?Q?ca8rHRIwPNJNuqx+lGQ/Z/cznCpNFxoxbTUwkKfZgmIpuqUbjFD5WbR7q5fs?=
 =?us-ascii?Q?X3eMV6myYHBGbyp2PJ3w4+7vuFFVbN7ns1c394C6hOYLgsaJZr+ott1tiiTb?=
 =?us-ascii?Q?olZ7U7XIZiLBCJM20Pt7tSk09bWQcKCVETPVslXuliS3HXQcNm/smT0QHkZF?=
 =?us-ascii?Q?AsM6JyS3QzXWtBveBYJ3NXMNX45sBt7SW0y9xdv1i3ynu47WCOdcKFMcWo27?=
 =?us-ascii?Q?ILqNfLYG6/NfP1W0dHta1fzJSSN8sjXZH3V27vKvWlCtCyUfydFOcpKfvhnQ?=
 =?us-ascii?Q?cUY+qcm3nABES+xfHCFkPbBpuKcsxibnpgUjnWifpb8DY59i+ysk9kA8AUgS?=
 =?us-ascii?Q?vYJUK+7zH1oIZNWhRDs6WSZGIoG+jYdCk8xVtcK2P1kwjqL1grmoQs15ifuO?=
 =?us-ascii?Q?CmPd6Ej/ewO3TQMFOZBYfjTMVYd9vYi4ebKejmSkaMH2eU8X4D76kzpjfuKD?=
 =?us-ascii?Q?GXSPJfZ+94eR2y/PoMJ4ySPzYHIJ/K16CcGgOT1QJHvx5VJda427cRVrL2Lb?=
 =?us-ascii?Q?DMAYMQDmr+2KsgYISqHf/jwYxx/c965vaXlJaUg1K5LFDwO3x1wDIjBcuwea?=
 =?us-ascii?Q?ywMgZUbcxr6iZrsBZp7xuc/2GiY/RtCmJwDypuFaTvVVe4eGcXamboZd6kie?=
 =?us-ascii?Q?PjHv9bXIaESM2waT58vAY9V4wxNalFjK/Hl2thq7EQQ00RlHj80krw6TuAeB?=
 =?us-ascii?Q?rOi3oWMrcG/o97QGAYZ+vSB91LMypG3job2FxhlyNgaf1vPQ2ExyS1CxOmoK?=
 =?us-ascii?Q?07KuxLCpWSC8h+bWT4o4pjVofJvlJfZgFIPyyVUq5LWKVrUTLpNKShRdW1ST?=
 =?us-ascii?Q?ow2x8t3jPgvzov2VbisdzbuFNebU+aLqSatsFfy19T6i5UY+V3ehg6xK/GbW?=
 =?us-ascii?Q?16mOoZITpryJVTYX2d5R3kqWVcX0pNq0lfNU4bNh2AfPbXktI7L62JofTSk6?=
 =?us-ascii?Q?8NsrVWqN3JvSxLbZh26BhzfyarOzPqyMGQ7B9/+NfMwsbti5ZjoyYfv6wEwZ?=
 =?us-ascii?Q?5gTlUvRJay5s877ZKSxhvG/g0jEvfx8qCKZqg1mojRnA8bVJ6hNldliMlnR7?=
 =?us-ascii?Q?98lJGF+1vVzCCBh8l+d+q94Hv+mMYP4X3Hqke3Dm2eyKcxSzlwf/PQSYrH9r?=
 =?us-ascii?Q?1dOYwBc0DedKY2jbcOJEMUyr+k94Po1InjHjlQMjRCori6QMh/ZUjcTB+oW9?=
 =?us-ascii?Q?ooodT7zQZzsxg+Gb1nTlOA/pLFMoBqONdo980xzlgeH/2Ew1mFEFKD/WeeD4?=
 =?us-ascii?Q?WY9EDzNqeQC79FxPq5oxUx3BDT2PFQnqFvWdGFnneSCP0UlhBysVIKJ1tA7q?=
 =?us-ascii?Q?lQM+vzVwVPfvYJvZhjo3rsmb1kl+/RO+zCj5mBSoEGUGEG8KWJvtRcpk4akw?=
 =?us-ascii?Q?/5eWcxWkXiJin4CiSrUbiJeN6isZxTYj6seerm3DWhv1vRAN1qAX6thnbMRr?=
 =?us-ascii?Q?pY0NZ5wjbqqTk6P49kC1DDtBnMgsWXkAD7Q93A7jrLR9PG86tWY4454yb4ah?=
 =?us-ascii?Q?YVpOvAX4FLwICjByy4PkdDet9LwyWb4YwidhOXzodgJhqdwvhzCbFmpasgYe?=
 =?us-ascii?Q?8LqMKQMTw7fHzppPqIQ7+zAyowa7hUKoaEAh+dsPW++eYaoFGRiA0/2yTMfu?=
 =?us-ascii?Q?g/fqXzYVJA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043b9ed9-ab9e-4f72-d039-08da496ee244
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:42.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxYEdcxxhcxO6ma6fT+3GJgbvyWvKTZHF+BlXslmDsgCzbEcVBqGxyY+zSIGGI16uH9FDhdFF0hsFFtAOkpkrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is splitting the fsl,scu.txt file from
bindings/arm/freescale into different yaml files throughout multiple
bindings directories. Last patch actually removes the file entirely.

Here is the v1:
https://lore.kernel.org/lkml/20220607105951.1821519-1-abel.vesa@nxp.com/

Changes since v1:
 * added the yaml files to their proper subsystems
 * cleaned up according with Krzysztof's and Rob's comments
 * changed commit messages to reflect that the fsl,scu.txt needs to go away

Abel Vesa (10):
  dt-bindings: firmware: Add fsl,scu yaml file
  dt-bindings: clk: imx: Add fsl,scu-clk yaml file
  dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
  dt-bindings: input: Add fsl,scu-key yaml file
  dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
  dt-bindings: power: Add fsl,scu-pd yaml file
  dt-bindings: rtc: Add fsl,scu-rtc yaml file
  dt-bindings: thermal: Add fsl,scu-thermal yaml file
  dt-bindings: watchdog: Add fsl,scu-wdt yaml file
  dt-bindings: arm: freescale: Remove fsl,scu txt file

 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 .../bindings/clock/fsl,scu-clk.yaml           |  52 ++++
 .../devicetree/bindings/firmware/fsl,scu.yaml | 162 +++++++++++
 .../bindings/input/fsl,scu-key.yaml           |  30 ++
 .../bindings/nvmem/fsl,scu-ocotp.yaml         |  37 +++
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  32 +++
 .../devicetree/bindings/power/fsl,scu-pd.yaml |  34 +++
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  22 ++
 .../bindings/thermal/fsl,scu-thermal.yaml     |  32 +++
 .../bindings/watchdog/fsl,scu-wdt.yaml        |  29 ++
 10 files changed, 430 insertions(+), 271 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

--
2.34.3

