Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A7D52489E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351863AbiELJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351862AbiELJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:10:34 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2172.outbound.protection.outlook.com [40.92.62.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532838E1A2;
        Thu, 12 May 2022 02:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQZVmhLWNv/FjQhzIXPOp5UFSVUXI1lj3M5/j9gzgQxAZsSPGTovuZFKnsYQ9wvUgtqj+zTSsPfVyZ/tZ7qBB1xfMkt+wBLX/xO6MRljSQsnfqRWG8JA15i+H0ie3Kc8aHovdGfkJBIPWNdRij6UoZ8JJAPLSmQEa69rIbbkbok22KgVMTFoZJm8QMtJ7LP3A6eIreDlttVThNPe5kdUG3kC0bdQszHKGSX7DJ9IRIrGcOeNFHOOG5oYZmop0jHS1TJXBdWXmWzxKOAxCtjAF475GHf4G0fxGlgFpbTMQRDUuRvhjNPH7HAip2VzoieDL7eXyLC20ODzuyuC47cjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTuCJP18nHfqeYgUKGf7KufJ4ztpCEhq/TXcnuTDP5s=;
 b=dS3s4gigX5PJ1jrR8Oww8SIUwkiWaC5NHTc0ZsbzwUx2mwV5brD+tnpylSlU1ZNxYr0yxIFpBNiWOGAl4Thy3ulNkcon5K+b3By4ALcDwoBmIir0n5H708RAX1kf1e9tVrvTMLRihwHQqMQRr5UAmI1lnnu6XACOhFWCkTh9OfCqYTQc0nZQYKAm4K+Wg+TxQFaslxgzpCsbn1nViuJ7mKVxkVMUKbzb0x3KCR4qsigAXeiO6N3ovGzYDUX+P0tFUSMcHqTeHkZ2RuR8QgbW+xNRIOH+7tnJb8Ovw1SDleo/3elaw7U0MmEpNTZYB33Ov7mznyFp7a9f03UIHzvLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTuCJP18nHfqeYgUKGf7KufJ4ztpCEhq/TXcnuTDP5s=;
 b=ssaky/r4LgU+ujcCNo8tEpzpGqZsAwNL+dE2xhCxFchN+TQC+GSl8psupAeZTKOvnuUQbI9SCCzA9BNfmJFRcJ3OuUSL8dhsrIT/gfvgPKaSNtSMXDEeasw58IHuaOm1fy4dy1mVC2rwfRTSsAS+qQy8jVQq9Qc8Qq3TOrUaqkQskgx1tLlaQEioXgFmB6+lPwgWNJcXj8eTTBW49ygt3nQQAgQ9q7NUgspcQTGZqSAzDU5G+4CIe88UXNPlk63DUrOKghUULRfK0H8yKG7r+m6zPrdifyRGdgn5sF80n2V4EtAD1jNFb6+slQH/H583ww6BnGgWDkWXPCD8cib76Q==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by MEAP282MB0583.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:65::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Thu, 12 May
 2022 09:10:28 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%6]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 09:10:28 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com,
        gregkh@linuxfoundation.org, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ylintan <yonglin.tan@outlook.com>
