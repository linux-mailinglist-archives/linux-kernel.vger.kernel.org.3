Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB25619FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiF3MNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiF3MNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:13:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D661A384;
        Thu, 30 Jun 2022 05:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtwSMkw61kxR8RmE8iy8TzxDi/VrMJfBPasRCBCmgRYgkXk3A6m36fzra6a93W3jyqwqFkJ8IAevy/FpVqBTj8ERxj7DWPkB3iHMSlIpKzFYXV7XQjKjCubR0y0Pji5RSG2Mx7kM456UM2HeV08uFPyRxzJNzreCjbcpaCBMKU3h+V8RAxMT3HxBdHWF3gdDkMG9nN1TixOsnQWC6Y3xaaw/yTXTtcrPe6WECivABNSHJyPk/p90+xbX+C+f5YBvtp1Ehg2AOkBIygbVhBpBRidaNM7GClPvyEour27Ext5gWtun9jWO7n7wWonx4QPtvmj/rMjCoKawNBFYnHa8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkUKsoJ35Gxeq7+3O7JfXfM5+RCx78j7gGoDrSznK2U=;
 b=jxoWSTiviifJVFiafciq1fp2hKO2zDlTaJ4D3OINE9k5QPEC4kkWRtBZuJxCVUE/ce6c9QyZRDfYlZ4PK6VyF5ZiDL7gxBiizgF2P5p7gr8Yf9KfSWABkG5XfOmYL+JxQoD7VIxpQEpBUsylsdChajNjMuHu0qw3/zuTvq/7DKpIKnDVtpyOVpe+AnVSxo3V8jS6B/KQgm3T8VjxWGPpJ0vCpFqT+h7D+iJ85MVCfA1DvduEEnwHddYObfS1ntZkku1rHvXsoOfRWCkqU0TYJiuSE2pjFnA4t8OsvB5IGB7ePIjyyOq9BmAYgknQDKfV4JAUQ8OrLaihqPZ67MRzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkUKsoJ35Gxeq7+3O7JfXfM5+RCx78j7gGoDrSznK2U=;
 b=MU9bOMKQCn1wX5MwPBB5p0JWCTIKEzvs2kwzwlDbQCMSUEN34CPRHPnSH02Qp9TnR4LBCYVrwR+xEvb1MYeZAoIE1ACoSCyXpCJmzUc3ilnMNDgKSR8L4wQkXC9fzoDjByKnaPDdTP4IfVnzdCwObg8tFHuGfQ0j9ujMnMjsuEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5792.eurprd04.prod.outlook.com (2603:10a6:803:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 12:13:37 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 12:13:37 +0000
Date:   Thu, 30 Jun 2022 15:13:22 +0300
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/14] dt-bindings: arm: freescale: Switch fsl,scu
 from txt to yaml
