Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAD44A6456
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbiBAS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:58:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19638 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbiBAS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:58:39 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211IEL4H008396;
        Tue, 1 Feb 2022 18:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bvwKKO0CMjKHRztDZVF/IpqyhizwfHvLKIfoniPvu2Q=;
 b=D21l060pUDWM4T4vEEgu94TGPnNqt9wRp9HHx4wgx+ZFU8nTXYyvWoPtbQemnGX8DdWD
 Id3KAPXhLrotpCdHMVks3kW2lOF81InTHvT1FSSRhfnVQSokRaWZ3/UoVbpDW97GqZas
 FFTrK+4qj54Dhft4zPv1XpWpcdpJh3JPaAjJFX7oCDZP+RGPY5rLwK18+eKq3cmrcPQw
 v3hVA+1hnQnM7vTDrpy63+CJZz/lHz0mO+t1Y9Fnsyv2aIYzstAxsplOyrr2axqE9qHZ
 HC9ol8fF91ijvjlvMxRaOzcygEmNoFTCFF6EMSO3J/LZ2hAa+1oUNt+67TKX44p+Eo3R Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vby83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211IpOQb119078;
        Tue, 1 Feb 2022 18:58:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 3dvtq0vwcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKaRF/+q+5SiVx0MdmOBUo6kgV7b5Lg4Aq06/hPG6pou866Rz3zt3mmjGwgUOAix3NGpTRqHI7UpG0fdSoldewZWaO6Ey77Vdt1SteGvPbedgC4kTYnGteKY/+5M5XZgItZpkyjDgMoiLi3eYE/PPVZf3EBgcoyV0uzTClhP21+5i9myvt8RptC2WErd0ZoUDwtAIRa7QhRy3sz6WELZfF7uYUolfkXbQToIUUZpjQJBTVk9sRUZ/SbZmg/DjJJy2/PHFLQdnFvvg2oJAg96fk6Zc3rdNUBB0Po4nSPUXFEw3wuL72kowrX1wOTTxMxxzBQr0IQuQo0CkJLY+kEnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvwKKO0CMjKHRztDZVF/IpqyhizwfHvLKIfoniPvu2Q=;
 b=YRcVLaF23kdaIRKBUy8pMa+98UXgTxJXkPIFjzkXB5hWjCwAjIiLZrW/QyptUzXomZjGF1hzyKsP7lGlv+pSHw3UEDnecFvvh0SSE2lACfUerbZXKqhEhXX/hcEtzA0cG1XVHC/G++iHRiY2gO4hDBhHKj82yqZnEgjl3f+SfiS3KroUQuy87HLF/dzpJbuwrc2itrzJm5xpHvibMgoa8mdPcc8Mf9IlXGkTENGI/nk3PE3SpzH+1f+bQKKuE55IxHODngXMeG8Qeiu8ikxyIKxgmCK2fARt4xnithlYOTso5OPAkNb0MkHcoWYSH4EaMGfV8p3aXRFa/YZjueqytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvwKKO0CMjKHRztDZVF/IpqyhizwfHvLKIfoniPvu2Q=;
 b=FRH4/wzwWeJMwgOfgTnQzBuxU6oGCSwcNUR9svzsRQ8jDcIXvNOfT15hJDBqYrUFaiknPpBHKMjlKjT5raVs2UqaDCH9VHx74YSQ7rQlzkVHhzMQSUp5EN5O2RTVclCulerRsG3RRqx55Ch7ydaHrWwsy6B1rpaagiSGlr5ApM4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 18:58:18 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 18:58:18 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 4/4] printk: Drop console_sem during panic
