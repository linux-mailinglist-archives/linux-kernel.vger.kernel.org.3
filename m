Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B5588595
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiHCB5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiHCB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:57:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF0D558FA;
        Tue,  2 Aug 2022 18:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csmQ1sKzmVJeUn3/ozNXlI1GJcoy+74TLEwP99B9/UdxLhVjfbP/LH7N+8S8Mu/OKY9QDAzwxyWmZ7dLgKpU3L6YnDDhdanHD0Y5JioMJzv9bMdkGpeFCQrPHufYxuAR+/W6c0Ux24xOZzhcd8qa7PrbfrIofGK+oOTLRMi1JTIuEPOOUK3gg47R1libT7K33sRuu2pLnyJPcZ+IQBaloSlvm02sP2N/WSSzRBrzaLTjPW7swinLuLOElKFUCPNz5jzZI1aa0a8Q334VulSFhTSpX9dMggRJDZfxNjRXBV9WiRVjd+zp5zJFqPQ7355RdwsIYUBT2W5x8qVYPnoKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3+T1N3b/3rAepxxP7ztCqAJkKl7GRbrW3MHNOLTq8I=;
 b=niD/Tw0cc4JKd9eFqdmdqhTRozf86uxoc16FGa6HsyorMG/kk5AQiVKgPfQr/etsjWuKE0T4JjhHJnPkaOXyt0c1yadNajS3U3XZJPMql3btXoR+DNR0cnO3/WxBED2s6LHprlKX6eGhWrbGKT3aIC9dUVZ+J7f0KFOrN5cc7iulaknL/c8C4O8sNbZ+pYVa4G5DMxaMT5+wp8djTQKgvjwDPiu/MScrsrmfWTLYbfc7V0UAMDiQ0m/NdJg5F/wMWP/42x0oxXkfFfDLBf+Xn5MIkPULs+blOa5sYO1Kxn/BhXnhcDnfZ0YMmwiDsRPSPca1fYE5wXjMcEOYO9gtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3+T1N3b/3rAepxxP7ztCqAJkKl7GRbrW3MHNOLTq8I=;
 b=A604lDYORAgGP3n7a4EvpKprtQek1ktiGa5lQTe7LMwPpFYFHwxbBcldO2icScZsPtTrBqJNohonw/koI1lHqIkg+VC+Q34MmzNwUI/DHKJSOyiL+DnhDvFxrlFYJgvOk3KWz8/0apAOfZaUdFJUnAmcSViDzrt1EYSEgUqPF8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS4PR04MB9385.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 01:57:14 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::d547:3040:284e:580c%8]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 01:57:14 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: lpuart: disable flow control when wait transmit engine complete
