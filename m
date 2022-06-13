Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958ED5481A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiFMIZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiFMIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:25:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2033.outbound.protection.outlook.com [40.92.98.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725091EAFD;
        Mon, 13 Jun 2022 01:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfJT5atsdFm9SHEqI53/AkzBeHn0wFvX33zwEYITiJGYzzWrZLGJ2LTELQNx74PyFp7cKi3WKJPolrFodV9U7GzZKshMDWWv5kV6RrBig+wDJ20Fz0tnH9UKpRqC/Q878CpjRvB/45gMW2/H6/0wgoZSWR1fyyXxtKDtyDkQ7XWkH8fohbH30U2yJfFHnnxvpHfnmZHbTVs9JqvmMuLosEcfYZKC8BPz0AXbpAO/wbf4xtZ5zksmrtv7BL9r0uTsEilJQ3VICGrzviI91BiW6coo6Lc/JYqTGufGIrm8Ma0k/EOFc7I0FkzMIsDaRekgWaUlV7PGUxJ5ZQlF4yU58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiTxWXEyoAPs/I+rjR5y33VsDXZiYz5yhqB9YfuxFa0=;
 b=F+4GlfZlD7SxEKIQXaaE/D1shdWU+qR57qeDBtFAckHKz/fAUNZDAmtZQl4mz7aY0qxO4d72Tya7lh6MsaZk2tmMmtVgVtKtmGAN3benWLHfDSefFJzXMnXXm9uLs0M9YtU6EQe1rI0kKCOqMu9sWR/T9OAM3/ct96gKjFaYQuCsCk/0kDusywjpGm8e68LNiv4YmRM0rlNG3qhFuAsPqsJQ4/JTS0YbuDkykXo1FOCNG6aLPrAonMTBWIhj/oupVldFUWq8Key26OVVXdiXauLAZZeuL2k/N9uULEg/penDooJ0jQJDsCand0YBYRIAWF2Ca9q2egphnZLbyXfB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiTxWXEyoAPs/I+rjR5y33VsDXZiYz5yhqB9YfuxFa0=;
 b=cTrf+FISk2K4DLq966fORUjLSxvmEgSWOs22iBwzmlvwmZ218cJhZWEhgH1+bCsGOshw7I2Qd1EO05dwo/fAWGOHcPkuitbnXi9cqRh/sptGTWEBbgbWK7CoesFb+AlFq7yrZqQvTluHkF3TW6XaNUKSXWwGxLZ0dQMjQHWxVrsSkRFnek7bZWwEDl5Gw3jBt3wGAEV0z9VRCoAuWnGtUNrIjoJ072pNtZffYdYyl9dpfqOioz4LUJ5EuUqIjyBbk8HfHNcROvqjlqPP2LAYWVoWTwietdZ/E/6tmhlUPO5Wyuju2HNcyzDEhRZ5jKuvpEPw9xXHDezPgJVr0V5RPg==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by TYCP286MB1426.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 08:25:43 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1%9]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 08:25:43 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1] ACPI/processor: Remove unused function acpi_processor_get_limit_info()
