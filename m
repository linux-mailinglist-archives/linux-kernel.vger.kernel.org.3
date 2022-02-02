Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2D4A76A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiBBRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:18:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54622 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346178AbiBBRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:18:50 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HFa86009072;
        Wed, 2 Feb 2022 17:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=90njUJI3kewk5sKs0oy+T2soqd04IF2f95OXXVuA9Y4=;
 b=Tsoo3gliQ0sLu/pBE5nVPmz2UIkb9jFtlVXVMkER9cWXOf93Iwkfw0whIOPkAjq1ZU63
 VfIE/AiXw9ndevt7ZUw8rc44NzPGerHvA09yPS857d9r3kJftvLtdmB3LHyIgKCU0WRf
 bjm61hu5EeKKcLVur1rXDgbCWscpOrz8oDJLy432tE7B2IRquehS+1xQv92YDzgK1ACB
 2Zw7sL1x4LaV+c0WRQIqKy2+xsCR7uXAIWBLHNYejQu21B0lcr9Rv7ooVnPHNAMq3tpX
 2DnV5SizUTujTyGXM3edtuFltHYJK9cC+N/7UdZixKMzDQJgvUbfO9Nl1sxkJcdsTFOK kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatxtyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212HFkEP196047;
        Wed, 2 Feb 2022 17:18:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by aserp3030.oracle.com with ESMTP id 3dvumhum73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAnwWs/laGIcqHZhUUF5JtL/yJpKZeY77ik2yofpVz+JPq/WczEeFwFpDmjt+1pEz6jHmQovy80AqyzxKMDyz+zp2hh50Xy69Y8Od4C/AVZXpiJq9FFsyem8sn7orGFVeY+zm7ib9wnNGBT6nY1vc6JaZLwkvqKgWELtMlg9Nx84jvD0c5rpq6Q/uaAS9Sts6edZMxLPB3JTmWrITn+R+orkDHpmwOA+356AXBsK0ejKY8oASosav5gjElmue52FfS+bKissMR34e4sn+ntjX0sjsIO+MqC4G2T+Tkoi8NB0gWGa5LxZZ7i1DCrlFfjTvc84znsNnfJJEBonGGCVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90njUJI3kewk5sKs0oy+T2soqd04IF2f95OXXVuA9Y4=;
 b=VRA7Thde7Mgm5lM+XeHJqcvH7XotNkxBl+Yir/K0aaUiL9zEQ2cSy9QPQvS+HbXKFRlSIUSjCPVkL93mRAARhLVouPypj+kZbcqT8so13SbwTN2hPUI/3BV5ctJF6WJkVAUykVtuwkDRQbwLZ5yG3RVBgZESTFMNPICNZSmlYELkwOpnrKIS4cw01qmuQd7ddDdgfsojriPfD+YwVpAEMtHxaMli/YZvi4X/1fwz2L/B2ixNufdrK3JNYBuN21OQY91O4raVUGnlY/PzVzwnwDG9VaBhCR5Wtc192Ppr2GjVGBJoRvQ6HeQGbfwlGQkShUW3fdR9AMuJR6Y0jSuQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90njUJI3kewk5sKs0oy+T2soqd04IF2f95OXXVuA9Y4=;
 b=a+sQEeX13rzyJ49UkJwcqx/KnTtnsnylwq+/O/3oDybkNsJ6x2xtM1+CvdcOhjC2nZv9yeHurPNcdn+d4iboDXRD+hGJs1RrV+V8fHWrtvoo5+QevH8ijvWeEngoV+EG5vVatMH7HOYK06VQTsy8WMu3f3KoxorD/xXY0F0iLxs=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:18:28 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 17:18:28 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v4 1/4] printk: Add panic_in_progress helper
