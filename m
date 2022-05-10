Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36016520F59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiEJIG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiEJIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:05:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA945AD0;
        Tue, 10 May 2022 01:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXRHbx3Cz94xtR4eYXrvEF0pPgG0Ogz4EOBhWqKY5PsCqQ9/mDks/IlToWrKthImDio9LHvbTxDA6B0aj9Xk/BP/j6DzkZhQqto2jzS1uuO3fMR5ONdec9Axqh6ZWTSrPBoQAyRZys3K3pOyU4YZQAt2C/YOopOAxhWYAeSM0+4mlKt1ATG3/HBIeqnsATvO6sXbXTLchRflJ3fIS3zC75VUU1Ju7pL6QYI3m1dQBu7AHBRz1awglzBXZtpQFb0Qyws2OO6z6SsXQxb2pK1LpiH7KrHy4DqPb8XHrczd3DcvNYwlpmlucIRhm3imJ5f8JEU0bbQGWL+JlK1r7OXexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDpR4Lqvq6uTXaRLhcnUUbqrxKArsMvZ7+0iTtL1k9U=;
 b=U+x4i6TdIv/IxbvuJvMkOwKjWPhK5IMYbu04Is5qQ5rlaxGwsZROStISyIvaEm3eXbOISwqrvlutWh9WwRB4zWPGgmemAfvLkcbNDztNaDzOFMh5wEdH6X20HnVZ+ly/6kWEy1Znhkoq7qXPcEIo2Puy59qt+l0WFwXMCvIt/16z9YgCaPE9h/gLXH4nJepMDB3WWHrXpItjgSOwoNxXb3gSAlS8+kPK87hhXvw1VmvR0cjpFWFzndBESd4PIUItcp5AmvxVkD2YniWmUeqh7t0Ex+ac3dSpqgqr5wXnsNUiYgknXNBRYl81sujLPoABDckltNLwaqhgzblKUbvEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDpR4Lqvq6uTXaRLhcnUUbqrxKArsMvZ7+0iTtL1k9U=;
 b=JAwPJt8JcqPxj93ACp6PzT2lZW5Y/WPBO9yQDj5FoqAh9t3lasdZsaDjDK2VsiP23BJPx5crklurOAjWkZF4Ced0ov8CUuK651nIDd8GGTuQwv/sY8NVpZwl6NJrkZ4alD1VejmB+iy+aae4W7rnDap/AOGMH5NEi1e75Qs3IhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TY2PR06MB3456.apcprd06.prod.outlook.com (2603:1096:404:fc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Tue, 10 May 2022 08:01:49 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5227.022; Tue, 10 May 2022
 08:01:49 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] cpufreq: mediatek: Fix potential deadlock problem in mtk_cpufreq_set_target
