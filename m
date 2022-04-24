Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D050D0B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiDXJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiDXJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:01:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A79431357;
        Sun, 24 Apr 2022 01:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XytdcyrQ3tcd30DK86/9cvRXU4mTa05/uPjmmUAzmymWhseWSzOTgEcblTt1R/iJLI1PACAXEn6w57R1hNLAeBjXwo9krxJCc30Wh7rbCWJZJCCg98/rP5nz2g63L5ZXAOkhmabqloglqf20gwDr/AdIXBF1jxnwK2J/CA+62o0duBsTwlC3gO639dzVMoEI1RP5qXl9kJ+cwCmuwBCIx5j2e2JGPw6+bGjnULsB/H63g5xWSvLw7o8DhssZtGBwnoyuRDZBDVujNKjMGTajXVaG0abrnMRqZ6wLtXAGILkr8bZImrh+lH57QiHFHWlNCbwmlLAHirPGO0V3TdemrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRebm0i+MeP2leMsrNHZBOD8KWLFz8zg3eyjXv0OGNA=;
 b=CF7aTfY9t/RAg5LBM+ZRObdwP2KaD/6q9htIyJqv1RdPe2yqJe/2x8MMQwbRwsmIlAUG6Jgt1mbJQbtcyQU7SHKtDS3TbjmvF/WgPuA18as+QtsSI0dVvQoeNu2Wc6BU/GnxIIMrHUxMbSWAOMa0YYEQLK/kUR6so9OF6Wr+SP5FJpDuhd+SeIiJD0g+oezHlVQka3ORyOmFr2y0tpx739Uy/XMDFC73VrTQUecuVnJpBLlbiui93KT9uoS9gDvghvUFrFJ3yXh0zsFnL0Y0BB+jFuFfDghmePenAPVVmOC9JnEWDQ6te8hwXxfm4IsJ+TXwyanc3QDhNGZCHhoaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRebm0i+MeP2leMsrNHZBOD8KWLFz8zg3eyjXv0OGNA=;
 b=g5YFbaJ/j4COm8nu/PiqY++RxL9O9UaR7YNSxAgDWiQwgG8RfCEIOPjGzuHWGM8G8adLkwDdu8MW0xI5exPp2UV4pbpFbF8hnpI31IxmRqCU++8XfHcnquOP/q35vwbreTtNkkxcNCjhqhVUTyIfHIQm9KJSTLUENmWSZwh6OXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2468.apcprd06.prod.outlook.com (2603:1096:203:6b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Sun, 24 Apr 2022 08:58:39 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.019; Sun, 24 Apr 2022
 08:58:38 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] HID: wacom: simplify if-if to if-else
