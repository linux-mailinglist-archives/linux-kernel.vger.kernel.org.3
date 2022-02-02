Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1724A76AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbiBBRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:19:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19486 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346241AbiBBRTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:19:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HFa89009072;
        Wed, 2 Feb 2022 17:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=yl9c9wZ4hVCPewVGktKfUeMsYgnZ9e2+hfWTqtGl4/c=;
 b=bmjQaWG8Fn2MDLZ5bPsBwcL3ZIhPPb88ImgWX0z37+x2tbsPedtKlX9jVn7sPaAlkMKI
 1zXMRtnh+bqGWVwMiaJsSjBeQaSRbMhL4e1fAqQ4ru+D0bpodytgNpG7q0YwGL573Ce6
 2Jb2pYnXsEoEaS46r2K4NpKWBrtBeVV/W9Q/1n2ztMORMJIqvY2g9nPc97fXxsDFnLfB
 tSsXKA5zs6N9DiBkBGb8SjKHazDFXO2mHgBXr5kAqxL9uVvNuBhphmKr0pQBuslvErao
 V0Z80TdVUbhjY00WxcvrmDvfp+EqbEvAnT0z54rcQdzd54U7T3ItxDykb0IJfiR/03MQ Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatxtyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212HFjJm196011;
        Wed, 2 Feb 2022 17:18:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3dvumhumfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6fItfni3d3gtsuZycNXyIGRfFx7Bad9+PaWdPRjvZ27ICSn8sRuBIZpjJq4NuVseV9hbwaLFzHHFd/ASh2FDk5yfgc2cWsnzHD7HhNPTEV3Hj5vQWdC+w2FojIC5a17PKcouTke73MpZe/xBIJiBlesFxRMgCTQK9imjJTIGDYT6H9vrotG8zGiGoUwpt/5QxdsOCRgd6Pi2cqYu60IjuV7TR+YDSAeb2Gv8CFy+gnPGw+vJ0A8/qC8VR1XoXcrTAK1BudpApdiAMuFwd8TpIWww86Kq55yZfTuQ6w/SEkJdMc1bEYyZIw5nxdP9wo0pU3tugikQdEhICGTo6RTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl9c9wZ4hVCPewVGktKfUeMsYgnZ9e2+hfWTqtGl4/c=;
 b=Rlq7w/N9fIDAilNAl0N8FZEklfAqkqAqp8ODq+RIeMtbDN69a1ftUvPfa6Xd/GUdVn0wrQb1Q6c7xRYGICqRcYwRY1W4NcVarDjxBOwuMF4jHmIjhHgtCFO0cHApHEnUjKvB2TaGSk3O/EsIuyPilEfVDBOAzuhsOcasBP+cmWiopGNavTjfx1XVSO/vWk6/fk5BKWizjCqzm/G3Qs75GqWFASzhZF73A7urxexvkiqRquJ0tstocyEdI8Oi/b6ZeZp4lmeOOXF3ssuUogmaolHADqj9cSaS1ElWvlxn+v7KbBn/U000dGxg978jg7U6RXq8gSEk/iBkykriclgbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl9c9wZ4hVCPewVGktKfUeMsYgnZ9e2+hfWTqtGl4/c=;
 b=OjEGJTekEztbOruP1JHKfgIGLvQLnX72A40AEUmjCjXHYRaQvxv5a57gcEJSvUzYxphxEV3gLX7jVb2K9BoXyk8myWp5QZ8kMzkzvSlU+1vlklAYXlszk/4KDG2taNGj67Sue+vGAKOPSC0EfLU2gI3QlF5hUHZ0ciO+flpJc9A=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB3531.namprd10.prod.outlook.com (2603:10b6:5:154::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 17:18:37 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 17:18:37 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v4 4/4] printk: Drop console_sem during panic