Date:   Wed,  3 Aug 2022 09:55:12 +0800
Message-Id: <20220803015512.25472-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0482677e-6aa1-400e-1b71-08da74f37c3a
X-MS-TrafficTypeDiagnostic: AS4PR04MB9385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d01WYkntGNKUFmr7oPIn6KSrqyw4YGyzF0NqpaEMmDmfxps3C2ZGbd+xaw+87Ewehpd0NpJGfoI57gO70/NQo5nTt4kC9GMQfg/70hC00xyTzin8LlbVngAl/XCnncbRBaDpRYnTv+sO7a43u4B7YNLRHrEBi5rrDq0a+pTwR73meWTiWZg85jcO9kuGOPkXNWCT4wzOuohSZR+uJO8cweY5rdXUk6Y2Y520Oh9NfQEid35fVvOVrlKGHkoMVvgtZJwa3J8BPvinjsS3HYlySR11YeNSaa8xjq6qRoxPAskJST6gky6Y1/95wzU7eBFWgicXqORKiS7WauR9CpTf+e3qIoau09x/Jc6wdl1HV7VHBUXPb3cx+2iTboSluoh/eTyZRBedaakx0PUqstbma2RTVal3L5S3YwYAgSj7ZTGWXtTLTMeOQhHfguSFf3zxNF9MdEa+8cSzlsx+X66dUplF1TQER3xLtUHOR9AmW1BBm0FHfD6ESTy50hCzuIP0MNckjqQ5gCdueMEUorxHq1AdN3xR8PRS5wHOGWZ461YNiQd3HSwJt1jQYAWDrzwKmMveGL6WhBDNgFPkwV5nZI9GGQWW+Fo5OcQ10y3vvkPKWOVnic5YjCEiXxl+hDrbamxu3drUVOZHXl0/PaLYg/MgMwhu4feqe72GX5M0TKmFliWAnrzSRJuXJ9OIby3eikGlwLzP0+6HfYcxeIxxtgc13hNRaGfvZKfPssB9lsi0Rlx8i/rZhkR3VbBZl9f64Q4+rc/BuzyvjV03Ir6RSIpVHDtHlvvGejat640NADa8OLYZKdrVy/558C9MXgmS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(86362001)(38350700002)(38100700002)(66476007)(66556008)(4326008)(8936002)(66946007)(5660300002)(6486002)(8676002)(316002)(478600001)(186003)(1076003)(2616005)(83380400001)(41300700001)(2906002)(44832011)(4744005)(26005)(6512007)(6506007)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyoaGOJhgrKy0+/GOk+xc43sLTxtTnKzUPwGWh0gLJo4HtBlwahMok9YSpd5?=
 =?us-ascii?Q?25mcOl3LFwM5Hpz9A26KjwQIg19DEpHc5/E7biScV8q7KKrOUPXRuQxuhC/l?=
 =?us-ascii?Q?BvQQgu3Lwou8R2pqskXQphO7FG6CA2FqUw0SVPXOlc+OGLvkxAmh3pKJfm/a?=
 =?us-ascii?Q?KXjjIvbRWNTf/dBfESWZAyqikW9CSDbQi5JQGPwj4B65wJt2It7qoPSO/0Ps?=
 =?us-ascii?Q?yiLFt1FujUBXDrfcVXnO00i6bEkpFT8AlmCrpeetcUgQjmw+he7tundzolBH?=
 =?us-ascii?Q?zN3eUlNshCH1VNl6CTFs8hoH1Vdp9KJjMf9/IF1qEaWGcrx7TeMioMInywZC?=
 =?us-ascii?Q?vidp5DZq83WIHsT7AVAmmsx657zjJUR6msjsBCaD4jzmvz+179lu37ONVWGC?=
 =?us-ascii?Q?jIVLrojlsIgL82WTmXPw53AK5EggTeC3o7TPvH/F/XT0uo0kU6j5dAez3o7K?=
 =?us-ascii?Q?ErWB3X8VyiG2OG0cyJ83nIUfXn1UR2gRIUCLi3K6dEs/Y5ooMWX9mD2eETCY?=
 =?us-ascii?Q?hz3kwMVODADbL2U1cUpf/FxJuSydgBUudp+AvEB4MrD3tJZ46NQ35UJrUX2B?=
 =?us-ascii?Q?T5LryfUOUecolCkl1qL7b/I1tU4h2P8GdnEuv6oEYVI8mbq1NFw7T5pDQQmG?=
 =?us-ascii?Q?NgV8eavjwZlokoaXSA0Jq/CS4l7/I5YnQqqRwNnCFHk1eKDs7JFckmeU/nyy?=
 =?us-ascii?Q?k5pcaq0C8sbEpWHXfMsUjDrweNpZTb3bVf5m2RHO36k+Tg7rFzmfIj6TduTr?=
 =?us-ascii?Q?zUHKDqsBUb3jupSKBaMKh3S9wkVLn9Y8iyw4Fu1YfNmfVFdlp5W3tUo6PzGX?=
 =?us-ascii?Q?6Jom76ISjid2w07n5ec3Zd1H35lcrYRCKxNyZe4gMIV4ZEhj6UKrIvsTbXmW?=
 =?us-ascii?Q?wiFRuliULC3hkE1X9eYnb4x0s4y2d7PIVTc1DeXB7k10wkjJSbx0bUOV7ZDl?=
 =?us-ascii?Q?xXug92HSC+UvcXRFuXdWq5LIobNp/A3bD2JyzhC0vgT5PVVJd8/Hd/Lu9ToX?=
 =?us-ascii?Q?d/m3HvV+SXC7BoNTgw6qpRUN6IX+KBPE9f0NPnCbwoIgSI20x1LZ9HcE4goo?=
 =?us-ascii?Q?93sknCfdp9sNdVQi1A8DgKdBl+33MTC7ox0qneltMl2GBErxc+DYlttiCVlN?=
 =?us-ascii?Q?VpCj51/WLuf3TA8AxwrRpYJ8HmIb1+3jUc7oT8tIJhyORp5AUmnMHhODhNDt?=
 =?us-ascii?Q?fV7gw79J7qyr5yroXp8kpC11Jr30cagIHsqhdKJEj6NiuHVWiRkjxOBsEwzc?=
 =?us-ascii?Q?ddFhWIfRK6xxL76tyiSBRi5Nab2l/Fprx7w/sxT5SuZPc/jvc4pTfW0SGNcA?=
 =?us-ascii?Q?vlpQlcBDsDY03dRUOrlZlaU7SGpZp6I53DZ0chEmmsPnQ7ZPH05sLuGJKVTX?=
 =?us-ascii?Q?4QN89rJLuyERGIryp72lBaURM5edlu4wT2vLBgnbIuMhhOOk33OOTXYeu4A6?=
 =?us-ascii?Q?ENmrf6TDPGSPBgQRZ0bCY/2P6uB6L0vFbth9plclf6jwArkYiq1SJli+Aai/?=
 =?us-ascii?Q?DAJDTFeTodPUFpc4++bvMrE/MwcIX0+ZHF5oSUy9e+vM8QxAvysjUMLg491I?=
 =?us-ascii?Q?0UUIVMNzzjn1pMsokgJqfCoKrz0kgqJSBjt6nR7x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0482677e-6aa1-400e-1b71-08da74f37c3a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 01:57:14.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HachxyZKO3kqdxTSAbcVbTzUs8dqSO9D51igLdnK0xWjN3iono6IT6069/MYUuxl8/Gmpls+K3phK6jrLEuInQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When TX fifo has dirty data, user initialize the port and wait transmit
engine complete, it should disable the flow control, otherwise tx fifo
never be empty.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fc7d235a1e27..f0fccd2ff7ac 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2172,6 +2172,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
+	lpuart32_write(&sport->port, 0, UARTMODIR);
 	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	/* disable transmit and receive */
-- 
2.17.1

