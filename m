Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D986F587A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiHBKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiHBKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:17:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF36237F5;
        Tue,  2 Aug 2022 03:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyOVJdBRSsvFYyrrWbsyNQf/3gibixUrrjNxYNme/doUZFfHyJSflGAIJ+IgXgJVj5OQsKjfIT0OPLrCjRjJta7qTVLjFfxVXWHbm7av5/mczSJKT63+D4IsnjoVjFeuipLF2nfJHqJ1+dXkVr4GtrgeLm32VUZh665VP/4VIEG3JGQXNFG8+3x0Kwi/zlSTnAtBDUdgMdLBEIC7/6C639TRGi+SmHk3lDSfIZxTa8AYFAvRXcFSbEokG1LxLjkVZw8eoCHz3DKsKpvMT69CGqUDccwK+RGRlPcnJU0yh68nrcbiHMuMYpDtwgUYtqe4XEfu72jmoBkDUkbaSm68YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXLCMiMuDgzVCGxCpdq5X7/6Rjrh+M3MH67j0V+/Hv0=;
 b=HalcjVvb5QNWRZks8V/Jm9PeOEYSCbXQy2WHUYijg/boRI0LbSn8Lg3St9FOFGmWpzfeTs3e6JxE7rvDu6acV0BhaTxbtrBysnSnamVlu6HL40wRg2B1+SANm9qyaX3BwnCNYLxTMuE7h2CbFaXSi844RMNedUolD3HhlafyeUzl4lGwLExslp0FlJTXLUJsIrAOwQfGdszxJQwTQuxqsnn/Rl6Hjbqox81X7sgCF4Jf6AQDAaojwOyF1gjFuzmRB0mqlR7Hrfsrgp2jfjRWJc9/aqqiyG+YaAf0CyhBFVESss13zOWpcVAR1NfhnkbRJi3dTOvITpX4095+3EOzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXLCMiMuDgzVCGxCpdq5X7/6Rjrh+M3MH67j0V+/Hv0=;
 b=Ji+xPLnTO33k2H2PTqmwEYGTgusjdwGVoGFH9HqUUBH9HlT2CzLbB4IbeEIrN0yIvsnQs0PnZovgvParePGL1K2UG7EvXBPLVxJJBOA3HyQgu6Wq2OaLJ42UT4TN4Y1np00Cift3iEzMC3+WaiKNcNd7yWjvYzlW6EfkjbSb4FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM5PR0402MB2722.eurprd04.prod.outlook.com (2603:10a6:203:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 10:17:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 10:17:48 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, jindong.yue@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency
Date:   Tue,  2 Aug 2022 18:16:13 +0800
Message-Id: <20220802101613.30879-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0210a02e-1ef0-4c61-8fb0-08da74703fe3
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2722:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mb1G8c1aYyBnwq4En5ZY+Dw7+WesvlNVMyH7Q8QDFtVktX/0U9HRgv12DEfh9cVu1eA2NO9tb+EpADS++BMqtIIHurblEDpMcNLnpu1RVuI6X52BtOFHhHQ9V+o3YF7p2qCnWWcxWk3iIZY8sUrdndLRUgRrsVceVI7aNd2h76YtcPcnarO5lmAzG7KoKFFxsFneSq4HUyC/DWUAUiOvvMSVvnP8dolONfFdu6Ha6WORxqMMU8DENtVuHdAgp6Te4bu2VT21JDb85lCka0oacsUeXXWwEUuVAwLBy2lNaZrsZJ/YxokWRAI381SAZzTqqgWxAm0cr8lFLUntscMaoJ1jy5IF6hz3xxNAnPUCHg3qc8Ysh1Zi07swg6PYifTxuhdOVZlaY5JelI3VWJkch/wFz7LxMJKwSQ+EErvygR16I9U32RzkkEP4Gzlw2xVvl0e6rUYU4ew54K1IfyXvGlZIS7wmxWcdOPvJP4PV/FjwBkoikn2ZR7t8s0nCMX5+DSSV1dEW4IxYRdWxntv1YyXnKhTwud5rl/oR4N/AImxm2J8rk2adJVS6uB49McI/l69oz/tl4WW8KzK52GoqCPiLBXGRNtux0pWAqGZkPo2fwn6bcVXNoJqTJKy2boB1/IwaGJJOA5n7Tshk87EvGG3j4i0Fn/I6CZtU3eQvi5KoAjHjmjt7NgNrdH16rEGCVgizgHUOplX4BnirqAhXHqvTdcqh6x+qwXkHHnjl/ekEtTsUYooB1Br+LcaURB0KY9ZvU6QvWi4/Z/mf4kIIf+sTlinrUFXE7AbIlLKkVciLiNBK/KZYZfpw+ZkiIUxs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(186003)(1076003)(2616005)(6506007)(52116002)(86362001)(41300700001)(2906002)(6666004)(6512007)(26005)(38350700002)(38100700002)(83380400001)(5660300002)(316002)(478600001)(6486002)(8676002)(44832011)(66946007)(66556008)(66476007)(4326008)(36756003)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0COfCTe+az2JzQMpIvoeNKQqUL3C+iNT1P+DfeL+9p/6KU7V05hcHRX3qALV?=
 =?us-ascii?Q?L3ONvM5mPLfiLXI7TejrKTFE666XIFIPtoAg/w4LZHVv+wKVaTk/JjJZwCZW?=
 =?us-ascii?Q?DrqeDtDPHTlr6bQ5DYTuvIUX0sUjH8ESOP9VWDsAH01RwE8uTkRzeHrOO4iz?=
 =?us-ascii?Q?aBtdryUPYwmhtxAHluEMKrxMWtWUFwPC8s6YxK9CvzsQY6uxF5EzV+Ed7mzq?=
 =?us-ascii?Q?HUGjAxoB8PLZxmkiJeoxby16FcIeOemkFA1lxxOOo/2mop9+QTRpKO1TIynm?=
 =?us-ascii?Q?Wf87K+6L3C0J4pCy60SP3Nya4Ea0jsNbEskCVmvTwzUzLlf8T6HgNzhtJi9u?=
 =?us-ascii?Q?ifrFHjKJv+OcWUn3kxZQA4/beBvaXE3rL5zYwg6gDl6Khqfj1RUc9v1Q0Q+o?=
 =?us-ascii?Q?+f1WODNy+hOh08+p+2z+tY4HBfSkZjlKxsnC3sYoUcO+kU7PNV94XRYHylrV?=
 =?us-ascii?Q?VR9BQt4zf1+6AcIye2PXcEPhcBbCBWwtr4pKhaLPnvgPMvmnAqjMSmpbDy2Y?=
 =?us-ascii?Q?yseJdHipmx9wAxLY5pf3hwCHMcSYFZX7yYVmVuvPka1JhtfZK93mQgeMGZwa?=
 =?us-ascii?Q?AAwJnTpxgI3XejNU/ZnlQLT3m8Q1JYI8o88u1DGr+X97k4rcPpRM9obOHtmV?=
 =?us-ascii?Q?z5qzbCQLl0qSZ558zbBQuyFhxq+JzgK8+AqFz2IJnTCaxo8hjIGTpgry/iOl?=
 =?us-ascii?Q?JHPaKiINPp4edxdaE8oXM5c6auNbnzNrfVuw/9YWWydlWJjVd6i/VsZgLYLK?=
 =?us-ascii?Q?Ndo66EavV/4udrh8SCG8Vn4JtVQmfLdQlMllL0nLX/hfoy6lx2x4Y02/aXs2?=
 =?us-ascii?Q?fX+zYqJovAuEMNNDMUE+v2m05nH/NyyeNAUceiPyIrxhVu43R32AxpBVA+x6?=
 =?us-ascii?Q?6H054TCtqfOE5tRN3WfCS1dVLWhZA0/AOgDXIfcrXk4X/XnQf/ZKE00wxrcx?=
 =?us-ascii?Q?vy6XSOYqm+gj71pWmdQYDwxof1EaJayJjitTcDPATJfMYWBfoa7+qNBfFa4x?=
 =?us-ascii?Q?uQXAlJIhBSDmoy7l8qJx80jSSh68jYPl1hpHRVndXAyJkR4N6gxuT6A7G/6G?=
 =?us-ascii?Q?NVLi8XOZrx9agy3dftL+9eXiXI0YJI31ed1wnD36qkRoGjAavINqyl3yuHOJ?=
 =?us-ascii?Q?fLX9yuQaL4eWhtlrkaxJFvZKcmB2bP8PdeyxgwcZNG0lSUv4QD2AplbQmlCS?=
 =?us-ascii?Q?JnUMqoLk4FkBSdcTg/fE1oSVmt9QE6HBCPpbqcCorhHefHoO2TKwjWr7sow+?=
 =?us-ascii?Q?sufF5Qgw2o+k3vUJ4tInfpxLL2qSVrknTx67io41oI8hqt8e1q1iQjaHzZIo?=
 =?us-ascii?Q?BOJ9Vu97hBc0N4jrc11G2jBYno/pLX6W4zcW/8dMGsZWXp11ixAkn8noNzMB?=
 =?us-ascii?Q?t2xqz2Dq0k196AsAeN1HSzibCmA8G6dl34gZRH8woXOgOZGgxzJw//Ayvon4?=
 =?us-ascii?Q?7rc5yz2AFovlnN123tjxn1Oayvmc8xm6FBQLU+64X6IeW1xNEBr0zAKUFS1s?=
 =?us-ascii?Q?OzLiOp5DXo1LdSAa2hqU2fHLWc/FDYBBY0L4aOuCL/AIJ/F9NZhMDk2dFwu3?=
 =?us-ascii?Q?lzT2FBQEF5Hrtqw5SosWzjOvG1K+XvMUlQcMzTHq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0210a02e-1ef0-4c61-8fb0-08da74703fe3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 10:17:48.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yMTsiU6B9WUdrCpdO1O8s7iPkwvvZBYGTABfzOnGaTsV4mk993Ob+r3rJ5xkdQSuTpZQhUQOGNQdliSIBFYMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2722
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jindong Yue <jindong.yue@nxp.com>

Remove the limitation of SERIAL_FSL_LPUART=y,
as we may need enable this console while SERIAL_FSL_LPUART=m.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 877173907c53..a18dd525e42b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1325,7 +1325,7 @@ config SERIAL_FSL_LPUART
 
 config SERIAL_FSL_LPUART_CONSOLE
 	bool "Console on Freescale lpuart serial port"
-	depends on SERIAL_FSL_LPUART=y
+	depends on SERIAL_FSL_LPUART
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.17.1

