Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442E4A76AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbiBBRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:18:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41204 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346204AbiBBRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:18:55 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HFmqw012793;
        Wed, 2 Feb 2022 17:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=1X2PFsnxKSNbS+iboXD4HyS6B1JFyvg7cuRcWjccXD4=;
 b=szSOXGjeSFVJheddFM4Ib8sS7R11YNxeCNa3XVypUyynO7FVucjAXZKPaj2AfxBBgedg
 6mlOQBplbyToviXDIjhs8WZlh82ie9kv8ETvSFsRAcu8bi0Jln0tJP/Zo9pKDtT0DmGH
 7TctTgeIFcEGLDWmL1o+HuiLRwL0BaNKBJGp1WErl1XIfVJCgFzH6VjzuBoI3w2T07zJ
 61f4xzNg4nOGRTRUhIn9BHswCYQIf2ZXDRbXFphzjUadxmiP4cvW+5Yc2/3av0wI1mIn
 6PiwXq7igRagidt1t3h595ZRuLH97hjC0ySvUPotDXcaHzzMbN+AIRKKcxidDHZd8dx4 TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fxs17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212HHQTp184160;
        Wed, 2 Feb 2022 17:18:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by userp3030.oracle.com with ESMTP id 3dvtq34d8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oxbmch/CKFh6KXW/HSBu3dKZE59gWIiAlJddVzS1QF/MRDL/RRIXA335u7DcEu217UNW3Wm512bPfgvBIKiOSx5hTDdseVwf23xZ0/6yHDn0TUk9Go4CCewg3z/tPCab8iDWsnZ6IoSBspKXfN0BRczoFJ/OX+Y6/pDZYIns4jezKueovp4hK4w31kAVr+fnA7hT556wk1wum8b0MNWGHS1uLMe2RdcSny0oaZfZjKwYLYYnrC3Ml8zFnL4rg51cmQGrF7noZeIYCaA1hWsYZeM5sUDgP2d/nmWWkHrVV+8aimVu+LCYzELBmjSq/9JEP1JYgPMZf/ivv6IbkyxLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X2PFsnxKSNbS+iboXD4HyS6B1JFyvg7cuRcWjccXD4=;
 b=duP2Qt9ZNuiET5S09QIP9K5flr7CdN47k974/2npoq1CEmuFnud4Lz6oTGjxWY4V1IFvJ4fm4wiCb/UvfJIGpAjaaAHm5bqQJemm0aaS3xmmBZx7lR9OwklhDaOMSpIG4nqj5o5BQ1iXfavvZPPFadGfKNMnC/Qd5pJ77ZlhqwqAtOnaUDVTOFD0Ih+qAjzMu8H0pTxkkfluK73OlHPwui4G+f6iG+A+KFPrrrLnbCLiAp5QRLccIeRggJ7HxHNIafTHe0ElUjuZjP59v1O55deBg0BsAEHDT5+azOU1Qi5szQO7yfKe4oPw+BGZ/38uZJ3kNscPM3OX+BATzk1trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X2PFsnxKSNbS+iboXD4HyS6B1JFyvg7cuRcWjccXD4=;
 b=yofrCFo9Ffa/bEMYE7teai4wmc8pMBAVbeXNw+YQ6fuKTntg12rWnXfX3Bsn5Zs45eTiAfxsccoNYDPvK21t4M0wbrp7qU1ll1QoAw4WZgfDPYAuAq/UbSKaUeq4Dq1wWSEnP518KmjeCqnpcj6iaDFrU9hjSWrblpKX05JyNEE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:18:34 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 17:18:34 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v4 3/4] printk: Avoid livelock with heavy printk during panic
