Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A268533C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiEYMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbiEYMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A964A92A;
        Wed, 25 May 2022 05:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYcMMzSAkcNoGFdcHWzZqgcDXmOYf+j/JMV+MviXiX08BR+x3I4odV136V6yjC+Ts0INVPfKbRGaeFm52C1p6NvsvBXrYfjP1rekT/hejJEWA8mTx0bc1LrO8UGcxGUIjkZ/m6E+ERxoD8qhk9a/Q31NEYBmjxeKpj1gBTYueQZ5oYkmnWhxJyLnJTzH5ut+BZdAORsEtQU6PoTlMiggGLT7BGDG+CagIda68+5f7XUET2g5iEKWH01X/Ox3EQb5Sbl0n2fC+uSwu4RCFkDtJJrQF0mR2V8hmepv9APoMIi+pfip7uMaGf1BSX4bqfmqr/DrqeXYOD11KHZKfbLZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de4WxhAiImnLRIRonOWML+EJo1xKSHXaLfDPkvKE4W8=;
 b=Xe9NEpT3JkiIxkTRznWPHXZGNLn7zIZG4XEI4sr+Ubgtk38wE+rutU4dYFPFI1vXcW0WSaJI1LmTwajpGNZXt5Dm4yn0E1UDXyAxaDbiL4kCbejHsmhWXPsxYVFjwqWuOf8288VUrraHEYzWsfOSiL+rhrm0Gv2fuO5RjIRCUJGcZZ2Rib5F79AScA7YEIS1avBwqpQWXXya06EpRVhmClPRDkIEAGZPhXEvpH8CgJ7zeGQU120Be1kMgXwHvJ01gaeDkLXFlEXL4M1xSNhj+HZYJ39MqrnnN0RLAY37yveV0wDAkBGQiwwDaqMB/GWa85yIV3377xgzc4If32ilpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de4WxhAiImnLRIRonOWML+EJo1xKSHXaLfDPkvKE4W8=;
 b=FE/Z5gi1sPZSfhdtaY/GNCgZ9Cb7xJAqcG7UUBogzCD5Q3nbfy+pGIQxcpw45CDWdqOOalGr0J9TubuV5VNt0QR5sowKyMGlcIhyI6ZiMA1uXEh7T79Km80U1jH0bEKp2V+xE2j9aE+7oREGfP3yRWJDHwwAernS9oefUAhfDyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by AS8PR03MB7859.eurprd03.prod.outlook.com (2603:10a6:20b:342::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:10:58 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:10:58 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Subject: [PATCH v2 08/12] clocksource: mips-gic-timer: Enable counter when CPUs start
Date:   Wed, 25 May 2022 14:10:26 +0200
Message-Id: <20220525121030.16054-9-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b59a8061-c9bc-42a3-84fc-08da3e479ec2
X-MS-TrafficTypeDiagnostic: AS8PR03MB7859:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB7859CAF1506008BF28360D82EFD69@AS8PR03MB7859.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Irp5SR8506Q6Jkwd5iGrjmgpXuish/aWoGh2oEQp2rqhe6HldztJdBBzNPj2M/9nWs9hLRUTWD8jnw6JU0+FT+ouV9FrG05YNVvqFUGshJX7MAWYG6M9klZ84P3I6mEf5Yus5Xmpyn6TluodJtxnbRdsEbLm6E358LY+07TGubPos2Pq9UZqP4HMN8lzFnFz/V5yahruQIiPXGUp3KXP8m/8I1KUXAjkHrYGoxl/ZterTKw29W+036ZCwDEhhNNDkbt+jd8x6kkKHkoSuY1QX1sZyiUWZS3fM+vFbRrX0vWr0r4gbIauvU5e1zStd3YyTOzBhdtRhbIpCpMSy1p0zPNuC++nBdehV+sgxNdfOAcnDZDWoetlfm+PamAzmgSxMDpPovCUWM76vAD123wTKRZWBZyLlUUw39MboXUWZVlFwR/ombt3T03T9aLoVX/+jFJEnSv0RsTUotYtZZZ6QqO9AEwCWCWQDuMY3K3r9y573tJVlC815BsmMqj2FjV8RmD6IVL3NPsEibfALari22priSMsO4/jsol+lnX6db0Y8ubqwaMz3baxmxii6SHIMJexIDgmuQEemo/gVVq7l8+xO61O0r0iM5ig1T11Ini7l/IGHq7KJeDtVnAPi6siJ2M5MOBIbrDmWYodMb95yhnHoBPz5QYXQkfjI98o+ME3uVZEhpuFgUvcB84B4rfaJIx3aVoe3G4WUmtHsvf9dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(396003)(136003)(376002)(346002)(8676002)(4326008)(66476007)(8936002)(66556008)(66946007)(83380400001)(54906003)(6916009)(316002)(36756003)(7416002)(5660300002)(6666004)(1076003)(26005)(186003)(6486002)(508600001)(86362001)(38100700002)(41300700001)(107886003)(2616005)(38350700002)(6506007)(2906002)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p86B5XsCXXx2vH0jl8LcN88D6wo8iGYoEmtKkpDTuNz61/KdDR6ReeFpHFzu?=
 =?us-ascii?Q?IV2Rxybj4li0R9Zgohq8cyvJgIcBAPOWwzF2wS/gkl7NLyDdCXtgX+qw82bQ?=
 =?us-ascii?Q?BSp91nfyL57nIluhZjWJWi5sVAuKWIQd8YG03l372tFITKsXs2hyayeJgjVH?=
 =?us-ascii?Q?rj49br8gVEDnkXgcNUdf+on4W2XJWmPjQOVNZcBHY/gTqgDTACctq1vNUCWV?=
 =?us-ascii?Q?jxDwgmuNCzz4PffYcC/OPzDYt9MAHL92Z8BF9uQdchLFRyD7poBG1NWF7vob?=
 =?us-ascii?Q?EEX/x9WRUCg+gaSWVCGV4PDuY0gE8K7bsaZmt+VS17KfXvXLXRdxhklrD6eI?=
 =?us-ascii?Q?9ZZ8PleXQLYZn720uitOCkd492RhjV/WCISOhC2lbtH/bDSAEsdknt48fbyA?=
 =?us-ascii?Q?D0Md2Ceko+MjnHa2yabAvuuz/ttftcvKBH3Sq8scW9iTuMV/ZE9EjbtVPgOX?=
 =?us-ascii?Q?TIMRXF9A+iORTIszBaKMZ+g7VVIuIKdNM+JM5vm889QHvaNuWERjMdiOuTcr?=
 =?us-ascii?Q?KGL+ymIjUzxKhQbQwvg8gwVppoRGyBORLZNcYPv61hM3Ui0enVnF4AU8CdtO?=
 =?us-ascii?Q?UsdcGDPRSluqVG+s0d55dcOfbLZef1Kh+CSKpme8TrDHrA+QAWw0bT8QO1q2?=
 =?us-ascii?Q?rUq3QBaYVArJ5/mzM2hHyevOTikJz28imL48VrL/gXFCDUHmuOSGxzxAXb2u?=
 =?us-ascii?Q?7isemF/l+8MgHr0AHgxYafsCEoEWldX+MMOSIC094eaHdlU84Os16aWtNetX?=
 =?us-ascii?Q?Po0FRroEEFwTjUrwdwosv32A8uS6AGwZIEzAOB4F90NOOlYmBCy6/oZfQHRw?=
 =?us-ascii?Q?ijg0EpExcB6tCV5BBkG1pijhXYaXTytXpmOWIE7C9qL1dzWZHpsxQo3LRrU3?=
 =?us-ascii?Q?WPDiT/sXfK6xyj73zdeE3eEVHMX7YJ852mLDbfewdaR8xPBgiqdj3qkFbBXG?=
 =?us-ascii?Q?dhrANaFpjqC0VCKPywZL094gQRSCBudCG9cwDC/MiYx+NjAwteXVHyZsWPnp?=
 =?us-ascii?Q?egF/WhzNfb8BqtG2SS0go6p9pQvo9XQ79XkyU4yObLIOy55zki4k2WDjuvqy?=
 =?us-ascii?Q?74PR4nPv28rab2K31BWhZMP2P2/vBouNLkk4AooAHMbHEP92VEM2RYimfLco?=
 =?us-ascii?Q?nYuVBN5LDmcAYq3I64cmw5lCfpLG3rpXYex8hmN/TShSMnbcXwYxwFvOSufe?=
 =?us-ascii?Q?EBF5z9y0FoKlRIU+k1gUTJbeJObiHAmBUWU7UN87G1/o1qIq2NDypdEVtq8h?=
 =?us-ascii?Q?WpzHenOKEYvmUd7OJqIAbx6kIcZpBhJbzAon/Qs7Y2gRwOq6f1LOo8KcMMVG?=
 =?us-ascii?Q?5qa7Yb6Xko9N8uII/SqdxdDl+6IT3GWew5gkPQ29opCTPCz3N/KU8pbBJ5wb?=
 =?us-ascii?Q?UN5m7aMaZBZVoW9bOX/HmmnFCaj2hk5af9nrfBW+ykNUuMU24lzjch6W30OG?=
 =?us-ascii?Q?Et9e4gSAfR4vQMOCI/MKO/LEpWnWeCOg/FNfxGmRIiGFpvAZsWSutUsKsumI?=
 =?us-ascii?Q?OcOXby5pdXE5LGJL/fQ7ezS730BvP+Ks1HnISSHYCzv0RPBxMFsyd9AqjUZc?=
 =?us-ascii?Q?aJk2L2ob6Z//nub0eH/tTIk3MpT29oZXlopMW3uLHzbg8LtWW407XAmJDRZJ?=
 =?us-ascii?Q?0BKLdrtYR3dbD1vUSL9ou8j3m4r33+GP4S2lauzHn4JaLM1eibLaIhi7icTD?=
 =?us-ascii?Q?01o245BxWQZFLEK/mXgToezIKku516Pjoi0GKsZxrVubF04vOVULAlmobrp9?=
 =?us-ascii?Q?Ez3MFzvz+TDf0IDDI2cqk2fXFD0VIiI=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59a8061-c9bc-42a3-84fc-08da3e479ec2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:55.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0hj6HexUcsYxlpr7G61VhUzGj8VaNs04mD+iSHTNF65cy0/RiTaTrUYr6emKvCi53zlXTu5ZaAr95+xytmQOp//36lvdBwkFv9/AWEapWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

In multi-cluster MIPS I6500 systems we have a GIC in each cluster, each
with its own counter. When a cluster powers up the counter will be
stopped, with the COUNTSTOP bit set in the GIC_CONFIG register.

In single cluster systems it has been fine for us to clear COUNTSTOP
once in gic_clocksource_of_init() in order to start the counter, since
with only one cluster we know that we won't be resetting that cluster's
GIC at any point (ignoring suspend/resume cycles which would need to
handle clearing COUNTSTOP in the resume path). Once we support
multi-cluster systems this will only have started the counter in the
boot cluster, and any CPUs in other clusters will find their counter
stopped which will break the GIC clock_event_device.

Resolve this by having CPUs clear the COUNTSTOP bit when they come
online, using the existing gic_starting_cpu() CPU hotplug callback. This
will allow CPUs in secondary clusters to ensure that the cluster's GIC
counter is running as expected.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 6632d314a2c0..90a736a13115 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -119,6 +119,9 @@ static void gic_update_frequency(void *data)
 
 static int gic_starting_cpu(unsigned int cpu)
 {
+	/* Ensure the GIC counter is running */
+	clear_gic_config(GIC_CONFIG_COUNTSTOP);
+
 	gic_clockevent_cpu_init(cpu, this_cpu_ptr(&gic_clockevent_device));
 	return 0;
 }
@@ -289,9 +292,6 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 			pr_warn("Unable to register clock notifier\n");
 	}
 
-	/* And finally start the counter */
-	clear_gic_config(GIC_CONFIG_COUNTSTOP);
-
 	/*
 	 * It's safe to use the MIPS GIC timer as a sched clock source only if
 	 * its ticks are stable, which is true on either the platforms with
-- 
2.17.1