Date:   Tue, 10 May 2022 16:01:36 +0800
Message-Id: <20220510080136.11950-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::25) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 481a9b95-c379-4c67-04a4-08da325b5564
X-MS-TrafficTypeDiagnostic: TY2PR06MB3456:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB345620AE7C9DA35B95A9E622ABC99@TY2PR06MB3456.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5oXJ+RiQ7BycNNJ+pxzTgpCOkyEWHytHOEDESrmU9erdhngtYAwIPLXRZbLkSk6L9Lr6kWcH/2eSOuw1tAabeklNnZUhq8AerzE/y7gd8vx10kDMkHXAiXvO2MVh0zX21Ra95L6vkpa1St5ljTJUgseLVLbwVWbO+iYlrBf4OkOu5HwR7RMlm6Eplk0fS6eV6O+9sz15O5wJq9rRpX5kbIDKJbKg8ctrQmEuv2T0NovGZsfB8H43gcNeJwcM57fSXuZmms6G81EsPeCLbBaMnY5CtP+/nnJkVMvMs1ub/OG/o/Eo2fNb5jjMD7dQHwvZX35qmFplfLO8Q7t3b254bOD5JbGV4WYxJlrUCB9crBJ06uATvu7+3+ejF5v3alhmUdRk+K1qjVZlheu6uliFMDo7ByNjXSn/AVCY/3GWfOny+wPDEBt6zrn8S1AFfolcwLQI8jwUzcc2zVbZcQ9NRTKGZVXyhQ6toRgqalrbob40vQh4g9jTyiOQ7yA/3I5qnMaphevw6eNYkx/z+Xw2z8SsX1wT3M7d4ai/aXlFmOQcYLD64zXGfokX0V20eKeJxiSCfCMY0OxGtNE2GY9befonFQdcU/jlvnoZrssK3ifFmB5bVpnh7eGAeZjG2w+MF4kbZfuERR6SaEr1OfMyOXFou9R49FhFNBUdHBjfWrEndouBTLfXst9iTNZ01K4VutxPJLU9SuDWo5wx7vd0f2u3iXi5+Ylai/nYBKoRNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8676002)(4326008)(2616005)(6512007)(26005)(6506007)(52116002)(6666004)(2906002)(6486002)(83380400001)(921005)(5660300002)(316002)(1076003)(8936002)(38100700002)(508600001)(38350700002)(7416002)(186003)(36756003)(66946007)(66476007)(107886003)(110136005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fzBJZHOK3YJW09gDsSJnSsq3u7qJsyPW5pZsiJDg9N4GdTCWVq6np26H68fb?=
 =?us-ascii?Q?InRCDnkStZP49O62V7TTeDs+MJUIfaS0JqtpUTb8GKuKETewHC5gwg2BXbkW?=
 =?us-ascii?Q?C1RcDkQbdh4zreBX9oDxxQcnxZgEGJAu87yKx5tQ7BW2Oj6mrlFvDjZaaTUZ?=
 =?us-ascii?Q?2Alnc6X5mV6cwjqdGcyyQN+LBHoMtIyjRwONG5IN3ib+okNojvKJ5vR/cXah?=
 =?us-ascii?Q?HGbu4tD7YxZYBtrZdMbjKbqvj7L5V44ldy2U7gMr5Vjk69tnNRuxDfM3p9I2?=
 =?us-ascii?Q?hoRjanxabr+b26JZxcD02GVe2l0sBGfjf+Xf09vH86TEht3p+tWbtlAbZOp8?=
 =?us-ascii?Q?I6iqB4R+AyKFcIh9ktIQJ389uLwmfbvwbjMFiLv7O4LKNnXqqeSoG17gec0Q?=
 =?us-ascii?Q?fA5FpU1tAds+E/ub0FhGn7eXe2aRZCZFgACN13sldcy/Xin/tFDZ33fvBhYi?=
 =?us-ascii?Q?/Q25J2SblILuGzwcOpsGPnqT5u+kYLECBE4ntpghBNR0ELsfPLkups1LqDyu?=
 =?us-ascii?Q?bcM6mdudJ9DOOtBOiQNx9MhTAnVT6kR49otPBWRmgU8qjwcDKHTmVOrLHPZn?=
 =?us-ascii?Q?yUk9cD7/XaCdIMp9f4EofqcVYWlR1LGTFtyQ0XW56c54jnLqmwQvvwFZOMHH?=
 =?us-ascii?Q?UaU+TWGNcB1Gk5jizZS/+sv871Y9XQiNBehqor/s33vRptrIoKgZuB+YBCIT?=
 =?us-ascii?Q?B2oPa9ImxWRxZW2yCOtuepl7ccQPtZUOBGL5JCmie7QAA3BHberVVl2NlvJV?=
 =?us-ascii?Q?84gE2P90hTqmCBro4kA8364CRxwh1tu8pjlH+f3cGJU+UxhODNjWon1ySaAa?=
 =?us-ascii?Q?hmljJDNpHgRUsJVL1FfWQeX7lMpEYDarpp7le/Xb+qCQdN5Rw5iCOwHFhxo4?=
 =?us-ascii?Q?mtmpwOc1vuNIGIzhZChJjIeAiCpGS5qbfqoHHjuWZpr90W3FDcAVK+5fO415?=
 =?us-ascii?Q?KtB3kI2556AX3w/vN831iwK6GVGZvDJpuEHJNf+YIVdI8rgN5/5ccOl1FaF8?=
 =?us-ascii?Q?UoWNIbQkJkT4hf4oBKWxW6QmxpXrKAiyk8YUd/pyUaT3lNvQfTKiafz4IKRn?=
 =?us-ascii?Q?k2T+mlAc+ft4MJJAb6in0ePDbYnRDJPo3AX32FPQZRxXkGS13y/I5PUx/b4F?=
 =?us-ascii?Q?z+5vgMAH+Jo0m9Yfmk0/KWOBQp2QMuouLX1hi+FD65cb4q76l55WL4ZFqzjt?=
 =?us-ascii?Q?tBhBvAAEqPC8J/hNjTTj/QDVx+Uk++Hf+COUGlC3N1DT9MEpeDmG767Y1GIQ?=
 =?us-ascii?Q?R2yYY+YiJokFkxfvi0AfsbDKloJ5AmIoSMu6NMwTJise5TSMHXw9W4RmDT8U?=
 =?us-ascii?Q?VMPFXnH44UTY6OgO5+n8lvmQgxUuTRGiNDY7LZBmeM0zI/jxpQaH29RWPEQW?=
 =?us-ascii?Q?5/BtGjYTpf+JyFKR2C1Cx6VvOt+V5C7cWjFLGGDjCQWRyXixYERcdBVNid43?=
 =?us-ascii?Q?IZuSIx9eMCihgsvg/kHh4VssKYnp0NU8215m3Y1Zv+GtrO0HIt1AYcbjfZ+0?=
 =?us-ascii?Q?i6PjLsoaTVslAvHdzMhmaPcSKtJdhmz36FVws97uMG6g1BWOmPgPFaegCIdM?=
 =?us-ascii?Q?grs6Xrx3DTKYzTqv2Mzt1VRcRvsmm/XxvI/d0QY8jb0as7GWGBbfXmn8QQIA?=
 =?us-ascii?Q?AdeElwcnX3Ynx1qYv03m85v/ZfXgqL1tltLSaHm/ATXuJyCgSEn8O9qx92lW?=
 =?us-ascii?Q?CApsnMirnfjYpRJVKDwcNngedg3XfYC3Nl13eb1fAqM6HP2jOgKu8G7WTVBd?=
 =?us-ascii?Q?tbNTgl4OlA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481a9b95-c379-4c67-04a4-08da325b5564
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 08:01:48.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GP4oACokfJt8F8YlUow8gvo+GbOsdXOW0JTbDRP6xpDz2mPHDhxCjPCj3TOpOKByfKZep5RXW46f5tEMKWcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccichek error:
./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line

mutex_lock is acquired but not released before return.
Use 'goto out' to help releasing the mutex_lock.

Fixes: c210063b40ac ("cupful: mediatek: Add opp notification support")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 75bf21ddf61f..4c6d53c99d79 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -196,7 +196,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	if (pre_vproc < 0) {
 		dev_err(cpu_dev, "invalid Vproc value: %d\n", pre_vproc);
-		return pre_vproc;
+		ret = pre_vproc;
+		goto out;
 	}
 
 	freq_hz = freq_table[index].frequency * 1000;
@@ -205,7 +206,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (IS_ERR(opp)) {
 		dev_err(cpu_dev, "cpu%d: failed to find OPP for %ld\n",
 			policy->cpu, freq_hz);
-		return PTR_ERR(opp);
+		ret = PTR_ERR(opp);
+		goto out;
 	}
 	vproc = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
-- 
2.35.1

