Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10ED4AECE5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiBIIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:41:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbiBIIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:40:48 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D74C003677;
        Wed,  9 Feb 2022 00:40:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPlM/EnkZM9PZlrOz5f7iDPr486fP/Y+/t03F0FUJXyOdUoffQQT9ASIbLzt7YLCjYTd/2/woXVSxRgi9uKu5bkl48IzfW15IqcT9stLST7kQSnXif8aSKy6ZJlNM0NuiFBv/b8XbZ5RCKZFa/5ituAM6xuODXqME1+cpTj2lGSxWjgxtWd16OipMs6M3XYDhxgHvbPrp1NNxCiRcDfbr7rWU1NKUDy6Qa54pMNMhtNECi5TdcGb5c7ftewG3fx/rS8Jw54P8Rwp24W9W3qZ/jacCfksbGTzHj2dTwwkZD1kdGaHE+Z7NwPlZlh5aOVS+vfBp1OwWsETgl8UDrhkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXpQwRkS7N/YG+Hb77PMQpOy4aiDE5ZqElAGXXe0VYI=;
 b=HiBpJmodp9nnLBSS7R4uo067uGFsbs4Qx0zFAnLiGJfkSvIAvFvtWRcWo4mZS6vGpb1LCH4u9qoqvX4qNd3cUFjRLtdgbD5u9IFaMddu4RwIpzZ891ubGLADq2i7CATPNZDuZezQikPCMR5JbwvueZvwoVKmXrGBkEgBoWrug7NdLM+qVfiVkW+9RBUYan8JAQqFdDo+Vb2wBMT+tXEFnOt2OZfJVhq4kbNBuuotJTIjIWdaJXqljX3jRv4uQ5XZaByuH5vzd20EQkxkLIHRDxdPFMQlnZTRxXAp/+umn3ZGeraSDAfcTUEQ97IlmKSOfYSCWQhcdeMPDIQIqYJn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXpQwRkS7N/YG+Hb77PMQpOy4aiDE5ZqElAGXXe0VYI=;
 b=H6nOj9gZCEIeOU3efg3bFL9Z+iR3I/C/g1i130CAX6lkTZUHvUKPj+c554JfrXuediq/bwywUrfeRfaW3i0UJ4xG/v3ljxwUrpWPXo85tbmPWUiplZV5uaZtQLbU8tOS4dGn7U6TpAWfhj4T7HeNVSGgTY3cg5F3Fg9Hp151hLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4387.apcprd06.prod.outlook.com (2603:1096:820:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 08:40:05 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:40:05 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] pwm: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:39:58 -0800
