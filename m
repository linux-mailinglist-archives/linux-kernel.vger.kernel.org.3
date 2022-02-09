Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574A34B0158
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiBIXcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:32:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBIXcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:32:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB6E06EEDC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:32:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KX9W5020151;
        Wed, 9 Feb 2022 23:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5xElEgH6bcMjxMOndqXAbJ3z5HgjC0FhUwvkQXnbmQM=;
 b=zx9aagLCm9N95U8aRkfs0IwtYrMCUokZREofL905Dar6n/6dEUSErW6h1qMmzEDdWv2B
 ycFmt/MjqWG2pQ9cy3JotLBH8pb9PkciUsivQ8uRqsctgTyySMRRNGxRLFMQSmzGv66B
 Qlow9obBcpdEoxg9KlnRfhhz9hyEt9ezocqJ/JeUWVN9sFffc8vRPkiRYAoUlvl9DlOc
 UUYyxa4Jlw32xIN1CVgGvpdviJRK3PRtik12txf1KAtOqC2YQGfuAbKtyVBXUi3AiRqL
 bhPR1kVm49MIiKWZ7+IxdK10dOqmvZGhf7VfK8NDss1qflUpvpK7XqxUWOepuWwgT4XK 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wyd4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFX117827;
        Wed, 9 Feb 2022 23:29:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWa68UIMNN8DDCdlAioyxcHdUgFqV5YnhlpMgbphwXzIrnKLc89O3ghsz8mN3cnD/mS7z6gsamhs0dRa8Toa06RGdQ6V0dSzORsAtwlSUK9kZYg5uWEKvImnbHKFFKslrmsK63kQ0o8g/lcFSfzaLJ3CsMyGJqnwbkDbyTYr+/VucTAoiBHUpgbEH/WCw9O+B703adB43i8c3bz794fbLLh71glBvTNbkQrINAvLgIpyKrLwYPdVFbkK3CdLZhKDq0CsjINbXPa1glwaJaXmZ3FCzo9QbH1SKnXFDEkqQ2KbdJ+phSpsQ8KguTDxrh1DrRYOt3Os43H+6XWgBIyebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xElEgH6bcMjxMOndqXAbJ3z5HgjC0FhUwvkQXnbmQM=;
 b=iX98q4p7VEg8a89ifz+2qNBNUH8jiXYsgVYIFAVLa8bwwGkEn0yCo5cyqSpZ5N88yz6v4d+YbkLWCzsXa8i828cS541gK7uCJadscArE4kyugdorMfZ1gx2zO4RJpiIyg1lRGGvd/L3RyP7UtZl//vITLXn9cax4G2wAMogh0+EO5CfSZyuwTMSPNqpxYnlziwQJd1g5fibUz/K7NEgeK0CjAUxSTRH+Lz594+9VTc75l5AFW9YJXAu0GSiKaljwlAtBK4pLvel2JSiiy3CT0m6Qsq2xnxajI5xbYAnl2XMJSnctss6XGzhdiBhJ9Vw1QUINx5TMPfNDLCcWNIQO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xElEgH6bcMjxMOndqXAbJ3z5HgjC0FhUwvkQXnbmQM=;
 b=IPNbGpXy0p2JTi0XZDFNCuqfEL6yOG1hfLmpjlurGm7TY1aoAKJTEog9jC0FEX9ZrzyjbltxmKSt0wFh+eLR1Jv9vx2TOx9GzZAlzlOc4bqiiB0VzREQ6/+lDdF4kpiLmPiOM0EAIWmiDKRj7sqQaTKlv3PDzdjG6++i97tnFKw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:51 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:51 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V8 3/8] fork: add USER_WORKER flag to not dup/clone files