Date:   Wed,  2 Feb 2022 09:18:20 -0800
Message-Id: <20220202171821.179394-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb1220b-7e66-4955-3561-08d9e6700ac6
X-MS-TrafficTypeDiagnostic: DM6PR10MB4236:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4236BD44A1CB32AD2E7701BBDB279@DM6PR10MB4236.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyWj4MoMYJTN9IcPj7XfVgv3Vw/Y5a/Szpz+OMS9LpwIHn18H5YVhP+Bd/omVuvrjsB0mNvgRjr/BeSY1jlLEKDrxgF3tvPTK7w8JLqzPvIRZPkZNs5AoQ2idnA8jUfJUhiMJ2ha210TesbqyMTkQFig6iMs8Yfpg88HDpzIl6qnRCRWqnyOssAx3Z6lyiQ3cqk42obOZ37/sNz4C5/yyj2PTxzWE5zpd6jTcHW79In+pUluDylP/8wCSuo3l+IPiGs/uztfPPhIWRTV1PreeYX+ag4iGlNGS0Q9ikaYkBgmkI1TnRUVlux7w3sa7yPr/EziNZCg6jXzvsTlsHkaX0e6hqIe7yE5nUwEeEpULTAazFAO83Cv2FpX34BF+maCT6tAXxsVgJ2dirF6ENjmX4vHQVUYmKPuxrMQtDz2jv2Z/852z4Ensn6iOwIZa5TE/CWPzWzp5Yt2QyBnq7H9FqZgofjF3YXjj2+xQox78yp2DIvd/3AQ2FQfLidzUV8XIRqe1scRqKw4bGpiUf1r1aS4jTTYQNO+CTzoZNqEZ3ybKvUDmhgP+5rtK3/7lgJSUNQqW6E5Kxv4hwPmCt7GUAAqfNl1TCr0z3DWNN5Gp92Z/ykp8YXljTRgXtPUfR13ZeGVbg58o2M2PUoSLJySUL6Y3WiUMHHvUt1uauD34NYs545/1uRyu3GVY4xXt2qT2p4/mApohiWTJRIV/wJ4tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(186003)(26005)(6486002)(83380400001)(2616005)(107886003)(36756003)(2906002)(103116003)(5660300002)(86362001)(54906003)(6512007)(52116002)(66946007)(66476007)(38350700002)(110136005)(38100700002)(66556008)(6506007)(508600001)(6666004)(4326008)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kOGXujxlJJx9cheAfOOnoo+9PXqz7NUNqrrZtip8g813WsO9Ta8nUBXAePzT?=
 =?us-ascii?Q?Hxhy8K24KC5Nytx8QzDUea7XWEFLxekC+khJiXCB/7uue6cE4M7n2rcabuHv?=
 =?us-ascii?Q?4ywVZ+HWMZlKQB8/UZcHFIflpwbVLw95z6rI2xHq7dBue0nCJGhp5AsTIT4Y?=
 =?us-ascii?Q?v8KYWYtUhgJBeTLPcS2Bt6Y7tqYss87nuVIQb/uBbCIrpCoEws8KUlHOWAu7?=
 =?us-ascii?Q?1YjaHB8ewUdIDSSa7GcDWJOMZF+WZDPEECu2pB5sqhyJJ1vBOe/QIdu3sfoL?=
 =?us-ascii?Q?B+zS+Y3SPdMviczC1FHzHNUlpbqe2lxKmhctaw20qwoKgMsdyDH3/FWEgPuX?=
 =?us-ascii?Q?KNC3S5CMGW8DJLk6EzIUxsaN+RPtuIblmcEDTvEIYCPxyVlOf2SPYaNIoKRe?=
 =?us-ascii?Q?3kNxcqinEuz6KgsN2JXIj3OOipzlt+FmGh6s/itwC3wm1qLuTVTiePXtLqZt?=
 =?us-ascii?Q?pDmuO1vwniDF8aGdV22dKB/le6N+rYi5LZrjTTAzivNN4d0wKdKvovOtzfsy?=
 =?us-ascii?Q?x9MLpyS/TXtwfMOyizO8wWpmiWD7WYa40XPUG6ZXRqq3qLoW78uao+jAc2pp?=
 =?us-ascii?Q?Vl5bluIFPh1tc59qvxOOLRfuJ+Iw8AEDUX72sbyYkFN0kvc1ooR48n7kG4Fh?=
 =?us-ascii?Q?U70EzCoAiek4FsFT65VMT6B6vTax5MDukx04Mb9xliwYrR7NFuuITCuL0COa?=
 =?us-ascii?Q?Ic6ca0ZAeR0oGGQSxaJK1HFMCzAa91XT2I7ffVieTqMZg+eqX90NwyB6jv/W?=
 =?us-ascii?Q?t9/JUO8BPj4ssQRimG2huwYb7B8mW6xw/055jFLVVSq8u8YwQL79mRf3ZQom?=
 =?us-ascii?Q?n+6ZAmrKBolUph91DUwd/6rAFM+rM/KqK99+CEApvPHqkfiNumkHehgqaG+M?=
 =?us-ascii?Q?TqlKZWG700nxecP/wmulVi1i9wcDgYqGPL5MWH8PHd/M04TZOUf0iT+P9SuQ?=
 =?us-ascii?Q?x9Ld5VhTsastnAolzZ30zXuUuI1D/fkt/bdhJ+bhY0Q+d8me6sqlFES7kG6N?=
 =?us-ascii?Q?hxHvKA8XUODKch8TgoExztX8iXNDSc8V8JI8i8MZ34cb6gvZ8p8H+PZG2Tff?=
 =?us-ascii?Q?r0cDrihHOk6DytNsc+Bb6meajmUi4p05IADduWR62eR26FOU4jyEJzn2YO7k?=
 =?us-ascii?Q?1lCHI1eJ+oIfCWAQNB8YxjzipFwdi31hliwCXHOL0wwQsV9bWQFj4Jy7iXzC?=
 =?us-ascii?Q?Zw2cTfClWAdd8tHwx4NmqSHeft253dZRTczLao/jyps6ewzcSBX4KPT42NXk?=
 =?us-ascii?Q?HNOvU/MSBMyt1KPDJI6v0mbWUX3/oAwDbVbwosN0ApM5CMaUImW/128x5Jcc?=
 =?us-ascii?Q?EDKGNjbQ2zu9bEV2ghJkrY0OY73JqvThrM03IKSdeAyA3O+24c4FM7azDleD?=
 =?us-ascii?Q?53P/65mz3WmXgaBKZR42jg11xIPYTjTWjV9YbjqFOl35VXKqERf8OWvRe5rs?=
 =?us-ascii?Q?Lac42p689WKlh7gh3eL6e9wwOdTimsKZ7TtFIdiVGrpUKI5UmSg4xUU/3AXX?=
 =?us-ascii?Q?53Q8pemEpxpmCkGiYxcfjk5u7+9/eXhJBxwMRMiqnxuhBa+0N9qtY8s1389A?=
 =?us-ascii?Q?9qqDNTbH/QYzMqnzjoLZccNMvAy6STo4HRo/8DlMWScXFlb/YC0le+CvMzmL?=
 =?us-ascii?Q?AfSBRzPlryHU6K2+9iSU9Vb9737M0diWpRIc9lgwJbNg6jeWSzvY3TG8ijLK?=
 =?us-ascii?Q?MoUqvw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb1220b-7e66-4955-3561-08d9e6700ac6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:18:34.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuH3996yuAhsZa3ArV+Vydvc7vvikrp1LvFbBA+lcYW8LSNsuKkkaSejNZNwyJssldOAsst+hUywUURDz7nJr28+6Apcj3tDz9ZapSK3L8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020097