Date:   Wed,  2 Feb 2022 09:18:21 -0800
Message-Id: <20220202171821.179394-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d4ee65b-a808-4ab9-27c0-08d9e6700ca8
X-MS-TrafficTypeDiagnostic: DM6PR10MB3531:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB35311D6C72866F18F281032CDB279@DM6PR10MB3531.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0oSSSdEIwURU7zrIEjlF9vONLgVzp/ObYi+Wfli2/VCQNAySz77BNLojC7+NPU8AiAdL+TpkBOOYmpykCi/7vmUvjNAqdrQAkZNCVGUTINvf+Cn5SPMdXRPvYJIPisFeNuVuGYl+vKzpjHulsFcRx/nuTDluyq2ZaHmydVF2ZsFRVp69xzQw2B3Te+ZhoFGUx+kFst4Q5R+nYJiEYlJ0RmqQgCfiXvXSXJfZhofjUh4blYtKteCmdbBGmzSDfEmQDL5ghJx+yxGFvoabHgTlxHpi0jVW+pBdKb+N2fPNYYA+KZ9P1x4Wm+26jp52PIj/wSj8Qu6yIp0s6beW1aU/E90BjzpjDfI9DP5RDNJyGqe+NUo2lrtigsXaBVieXkKzcohO87JjBdk7390o6P348c3ruNcr/YU72eRMeGt4yIzkfMzP4ivj5ex+y7V0HyuYKfDXfA17a8f2FoEjZgKz/vbvigGBaiFINDgaMlf8Nsngi9TxaJuVDOzJCzl3o1ydvri/wQWw7tcZxTtP7AeRVwXAQ0wtSbk/mSH4pI173i0sxElspRFbZxeL+YEz9MssQGxbOXr5dw0leiQzEezXmHa69x2fHSMgk/OoeZZLBdoieSkOdARkikfHsqO0hAWPvPbXQm1y9Og0pK2WkWP+aocG57QmSFJOzd+H1PMRvGGCGMp/DaPrP690Qqwtil/aR7f73ibBhGF/Cmy1MkQdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(103116003)(1076003)(186003)(2616005)(107886003)(26005)(38100700002)(54906003)(86362001)(38350700002)(36756003)(4326008)(6486002)(52116002)(66946007)(6506007)(6666004)(8936002)(66476007)(8676002)(6512007)(66556008)(110136005)(508600001)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtjkIzYS13NfSYxKvaYWdnMZoWo8Wh80cbWsX0qWMY8lgzJdJ3KRRCPw7RLy?=
 =?us-ascii?Q?g8Rb6FT6gHMPz5hsJYVEgUcsmiNRaCFPSg2T2sDaW+KUUXjBZia7VpNbsfxu?=
 =?us-ascii?Q?/ogxcLtCZYdaMA+QLP4Umb8n64eKpS0KYzbFpQDJ5BfYNA3WqEsrWr0VOj60?=
 =?us-ascii?Q?s0QQh0w4+fo1V6v7qltbT8HRP9G8pqtbpYWQ0jtTwiJAi6pmxSL1E0Al8Q/S?=
 =?us-ascii?Q?tekJ0KFUvAEYWVhGvj0iStVhkhq/FQRqvA/Tg1zn07JiE/7g9SDiB8wqLg4B?=
 =?us-ascii?Q?z3XHvIzGGG10AKNotO3vfNDNP+q9xKP5jDmAugh0FVf5lkOpqCH4/taU/k64?=
 =?us-ascii?Q?YT65zJeu5hlPEZ5kNoiCiKgiOL3xtP3FwVinZnmtWJ+7DCJ9jwbjWjlalauF?=
 =?us-ascii?Q?rp/3bTtUDcZg+Hi5AeQ5WjxJLCHlXEiSSirdQR69KleOy+wyA6KgGyuZpY48?=
 =?us-ascii?Q?K+ENf6XL6xOxcH3RLoLZ3T+OeflWyaanXQ1t6YnzsA1ID7lQTJGj/WaBXsLd?=
 =?us-ascii?Q?VJkTa2uTe9aXmQdRFWtALAQ/gA3vO23gQa0ZxaniLQKMdMsNMjNB08cSbz7Q?=
 =?us-ascii?Q?y1kx8+L3LEZDdmBtuUcAsS72K9nHiQ57U5AkilYDpVBCBIZEZ0S6f8Otjwbq?=
 =?us-ascii?Q?auodw6yX0kF5MhmJwUZ3gJ05KYGCQ6ypuU18067oJAa8Td0+CB5tX3Aw5NHr?=
 =?us-ascii?Q?xyR3t5PYeN2Q26k9B1l1zJ1WJHnNxxpzoJUrVIvAeAThgP2JCAgf0efsdM7N?=
 =?us-ascii?Q?hyfKlXC9ao3dHZGO+WF/AW3HQ7Oec+V1iZZE5VKvspJSsGFyBJxr3VNPfSrY?=
 =?us-ascii?Q?43XbM08zcFmHD9wNRWXizCCUW0biWoyMsVZqQDuWDtpljHT8wlt0XuKOF+Q+?=
 =?us-ascii?Q?JQSvN9dlfgSclOlNzBhI8YBizdu15ybMAnraZTO1tk3XJRyNpzyecTCbsO3i?=
 =?us-ascii?Q?FmN74B/q/8GefQmnDl+YWBDxNEyMhbP9DXoGOb7ZfzH9ngmVeAGJDfzqdju1?=
 =?us-ascii?Q?rGoBd/PuGLXJPQUwGjO7XRjOX/s1DYw6aeuqUSqsfAIoOmbSZijpXqs8NjNa?=
 =?us-ascii?Q?qTZTDjeMK/9sEl3x3jW2/MBbLhSBpy2a/13Iihv2q5aklWs1yvoRuQrrUc2M?=
 =?us-ascii?Q?mlvLhRzHnNbCkHOcvgDijtVsy0fxl7nGKjCTzPMJ1GtIv92YfRYC80BQJuxR?=
 =?us-ascii?Q?Mqaq+GkiB7LUS2XzAI/9Uh3WqIjUWqrz0CKuA1KvD7xFL4DFcwiSfl4UXSDG?=
 =?us-ascii?Q?dv37VK8tz8EwMg8rc3LyxzRD5jtfO5h/czzSRgxcc23Op5SLpehmHi6iVcJw?=
 =?us-ascii?Q?LjCnTiFp06xu4REGHYJdoMoTbJOOOcYQdXzIFppvWT+EbBIZXnOfEjPfTwUb?=
 =?us-ascii?Q?SPyzKQh2mbAd0avK+nGNFn3djqYsV5nMd1fldvExrSvFigg3syIWZOjda75U?=
 =?us-ascii?Q?vlO4aVQ6BCyvneRGrVZ8S0594fCFhePdHWCGIvKd49+6cEmcW41hCLpcI0yz?=
 =?us-ascii?Q?4nfHaR0CO+0hfyrrkcbC0Gmm65Dl/MfqXix+I4O0H9KmzcNCJ/UtFFv42Vbf?=
 =?us-ascii?Q?Lq7zOqMeMnzK0IFrVthwUqJcQ0h+CCzRvtkK/mmteHT9PvNYnSAlZ6op1AQY?=
 =?us-ascii?Q?GLuyWVPvhNO7MGeh/MclZSSMwR6WfbnAJfXwyNK7bCethIUjOgc+7oIKqHCe?=
 =?us-ascii?Q?nBUDsA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4ee65b-a808-4ab9-27c0-08d9e6700ca8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:18:37.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmo9OiFnBv4MrkyZVX0Az6P9pHXXwtT3z2cZ5yzL9OWShtiiNtlWcShLV5RBlDD4DuuJfMWzbSnzFxnHWqa+JVMvCOq/0e3wmawpOgb7ox0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3531
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020097
X-Proofpoint-GUID: fHQX3ynWskir6NjRbm6w74X9t6wONZeQ
X-Proofpoint-ORIG-GUID: fHQX3ynWskir6NjRbm6w74X9t6wONZeQ
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
index 736f00d33087..a174c4b2d156 100644
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