Date:   Sun, 24 Apr 2022 16:58:26 +0800
Message-Id: <20220424085826.96447-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ed61d27-7434-4f3f-476e-08da25d09ec9
X-MS-TrafficTypeDiagnostic: HK0PR06MB2468:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2468E99F784217544C062287ABF99@HK0PR06MB2468.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FsnqLcIB1Q0JqoMxQvD2KdFhzxBCLPz6aGJVN7j91Wii7lJa5XTFx2+qGPvCA+GzOtoINTS0y2dACwBiTZwIMWdahRLTnNOg5rP4BVMdwsuH+jLjnN4Ls/s3lt81YymgFvCE5Jx3rRUdclyUrY2AxEjvAbdW/T/N9g0EpS+TtNkoJ+2fu/+lKJbi5pzhvwM3ILxxfXnO1vvyFuvhO7GRlnmTT4TpI9+fkD0WP5vpvC3sd1e+6lhwEAICxiRY5SANMkq3O+aaqUEfoOUhX2ZVunSDix81st5hEee8GQz02XntjS1I7vvS1gKdOcd2fNb5Dn4307BrxqrRGeAzA/6kOFinhQf9109ZqS9d1ahB3ux0C/Kl/MrvEN6lVONK7ahOfzI/5HpBVVJXMmL5BhaHlakadleZDcQK/ZXD/0jgFql+pXVMWnrnf69QpcKTdq+kzf3IxT+Dbrt+sQ2uES1NxFl5ASWTqpgawZgw70ounKAbjjZ51XoVKqbzy0qT6BsJuGwskoR11T0tOrYTSY3QAhWHEE5ZFohkyJkqH+IHUnWuOchy5d6ez6uF+g/Efm2C7vUYtzH9ZaMh8PR14vpKncyzgewjB5xf6lNVEy2a5wLw996Hlu31H/sBdNErmiVAY4X3exrvN8fDg6zvLN5in0RPq5Jc+qKvEKE/UEGIr6E7fE7IvMtRZKMe7+wxrZ/+fVjcr9oEsqzCak4MRmhJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(107886003)(2616005)(36756003)(38350700002)(38100700002)(1076003)(66556008)(316002)(6666004)(52116002)(66946007)(66476007)(8676002)(4326008)(8936002)(5660300002)(186003)(110136005)(86362001)(83380400001)(6486002)(508600001)(6506007)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xzUFD5tyWrtJkM/J1RXMV7EpORUrGNZqpZHJ6GP8XUOpRr7ltgkvMZAb2J4?=
 =?us-ascii?Q?gLKRy2TuDxQF3/vnuSNwyBPb8FlcGqBIPXEg8xRjMBLKeI32R5etRAkpfGUp?=
 =?us-ascii?Q?1VqMremcJBIY7f/Lc3ktdEyAh9iEyT4AQQIRyPgg3KPPCQ0oj73W7BZAldof?=
 =?us-ascii?Q?Yf6LNSJizr1ZuWd7w0M0J0DboEffaWUUoODy9AA8Owetlm1RUtrFDBxzluXi?=
 =?us-ascii?Q?q/UgB8Wlvl2HqCPz9cssgwxxoYxOutzgoXtpuEGtGrm7m0o+sgUyNolF+W2N?=
 =?us-ascii?Q?eORO686mxRZWTTlUdarBg14PfzvkbhM9rOTvpZf+k1vwbfgffHMxFb3gMkzC?=
 =?us-ascii?Q?Vt5X7RCqtLltNIGTNwH4jYuDiJe5b3ZPY49vohOHHmvpcmtaSFQHi6dVeRKO?=
 =?us-ascii?Q?Sffz044aXiOGO3GuoE/wSKo+AcVejzxapfeQSI4cdayg8HRyvy4LR1clsr8x?=
 =?us-ascii?Q?tqZ2VWBvpP21pRC0gDaMnwgFYWZGibz9LqwG/tHDb3t/SuJ5CCD0AoPKXp26?=
 =?us-ascii?Q?toBYNB0oLVJuVGD4bryOAAaZamzPlWGtEqj8BhaI6Kx7MaIcEcIDkDSvvC8A?=
 =?us-ascii?Q?JTvzn9Q5lJxZI9Cy562okZSJYceIWv/UG3SrpkycZ9LrRz0m5knqEhbTgzek?=
 =?us-ascii?Q?a13noIOIpux9qdRRrZlw4kKH6jZHajAuiahbYYQqZ4gwR+pj59QfgBBP1ddT?=
 =?us-ascii?Q?gdUKr9RomNgB+O5ixpO055PPS70vEYh9rIsVdZZSTlJ/3HJL1nSDDqo7wYX4?=
 =?us-ascii?Q?3hQYfNQFxHIrjuJMrfuM3zCWF9j9qf4iYptoxyEmqFvRJYvZO3wF3W3aXE8r?=
 =?us-ascii?Q?KRBsjEjgN/Is9T1+VL00JSKLkDkkJkdJoT+v2E+zyCudyHgZ6XFz121aKQmc?=
 =?us-ascii?Q?pA9MXZx8eTShNzKrzAUwa4T9n25USJPi7/7//1Z86xRqkyMy81DjVP6bJ7Sp?=
 =?us-ascii?Q?e1lStDCaRnOTuslRvB66ibLi9lUEpwEK7bNcNQ9FPeQmfNqCvCmH2EK61LIj?=
 =?us-ascii?Q?veb7NhAwq5DJZmQU6rcxDEiiE/HpHtVKzHiPKvuCBS28opgE0xCtHo0wR1Uh?=
 =?us-ascii?Q?BU+YoR2VCLFmoGR1hs4MB0iNPfz25DwS2mawj+aMVMGcgAPMFNxERETAK+wt?=
 =?us-ascii?Q?m1pQyJ0DBcbiVId78V87WGuu0graWIU/1n6iNOxiTIEybxXjSN9rKaJLoIGv?=
 =?us-ascii?Q?cOjpFlLdQSyBwNcK+MWJgI78xJUcBwSiL8IKTOwzGjxA3fvmcux8LCAiLwi2?=
 =?us-ascii?Q?5LPdvPER0K2ffrlAownsjNWkGs8TtUzMjDXErZuRbh8Q6q/c5K3WVxMqPPEh?=
 =?us-ascii?Q?QRhDbc+C2qvWRmVxUqbeE/qIZy//ot+N5TB7XE+MnExLAQLrQr1OAW/MQbRT?=
 =?us-ascii?Q?QhaorlxGTiBGUHiqUeGpDo1q1NLGoz8yX1uQa+h4P/n9F4EaRCtr6tscJKjV?=
 =?us-ascii?Q?jam+sBDsHZkzisG9jG2wGQjvwC9eqQ4IWLsjgdU9LFRrjURwEd2K/r//gWVp?=
 =?us-ascii?Q?uDACh6zxeIo+cvSHG7T6IJohEdakA8AC5QCmRvD+GoIw1MxXSyiKwEf4jfdL?=
 =?us-ascii?Q?zVkSepp4mqTzjssAKZgMqazzTOgOk4SjvLjnmc7RUIVZKQfqoQHoFeU3OThT?=
 =?us-ascii?Q?V6SPzUYb5M6ypFIep7f9LdGiZ4+lKLV/9V9fChApHisntM6Ow5OStpymyWPC?=
 =?us-ascii?Q?jAdprIE6cfjhtNXy8OGx00AgECvlJr8p4aWT85r7wjGL4gw72sgIjavbXBsm?=
 =?us-ascii?Q?HYU9JDRCuA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed61d27-7434-4f3f-476e-08da25d09ec9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 08:58:37.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOagXtC7sy0if8TG76+iu/JmbR3FNa8LYOrrPFeE7wOYS/9fkpuU7OUkEwfS0sR8O3FBr345ONUD2u5LuPbKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2468
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if and else instead of if(A) and if (!A).

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/hid/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 64fe573deb9b..886e87f1c8bb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -181,10 +181,10 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 		input_report_key(input, BTN_STYLUS, data[4] & 0x10);
 		/* Only allow the stylus2 button to be reported for the pen tool. */
 		input_report_key(input, BTN_STYLUS2, (wacom->tool[0] == BTN_TOOL_PEN) && (data[4] & 0x20));
+	} else {
+		wacom->id[0] = 0;
 	}
 
-	if (!prox)
-		wacom->id[0] = 0;
 	input_report_key(input, wacom->tool[0], prox);
 	input_report_abs(input, ABS_MISC, wacom->id[0]);
 	return 1;
-- 
2.35.1