Message-ID: <20220630121042.7kwomc4jc4zppoyw@fsr-ub1664-116>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
X-ClientProxiedBy: AM0PR02CA0119.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::16) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5915739-f8e4-4ed3-6228-08da5a91f60e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5792:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4c0VcD0cFuqzR8M6Itmg/QktZbF+iQ+9AhcFsct6qPEsrhDjBIVDMq2vlVEpua6ana8j2Nd/lL+a8Sf/gD3VVC2Df2bmWMvTY7SDc2vPQQRI9/LM+ZE68AluCWcj/ZK80ctTJPePflcgIJ+IsCsVj+F9rNhh0XJDiNxePSQy/RToDG6/Q+Zcfj64Z13cKd1SqUkhlv8Cf/+mYtG/q8kd+qjxNir6xVxykkjHW7OGPEUefoKr3HSQ7ZPlMgXjQNDWsvJvkcnMzFLymedA2NoKsBAmItYcmg9H3fRP8m3HJq/DxY/j+SRh6TCkT4d/CmgQDmHccyip/lWNcF0xfaBQgcCSzXqFASi2BbjIicaXgwSaNyJo29BRjJa7pj0Fmcd4jOYT/r/57kzTL/uNgAH0Z5vTDFI4ntHYQWC+tXL7dXvEoL9uzU+Kp4qZ6Y+lSzyIJsQXPHijO7VOCd+kz7GlgZS1/E0UAAPFeULgSzIylYhaFQTPNPcljsbwWm6KZCRk1kQSpGUyS9vUJtO3Lstdwz60LHXWGc5owB2Ke+EUJA5yYSSowXqmACE0HUV7vD1cHGFhTRQ1mjMI+CDPmiQDKlqSIlS6rZaWHZSiYllm8QT5onuqa+dW9f1qpV47hfQjnsy+ZcSO05w507Tn+FOv1irzTT5yaOD1ol0Tl3708ABzn5gb3sboo6cXrzVsFTrEAHlomRm0ouFojJvLR1159VRF3XJLsFp4ajszijH+no7ORORXL1KkIjrtePS3HBv+nEx98e5vHC9rk121hyOUNzQMhcA++qS9Y6tNYbhY3JyhUrNrAyNzYcM8Dn8Gf9W7dUmP7opTz/k7V+rUKrlVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(33716001)(86362001)(83380400001)(38350700002)(478600001)(38100700002)(7406005)(966005)(6486002)(26005)(6512007)(186003)(6506007)(9686003)(1076003)(52116002)(53546011)(5660300002)(4744005)(2906002)(8936002)(6916009)(316002)(4326008)(8676002)(54906003)(66556008)(66946007)(66476007)(6666004)(41300700001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6J0DTm8pzmCCakVSpGAWGlvTBOudK88a7pphnU7R/IigdktfbUU0HFUx2Gz8?=
 =?us-ascii?Q?jg5LLvSFadwd38cre2i9xpEu8BaKmJMVkQAyqNZx/WRwpMfWE9NUbrSNsS6g?=
 =?us-ascii?Q?kN2S4s3doOgg/vYgblgekmaw3JdmJoguAuREXpYKk01dt4UbIwPQNGvola/T?=
 =?us-ascii?Q?rJahCmKT18jffOpkVaQfJYf4sYA5ceRznLbcbenfuar2hcAYFaX2X2y9pu5q?=
 =?us-ascii?Q?Zw20sZxbl35+ek5L24LP3yp+LV480oOmexQD3NeGYzFrSLrbLa9SxgvD3Es4?=
 =?us-ascii?Q?jO1nXBqSUZNKEm6cxWEydr2wnw2VIArWaynAquzE2L2Ai0p3ht3d8wCU1kbN?=
 =?us-ascii?Q?m8OS5YoqrLTML+0pI73d9R+YwXcqm3l0WhyFou2n84r/OgRs15eQmqUQF1+e?=
 =?us-ascii?Q?UWcp07FwRRi8lDQVWhZJydmDsml4DLSTcWJTbvS/6GV4ZEzxrEq1ufHhjQRu?=
 =?us-ascii?Q?orm3yIvKb9B/mav7xv30E+2SMvCLiDZiIJfZ7uSdeQAWyfpIF9jYAo1R2mk6?=
 =?us-ascii?Q?FffXtZHzmVyxPStNjOQjAdycFQDMYP1GMbo8bsbUdwjgsCHlGHaRP0CXq32t?=
 =?us-ascii?Q?0GDnDeOz4vWtxc3fD/t8CyR6e2L9zCPEH+A54/W6YPnlyyXdy508wOJAcMGf?=
 =?us-ascii?Q?hl7rTuhupozawZMwSm+jN3mRtpETIIXNv/JpRke+8YMzcy2RjAqd8z5PnaQQ?=
 =?us-ascii?Q?ePKhw0dh1QSJGN6m/zTJ7yW2XJTyexMHYEPuS3PTw0z6wWbCjeavjXcSiJ3A?=
 =?us-ascii?Q?KHad8HJMTSeqkpf0+qIT9yC/QOLuGWdrL2apsMXosLWSlTAzZeMk1p8NTXzk?=
 =?us-ascii?Q?yCZUm2KlI5Z2Ukeg+ipj/GMUYH8Xu/TLwMqxqJjDsVSXvM/t9Ky4H8puH4Yr?=
 =?us-ascii?Q?a+Ww0aeVr8n1a8gEtzy7oiNsY8bY5sf+rqF0zKwumebVP+bYruPvkrg0ZJKs?=
 =?us-ascii?Q?4a/GjEeVQ0bEmdXXSMINmQPcXIUCsf8IznQ1Uk/p0f6mzAnXAhMsapc2FgLL?=
 =?us-ascii?Q?KqlLtfxK63pmCcKUMRMcRPdqhqqnqznfHy/5nsNrnCd8hzaCzKuehEq4JrDf?=
 =?us-ascii?Q?Fi21JWi5xkjmP12ewkYak8ughMtgILaLnKE8VBbKwrhBsYKr78yYMEy6kEv/?=
 =?us-ascii?Q?XJfrNBSPYtVtwEpSxL5I6sEDI7RV2oEdLK1VUmyltbCzDR9N/Px2GUHTvSli?=
 =?us-ascii?Q?e0QDPyyK+fLV210noXC8KsJNRCBZZzJu9hZO8J3yN2iKutXZESBDIyBKwT3c?=
 =?us-ascii?Q?XSTDSbZIHk3dS9YiCn2VQ6CiplBsTrWhCGc3/xAQVsZalW9Bu1bMcmga+3r1?=
 =?us-ascii?Q?nfhsRJ52X+7stjeF9agiNAQfFxoDtAbP9oTKfMyOHF2V3vtAEtkeHyuchZyH?=
 =?us-ascii?Q?rjbREjAqeflSB02Xbw7ALUIpWwFIhW8tQgJs2hRgCR2dJif6Arhwrb0x9uXw?=
 =?us-ascii?Q?C96W+Sklm7gSEoGbP/E7F0SwTNerkyMOvhduvqyZ8tRm4/JfUfKRvH9M6ns1?=
 =?us-ascii?Q?zssgYXJMTrFgJ2uCCC39p2ejqdSfKm+L7vAsnbCcYd4Cyt9T46+8BVz85MmR?=
 =?us-ascii?Q?8RVPQVAxYFSsdDI5eC0zPKkzqF/u+SZC2/8to+Uc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5915739-f8e4-4ed3-6228-08da5a91f60e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 12:13:37.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdRxfp1hspITcW4suhPJcmq3Un7RNDtHkYGkxXXpOhEXS6Ymtocn34TZcCIMIebSIX62Y3KfGnKz0aoaB0aqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5792
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-29 19:51:06, Krzysztof Kozlowski wrote:
> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> > 
> > Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
> >   * Updated according to Krzysztof Kozlowski comments
> > 
> 
> My comment a about removal of each part of TXT bindings in each patch,
> was not addressed. Your approach makes it more difficult to read patches
> and makes sense only if each subsystem maintainer will take the patches
> (separately). If the patches are going through one tree, then better to
> remove the TXT gradually.
> 
> So the question - who is going to take each of the patches?

Hi Krzysztof,

I just understood the context of your comment, will do it in the next version.

Assuming TXT is removed from aggregating TXT - fsl,scu.txt - gradually, do you expect the
removed to be added into the aggregating YAML - fsl,scu.yaml - also gradually within the
same patch ?

Thank you,
Viorel