Date:   Mon, 13 Jun 2022 16:25:26 +0800
Message-ID: <TYWP286MB2601D57F678AAC931003178EB1AB9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tqLLVWLLWj+3y5T+uQi1L+8haBgY1PpHz+adaV2iekQ=]
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220613082526.3746201-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825e42b7-8eaf-48d8-419a-08da4d164ea8
X-MS-TrafficTypeDiagnostic: TYCP286MB1426:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFBwbpnuoMFnJd8uYn1bmrVjoBLiHv1Vo2KIKNx96xdAa2efZ5Yv0THhqtr7Pmug6SaYYjvENeCHIqZA+klWk64IURNRNiVBIFFLSgEhvCY4+d5LPrW8T8k0h2YOs/tMrvyQfo5yUdN+Zdt4WESmkMkRCoKaouIEwS60XNkWrFHO8O3yeruNuFX7pCrbuqlXjbPM8tpO+tPbK5SwpSDeAYPAAUdoGZ+YSDKX+bb8qwHlW1NjEeinUOl8WpGu26okpgkBzFQE0Mllyp80joGMOedkviTNDBCo4LXPeQyVD51RRuaw83G+N9ezKYyoNfrk8Oro0B/YSL2+XQBw/B7zZLxeNcJRknkejRJYPjO712bqbX6Ae7IkkXDqzW0as9ZXpfRcjgXGXLw9GfmNBlf9e4I/L8B23eARw9SloQkKL8Sjtke/0hFTNTpxSvrcWOxIjaLGBh2yBjx8tGZnFVjtNky3nZWa/JhiI1vH4fXYG3ivfBTeJJUcykzi+FqDU1ma+Mj9TKOIbHKIPuf6fDekZwSiRgYVvn7SeQS4F1RHtde67iQGvX0qnmS20Q++Blm2kX7SH3z02kirKlDSXkw3aw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?deYAQ/b7hlCKyMeRUar12gRol6W4d2RaRN4rduEURHbTh42OzoxVKnSXAmu4?=
 =?us-ascii?Q?b2MObBuB0k2H/0uL5jVU7qbG0c3mK5Gu1hX8uVfgCTCjAIinRTdyPGO8L3l5?=
 =?us-ascii?Q?21Eq0llVjynO9zoAc6sTYDVeo86mKENdx01nhUYGjqZd8chAxkZmn5Koybgr?=
 =?us-ascii?Q?VF/eTnMURDG4RVMOizXgn/BbBwssaifPrQKnJK1fZ+n0XffZbdfkTiRNfiQ9?=
 =?us-ascii?Q?z1kum/EqU48mSVmgm9x3Z9xIWeawwoM0FY/+r0f7ijJotKz29J41qt+tGw3z?=
 =?us-ascii?Q?ep7+zwx5aFwuIArlnScJSWCdp6TfWv/jAUdO17C3R9hf7hLhlVddjBCLoUo3?=
 =?us-ascii?Q?MVS3iRoGz6LZwmcmYHxn58cn1C6g3oHGmhRpkYHvJCPjy6fhsWbRV9tVPK24?=
 =?us-ascii?Q?hGDRXX+Jt4cyQLuJ0xU0Igtmp85xF342BioMU89+Q7gtmozOLTrG6cJFRwci?=
 =?us-ascii?Q?iHLWSGb8ZvXqkHZQtbM8IWb4d8DUK6G2TH33TBhXSjE1sKcgDa6cAf+m1rAR?=
 =?us-ascii?Q?dM6N7pRuOrT/6YqKmbfJ04rqCAT/yXfxJhusem+UILsNl4U9bOAdWruAAbZY?=
 =?us-ascii?Q?gxBkrD9E0e5LU5zax1zJOU8f6nft8OeqOqCfiKXzyZC6QgC5KOIMh7m1Ckgy?=
 =?us-ascii?Q?4oNpLYqJ5NrzZriaqO4XAYR4Pfbuh8CbGzTNMo1ZvYu2p1nIKPRsqcac6T+n?=
 =?us-ascii?Q?CM49KRNJ4KrAKfRH03lo1VMwH+otlOeAI/jHFKd8ATv3Fj2+qtgdtRVwoSq9?=
 =?us-ascii?Q?duO7BiagK4t+vVoVTO3ad/yQ+i4fjJRX+IOnVVdhAILogaCBNZa2uzc7Jefa?=
 =?us-ascii?Q?SnGnG1G2/zBkFGknyJIl3W0QXRFXZFI5v/eA16dlrO8zIzwA4E1gSYEN5XOO?=
 =?us-ascii?Q?1YnJwK9i8SEytoiQ0b0jdgUQKy0+jxUbksmmCilti3XgzmauB46bM7xg7D5T?=
 =?us-ascii?Q?fddPha58C3B5v5LinGyK3A0FmAihw0KnFOgEgn62OJYLRUGma9oUa3946G0k?=
 =?us-ascii?Q?72k16PrbAA68CQL1CnOrmqCv+dby+HPVgYeCqi4hm7k22SUHJCPaP4WUmq1s?=
 =?us-ascii?Q?aBUNhq5OAtzvfOZBRFJbQWjgneA+5cvIavrHABsMnhSXLEqcGMZoRjzbMCnc?=
 =?us-ascii?Q?/G96sad1/lp0CelnrKGeYi98JTCgindVPYrp7TyMOyJBrcC9ogWayYpEqi6M?=
 =?us-ascii?Q?2cVSOZ2566uUdnn8TcE2KiNJw0NjXotIxZP0hC3Qh9dX8LcKEDAGkXemvTAM?=
 =?us-ascii?Q?6oWfRUPbuN5YXUF/n7Bba/WvRtH68RSaclQnDE0GnyWsrXxYbKC2c/9Ibi2C?=
 =?us-ascii?Q?uNFoKQ9MLixqx6e4xmPrh+WYExF/klkfGU99EdlxcpIr42j8VAf9HQGBOsCe?=
 =?us-ascii?Q?5VkL0GoM4yzA+TDkk+sQFfSSAnN1wNipIUmsghyeNw2o9/nrrchUN46HsSyn?=
 =?us-ascii?Q?q2kCXg82bSo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 825e42b7-8eaf-48d8-419a-08da4d164ea8
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:25:43.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

Commit 22e7551eb6fd ("ACPI / processor: Remove acpi_processor_get_limit_info()"),
left behind this, remove it.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 include/acpi/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 194027371928..1d44b84da22c 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -441,7 +441,6 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-int acpi_processor_get_limit_info(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
 #if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
-- 
2.25.1