Date:   Wed,  2 Feb 2022 09:18:18 -0800
Message-Id: <20220202171821.179394-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a280b0a6-ba44-4f3b-8bcb-08d9e6700726
X-MS-TrafficTypeDiagnostic: DM6PR10MB4236:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB42363677BA66E35269AFC794DB279@DM6PR10MB4236.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCMwXJvvIkhiZZa4+k9AmRcKzbhxXMG9WTSKjaPWbspyVNX6QtPE9HVpWvuUojlYVChPCmisRVg8q12jqMA0inOeraohRTA89c4oukQtaDS0pwKSeyjqKkdcrI86bD1I6Xf9Jb7nRy1rc8782Fesry1u2Eo3/OoxeZhpizKdXSiDzEBkvc7My6ogucalCwPGwkyAWgrh0wIYcFwiSvDNyQvpX+dNBnsPJdg/mkhbRJH5stC7bnqIrsQRZFa4nvZr10MB5zzHwnhn6sAGeg58sBSm09jOhNJvqXoUFMauvhN8I3ehua0xpeIHa+nKT69bpAuAQn543KXm9cEUV1nwvIDw5BGc+nIILZ7uro1gfwdM1PhwGLKWL3x7HG7jeWgSiTGzcY1N8XUuLKIZrCvc/1d/26nWF3i/zP0LsWw5K36Zu7cH9DqlYdUS5pGu77VZB2Ke8dMWeiHjwMsQBLgMVKmbLsXdLjpEV1B5418lrgf5R2jA4+B7LSJb/WCKIe+N3EgOORDgK/ysHEOgYxpED2pIpmBbnu0dgCCoygjQ+gZcoI1ieLKgn2FYKLFQYFY1gsNTyXOTExyMHLv/EUFksLob+pnCPbm63wnZIRcqYa6bheJSytIjHi1UiV9mlvcv5TQByeq/3tgs9Eo6txwwyFk5hhdpds5a+Qp1vWT6FO+N35bI/6aHCr5xKrR2Qb11L0QeGePys6ZX9Orp9VsB0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(186003)(26005)(6486002)(83380400001)(2616005)(107886003)(36756003)(2906002)(103116003)(5660300002)(86362001)(54906003)(6512007)(52116002)(66946007)(66476007)(38350700002)(110136005)(38100700002)(66556008)(6506007)(508600001)(6666004)(4326008)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lRZYzVbziwgZfCurs4s/aQtDQtXlCLmuB+BJXaAQFAGeRr0OXkLUwAh+Qz8?=
 =?us-ascii?Q?auDm0AfyMW4deMe5GDRB4wFfgXDsgmIJ3TxmGGxCLpXlJ/c17FG3NhzeiGOj?=
 =?us-ascii?Q?qTQPOLbwhHI9ML0Zpysl8W8IEp0ilyo/nTGzKyHDT+sImgVfxw+0nZJDUHHk?=
 =?us-ascii?Q?2sqaq+4pKixnNsp7170IOK+g6s8txb09ke1lwrY39qmbRq8dADiAb3XP9Q32?=
 =?us-ascii?Q?ohQuFOuAucnt5x5Lp8IIaHUN3+5e1bLDjuObTmraRI+7Aq8a53JgA+gcjMK7?=
 =?us-ascii?Q?VwpJbRle2ZQL3YLqZyg8BNcr9wP2nw42v2Rxcz4U6qAvuV2pLHmiYDfLuRZd?=
 =?us-ascii?Q?JvriezyQXANxcyyH0BnlYNQUDEyDatHJvOY22pthWq9a1ezuy+BsdGQdikip?=
 =?us-ascii?Q?fTamtCYt1+SVSQz+OUqzy4DoSGf6vm1G6J102RZ16UXA5LenRXwH9idVav+g?=
 =?us-ascii?Q?Qjw5MG2DKhp2c/UQIZi3LTDGRRdkzcbLBHDp8nipKjn3r/+Ux+ldP5W0lnVP?=
 =?us-ascii?Q?uxTZqQuV7QG2zyC6HbZxEyRikW60LdOyCx3LxdDVD7TsWF81u/295JHrJT+x?=
 =?us-ascii?Q?rCsYS9lcTASoVwTK+T3H22BP6Q7yDs6KefXwC+7NAoDJ3O/PbxWwPR6PEDX0?=
 =?us-ascii?Q?dymFF8pt7VrgoG0HcC9BEb0L46xVgnioQw0wUpJSEVYufW/rxI4MplpGpi1o?=
 =?us-ascii?Q?3yQd0mf8lIeWP/EFiStTKzBNy2Ej4xd5ErIqMJJ8CNCJO6A8RiVDo2nJgnsb?=
 =?us-ascii?Q?o2zkBAdOVHO/s7QyoMcqkkt6o4nAiiJ5ur6nD7L5nKzORP0G5XYvZ5FLeLTP?=
 =?us-ascii?Q?ZvMMQMo65uNpAVNHidBAmxj4anM7wUSmVDCP7BdYJFWaH9Pjk09pAP8KYj2j?=
 =?us-ascii?Q?DH2QcUNjl2AKcIJ4T9+YjQVzGC+AjN+iZF8ZEpBBin5vtp6lu9rVAtxo+zDq?=
 =?us-ascii?Q?AX0yLuleTLfR2vGYvGI8RJsXZJUXcjqvzrW2jFBKFehXBMLrLeYhH4Bt3lF5?=
 =?us-ascii?Q?jyBQBUyqcrCyms1pS3YQJdr+v20p6IbyUE+IaXidTsjh7b9aneMSPoeGoB+S?=
 =?us-ascii?Q?cS0bAcDolkS2QrnBM6O8Gbej0Wla+2mH13vsDXYvcBwr7in66OvXRYEYhaYI?=
 =?us-ascii?Q?ltlwGfI9Wucj0YVrqUvbLFm0H8mlybDC8R1OSx0EJflsqpOXWK2ytYl9Br3a?=
 =?us-ascii?Q?4P1eybU8Y8St3lmW0JJjPJPo7p4G83fHjwBn4WjQyzWeIUUbpeMAxmdMtKAq?=
 =?us-ascii?Q?SUFFbH/rDThfip3q/qQPiPeoB53rppMmZned0bWWXgEkLqUptm/9SCMCQqpt?=
 =?us-ascii?Q?d6jfL0hMm1S+6BwfyvruxUbptDmRbIpmQh6MFltqZ9QPPAf4ArYx4c/NL7lb?=
 =?us-ascii?Q?o3kA2HUhu1EXaRQFt3/pWS3G3GlJ6gXRChzLBAlpGSwIGizVX280UfjqTqSG?=
 =?us-ascii?Q?om9Ycn0jYoktllTilcZrwQgnT/raXD0dqLytwDg1RTgLey9GYB6nXcoWWZYG?=
 =?us-ascii?Q?PrT9MCkIURsDpcZm4GQ1RTISSHvBhrJlleIYf8oQJsu03pRK2i+OdRim2fJT?=
 =?us-ascii?Q?hjpMytuhm/8yvF1GKKOm7B5lMhQZ4DIy1UUiB5ST3NAr06SUdI9SK9DhCnua?=
 =?us-ascii?Q?3k3Xizz85ROX/T2Qvn0DudJRyjYxVEfNCa3tWppmeu3nOv/KlYCQBTRBpHfZ?=
 =?us-ascii?Q?D1rEcg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a280b0a6-ba44-4f3b-8bcb-08d9e6700726
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:18:28.2202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NVhu2DUtJi/aZ63Q5599KtXkAr6vLfOEf+tWV4XtBRkkxgmpsvdcha1LKBC52qATWyjiHozJM0cE/k60udmMuwQbfIJlDfAEE28XhLREcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020097
X-Proofpoint-GUID: a_EvTsoMmzAC-itXVupDpwyQapQeKmwl
X-Proofpoint-ORIG-GUID: a_EvTsoMmzAC-itXVupDpwyQapQeKmwl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used help avoid deadlocks during panics. Although it would
be better to include this in linux/panic.h, it would require that header
to include linux/atomic.h as well. On some architectures, this results
in a circular dependency as well. So instead add the helper directly to
printk.c.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v4: Move helper outside CONFIG_PRINTK section
    v3: Move the helper into printk.c due to circular include
    v2: Switch from macro to static inline function

 kernel/printk/printk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..e3d986dd49a1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -256,6 +256,11 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
+static bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
-- 
2.30.2

