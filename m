Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08F4B4F90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352329AbiBNMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352194AbiBNMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:03:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049E6D9C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EAvAmD018836;
        Mon, 14 Feb 2022 12:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=K8ffF/DIITezGYp1oGJzxiKDxgW5J76IxsHozq+1X54=;
 b=G7WBiuD9kzoPRjkbxHCwjAgbfRo4FkPH1+oMgkN2m76RvUMtaHeTtLxxPKHNPtf4v+mU
 HHzuv37ocBJ4zUTtFzHjNxOMOpWs9gjkJkr38FRSJRglVIkaMvbgShLc24rE72IHhyTO
 iSPTknPJIK6mR/YQe4+/ly1UfiSWWm+j8F00jL/A6tgzcFjMWw7rN+b7YScHx++MvRcm
 MLOELTJCBk5EXmaSOaSU3L9BAGOur1hyvX8NI+heSD3OkUljVFJpVuZe4fhfTgKj3gPz
 HlQZh449EPAygWWI9m61tO/kUd50jjUgqyWfstlI0mUYTcGxPGfkZyDzQInrXM3l2EkB TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e65euc5qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBuOEG176340;
        Mon, 14 Feb 2022 12:03:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3e62xd07e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEWkD+zeDOG6liEwSrGyUH2PSG/JmGzO3VGBazv3ucK3FsAlMwcgWrFBy9Uuv2y7jBqrGFileOvUhwkKXUD8qnGistphiut0BJpKRrlxgLzpm+dFp4IOCvccIofafMoAxxTcjqgo7swOgbzi57i6vjK22iFFh3fhFvF/9SXpm1AKFx8hbkbGJ6VPeolp4202LYWkJ/GfAocNcp/0439sUkRaIXQepGDRb/Gi8WPOycKomiTuA1L6IHoikk1h3D35ohsamnciZHqQLlD1naGG8rfQzsOVNwcVaExybW22yUpJwa0Szh9w2bbgDQr0SCfxY6+rUDgzlEH2N5yuKkDxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8ffF/DIITezGYp1oGJzxiKDxgW5J76IxsHozq+1X54=;
 b=j5uENRAj41b5sUbAqqPnwRIjMaBVgmj+L2D08NRVBVg/YB51RVqJEaOtT86yZM/pji5lq0wYiyXi7xazCa1WtP5I0jW1in/Fwr4JK+oqIuOlwSEZI/h7xqKrNXtF6hvRbuDZEzSzJt9+qwnrjJa1LBheKfr9s9ymt/7oD6elnrhhc0VGzPy+ly1Sh6i1A9SA+daVjtcxYhhFAAU5DytuNtXL5TZxnGBj00j9j9KpLr7yL0FAqUfjbN1txJsiBk8/lP7/qolvKdfasz+WgMQxE6nVcXGFfi9b2PwVX54cytEX2naQ65dtj778fQ9bUO+Sasvb0bdwpPZHueK7nkToQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8ffF/DIITezGYp1oGJzxiKDxgW5J76IxsHozq+1X54=;
 b=J+xohrpX1O4DSIfAvnpxiEevapXwkSgc96i1PyiXeAlTMcjC7JaL9EX8Sip8iqWpcGfygQbQHq2srpUOIxqcO2hfnJQ2dJcx72YaAWAwEp8PpWw5h17HFhTraiK4cc8cEHkPW4TNdDLQ1QMH6+HRp/r3ysD/xOYVkEpHdLCwteA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN8PR10MB3538.namprd10.prod.outlook.com (2603:10b6:408:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 12:03:38 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:38 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/7] kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
