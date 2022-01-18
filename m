Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8054926F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbiARNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:17:57 -0500
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:54336
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241959AbiARNRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:17:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8pvC+q2QH5+pE0HJ9hvJJYv2BXdmZbPfwrrQlf1nuKxlYdJuaXQx2/cjH03pLa1eokUo2Lf6vrPoBm+86BZI1CBVfYFCX+HVUh9YSiIJGbuDMF4yWnAqdDtLZyJ2wMz7/jyPZ3auasdVTHkT512r1VIVV45Fp0M/UxA4xcgz2dEy14e/zKP/pj7/sEZlTMyBt12U0V4ymslcOWVlIaiBm+hQVMrMl3XDTq5uOvfHkGayBDt1gZe6+vKvs+yZZLJ5m7x3YWZS1htXGJtzBMsN+U8d9gcHJApUdBLaO9W2KzTdCHXGkqMbhpNpgTXFm441WV5/JHrKXBHcUWtMI85zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSpx/wXee1QgkA1OCkDNObFPBz9DBnirUDrqiu7AB4I=;
 b=J4ZuoYWwtkBft9z8iDhzK7gd6PgfAstf7TBZ9oLeMrXf3D32ru4SXjygE+kXsHoULig3wihVR1jCxdaQ+5yrXUmJXY8UNl5mndygRbljY69yMKSgf/pbYjc90qrseLtKu9FgxmqiiC+AUEzBntlY131NxHzLAGaxfCsf/S+WyH9nBvJo5iuemNZXKPO0kpJY0NVU1Ie6U7dsC9lvOO3dV9fZU9HFqX11vQESi3dZFvS2W3vNh4bNrkqy+kJqBwPbL32nJ+oDIghJ1ozLv5F6L2UvCZYtmt9akSQ+L2sbPbZ4hrv5nYgQWPbiDT1ahfGcL6c/FByCY77NHh7cHQmkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSpx/wXee1QgkA1OCkDNObFPBz9DBnirUDrqiu7AB4I=;
 b=k/jW9w1buoCya2mob3Cf14W9IdPJfzdva8bvJeFoa5eFyBwrtsRdokOVACj2IWmNvk1UBE349k7vBqo7LsRbgp7dBjGqSKIwMs55tyOORnI3fRgG3rkcJTKKJ+0NkHlmWafCZ75MRawVYDGTzrF9ciMCKzritHOsClEhYzBACoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB4053.eurprd04.prod.outlook.com (2603:10a6:209:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 13:17:42 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 13:17:41 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL compatible
Date:   Tue, 18 Jan 2022 15:17:15 +0200
Message-Id: <20220118131715.2051965-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::27) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e268656c-7290-4a44-39a7-08d9da84e83c
X-MS-TrafficTypeDiagnostic: AM6PR04MB4053:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4053E605F0E7A95E483C2C31F6589@AM6PR04MB4053.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTpGwuy7vrfSjweInUDF7ywHCEvw5TdppNaRUTBB20dtL+uw4+vP28d/riz60XxFnvUblaMK1lVqEcAylh+0Q9hCBhC8THXL8lEodZowJ0so9vdPIucCD33RNj/w+tyr6mQuLkULv6sj4ooWCSQALRbrSKioOgQ/+N6u/1+dI03W1eUPn9Pzgu47R0Z4zrdLLAzwgv8fLJlET3+W832JCBE5PEDA9zgBA7+TGkaUQnLWXxINCGCOqVUvbq3N8qMjt9yMQ1r5xEKLyfrihl8w1Ha1O5260OcvuuPDhX8+CjEfAWS4vGyf4wWpOKWfj85OcPDeoM7yBvFyg13HeAsphZ1N82BGg8HsJYdoR45Eho4SgTUuCCqSCun3jf9KuApH6htVx9GQbhPd45BI11ochJgOisqrAPVHxW/XNqT2RdtXLIGvrk889kCzWbSgjdQN+WJnsGflOI3KntD3kBtKoiyzL5hFEyjnO9ynud48GxL3xNYKmZpgr0AzZ/cTkKdkOSrKXrpR10SNk/c3LVXDbnURMmxJRXx3rRBi7WAXNnc7Y2/hKRo9GHl7YKpsrh7FT9muuQfyu2nMtIsTKDUjvLkDyBi9RwuVAFJKTuAMwtyjFHZdCmaXnv56JRzO5WAj2VmhUpGs3/9GlRIOrf937ngt1nhhbk9kMeQMr+fIJ63mYc/DN3QBjKdZBWItTMpm/1fx339AejqmWq/vkpEGM6um6TxQa519iCPdoC/1VvDGVxuogEu6SafUz7HBo4g2phdlLiMMMqDdwCmMrVuy3ROKSevDORUw1WZsVWBPSyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66476007)(83380400001)(66946007)(316002)(54906003)(6636002)(4744005)(1076003)(44832011)(2616005)(508600001)(4326008)(5660300002)(6512007)(6486002)(6666004)(26005)(8676002)(6506007)(966005)(38350700002)(36756003)(186003)(86362001)(52116002)(38100700002)(110136005)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSR1PEh5nwfxtHA7PQ4gocPC+ABHXQLGKheRncFSWVSNZRi2GMMQze3uPKPa?=
 =?us-ascii?Q?j8zUQJMXrGUxGeaMGJDwJJlQq2qH4FG9rvEQ4h1gMcAO6zKahqudHTE1YsfR?=
 =?us-ascii?Q?UQCtI/eVmmoli573NYSjh9+0emuY16uLvDFs/eDO3g/I9vpE7VovLGqzAuEl?=
 =?us-ascii?Q?j/tC4MWkMExBbQnXcaoOlY6tUSUL4NI+yqqGxQOKicXAdFdUsTnBlpZMWwRB?=
 =?us-ascii?Q?+YvRvVnpbYPhjmx69dvv12kacuLP3wsTs1Jg93guqFOoa2Q5YMWKrEBiyQMH?=
 =?us-ascii?Q?l/39syZyVV62IVO3HQ5NYxapZd5j0iQ5eHVR967v02BcfJ3RbdSAAf4kaWFq?=
 =?us-ascii?Q?mJotnm+8FGGyp5qOz+YWL7KEsl01g5tQIgqYNf0bWDmLIOW7otnYW9+hd+NS?=
 =?us-ascii?Q?KAvbtoPT1PHLquu3ykm5wPEDOlLK9TACqBL8vzWb64c3oX/2/FVJ+3hMEzVV?=
 =?us-ascii?Q?eX70yauoKlii9SJshPkVi0wVBOYvVio+uWtV7oyrbYMTM3Bnd2UOBiBQTLUO?=
 =?us-ascii?Q?VXJ/dCHwcxUAez4ykO8P+cVJgZHx6d1vqM2dkhQbBXJvocggCQtcvlpJiJ3O?=
 =?us-ascii?Q?ntmrU8q5ZP1vsexEHNudistCd+W723m75wEKcsYnegZFhJ+233qnaa1EOPgq?=
 =?us-ascii?Q?lksAef77otK+E1hG26/klhjAkiGp/9L0CbkrzQfi8vNuxnVdQe/pdtPoEM6V?=
 =?us-ascii?Q?x0d3vdDCXVPorzLgSUVJPrhxvq+V10CW5gWpCrL8qINGkU/YaiKWFd8pmi9J?=
 =?us-ascii?Q?Ou81bwZqfi/CSXQSs4t/3aXshBwdon1sHJ6irc7mRil/oMpCX+2W5Z0kJuJy?=
 =?us-ascii?Q?YQIcrrWKABn0pTxGXr1lkktx1te5st/sqG7uXTsunVwr/8Q9pDOmvj0ALDw8?=
 =?us-ascii?Q?1QYWgHnI+Rr9dlEJevmzseMDF4fj2pTfILx6HuHLUeFvxbhF4+iik7lCQ2Tn?=
 =?us-ascii?Q?zkLA6+wUruKF7HWH/8TMFuAeyKJDU1Ijg7yVXgAbpu6EMK/2aco7d5BpL5pb?=
 =?us-ascii?Q?F7/5G2DAJDgX5Nj9OTlB7B2penKm5uYQ+zLvTBKP4M/GIgjx+29D4Fmf/Nk2?=
 =?us-ascii?Q?MtQSVH7LYSLn88940qbHQkni2uPD5lYln0B4uoDY+njxKeypjJYkLh+JypWM?=
 =?us-ascii?Q?vTf8ktcBm+VXPWPHfgGlqnHaXiyUJcTc3p6+qkRHNmeX/toYWLKIsI84+mcK?=
 =?us-ascii?Q?AyruwznskhvmqHWUbd3ID+hG/nNaBaBIAnYWyHb/rms2jRCHcC1lZWMfK9mW?=
 =?us-ascii?Q?p3RR3++V4FWYwWUNbJgjLvnXYqJPHfYj5StoOiLglSxr7vb3WPugEy8pdSiT?=
 =?us-ascii?Q?OZI4QbzZz2oc41b5kSSTsazALYkq8naS4a/A6fMbX8kZOJinBRcjqA56pU4t?=
 =?us-ascii?Q?Gd1Q3Q5Bjgv2NdTWeNw1bGnkBuKCtBtZeS7J3+U1ZLyTNr6pnVw1348OMQUy?=
 =?us-ascii?Q?ZDIOmCa+My0BFrwW+Y8Aog1cdpcK+BjehDdoGi57i0Dzao9fsPQ2G2jzm2fT?=
 =?us-ascii?Q?bbdIaMCe8DUdqD1tNIbot2hrcbeKeDB1djfNYIODSmyWz/j8t4Qu+Jk1g7H9?=
 =?us-ascii?Q?JLwcPmpf7yx05tyYYciTMtYcvlvACrdM/Nw6rc5MqROfjGDlk+EkG/AIQs3O?=
 =?us-ascii?Q?DD8KhB1F22wbr08aKpdFUT4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e268656c-7290-4a44-39a7-08d9da84e83c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 13:17:41.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiOQx/WHXG9+noYwjfLdTlUPMyP3LjRkADXgrUksMydLmtXMP7FPP0Mzrcnit2d5+3qw7P/2056nEYz6tSJszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8DXL lpuart compatible to the bindings documentation.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 * imx8dxl will only be backwards compatible with imx8qxp now,
   like imx8qm

Here is the last version of this patch:
https://lore.kernel.org/all/1640085372-1972-1-git-send-email-abel.vesa@nxp.com/

 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 6e04e3848261..c33e3af1b5ea 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -28,7 +28,9 @@ properties:
               - fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
       - items:
-          - const: fsl,imx8qm-lpuart
+          - enum:
+              - fsl,imx8qm-lpuart
+              - fsl,imx8dxl-lpuart
           - const: fsl,imx8qxp-lpuart
 
   reg:
-- 
2.31.1

