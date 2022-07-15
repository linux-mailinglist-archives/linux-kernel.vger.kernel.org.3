Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF95759C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiGODBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbiGODB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:01:26 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DCB4F65E;
        Thu, 14 Jul 2022 20:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Zkt0TouS+z3axqgDFYDmJuCvc3ZHbHrrsVjORTRqacQmUi8ARukfSUBB0n/tIWmU9DMcx2x/c4tofGvmIEUEZPRmUtGLRN0htFue0fOKpwjaocrGYI93kJgnXmKnunfk8VNlqr/qzzP+UF1WXAxS2Eg33pcKjTjbd92wymFhFyMM5H/mK3Y554pa+8x2ajDfkHwy+Y62QFXZL2IIfiTpunzmvGR4RRBZJdtvM6Wsf00OqiNPNiNWhdqD2SSV4tD6IdGEQ5sGuA/8qkW5HdIyHlVOW1XXL0K1sJQG8n+iETBJNvHATJvX5awOFx2TqQlDcqSVxyJCTDnQwpAP4hJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAOkKDKrJ43+UWkV4T6XpVVbClR7ruNCx4AvwAtxs7Y=;
 b=P1X4BtyCOYAwoklTK78niPgFAcdq7JM44Wgw0GRQncukP8W66x+spFTDeoWt6vi3ZqHpPzhtxZljJANGmSc1lxipMjIYBhP15uA9jtJGQrMxdHtsKWIeHl2SLi355UqngaTTZBP6Vw0mzcDrFOHflptNWQq0XlwESh+pZBCgQHUHDZQsZKb53gwcFpi1kqbIt4953ofMDLtxgQlNc56AvXzYb2ee2ACapuEFK8mKrBBDIcM7s4dh3kMYdG2bvFOaai5QOqUpSw9/dXKvysJ49UHUd6DLbEbFIEkkvxatZLf848he7BK2sUwxHBazTuUkEAKjFDatvaueY01tCY9Ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAOkKDKrJ43+UWkV4T6XpVVbClR7ruNCx4AvwAtxs7Y=;
 b=Q27RM9LLnTZmMdV8FwVjj/s7Uv0H6bkV5x5/9vdIo9SAd1tjgQuSq9W3gzmf4cFsgJiBLtXtNYS3gXmIZsffKRx62b1K70Mz14rAURJA60tsZuI8rrjBL5DjI1MrvOwWBOP5nZMtL871tHMsKFQVdMgItIUtJlfK3YhcB02aMVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 03:01:22 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826%5]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 03:01:22 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, michael@walle.cc
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to trigger a break character
Date:   Fri, 15 Jul 2022 10:59:44 +0800
Message-Id: <20220715025944.11076-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220715025944.11076-1-sherry.sun@nxp.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74d5c18a-27a5-4f19-566f-08da660e4c51
X-MS-TrafficTypeDiagnostic: VE1PR04MB6477:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7J44oENv+yTlcPhHfD0B2Fg5Lt0WxJydtCvMwZ4zLUi0rzaqG4KVXsIkCFQxsWgAFXv2qFgU/pZdEOu+VAX46Es5FKItGVwpS0eGIYlUAdGWZlfozoCyAUQ7EeHDPZ/uCUqx1WnAOm3a2/Xcbh+wyuCronQbSuCLmWeYSlupqbQS+mj+KXYcjBiiZRFFwJPhHErhTzdwdpR5bUIUplgRlKVBOZJ04WwItG6tletACRLVCjXl9RW7J81DDl4oZ85vgaSwtXZP91mDy0sfE6lJsJraAyONWDHybgRws2ku9gRH432XehK+nR/CfKpnmGKU5jH/qMjKMCY5CSITnwYJtoH8mMcnGb8zR49ylAPL9LAMplHoLqSGtPneeroDqvnAUrE5BzvLwLLBxP010tlDciFvXlCPi7CtMGhC+o128NPSGfFaAfZGFEuiYuZom+cVBBSQFo4D0kxDVer2USJzA3GUoHcsub2QImZHZifO3YaLNz26I5yj3TPDJshOpJHvDnewfof6eWjpJK+EQiJnxaGhCF7O9XqoQpUx/E+dpLvlmtYFuWlXwRiYwoWPcrj9SSbJCNGOf58O1wcM6Ztat9EkJz3DGafDZgPKfxBbOHo2KgAvB7QMg6xyeKZhs2H7iW8eZwmuGnT7G6FiQbU4FhGGh4mjGWA74WeXks2oDSlrfzKJ7a2CrHpH0Pg7YoySFMK6ulYg7XWz+W4ynnscMHkW1Ey7GOqmI4SdLlgVY4BOfe9Zx0/Ubp7CdKri3ZVvQpIGiOURREytD3wq/wDTJFC7y76gugX4ovU7qDQcahMm8MyhsT/jjX1lid/4Ajx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(8676002)(66946007)(66556008)(4326008)(26005)(5660300002)(38100700002)(83380400001)(1076003)(38350700002)(2906002)(2616005)(41300700001)(66476007)(6666004)(186003)(316002)(36756003)(52116002)(44832011)(6512007)(478600001)(8936002)(6486002)(86362001)(6506007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZdkulLaGLTuVyukhULiCkG9M5nQu/R8Z4FE8/CGf9L+A4xUT8f0r4QJQ3x0?=
 =?us-ascii?Q?H0RqEhoa+Rd+xkYzCIs8bK7BmN1g6rF+FkA64fPce6AnKIPV0SOCD9ytO6Tx?=
 =?us-ascii?Q?dioa7cFToIqCIcHFFDCxti6Hlk5IQ6nKqSRRhIi9mbg6v8fc7f0XVTmocI+b?=
 =?us-ascii?Q?2Rl8pRcwwko+9Gg20jDTlx1F6WXcX6tJsPZX9cXIFTmgiktz7XKXcAI4uAAi?=
 =?us-ascii?Q?naDBMY3DFyNZKtjvapk1PilmFd6HHD0K+ziedj4FrpgKpjw9YX5iIOfvP4c4?=
 =?us-ascii?Q?WDJYJYHhMbfMAgDBgoeEJwN+J2p0zeQYAwXeKMMdN3Q0oyYFH6h/7FEA2yYN?=
 =?us-ascii?Q?wpY4YgWYLCjmMlRzDEZyd1bLZ1dW/NNfo5je9/4hkK8WtZrOcJfhT9Wv7UOy?=
 =?us-ascii?Q?god7oaPuchnimLflsBdkIBfIHC5wOTCW29rCSBYEdgh9KHwsqINwi+ajdeL4?=
 =?us-ascii?Q?2jD40qveXIoFfxcSU+1yUeIRTx8XAORtt0Udn9FKGaV4nl3tcwLmpwQTkrU0?=
 =?us-ascii?Q?dFrefHT7ASpPvcflYavVArheJHPzyZAVlWELWaeVNAmggOIG8hYFaUZx6Pz8?=
 =?us-ascii?Q?lQYhWd8//hTmRkHrcxP1pUkD8rnappSKiRL5C0Yi/7Y5aM7X9VWzotZ28Ps3?=
 =?us-ascii?Q?Phz5gpsgIxkS/V+ILaCvxsBJHByB6nBcfzyid5vUS2ZseIYecgRjz1EzF7FR?=
 =?us-ascii?Q?oGC9lBcjoRS2SVYfF6TuOzZnSkLp7N3fgNbJOFRFMXu7rUu0D9bwK5Wn5rdF?=
 =?us-ascii?Q?gpZ90LmBeusaHErm1eDWooE4rNghGAS1NXE0cDRH3X49MepcpY0DQlFq8Uy8?=
 =?us-ascii?Q?FKBsKw7VC3NqxT9k5NBr3D+hrZ4wMzIGGx1GsPXJdT67AR9qZrQjWnn+2K5C?=
 =?us-ascii?Q?wABqQK+xZp5IsVuSJ3dWm27RIiaRaaAOXoJWRr0SjWa62h+cB8AUMovN29K9?=
 =?us-ascii?Q?RYHLMyue1jyCXmxEB91tch+taxBOFCqOrne/gOrTsWRXX69Jhys5kQWK60jm?=
 =?us-ascii?Q?FgwMJfqYSbz6784lZhk5cADplxVwpMPLVy47q09ljVhf/6LQWCibd6mdHboq?=
 =?us-ascii?Q?c6XhXN2suIETgiBaglC3QTszuokTUo3+0K94CRi+3hByeL5FDYFgwi5jbyp4?=
 =?us-ascii?Q?GeuaErLkr7yEotUANSgKafzS4RiPeAYh4hrL5Kmk5Y9QKHj19b+1Qd2HwQnI?=
 =?us-ascii?Q?AKKA3fk/rmqQIXVIKoMsHk83tBxF1EHSLoQD3rFhdzR9v98MjXUlFKgvniTL?=
 =?us-ascii?Q?f07qn9/BZThNmgtm3f87ntptTpzven8IpnVSgzdOSuoq24eyNppiTu3ROnTd?=
 =?us-ascii?Q?A+WAS4kckeoSC9dtBNACuCNOexSVfD62SHzoVG0vvrjOLx/XkfCUc5egN0/J?=
 =?us-ascii?Q?y+37mjLN9mqho+gUFXe4hSvGvFbbveQ4S7SrWUwQ3ArY3Is1+xF/+IEw8N0R?=
 =?us-ascii?Q?xNObS0S9y3vspmdGZ6uouem5PlLMzVrtv+6TfhYZCDJhCIuqGy489ViNQ9bL?=
 =?us-ascii?Q?MnO9ue4zzsShqZWg9XL/E+RI1hh6oacVMdOZGrwKNwDuIgJcHSUwQIr+9fpl?=
 =?us-ascii?Q?vE5kU57hAiE9UX1pmxqFx9kGZAoIlaSkGmngDefy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d5c18a-27a5-4f19-566f-08da660e4c51
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 03:01:22.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAx8MqOqX+o92VkI1Rj1LiHnRwm48RReYhgqJ8vFl2y9iVEtC6zuVrLFwob26diuUgm+b8VtEnS9LwUQBgVuiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the lpuart reference manual, need to writing a 1 and then a
0 to the UARTCTRL_SBK field queues a break character in the transmit
data stream. Only writing a 1 cannot trigger the break character, so fix
it.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b6365566a460..8a4aae7dbd99 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1486,7 +1486,7 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 	temp = lpuart32_read(port, UARTCTRL) & ~UARTCTRL_SBK;
 
 	if (break_state != 0)
-		temp |= UARTCTRL_SBK;
+		lpuart32_write(port, temp | UARTCTRL_SBK, UARTCTRL);
 
 	lpuart32_write(port, temp, UARTCTRL);
 }
-- 
2.17.1