Message-Id: <1644395998-4397-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97fd855a-4559-4c01-b6fa-08d9eba7c512
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4387:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4387C226B7D85DB6222C98ADBD2E9@KL1PR0601MB4387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqMyuBdVyL+85T2qX9kH3mwsr2GDBCS+0xIm4kHot954amqqPMYAIskpIvZpi9JFzbWB5SvXf5GVvOLb7Ynqb5QEGVS2G1dEzAo2O8MdOJ5v3ALLkTfpL0WA1k2DlyD/aafu+Cm6bDnuz1bPxeRgwaFO3AJiHEvCfprLb6QliQYddsjSfmoWbF4zRx8SdKvTqGbnoY6Em1uS+ibY6IrXCMKNU1M920AXdPRPkVbRZcUJqss9vuc6RLDTPABeg9cfFq9NeHjtqhUdcyv+SS21QMCK23DH+Q7hEJK1FOSdcbtuKPykE7gYlZ9MQihawbaJMfYuhh8nI25a2GXmEkKzb0nEaK+nEi4gPM5NBX+cVofHOWfn4/7RXMHVjPnF+qvN+S5OCi1Sr4fUJYEeJLF186ZtKJmA5ZIOVyM7VnlpNskLkTF4EG9LTzYDMGv23SALDIDXb/eBD2trwe7hhi4QqjZe+HjMfJHwRC9qXMXEN3Ylmd9aEYzMR9BI8RONmxNUcK2JBKH7oWcZ36jf2WAM07d330yv1K9Mfkok8pjuNlMZL+mhkQPkqaf7yHABRgcEng5IthP4IXeF1o020EFbJ91Pj9PtIfLk35LW/i1N7qprbgY54uaj9Os9zxVnyM+rIbrFhzWW/QbgLz1me0X3ziSZgLdTFTWcrr5EeyZK19HHTcz4FArFOwk4CPJgkWzIh+K9OtfxJN9O8eYyUpVU+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4326008)(110136005)(6486002)(66946007)(66476007)(66556008)(8676002)(86362001)(38100700002)(38350700002)(8936002)(2616005)(2906002)(107886003)(36756003)(6506007)(52116002)(5660300002)(6512007)(83380400001)(26005)(4744005)(508600001)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzMaF4fK+XMLq3hRqzZPZE23MDd/2x5Qd7MalRQ6CnG+7UiJRAE6qfFx173c?=
 =?us-ascii?Q?/uMSHDB15eoyfq6FGtH3qbWUUj6GpzXy/dbIai4J3u9zWnbh1OeBdMV58ejj?=
 =?us-ascii?Q?7jqCmx8061var7E20J2L6+R83bCq2++rJWe8UvDMFhvlb4SbpPylMbHFisjW?=
 =?us-ascii?Q?f+5cPnkob/OS17UYvsFtpyp88PIR0E+CUR6mT8YcHU5BSyYIY8hlgktcC7eN?=
 =?us-ascii?Q?JwF0WZUeYSaXPwDT27vLK12oFfJmbprWSbZY5VenWz/2oJXQZjuEwIFf8xBj?=
 =?us-ascii?Q?6kdjOF54J4UrTH5D3mNUNhND71mNOfQPeT4fqyvnW7u1QV/1aYDw+I+Z6Edb?=
 =?us-ascii?Q?YgmkTJqHn1a6yD2ohzhyQQVUohg9Flg/Z+wuEQR9PBjQy/WzwcTWnbM/TPJo?=
 =?us-ascii?Q?2qqyHnw7XROsfsyIzVhdw7fMRzxXttjdfBIcCrMmOxJW0aMGHzTHoqOsmhen?=
 =?us-ascii?Q?ihKeNYJChh4b7adXaOGdkWHJfgK/bSXvkm9MPO1jvxcLUY7gjuBCrd4asB2V?=
 =?us-ascii?Q?PQ6Oba1ufdZTs8yn2ZFZ/KTBjnWShgJPxjxbBHAb7Vi8TqvdpvIJI6lqiA+2?=
 =?us-ascii?Q?l2ZDDwryC54W3L6i7QYRPvOvZRSb13qnV1ja0A7zVmq5V2eAdHF2pfvmXiaQ?=
 =?us-ascii?Q?VrduR/InHPqVgZ74TPXuvm+bXmAGnWZdvTLQgU1y8ZMaOTFYLTu2iuLsR2nW?=
 =?us-ascii?Q?YEN5RNzGr4HfT1e3jRvcWnshs36uos6uJQZsQGj+RxAjMB0Uzw7Rp2qdt6YU?=
 =?us-ascii?Q?qGJuSydnKvJuzce1KnSzxNsRbi7fd3b5hB0ia+2V+F6NB/ngEXRXq2M97o71?=
 =?us-ascii?Q?+OEMUSwpnr/naZzK0KaN87njarWeTI8Zvy7kB/JMWAqhXVBrohdmeABFx7iy?=
 =?us-ascii?Q?MdKPcn2fHLp0o8Ofb1O9DluQgXfE+bn1oaKnVDWZqD1EmKu8BEW0EWgptJKf?=
 =?us-ascii?Q?KQPu9ptW6pTTAf/0WEfJ7ccu03hsrNVlyAVjvKqYkkRHK8Sn9LY1khFnriM2?=
 =?us-ascii?Q?Khf87dIW2uGmh1KjFdQ2YQkb7voZQDi90aV8fSCbzrhGGU9yP4sSM5e4s4gG?=
 =?us-ascii?Q?zeJZL+E178OK0LNpjWYH6qHLvXPtK+yolpqkGBQUoCUnMaNANPqFqNjs6Nc1?=
 =?us-ascii?Q?lKVLHRUVh/doeDGcHuIMQlOUDwrw8Lvd7mMKJg+O+k748WTMfrcIGAyRikLE?=
 =?us-ascii?Q?sSzZapixLR2WeIxoE1QcafAhmqAA/e1DZlPlDKEwhk2OupZxr29Rb3/jNvkq?=
 =?us-ascii?Q?s6oIJ9iYo5ZJqeehXHfzknk4JDeZi/uU+3UK4frTYImoRjkjpodDNPY8zwXc?=
 =?us-ascii?Q?VOVDi631t1nFy1ZTP1KYgg0Cw8WzHgWwrnjg6gDmTI5CdyQy1yoe2yM+muR2?=
 =?us-ascii?Q?vlyVhn5ZCSTDRt2PlLj+oGgMwyRFhxIYbUw7dASDghabE00f3VlOO9jQ78Md?=
 =?us-ascii?Q?zmeRdoSr0QfqLUcbBBk7ERbFBibHuFnIve02ik4wqIOPnHW0nwxxE7KlhZ1s?=
 =?us-ascii?Q?7u/fUGYU5L4zp60cdnUuUefzgdzWU2T+z6SAb7n9JFAOtZDQS8ijcjHEYE4p?=
 =?us-ascii?Q?UFFdDeqa37uoHEXfj+QcyHNo1FUu3pKwTfIRgTgHevsrWfl0sAzJnsmN2Sux?=
 =?us-ascii?Q?affyzC+qgoGKS+acDq/Qtio=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fd855a-4559-4c01-b6fa-08d9eba7c512
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:40:04.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K01pyWttu94RtQwAwwZykmc7r2NCYhUJz+98eIKMqWrA054Ntd+J5zfSgCppsgwUkUqkRx+QZRnGkwTqbWXUrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4387
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/pwm/pwm-berlin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index e157273..15b10cb3
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -109,7 +109,7 @@ static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	period = cycles;
 	cycles *= duty_ns;
-	do_div(cycles, period_ns);
+	div64_u64(cycles, period_ns);
 	duty = cycles;
 
 	value = berlin_pwm_readl(bpc, pwm->hwpwm, BERLIN_PWM_CONTROL);
-- 
2.7.4

