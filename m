Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB757ED41
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiGWJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbiGWJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:44 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30076.outbound.protection.outlook.com [40.107.3.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AE30576;
        Sat, 23 Jul 2022 02:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ4bdB0SqDRrPGCyw1RVlSiaB/zZZO3It/ViE/A8R84KOcOtCwngZXgm/0nBstKPF0Gxq4uM8qzY+DWFscfJs92m6y3c6gd6NWo7T3nI4j56z9KX8UevkFsQEwJ/twX/Y8FjR+UeJqPINT/46GrpsIHD5VeArUz1+79Rjt8m1i6SO0msbndt/b3zJbKoQkmy++MLMrpcNNuTPEIlJzAviWjyyx0uMYoI0V9xGfdHbdx3rOVqJ/DpuQXlVqQPG5+vvcNKZ3GYWUeqE8cPGZIJtATeNi91zBN1XAdpQUxsISrz1KU39jpWXLUi4Wkt4thrHARsNDWWN7TVYQMCO8fOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Yb69OZj1b7cPEE52C0Wv98nQuBwq2TH6vjOcMnVLQI=;
 b=XnOC+lUek4wFdSsKC0Pi8jhxkQ/jM4qmk8pXZ9L5+H0nK9D4zGtDyyzrX5Altc/K4KLF6NgNgpeM0eGThp/diX5BFkCOZen8FbCtEK2HuLCGF/eC5AJrwgqe5N/1pH6QAv8TSnfEKdDicueuwAPpuFwx6smoVd2+KFTpSmKzP93gTcIwWCSK6mMSNKVbAz3g+CF9NRx2Aj2jetPNog4EEiBi0c6X055oQCXqWczg0RaRLyvHEWMjGc9QEZXkEtHz2wiPAOZ7Cu6K1DV0Pwu7u6LLWLcETNBks5zU0UzXknimW53DmlOP42a3ElrLROjQvpggUhLZBf08UCRGWyX+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Yb69OZj1b7cPEE52C0Wv98nQuBwq2TH6vjOcMnVLQI=;
 b=iIySiC4zDy0lAouwENncJqps37ht1wzEDalMC7prR0BdR7C7CVoWzODe/226pZlstoakZ5whCoRJrjApS9tXOR74IFNQKgKWyg/hl5e8MXmzrqjIlZykRPTutdScPLI23vq5pwYt9ZOY4izvnCTp69W/wjcZiUYS2Cp1B+LSfPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6067.eurprd04.prod.outlook.com (2603:10a6:208:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 09:42:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 9/9] dt-bindings: pinctrl: imx7d: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:35 +0800
Message-Id: <20220723094335.3577048-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0a09422-39a7-4364-7271-08da6c8fab4f
X-MS-TrafficTypeDiagnostic: AM0PR04MB6067:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmtqPdyPDC0dGYyC9IkHCs28EwrtMSorLc3aCkecbvA8qdYWXyI8m/FLK/o1rr6jPA460Lz6aCwh7nbQ+gujwR7AxdDHihTXwPHmRHQkB6CEG7VPWR7p9eVdBy/9Z9IiTaUX1B4VtF+8Xi8AUtyX0+IlnCKJS5JRmpnmPigCV+XVz9bfZt4PNs2Hfzv0Pt4hKOGzMHQz/G9/3UXkW8hZFCmVprLBoW2N8AriC5fufMT2GWJP+APN2vDNPgeJCz1fDKzf9WBIkVVcq3I5A+jjazL9fs6l6RFqykKT98NJUoBIs6b0MO7sh0hVQvD/oosE51lAdjlbx/5GDvLZuwzEC/cIGB0T2en3yNwTHp3Sxs1/RWhoR9rXSUn90Kag8LpJhCh5G79Op6BtFhM57c0Q92pI7g3/+bMP+gEhYo2x+4ofLWUaIzi67VzIAeAGzMwuRDHJ6Kf0nZi93JQdu51Z9dJnBInvx7qSLHzZkLKHuFp5BRggXm96GSEBivvKue9AMXrbZfNPeu979k4ifzXLvB10VdUes0CnnOFUXTtEiBbHd/3/+kkNybL43+gfXG99lXBnFDVsQUkbmdHuX+ohxrVv3wMhhdC0exM2VHD6NIPfZNxbf/yckKqDE8PnS1F0IRe8T+m88J9XqxciUEaA3i5BOXzxExeGQO50VoxgZF60SfuoJh0GpuaimEOsKdhdQc3pdsTRNfNTdD8NdtrWPnlfbrr6IYa5sOce3ZmZiCcmaEEZ84bZm7E7EvWARyKHzIMvUwnduOjWgo7obhhxuQY+U2/W/jpriThucDhvs6LJ/zYAsMEVb6Mjqjt0sNgi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(2906002)(8936002)(7416002)(4744005)(316002)(26005)(2616005)(38350700002)(52116002)(38100700002)(1076003)(6506007)(5660300002)(6512007)(41300700001)(66476007)(4326008)(8676002)(6486002)(478600001)(66556008)(66946007)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ntxs9kI3ZWojaRcnZYAUJC81lxS2MQQw9CV2+ZCrAMOdJ1VnGM9T1bdNXbzx?=
 =?us-ascii?Q?FSvaBxPQei+h8y+QLYIknwLXMj77F7pLw73HMssh3NbF2u6aPNW/EH2Yei8q?=
 =?us-ascii?Q?52k6YhLZ8hwMizLsf8dU5iZW+CgTMh2qTPPV6u5E6GZGFqrPjredDagM7IHs?=
 =?us-ascii?Q?ZXPNOPA01O0N3bUzzGMbKScKONIQsXFQG7OacP8dURgkrKETutIyBCKJifM6?=
 =?us-ascii?Q?DU2r+0ve5xUaCqr6DyGDMkovzf6kcszyqsqGt5VYu2V5uLFcHcqSnmd8+IJE?=
 =?us-ascii?Q?wGUCrU2wegMMhbsOT5c+0MH5LSbZ3f01RTeYxj5dbdJxmgi5ZzBZDca8YSwe?=
 =?us-ascii?Q?KL7KV1bchvR6ERCMacYC0rHr32tK/rtA/VXHchRYZ4gVDBrFBx48lTONz8f+?=
 =?us-ascii?Q?UbNiiGS/h32YwE/EwtWeLW3pEyqqk/qu0YM1xtUo8TmG1ElB4pJiOtGY9AVs?=
 =?us-ascii?Q?gNqaVt9Zsf2XozWcLeLYqNQj2jumpdfqjtmaPkZLa/i2O2iL67jjoK2GRsD5?=
 =?us-ascii?Q?pJwxC0eSXKshm5E6cQ0lbABH7hVqCUhszz7DxGrUGpEjfrs+cpgGs4htdeBQ?=
 =?us-ascii?Q?R+nk2BKUQV6TzDVmzWN3TnuQiEPFt6uvd3rIxUkpvaK0WqxKHbdRAx66isBG?=
 =?us-ascii?Q?G+lzIMPbJ+rpZKkyN4fFNFatxRKN8rk780LzgOSktdz/bs66ZrfR6ilWNbVJ?=
 =?us-ascii?Q?wRvxiVI21RK4jMNs8K4qBr7aetpAe5FeuE1IRySUIsf8Skh7bFTC79tfQ3Ub?=
 =?us-ascii?Q?aihvOMzAVfEldgc40E4FfcMPhol4aKEIfFtfXRli56BHrlAKj8cbmU5XYYGs?=
 =?us-ascii?Q?lCUaokdxodzJ6xOfTecnUS+O6IKWRpDv0qEcfQ2kyved2ArLaW/oG8Tt0BFy?=
 =?us-ascii?Q?7Ne6o5sXEv3FDX/R+k43iFafnngQycFgx3TqLCL37Za5e4ZhvZLSfcQXM/4A?=
 =?us-ascii?Q?WZiRuiiuOuw4KebC+9a3AM82Rzv1Xf3HGJWgH2CO5z2JrPHyJOgUQF367sDE?=
 =?us-ascii?Q?C5oOkF3FjOjWdBHupjsSYv8tpbYEPAbTMl9iEu99k/Ni3dLQ0XNSdtcqcijG?=
 =?us-ascii?Q?6XEBBb5hK75xx2DMwc6ATEB2gLxp6546Ved9+0mOmavY64GQcxK6TgkPqqOP?=
 =?us-ascii?Q?q3E1rpeTwqudPF5ZwmEVk6IZzqz/zBY42JiJmYE37HvoKgSOB+EECO+0nLeB?=
 =?us-ascii?Q?yFDoSJW5jy5cX/hcGvqgFeSlzA0co12c2a+w9YxSh3v8+PUCEZLOG+rxsPrn?=
 =?us-ascii?Q?TqfguoPLo51YnJEa10JHH/6Zo0FrGB78ZGWlOvGrDP8kGx9p2Pe1anIbwDiI?=
 =?us-ascii?Q?4HGQc5UXFarjPXUCarhQBbTdMUGYImFMM/stGuR+ywCL1yIC4Aem0RbuBXIV?=
 =?us-ascii?Q?xHnXTRtWCIgHqUjSMd+iNdUXHO2iF+dduJsorykNURD1cusggBcRfXKwPJsH?=
 =?us-ascii?Q?uzbpAplIP9OJcbvVvtj9argfh2aQ2RtU8zt7kfvnuAOmhbc4EiXP4q4fZReD?=
 =?us-ascii?Q?AEdhowuvfp21l9vPmd6l9zm8Y1Bucz05NJQuOQB70mOXyVd2/6YpdIbPQAhk?=
 =?us-ascii?Q?5jzWuaoaMLaS2WdhXNxwcQgWSM5+faWw2ONlnejX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a09422-39a7-4364-7271-08da6c8fab4f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:34.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18/1dqqMacseUTBivE+khccrK1ddLLnfAE9Vn8HfANka8nHcWQ58XWkA97mbpxcCWA9fnY0fnsjc2izyKgXH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6067
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use minItems for fsl,pins

Fixes: 4764f39e3676 ("dt-bindings: pinctrl: Convert i.MX7D to json-schema")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
index 621038662188..63092d1a34bb 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
@@ -61,6 +61,7 @@ patternProperties:
                 "input_val" indicates the select input value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

