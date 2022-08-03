Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02DD58855E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiHCBWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiHCBWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:22:50 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10081.outbound.protection.outlook.com [40.107.1.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC8558FB;
        Tue,  2 Aug 2022 18:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfdglURrNGx93+/UdndSryk9QiKQVG1I6841LI1gxwyj29uJcc83Goetsw3rllPkHhQSLGrF94FqGO1eMxnBXhSKrKYkrnB3C22ZV5nyuftZsNr2rECcGQkRxmC5AAE+nr8gk9tXjuZC/cJ68l3l3C+X6apqRxKrj0rsx4TTmilUMhiEGsBE44GxB+vPE4pz20g2uloT38xsSAELMofth32qft3XLrnXCL+9D+vqghmVMbrhKpEu3IYALPD169h1bPtYLRQ6s4F/6TcKBUx+qxRIXvpbfslAFvwBts/8JsOeqeCjxXyyds6oUC92O52uA+I6s+0LO/WoH0iTsdAIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIRLbCo4lj2kOGYeDNFWOQvPXwxZY/qx3zbTHF7lLZs=;
 b=DaRCShPtuYFlIFJRs6vEr6sXk16MSq9EB5QZydnbPFvu6aQan6kFxjE2j2L7UTHGvhMUIBjl7y8tjVZTKkaXTJLiKQOtlxZKSg/rXMS6sZR5q5tkclUNcmsW3NdmOq0Ili/XXJs0cx6bYxxXL57qycRyXMs8GuSHAiwfhjJO0peLOexyP+e7YQJDFLHlhmqgUOxbgo/8cN2Qqs0ypeCr+Irq8O5xvF1Jh1OfCIOA+o9VNDbE0keCTVsUEahGsMnEp2RWahTIkDq1V88HXPIrt7q8m9pcqHGT8N6uuXmN9kCQsGhLK7kP+SltG+9vO17jJqLiD5hQ9MlmTKFKknXFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIRLbCo4lj2kOGYeDNFWOQvPXwxZY/qx3zbTHF7lLZs=;
 b=AmCrwHT92goVHIMLpWp6aAHlHpm14jm9dZa5Dhme21H4LooxMTZLsTy5XiU7Fezm/wkCidCa9P9koxz1WTxGK3Z9+y1RrbdYxC8R+d6nljRXqNhIdVStNmn4nn/unnYW9SKGlG6RwjCycF2OttIrk581rswVHdSW0WpC2nEKZYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 01:22:45 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 01:22:44 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 0/3] drivers: bus: Add Freescale i.MX8qxp pixel link MSI bus support