X-Proofpoint-GUID: H99jLAZDGZEasr6OWl49C9z3_HUPDZ99
X-Proofpoint-ORIG-GUID: H99jLAZDGZEasr6OWl49C9z3_HUPDZ99
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During panic(), if another CPU is writing heavily the kernel log (e.g.
via /dev/kmsg), then the panic CPU may livelock writing out its messages
to the console. Note when too many messages are dropped during panic and
suppress further printk, except from the panic CPU. This could result in
some important messages being dropped. However, messages are already
being dropped, so this approach at least prevents a livelock.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v3: Use pr_warn_once, and don't break the message line
    v2: Add pr_warn when we suppress printk on non-panic CPU

 kernel/printk/printk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dfac84876e7a..736f00d33087 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -93,6 +93,12 @@ EXPORT_SYMBOL_GPL(console_drivers);
  */
 int __read_mostly suppress_printk;
 
+/*
+ * During panic, heavy printk by other CPUs can delay the
+ * panic and risk deadlock on console resources.
+ */
+int __read_mostly suppress_panic_printk;
+
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
@@ -2233,6 +2239,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
+	if (unlikely(suppress_panic_printk) &&
+	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+		return 0;
+
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		in_sched = true;
@@ -2618,6 +2628,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[CONSOLE_LOG_MAX];
+	static int panic_console_dropped;
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
@@ -2672,6 +2683,10 @@ void console_unlock(void)
 		if (console_seq != r.info->seq) {
 			console_dropped += r.info->seq - console_seq;
 			console_seq = r.info->seq;
+			if (panic_in_progress() && panic_console_dropped++ > 10) {
+				suppress_panic_printk = 1;
+				pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
+			}
 		}
 
 		if (suppress_message_printing(r.info->level)) {
-- 
2.30.2