Date:   Wed,  9 Feb 2022 17:29:34 -0600
Message-Id: <20220209232939.9169-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209232939.9169-1-michael.christie@oracle.com>
References: <20220209232939.9169-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:610:b3::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fbf2a44-b044-4f17-8673-08d9ec2411cc
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB300721C07C469E2AC93A665EF12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugtBnuP+5aO+SNJ9phIwrvQYqUTxyalGGbFVut7qCoB58zTl6HDLH9v8wNVSglBFADxISickD/eBT7Dq+qAGIftjppPqrQ8+5Z+NF4IxN+kRV+baI9Ur7CU73B/v80ZVCktgbPgIUNEpbFmfy+g/apJwZCQMBmmDA90zXhY1qkIFMeuUXr46RBu7qSVPI+vaFALTLDlsmsg79cwqUeXDFaRHipfHGOJRwONKDdRE/k9N8engnJXoefEKpZB6PvtwmxVXjNHPbsN6BZJZOjZLDiPIQGowsH5Q3oouMj2YjDxJ8lPprHlwiEV9eRYJ2x6r3xDuoSg9zU5rtc0h9kU5LpEk2GE7ksc89iSZoSC3iUY3rKKlLyzQbUWN07VV5AxIlR+7iWKDXbV9cYDnwU3iJ/AZz7LjGKCT6oYsXkqMx5S6dUnHhAK/6Qdwa5sSOcogCxbeh92Hzp/1B8bdQ5zKf0rFe4IbBrgI9zIhEvzwakqA8ZFm0UnqcqJ3BntmlZLCua1eYJX0EH7UU4EAAvgUfeLR2o65M6MjKp0UYk0FmobdGJd2boCr4IXTJIIqM5kr2zRBtW1fwcf5B17Nh4yi2K9OBnjaRlT3/wJmRtrOGU33nkPX32RGOi1MuLQY+hAslvsq8ELK1sii+WLh+wghw00E//YAtbSZPc9BVATDHG6OoL5ze6WtPxKHOUbNEC4gtm1eAcpSX9msylbz4m0ZrPGU1/GmCYsPpPPcqaSJgSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uncSZwZsNt4+aix0p6vEIaFIcdPzH/+6f83fnzurl0ACcCxqrebTK/FimsOV?=
 =?us-ascii?Q?xiWUmblGF/AADmdNNSUOcaJJtaOv394Rmcvq45jwNDV+isnFPtirmSNc2BRX?=
 =?us-ascii?Q?nJwgtbmpaTuRahlWM4x36AeBEU/VS8X1mnHpjD4T3CXPeODU8z8lf/rYiCnF?=
 =?us-ascii?Q?Rvie/8u2NbKdf4SdOO7ikPpvSPdxz5Z3YQ0r9Y00kV+4o5p+C6OjGeDT0VJZ?=
 =?us-ascii?Q?U8ty24ZRP37zbKuiUF5KqO4K4XQx6bQccN93Gk0bKvgtPs9Bvn9lkPRl1MT+?=
 =?us-ascii?Q?MQ9rnsuL/zIYfNmx3C2kzqzmcgWMpiGk+QsMNl7fkAXTJ3U92qpQ3PFPySWl?=
 =?us-ascii?Q?AYTyZRDRL5rMcLUMSc88WO+fDFT5CLgfON7IOCev5OSNX1dkX6eLbCjUqmzS?=
 =?us-ascii?Q?beTAJtVU+YlOF9e1cXRbXRrp2jJMBU1M9uoFRDmfjGXIUEHqPHlanXO3UbhU?=
 =?us-ascii?Q?J2RrzUcMbBPxaceB4QuO44JFIlR1VQD0O6WXJ/+u3L+npFv48JZmGNcvVoLp?=
 =?us-ascii?Q?SoTMvsK4yyOpA2h9Pz6KpZEHzt6M/jyGMsptfgfcHL2Q27V9XB2YE5KYGmTE?=
 =?us-ascii?Q?wBjukLBqoZ/HL35LZGxXrVOgePjBXg89N/3XKMxokSTxloA8QsAMx56HdZ5E?=
 =?us-ascii?Q?ZbZ4EJwfA1oV7XzKa29NIz8Y/CegzDVH0Hz1YgHAm3htNj+0DXzhVzZkQni4?=
 =?us-ascii?Q?AQ6ZV5lQH3pMCNSZOYK3ZeC9/fm3sWMsnqDLgbOn1/zqDQ43sYZCDxZEpwEZ?=
 =?us-ascii?Q?U+WE6cAxXmtaINHvJ0CLtmYt9hbl93NWfx+aXkgiBDj9sCAZYSp0QTWguHdi?=
 =?us-ascii?Q?G3yKln49EdBZPx1xqtzHE08nF3iHdvFH0Ye87dV6R6DKdxE80RJHMWY81U61?=
 =?us-ascii?Q?yo5egxAKkyVDgiAbrRcFW+Junq9BPrO3cMbeLNOmAoyxxp5QvFkRl7xugtqv?=
 =?us-ascii?Q?xTTf2RqIrLGQQDWCgoRDPjHJ4ujTp24fJC24h14dUWYZJPcaUyVLRF90KPvC?=
 =?us-ascii?Q?nYxfm3VLg1fnb2+mUOSBXNyQHqWpjUoAFrh8yc8wFpLW5swsaKp6jhwHoCMG?=
 =?us-ascii?Q?579RjLMEAQ7m9k9Q/Qqn/Ca0ME24Yl2QsQAyC1nSgOTqnJ0ckS4LP/TVM9TI?=
 =?us-ascii?Q?0N+BwywBybSSJ+ZxJ62S+cOsZKprVs5b1j3BW03FGdnxwFzmu6swmXl3nbmq?=
 =?us-ascii?Q?9GT4pQMt9BUEk+SkjLwxhcRsFDqcV/WhBBcQtfmNbrHiFB0oq8/FNs4FUbhu?=
 =?us-ascii?Q?D4QNdUB+SOrts3Y0oAk3nr2w79LO8vD4KUCCDzhxxMymAR+TA30Kdnpq/dUb?=
 =?us-ascii?Q?yRUtr2QNehTt8bhj4nSL9Zwuh1GZTCzTiTT9KBkretkFJkK7aV2IfHcmoJle?=
 =?us-ascii?Q?9qUmuIKLbtkU+X7Z3Pub8hTOTZxinD8lFW94bv/3bJgQHCytzyiGIDjSq2yN?=
 =?us-ascii?Q?91ZpxKRQkITVFyf0AQnGYOF2xmfnGMxnMTYCV3gUKVCWGNgxqpP4hFB+3mVW?=
 =?us-ascii?Q?LL/6mo+cxuK/zH1f5qJDkHkCBZGijp+IucTWe826709qRybVZHRoOQH+5XAK?=
 =?us-ascii?Q?J9kPRkyEP1IynOPWuWKWD9dUkYJAZEA7o6BicAEl2LC2kSipOpAU4U5n8acR?=
 =?us-ascii?Q?c87gI03dwXPMRNIvpwt1i2XdpB+Tr98O0ZV28qRbHnbK+mLEORrZv53x3NoE?=
 =?us-ascii?Q?jcVInw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbf2a44-b044-4f17-8673-08d9ec2411cc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:51.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/herNsvyAr/Nz1u/yu2n6ZcXSawpb/4lLAmeCrZfDxcyTDOmecBeWGRsM3b2jTCps/Jw6ZD31sqtjoDTcrwNUjDysplqBBJKcJhTMIQHZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=947 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: zJUb634q_kYtQMjk3PEFumu2YUIXtJfu
X-Proofpoint-ORIG-GUID: zJUb634q_kYtQMjk3PEFumu2YUIXtJfu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it creates a thread using a helper based on
copy_process we can't dup or clone the parent's files/FDS because it
would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0467b3ce1c94..706ca3dc3423 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
+#define USER_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 1f6e7184b31f..81a1096d6ee9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1530,7 +1530,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1542,6 +1543,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2153,7 +2159,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & USER_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