Date:   Wed,  3 Aug 2022 09:24:18 +0800
Message-Id: <20220803012421.3410226-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79fe8d7c-baec-4b1d-f9c2-08da74eeaae0
X-MS-TrafficTypeDiagnostic: AM8PR04MB7780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5HM54cLZNR8YMbm6Vzbx/9hbkxbPbmK0+iWnn0u649uqDqkpY0AZqG9SnxH1Hep5Xajv9hKv3wgfdBEYNsU2C9L9lu/eDQPTMM2mS2UcD/Y6dCPIhMt0u/XjYHlaChUdvJu4JsDM9V2FKCnHmyS4GW+8+QB3JjfnBgpE+JOiwhMTuwWcKSF+Ll8eQfCNBOet50qn2XNUhrxPrskWjYLqDs2qfl8epn7jU9Thht7aWAsFwSbp0jpSdi0QSAfLs5V/4i+cZk5Zl1xo5k7hLgVFOb0L6ybbFXCp/e4GQBNlwQKwEm6pG8QouWrFvZy+f+jEEBWEy5Hotr+G7TAtyf2hBN/nK4tk7u2oypSLrWdLNiLYWkpXZU2gh/GC2igCSnM/6+TwU2xhEL2CnJrSOL6QxxM/wL3JFSPhz6VuiH7U6ecTzmPH81Z0NLiePIwZi/7WA/cEWHZ2/Twmn6PF6xLavYj+LrhVJtpATNWB5i7ug8Xmll2/kmMKU4/NWB1ZyVNLtiymZCO4wchKxMM41WnlE/OxGlihrc8aDL5lpSH9ENKJ5LeIJT89xfBOTa6dpU4C6eIHqCS3l78O7APhQ5+t79hNOakjYXA7fVENN8D8F6GFjBZ0YC++9mKDv4N2A6I3YjFlyqFatRdwemggtO9afRttGTMPw2KyrGBpOVjcaYFTgWb7vXBPY8hlNbpTYA3zwT+RuSLJBoU2De3axdPMyQZBo4zHjKBvLI2jt1Vzk53SjQPzhquoU/V+AiD6LLafI/DT2lupFDZU7ZSpbECc90OZegGfNN7XXzF1tzdLCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(478600001)(41300700001)(6666004)(6486002)(52116002)(6506007)(6512007)(26005)(7416002)(2906002)(36756003)(86362001)(316002)(1076003)(186003)(2616005)(38100700002)(38350700002)(8936002)(5660300002)(4326008)(66476007)(8676002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPa8r0xXmOrMIdMCMHNcuXZ7v7G0XKs7cgN8UZuAXO6+KR8IrGgJSljWXUGn?=
 =?us-ascii?Q?dOKRMRXR0to5t2G265oGmTWvbWODL1KZl/HXjB4tkVCQkEY4fHVMDdhYB4SG?=
 =?us-ascii?Q?xVnQCP2/KIpSBlHpB8z/fWu4h4f67dpdNBT5Necq82+/4HBozznpIK9XBjmw?=
 =?us-ascii?Q?nNy+Y3deuK+z5TUQOhVQGS4pV9tBQrv7UkhR+rTyrilo1uuEbJ8t8jdXf1YQ?=
 =?us-ascii?Q?/AqEViiefXNsS0ecVWpZbrMAnrccVMFihHM1OEYRIpry10Oa/a03vBk0WTYi?=
 =?us-ascii?Q?5q2tbrDawe+77NbkI4CvZi99Qa4+nkP1G2nC00eaxdVaRpR1G6NoKdSLSRHV?=
 =?us-ascii?Q?UKN4lBzkYfomV92rrGm7iS4j/z75Uf1utgJ1/pTlVd1p/aB1mKrY7UgRNCOJ?=
 =?us-ascii?Q?L6QrDXTkL0d1kBzTi57HlNYo0fpLFjrImfvM9bYLsNa1Yo1cEb/TFyf6+iVm?=
 =?us-ascii?Q?3o8rM/DOyY3kFezwuJhMbzasWDVtYaF7scoMGq3S/GYFnqqVYPHUj5iOZWKB?=
 =?us-ascii?Q?BB/A/WU95J1ddC1gwBGzRSbihGbLV327O7VwTJGVpfVx/d8tk1t77k0ALQDb?=
 =?us-ascii?Q?vSRAvp4yATNakZTsFVZUu7n+sIWpg6MEDZCNVNB0dK+Glf42vHdrMOP+iZLq?=
 =?us-ascii?Q?P5EyeO1b6+lo3QjJNCwk8dlxrXoNJyC3mlWjqo9s5iXnmmWolRl7QK6sQeKP?=
 =?us-ascii?Q?/vg3Es4EcKLfsUhSx74cBbEaTBiwjSeXxtiDFPF1/+kCM7sorR8lQpKmiuNR?=
 =?us-ascii?Q?gLSB3vAT3GJw3jLSWT4+nG6ENTJFYVyhxuX2oas1hm3BYhiGwUVay159ZOIF?=
 =?us-ascii?Q?bnqdG3S/C37pSkiwBYpJt5Vnuu/4KxSFWTLRUKNdYF4E4rRBFaojPNsL1euq?=
 =?us-ascii?Q?iebDEyPti3xjfZxcdRBX/gd+hwz0ngPkOF99hWlc7aterq1or+Tek71tQEgd?=
 =?us-ascii?Q?IqYSrjO/z4wG1xAOd7z34rf1S2cLoFlnOr7Vw1SzxVPLmigItFD893K2iiBX?=
 =?us-ascii?Q?ijx9Lp1R6zKW/uL2upFQfkJr9t3VTHbq8X9UwFLn8SsaC/fOOxfcgjoPEfEq?=
 =?us-ascii?Q?tlbZlA2jp6dcwI7Uxi08gDI3dG7H0vgyiHNSfSKdVnfukhmBfxjNydFypHEt?=
 =?us-ascii?Q?8JJYEz4hbFGd3Bze0b4IL2OKHBy7MmddTnSd4LiROUpievLF+dgrEyjLTvvS?=
 =?us-ascii?Q?4lIedV+VzMVvOUeKdCqorAQQ062zDjUIkY9WYK4CoYEpSRb8yxuGzTgD1dW/?=
 =?us-ascii?Q?HbebRno67OG57QWkk66Rbm/SPD+svBMFQLEfHL5T0T1QFoXCjJvZFBVydgiV?=
 =?us-ascii?Q?W4330HYg0F7bMiPk6XpoUUldfpnvqczxg/VQTFPJdjF5HZWooqeaIFNT5bGy?=
 =?us-ascii?Q?FPDoRSTqaXyOe7WgDgpAjgzyUatf5xPxubNOqpCsQLfqD2va1JGWUJPAG7ut?=
 =?us-ascii?Q?VDFfmqPEFs48p2gVZNNrw2pjDA4voR5Yyc+hDWj94IhbFCn3irXt8vJjmhpD?=
 =?us-ascii?Q?I1LUEYyIW0miwKBAilpmnibJc3XHno+XTtVzBNj/SyZEiSeSFhXsQYAHtH6h?=
 =?us-ascii?Q?KEYTqVoB2Wy/OgmlCED5pWDMSpuin070bcPYpifo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fe8d7c-baec-4b1d-f9c2-08da74eeaae0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 01:22:44.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0b1c2jr9feqGxIc4bkPnnvcCtI5i6aVn+g1eOnff2kS/ID65uKmDDcMUCA1UYCzxswfdqgDTVO2sJY0gNsAdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to add Freescale i.MX8qxp pixel link MSI bus support
by using the existing simple-pm-bus driver. A power domain and two input
clocks need to be enabled before the MSI bus accesses it's child devices,
which matches what a simple power-managed bus is(See simple-pm-bus.yaml).

Patch 1 adds support to populate simple MFD child devices in the
simple-pm-bus driver, since the MSI bus may connect those devices.

Patch 2 enables/disables functional clock(s) as a bulk in the
simple-pm-bus driver when the simple-pm-bus is being power managed,
since the MSI bus takes the two input clocks as functional clocks.

Patch 3 adds dt-bindings for the MSI bus.

v1->v2:
Address Krzysztof's comments on patch 3:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.

Liu Ying (3):
  drivers: bus: simple-pm-bus: Populate simple MFD child devices
  drivers: bus: simple-pm-bus: Use clocks
  dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 97 +++++++++++++++++++
 drivers/bus/simple-pm-bus.c                   | 61 +++++++++++-
 2 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

-- 
2.25.1