Subject: [PATCH]     bus: mhi: host: Add support for a new Quectel Module.
Date:   Thu, 12 May 2022 17:07:46 +0800
Message-ID: <MEYP282MB2374BF134896B003FD8BF826FDCB9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [hMnkSDSX2drB345a6wB4buGMqTV5dL1T]
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1652346466-16902-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0b35d9-5207-493a-64b1-08da33f74220
X-MS-Exchange-SLBlob-MailProps: 0RSV28T7LqTw98sKciW2l8XpStjyDTN8lXQUQIW6dh9a5RGd2BB5afhuIdpOem/WjOCQyYwtSamluRPx1nyaAIfzbdY4bxDlF99XjnYFCXBnSIshHcJGGj+GKjBrjzvLfdODrj44g+a7s7xLkJeRaJFBkdTue9Tjt/qwVOXYtmmKX3CxzPDXQP8vKSE78t0xj7ObKTbgOBin6b0x46+Y/4LhEgsFDRaZvC2RcHRpe4vjQHBnSwhRJ2uYWecI1Z+uVWSwNXV97akNwKZSLBDgB/TLoz9tZf8G6pUGTglzzNmMVeRh7kzP4hM17hKyckBn/WxGkU3AD5BAgtUceTi/git/R/wuoJqNwJHFB+ppTp6wlxJlim6SBukP2F5MUMBXG/3dqBucqRlTrLbmxeRksQeTCbKYQZpXLiACjwJrq484h34aTNva1ehnXHj8SOoyWm1JnE284sdjZNV9S+LPyxxpJQCYwAolNHhZ8e+ifApd93sv/wp0wbWbsXQ72n5sNN6rkP6iCTIXPG66F9iTubG8CMlIJVsJkAvRcpS6Ed0pRfESCx4iGF+2SiM8zb+cTTWYjSeuh0WsuFPc0Prsv+9Hx6TNPAa8vVqMf1UvoN5T9KFiYlUAn7kLxbsBCs9E33Q2QpbLbWJ+d8FWDOawX34p8uscVdNV9DQ4P9acPYNrKv1B4hbXzpmoGFhF49J9
X-MS-TrafficTypeDiagnostic: MEAP282MB0583:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6t+/12OZAjh1G7j4S77p/BdjfJ84VRefTRD2rr7LGIhko8pepIjD9ZAUCWJyQM8nNhQsr4U+R5S6D4Iwhd5wd49aa6+5KqlZtWCBH1AWK7ZtLZpo4Hn9Tp4P0gdogSb9w5NqrIIg6feNXAtIv8OdgVdl6j47HGIoyOAiUvi+EBlwSkFA8CknBWtXLL/wbhPlzYZHMKtuhueJMjF93yYck/3m4YODqyYUgitOXs+hQcUko1oS2cmyVz3ft5Zp7xPJI6Pa6IiEqvDju+s5tHG4MqTj3LKfpXzIutux9eQ75xp4DZ55CGeLKrpvTp5K6I3OK9wUMeWmImkXejhT4GvQJ9vYuhCEGh1vVP8vedB58rBRQzBzto43WySdAMSBV/AnCBGc98LkXVPWOp1Y594++pMfQN1xEKpxtPbumi5J1tzfxZPljnCHEJp01W/FWVph252V+CJdwpvjZdPLC/ur4frbO/BA41fAv1rHbmDkVtqmQ0/KRpfPJiROnU+MhGpJqo+pTluyUlUGdy9Cm8JP54Hc58Di0T32rFbpBe3j9iVh/yNTRvKRw4vMXR7OOM59UZ9XEzocXPmma9BJEgD7yg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V2q1dB4Yk9pLeaZKy7zDhzyV/P4blRkacuA7l0Vu6Xpjl5j8RxdbMTfrhahJ?=
 =?us-ascii?Q?yLZo9A1fp0nkXRXz4IvdAzVAWwltl4O+x53iH+jLKM2uTUwkpC3Bpn7lbRVF?=
 =?us-ascii?Q?n3PVQedHQueZoBBPU5/7ZfkyQkwMkdd/RZya/3WZuZEGj9pj+aZNA395j0Jq?=
 =?us-ascii?Q?amEpFcm7tQ+PAUCXcyj2Mt5M3fEgKk6S4Unf449hge9Kde3UylDalmYNsZcL?=
 =?us-ascii?Q?DitgJFyrb9ERgR+9sazcc+I3FYTpEUG5WD2qXtiCWcNJJgWj8AkGMoNHhSZM?=
 =?us-ascii?Q?0KOf4xuGwJlT19Fz0UAyzxD1muxOZ8RoRBlVtV5d00vVWeUr3sXFzXliNIB+?=
 =?us-ascii?Q?Inyep+NKm16Atpr6XsAcF/dHiucUye6kh+FW17u6b0gSa6zKbtZWFilow5Sp?=
 =?us-ascii?Q?lplRhXPgZPpt6iuIzA3SIK7DUbCX4G/z1W+KejpUHb1MpqpnNwxXtbxrNQfR?=
 =?us-ascii?Q?eEogyjhDbfgccfix7v9Q+2gLL/4fZalrUuyJENJlVDJMNruFZsZPiHx1plYM?=
 =?us-ascii?Q?BstAINwoBf4fy9MG+Q+uPfhr154y5vsJ88zGGIrHdLeFfKsGoeOVeo97RxOL?=
 =?us-ascii?Q?8pLhJCi4Q9XqvVZs90z7MtJogEvQDB3wAvH68pSpNx2dmsT4lkIO1rHNSzr8?=
 =?us-ascii?Q?l706APiiUDRIWUuD7DQ0OzxVvX90htLaeiPJQfW/ng76NsXEznnIVA+XK53F?=
 =?us-ascii?Q?bASdwpCoXsz1s4dh9pwN6rZ8hX2mYV+9ogDnoMHMqIUF4XYeRC4wz/H2LcxC?=
 =?us-ascii?Q?tV1MpAa4GMK+7POJGb30BW78gSTVdKTkQf5sWpRzpopCK8A1P9gCW6uV+NTs?=
 =?us-ascii?Q?9IqNu9xm5qmI88rl7lq8QM6HSm9jBHbeZm5JhdPo2GqTuZ8xXlc0PTphODce?=
 =?us-ascii?Q?AFzbQ1tAR8d0DQcewgqxmcB0fLhI56umBaQYz8G2jWDNDeBRV3561Gpu9jEg?=
 =?us-ascii?Q?C3m5ymAE+cGkpjMv0lKo/pvYf+h4xjRgAyT4K/gvlpYwPmXKQqy5H3CITRbe?=
 =?us-ascii?Q?VsG4dPRAcO78VhnGPG2A76ohb6IsA6a4DqBt0BIEH2s68pICKoZJsp8qx3P/?=
 =?us-ascii?Q?QyAzVif6DSmPweWepmfRmKE8FKnjrSRqF0t4B2vGPoy5/4DXfewQnv3TxDDR?=
 =?us-ascii?Q?LP6C0nNWfXR5hG3yHEFmWdIbCTrDBoabp1G7zaVB+hDrgBfyHIGMJtzN9fFf?=
 =?us-ascii?Q?b/Ls6AeWbq5iLvi+zqWoR9mTf82MLmsexF/0yXTjGih/9S2V1B1azKAhwguF?=
 =?us-ascii?Q?K1vkVh4+owqpIIsEVYt2Zdg32rTYakxWgx59V//8mqgAmi5kQjV5A/ImISb/?=
 =?us-ascii?Q?wD+xwn1Jy9puCJGI3SufDMUhAu/I/FzXJldW0gkD3iTEm//9F7BjzyWhe87U?=
 =?us-ascii?Q?xDKuRsakCm3KdOuaiHXqiZ6bZ9KSP/bQMlAN0ViUI7HuhAlFNQwQ8cb6GWV+?=
 =?us-ascii?Q?bKR2I2SeKqo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0b35d9-5207-493a-64b1-08da33f74220
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 09:10:28.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ylintan <yonglin.tan@outlook.com>

    A new Quectel EM1xx module need to be supported by kernel.
    The module is based on Qualcomm SDX24 platform and the
    configuration should be aligned with EM120 and EM160.

    Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>

Signed-off-by: ylintan <yonglin.tan@outlook.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 8416267..0a6469c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
+	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
+		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-- 
2.7.4