Date:   Tue,  1 Feb 2022 10:58:02 -0800
Message-Id: <20220201185802.98345-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d174507a-f399-4b11-4c61-08d9e5b4cf19
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5156B84A62B786CBAC515318DB269@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1+zewDvpQqvKzvgk3T8FTtN0GMejtU6D3S1vv+NvgIXJnpNtJWG6OMjxrHCQW4BOYCtJY9P7WGF/ENrfSc4p9gfnkaeR5nIcQJZnBsLVHeyk0i4kAADxlcj/5FKJXf2ZL87k5CYiMiK4wqcj7c20VsGnuv80f5ZTYLiHYkkBISRoiqCMh8+U9Lpjn/PGAFtZiP0j1N7mDAskUKurq0LR/lydcXd7xQ213ffEMYHDlfpJoyK8KzkprV0L6R679omq1G1UoCfNHEF55hkL6TqtrAAYQShcpgv3H3ov7wSdsnIa9PRQmUN2jyFRSi/f0pzeZX3s+gfD4h1flo8R0UcTMP4qTBVTgrcoIZjf8vkWf6Bz10ZHd58bYHbCKfxsl6a5Kn2hbFJo0nJJJ0wKkGUAxPen1lKDumwt1z7dQI9teTk7pgVwAp6CVe6AFisSfpTnP2a/uZptOTvJJBXooz0F4bFEDPNCbRnQdAiSrA86f3AypCc10gznBi6rvoN7PN2lK+nPxUCUgAAjKcxn44MlDYCYP0ZKMz00u6JwWSNV3+K3ZHFa/yHW0jIJk2xVkt7qkTD09TJLAqT1F8en3/430xvcKiqRpN6QHGUbZVd9X9ck2+vsyK2TWvHst2cGtl0QwFWBMZquyZ8JYBpo9FoV2GM+sSoWs+96HgjTPN6Q8UWeBHJtcAd8MQvOQ+Zu59Yjvv7rpUpxJodfAfSLSldxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(103116003)(6512007)(6506007)(6666004)(508600001)(66946007)(4326008)(66556008)(8676002)(8936002)(54906003)(110136005)(26005)(186003)(316002)(66476007)(6486002)(83380400001)(1076003)(38100700002)(38350700002)(2906002)(2616005)(86362001)(36756003)(107886003)(5660300002)(52116002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMsIoKBYdwLYMb8HO6WniJ4dezSJreCweCJ6MuZI1JCIhadp4jpCdEmg5q3P?=
 =?us-ascii?Q?AWGEIUBsa9b7teat9+qlpvqfG+Z0JrEdHT9+Wevg/OH5WoVDe5c3pOrhObx6?=
 =?us-ascii?Q?uZuDjGBPD0B5rzZkbfz2kImydbzJMc+Jp1lc16iMgDM+kSjWqKGPfhnI7B6d?=
 =?us-ascii?Q?yaq++j/lNZkBtALtEHw1axXq0vJSurdbnXDXe3T6/RJuCmrEnS8QuJjvfKvZ?=
 =?us-ascii?Q?Mr4Tt+EhMYDbFhX0t6FX0w6XU9cs36nOmJDNqvZrnTYYrLRaVnV9bMF1+Csw?=
 =?us-ascii?Q?pDWiXTTFzaAWX73WFICNwLaP28zsN+k9BgWGb8frIwr/AOzklweKxMN/tEbr?=
 =?us-ascii?Q?jrmqbPbZ3Xt2EmIXTrHS37eVDLFWR/CwaxT97epZ4Ea6wv7FIhn/W89982H/?=
 =?us-ascii?Q?jupBUJ9AO92p09OUKFZ+dMR5G7nl9G4ButDpXvHm+JAL73xRHpR1XFWFEJrN?=
 =?us-ascii?Q?rZVdERTCDPIxMZeeqM0/KY2nLqH3n+OJ7N6L48m8udu73a8D1gkUcaiXeHnv?=
 =?us-ascii?Q?1Po3aJHlWYp6iMTxy7cTx89yv2HY43E8NCoCtHzn3Jsj5CmPaqCPG5zy/gSi?=
 =?us-ascii?Q?JQRhH6GcNGvjt9zLW99SIk3fKuI6t2dO4YJC2i7gwje+zzNy+qUXtrl21iBi?=
 =?us-ascii?Q?b8Jf54yAwF7JvKFxTHVbeIu0MTiu/F3b0TVikvFT4XF0qqk7yPm+Y5p0gsWG?=
 =?us-ascii?Q?pPkaE/3rl5e8ImHWzA+gch0N0IlvstiDxL82hNf+TABrrk5/LBCn4MdKX6k6?=
 =?us-ascii?Q?8MI9ckkwlxdr54wE9P9DOzGtRud9T/+qxNEuJwY4Pr/f+T/KRUZcw7SpkivS?=
 =?us-ascii?Q?nvls7dGWD41+N/ly7adF9NkRJcH6daPsbk4oIQXlr+ugG1tYn5DBgPqsKMja?=
 =?us-ascii?Q?I5rcfI6HqkebWNvRahcUdvgN6+DkyHSoQMOKQbzGFGYjM3AoiW87+i2+NFAo?=
 =?us-ascii?Q?nuwS4DrMzP8TfOQPB4KJQ8Mtxbxa6klJTknztcSaivk3nwbdp56SbtUt8K4j?=
 =?us-ascii?Q?B7WDw68lrfuSueV6n07cNGTXR9/x8LezUi9MxncT87A21HiX3eZ8udmuh9jN?=
 =?us-ascii?Q?xjdNV8ChFGw6R86/mP1Saq+qPYRm/gPYUKy6XYgyppMVByIhARCTPD4PmsxF?=
 =?us-ascii?Q?mSMYPuZRs7ZhLBEP7H5fSEhZG5mzlL0ROq5aFxLkS4YHTzJ1c0JLTjzJv472?=
 =?us-ascii?Q?R7r/C1kcymx3SEGo5m7jHMW7BuvhJCcT1a7JXlvBWcbb0EdsBpGE6F61wMW/?=
 =?us-ascii?Q?4ADPSlExwEv2WX097pCvisgRK7P13bMVuLUGzd7aNTjur6md6WN+t2sFiSjp?=
 =?us-ascii?Q?tFRSOK+lykaUopNsy9V8C8jknTDjhw26m4Cd+NgmGnc+D74pxLjincXYluHq?=
 =?us-ascii?Q?sob6tEmJWpsr7wspvO+4slibxLABzQp0JPqE8dHKkoFnLoELjd6dZsj+1WDC?=
 =?us-ascii?Q?4/nHSv6jMxaIvx4Sd/D3t4mxQu5VdwJupS85hetZHhS6aa0m37utuDzGh2Oj?=
 =?us-ascii?Q?FEMcozYV7lZDQapRMLStB5zRDfE2YzVFPAETZc1aiXQTICKrXB279Tz8Nh88?=
 =?us-ascii?Q?xmU/vNF4I/+jgNODFN22AJMzmEuo7EHCtHR8jsYmqA5YUYxSRWl1UPj8yeiU?=
 =?us-ascii?Q?0bKqBMq5ot7I8tjbaLeyNEW1FMR6g0AsJdNAHQw8QdhZ2lSS25h/SFGr7UaB?=
 =?us-ascii?Q?3QqKPA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d174507a-f399-4b11-4c61-08d9e5b4cf19
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:58:18.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ7iK4VprEt/l28Kz/efZPrqMXA/m/J3p+98jlV3qGm3LUcJZp+7f9mQFoC+lqxDPYr9XJic785dMAPkKBDUnU2j/Y6HgTrfUBYi/9RpVn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010106
X-Proofpoint-ORIG-GUID: 6V8wlBlEEhS3Blt-A6wnpuNRZt81btnQ
X-Proofpoint-GUID: 6V8wlBlEEhS3Blt-A6wnpuNRZt81btnQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If another CPU is in panic, we are about to be halted. Try to gracefully
abandon the console_sem, leaving it free for the panic CPU to grab.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v2: Factor check out to a helper, and check at the end of
    console_unlock() to prevent retry as well.

 kernel/printk/printk.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cc7bb86f7bfe..35676e76482e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2598,6 +2598,25 @@ static int have_callable_console(void)
 	return 0;
 }
 
+/*
+ * Return true when this CPU should unlock console_sem without pushing all
+ * messages to the console. This reduces the chance that the console is
+ * locked when the panic CPU tries to use it.
+ */
+static bool abandon_console_lock_in_panic(void)
+{
+	if (!panic_in_progress())
+		return false;
+
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return atomic_read(&panic_cpu) != raw_smp_processor_id();
+}
+
 /*
  * Can we actually use the console at this time on this cpu?
  *
@@ -2746,6 +2765,10 @@ void console_unlock(void)
 		if (handover)
 			return;
 
+		/* Allow panic_cpu to take over the consoles safely */
+		if (abandon_console_lock_in_panic())
+			break;
+
 		if (do_cond_resched)
 			cond_resched();
 	}
@@ -2763,7 +2786,7 @@ void console_unlock(void)
 	 * flush, no worries.
 	 */
 	retry = prb_read_valid(prb, next_seq, NULL);
-	if (retry && console_trylock())
+	if (retry && !abandon_console_lock_in_panic() && console_trylock())
 		goto again;
 }
 EXPORT_SYMBOL(console_unlock);
-- 
2.30.2