Date:   Mon, 14 Feb 2022 23:03:17 +1100
Message-Id: <20220214120322.2402628-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214120322.2402628-1-imran.f.khan@oracle.com>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:1:14::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55acc43b-b1af-4ef2-b79d-08d9efb20914
X-MS-TrafficTypeDiagnostic: BN8PR10MB3538:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3538F0D7FDA1C1171ECBF299B0339@BN8PR10MB3538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTlQx1oQI7nldJh53d48/6WavUwSh0ZlV2jQBkLXkM5qII37D3LRPoMJcWzduCvxBtnLSSBHbsn6+81+JaDBdlSn1MuEJ+3rByQofKClZfxVkkbIkSpKM/u5p/6ytAe1Wndr4nqAVeKPhlNE/gDqUa/IRbUqKHZs1lqohao3WSuJ49BOOKvz6E/BQ2Ef4bWSYoMclsh7b3jLyEhMyJlGXO2vXZdQwzYNlaOpqf8Kz+Ds2LMDHvoEQIXeCVw1D0ycTdvh7k+OHSnFqufWvGweN71q0il1nQN7OnfdZccwZXkSPq+7OTojbHua94jyZhayf6nu/IPoie9LNsNSAZBpMSB+vduVWBOItVvZT+AWnALhLpTyIdwUOvO3bv1iSPS4MSc8LOike0nhJfZ5Oq3FgR9tMtXzxmJKfpDLAUO1q8XoHQgPnJrONMVqSjyIftQg+TQAvwFYUpcwlA5ps4OtUCYi2skQe6S9fiy2d1mtbWvQAZ67TjJYng4UUP3BbDd4S8joGl7vgrIyC73wTPwHNswokSZIAh/PN4aYGOPtS6hlqW/b82TIj26d4pp+h1Ev+g0S6/hdlwb0AWVTFXYQgTtBUdhYN2V4jh0eaGEuNRHuIgDt32SzbA2JDj9BrHwAF08HEPFRL+6745z7fGl8JZWsub60C2nxLEjC43Scfcdx9SDQCUczFWYWvxlbl1gSHLoQaZaM9uoNZQGG9qyWzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(66946007)(316002)(38100700002)(2616005)(36756003)(6486002)(66556008)(4326008)(66476007)(103116003)(186003)(1076003)(26005)(6666004)(6512007)(2906002)(86362001)(508600001)(52116002)(83380400001)(5660300002)(8936002)(6506007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jl0mws6S6A6vibLxrQXgd64U1BiyfVIthlnVNDeMBDZvNf382ZW7/YQ+kng?=
 =?us-ascii?Q?4HNiYAwgRzzh5h5uHyxzEM/QCux5qP9RAr3BYG1NaPFA+WZ9Y6z499Kyi9be?=
 =?us-ascii?Q?6FOpqiAcTflj0Y0khTU6uJbYxao0s8n0m8pqBJic5JbEspv7U99QKUKgDk/7?=
 =?us-ascii?Q?wg1poOpiOVktORn+jq+7Bzc9RjImjx0iZOMf4TnTKcfk7rlaJ6TI5OQJ9ax1?=
 =?us-ascii?Q?RR3Jjb8Evk3MQxMMnz7g0DYNQV2/6U35iP19a44i3eEs8eYU4DAQ52pFJxCV?=
 =?us-ascii?Q?bBIl8nEQ3Ts2qBEE5JoERkQmyjTS/19+bE63reeNc8KUWSsDbvxIaHq5XPyI?=
 =?us-ascii?Q?2o2o/IZabHPcknL8Y+98gZ5eZxrZJ/BOROb8KhKoUqgGkEzNfoV2+GTm5Lls?=
 =?us-ascii?Q?o5EUKH94pBH7jdF392IaAVhIKmCgdwhgapfGIFIMRN/3tAyMsdVo0Qm1tvJv?=
 =?us-ascii?Q?VBaq3yNVL0+tDmh9qCdm1eXYhNAlqC2gl2ECmGNO8xT/X7Zyt/z2/K/2cVWf?=
 =?us-ascii?Q?DGLhi9fzmlDy9uqS7vnV3QnsqQgAoqw4y9M9DnuQ7pJ9BcqChjwzZiJG/BMy?=
 =?us-ascii?Q?hrln55Pk0/aQsOD7VA6yR0HA3W056fruM+V/rgBim3rv8t+Td/6p/aDenHIc?=
 =?us-ascii?Q?jVSQbtHI3boUIEGjsg5Wa+z8HouNxmDAyCxOH23qnY2dMcoDWGUUlQ45WTiZ?=
 =?us-ascii?Q?rvIKqba3PtXMufLg5O2SXHBf7XopITZhgUk0gLSDvjgEwG9FzoU+CWY333qA?=
 =?us-ascii?Q?jfT43jShYPXVdV2OJ1vftX9tII8UCDo44ZGtacBbDY1P939ZTDO1x+IeEeF1?=
 =?us-ascii?Q?lDjLujoNGgCVjawvIhmWxg7/qDlnDAmyNuw+XgtKDCKmpc1s98hxg5gcqFje?=
 =?us-ascii?Q?Fy/GYqg3as03LOZ8XadQzy9H52w/IeQUo1Xm1eQ6ZSuOkYSCIySjmp6Ygg0U?=
 =?us-ascii?Q?3Vj55x6W/XIbMgYgjsJqq/LFx6ybLzJA2W/woDzSNa6OX9QVe8gHEeogoH8l?=
 =?us-ascii?Q?DarvGsJR/+4EeLUUj79pujmyE2I4bmVLkN3mKWAMtQrhHaJPy/DfWHJcixyU?=
 =?us-ascii?Q?JZP550fN6c5QQrUZLGLlCGVtOJBc2gyloqGRZiDfQNVAoo/tkX3I3f+HumuP?=
 =?us-ascii?Q?Ph3Y9CCr5inccMhwRlyH4lxa827RxDnbICetqi0ETvxsMn9e24WJBbZ+3mxQ?=
 =?us-ascii?Q?CLfttW8caC3oOckmVzrOHvz71+THBI4rDuhIv4iIoEGTO8ySwZa+g+1zQ/5c?=
 =?us-ascii?Q?rINZzPiWEdT2FXg4dxDXrV8PV1H1bgUNFh54h6dLu2MD3lgnKcA7v5M+w3w0?=
 =?us-ascii?Q?P+3YcW3xFqRtrbQZf/LUepIk+x8ctv5G9RoiIITqpwwqt9sLErRph9Ji9DEv?=
 =?us-ascii?Q?2+xqhqe7xvEY4trRwwTVaBVDjXdYhWJWgv7pManFgyVbyzqA6sNXEuOdSDQK?=
 =?us-ascii?Q?8emS1AA1HJyJ/MEj/fWRHYIK9X55OhnCTDIHe0tT15z1TpFKca7cpl49vPqK?=
 =?us-ascii?Q?7cQTfzdb1PSffem/9HWFxjDn+U1GE3NAAslSQFa/HLnsexWJYporoAOI1uEL?=
 =?us-ascii?Q?9uvQYihuqSrfDdIlt2AxevIJb0tie5/HHxHnjsIUo0ilydmvh9UH/SoLjLu2?=
 =?us-ascii?Q?rSzRvJDQuifjXksVVoCVSMc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55acc43b-b1af-4ef2-b79d-08d9efb20914
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:38.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PrsEBuMcYAbpbyxGJMmbS9W32BTLsS97uY8Hc2ysIIoKHWoPvlvyOGvVT3Iat5431ujGiMKqI/sXbgkPE6W7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140073
X-Proofpoint-ORIG-GUID: ISfrRqktHsDMElRr1jwyCxWbj9aGIEDc
X-Proofpoint-GUID: ISfrRqktHsDMElRr1jwyCxWbj9aGIEDc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove global kernfs_open_file_mutex, using hashed mutex and corresponding
interface introduced in previous patch.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f4..295fe67950346 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -19,18 +19,13 @@
 #include "kernfs-internal.h"
 
 /*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
  * protected by kernfs_open_node_lock.
  *
  * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
+ * kernfs_open_file.
  */
 static DEFINE_SPINLOCK(kernfs_open_node_lock);
-static DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
 	atomic_t		refcnt;
@@ -524,9 +519,10 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	spin_lock_irq(&kernfs_open_node_lock);
 
 	if (!kn->attr.open && new_on) {
@@ -541,7 +537,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -575,9 +571,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
+	struct mutex *mutex = NULL;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	spin_lock_irqsave(&kernfs_open_node_lock, flags);
 
 	if (of)
@@ -589,7 +586,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 		on = NULL;
 
 	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	kfree(on);
 }
@@ -729,11 +726,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
 	 * we just want to synchronize release and drain paths.
-	 * @kernfs_open_file_mutex is enough.  @of->mutex can't be used
+	 * @open_file_mutex is enough.  @of->mutex can't be used
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -750,11 +747,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *lock = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		lock = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(lock);
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -769,6 +767,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -781,7 +780,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -793,7 +792,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	kernfs_put_open_node(kn, NULL);
 }
-- 
2.30.2

