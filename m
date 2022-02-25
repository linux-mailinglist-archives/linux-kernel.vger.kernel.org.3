Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53DA4C3D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiBYFW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiBYFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:22:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A125431530
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:21:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4jdqR019338;
        Fri, 25 Feb 2022 05:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ktxkINM0xFCRjBCR6qswvo2bL6f5HAVIj6fEBbDnibQ=;
 b=JUGyYsPXW8pGhOceUC1QA5gbX28hEOLBsa+sU4yYfvRLXIhOqf6D2cO/AmUN7haL0f2R
 Ozivf0XQR/OQxZi9XbfZiCM7EMgZx3Xc8sX+sly4wLLF2Tpb+yoqDyEucBKYESF/dp2C
 yyZoYPxjFJ6kU2/I//fGITzBQDa8s8iKWS7UggYld20ee+eqJ2NzzhVpVmbmInFRGBmN
 QWUu2SFr+1ylfQACqRGJ0h1TeJmXh/MvGwy1t1FSZjAdWa3awyA9LytSz1KTGErl/hvz
 aQpRzf4t6BhouUCQpvnrM0QbEecLTpwdDDymCADR7fZ6db9UUZyAw9wth0E4znbFAHem kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cs1xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5Bg4c011961;
        Fri, 25 Feb 2022 05:21:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 3eannykfbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqUiIhPOBOzHwPGD+fWwMeSLCYE7FQpwT0GN4KEWGPmiE0F3iaJVe4j/fyGcEpqsMwBT0GQLiY2l8pUNpLLk0p4EbqHL4hMxyDAN6OqDEYDKImsZ3POshQ2xXMXOv5tGvLT6oMr52T0StwL2H0JLm7xBsEup+6unAMe3KXQPB7jXbbVVeoLrY7/4QkHy8iEe2jV0LVo5boP4iUkDfiskqPRCU41/C1xfgPwYx5KQsWto6u7AYgxIzCGLnVraaa9cYghnrj4Gv4Bv6yQ1bYmTMRoyRXkzLvgl7sbXEe/uLiE4g9NWh9233EpztVj8SmVgWIxvtOJfD195jyjxjMgDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktxkINM0xFCRjBCR6qswvo2bL6f5HAVIj6fEBbDnibQ=;
 b=dEPOh8z+svtvawWe+piekhsbJ2+ESBQ9dcSYHMLdqXk58SwC08nqfGtPU13pTkfkeDsKg6dJS2I76/MQ+X++iSo561dScgIiamOXlAT20LpPkA15yuGktm+8GmhqYJqk958CbO1UMsr6PIP9PLNTI71SYNGbl7da+Eu26BnZ/Yd9bRPzIXU+v0UAg1UguOg6A9av3NVdBb/DsfUVJn57Bidxm7lcZzatf+QjgmsBCnk4GlvajTr/wh7plmmwjXZFd7flI5wy3Jq0Emi7fVA1IK3mGusx4ZN00g9nNDdDrBPlraQIn5DNRxAo7e6LxKRZSX2kWnk/oPBngBipHOn91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktxkINM0xFCRjBCR6qswvo2bL6f5HAVIj6fEBbDnibQ=;
 b=cozXqm5j369JNfgmuKkvODdWzbbitlDJqJscuFFu4mt6H7o4BkfTnTAEP+fPZmxOiBB4XUxXHDGkseMD3mo2A8o70JRbJzTYqqUk+thbMAYqR1eNTcmL9Bv+87xTuoSDLBMMTWVyY34LPaQ2wk0OPHHwY05LNXcOIQCtlw37Y6E=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:21:29 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:21:29 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/8] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Fri, 25 Feb 2022 16:21:09 +1100
Message-Id: <20220225052116.1243150-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225052116.1243150-1-imran.f.khan@oracle.com>
References: <20220225052116.1243150-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0404deb0-4283-45ec-396f-08d9f81ead67
X-MS-TrafficTypeDiagnostic: MWHPR10MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1677E0ADB70AC2801F2DA62EB03E9@MWHPR10MB1677.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiEZroHxg+mbiIgtinArye5HHbIT8ibak42Ulq75NppJZoJMLpOAG15BQDb/ejd7/TYF3375tVWqtKpWaLhy4eAWsKqjKg9hHjSx8NPUPGHtQ2VgEEzVAIBMmuw0HIXxiyO8tUOqu1dXpvcGLkadWX/okorzhjhkX++R18XB+Eu6cD305AVWSnEqJyUJBOxBJMKK+/okXaV/k4f/Sqt1iw9ZclUQoOhopfJGSIZrOuYyImo6r/dFUf0mhToorq3aXgSdSNwoCA6qspr/aWd/ArtpGxF6zJtBNOPAchfHtqcDDpVSEgjHo2GqyuHAhhFK+TKY52ziB8MTRg9LqwsZTOn0w+1fYsU5oh/kWO8f63yBNKpEb4hWEV+KzbIeAfQyOcslImTMe/vlt21W1x9+B8bG3RnIcNgJYk8BhKL31EoxwcH8dkjuwI9PJP9BuSV5EsHhIPo9B6bA+QAmIi1Ia69pmx0FBEW3jL9pMUO5kZJ8duBeqt0xcV3AkqZdROoHQMhSnb+mcz642ERjIuckayTIHPL/i6tb49VAh0x/4NFtCTBKCSqLE5hVsEv7iv2PLb4WTVsYUEAM9QIp4pLwlNzSaM5BdOBTGqv6MaOp6uuRdPOMf4RP+U5C4+bv43uHd2szrLFGlOch6EhGJq8n8im8AGCEn1Ovpz/HLSZYRuwwNl0t+avLMAR3BpMbgnALGkQzzZdfz4vXQcs6ebR3yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38350700002)(6666004)(8936002)(38100700002)(83380400001)(1076003)(6512007)(508600001)(86362001)(6486002)(6506007)(2906002)(52116002)(316002)(66946007)(36756003)(4326008)(5660300002)(8676002)(66476007)(103116003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1umumBXMQhKyHlHdZIWFGvDYIJYbLq2i/TwYxTrhRhIx/WHlmRQOoW3CdHG?=
 =?us-ascii?Q?Xn6BHLxIv087f4m4b49mK5Y0ee8EPlGXAMcyBOPIeDnhKVI6OtUP3m0/8X3s?=
 =?us-ascii?Q?ebxNRaEznKPzXgNdDPqFa6FAynq0RcHwfzFZycfB0C8TQ4QBdI1GkYs9Z6F6?=
 =?us-ascii?Q?MxbZ10KTFpbBqQ/7DzM5PbLi206Q2UtkPsctZTkEFuB6DCO88+/BqoBEr1OG?=
 =?us-ascii?Q?D6NKRC78xf6dqvJGRg3z4P6jI7/Btuz0UeR18GqoVNdrLoYGZ0bG4BwwsnkS?=
 =?us-ascii?Q?fw6sehfCCYPkTPamy67rbawoPD8rSJht5L8Q9oICWmwhXd6c5Nv0nLuYVbs/?=
 =?us-ascii?Q?y8bvd2eMk4GYmHJCEZuMjd1zROjr7IcjqzPEApzfZ8JR0Ghc9tN6zoASVuT2?=
 =?us-ascii?Q?frz/1I/Y6dmWgBWjHXf2zWZHeu3OuvWDVpE49vWE77M4lpzhqzyYSj0TM4U3?=
 =?us-ascii?Q?sgV73XlAoLDkE3/bfHhjcwvosqZep0OROwML8hLHveUDKS+5QJf8zbP6mC5l?=
 =?us-ascii?Q?8g77n+62sfI5kFY9V5732ZWjXmdUfDEHptwOxrmPssXUVN5y0fofM8H9L3fB?=
 =?us-ascii?Q?k/Ke1ep8YN2TpO9Tt06il2eGQeAsMldQ88EPB9kU+6fkSdH/CzfvQd+bIZ1F?=
 =?us-ascii?Q?5K8+u1wQ/ljvHVYM5PG/j4KDU7u5CuV2qNsxN7j5HzVR0aAgZW+jR8UKMd02?=
 =?us-ascii?Q?iP9jCKybUf9Z9zo4hsJfXvYraqU2CYxJH8oL842l6KPlBppszI0EbkWx+EY1?=
 =?us-ascii?Q?b25UtuasVn+/aidVnga13VYledRKjIBfESMSaxCEDwdHpB1LJCcZGQhIQse5?=
 =?us-ascii?Q?OFNomkm7tW4fCJ9DmmwAQMXRuDDXBP+9bdaHJrlhmobg/XlqtDdjeAXIYDcL?=
 =?us-ascii?Q?8G/Z9qJft5rBGxqWPxiOnOMWzbI64G4trnkqEzZLuGRTOwW1kHwrMQIOf9k7?=
 =?us-ascii?Q?KTkIoeoRZ0InGCrSIzRozgSKDxQz+UlYRWeTH8hP8Jy8AXrKvJiLT5wqWGrV?=
 =?us-ascii?Q?7hKOVAooZvWEMfFyXVL6eQ7jBl/eTDUJWzwfT4Fio2euUVd9RXDYCl3bMEIB?=
 =?us-ascii?Q?eN5An0Y6caME8oLm8a3c0giC/+zG3p1r+drDv36Q22lhewriuCzdJf2B7aT8?=
 =?us-ascii?Q?yXqLo8RNY8y1d0rKer6Ss6N4kwRgsB6Utw9B2n7ERPe9DeWIYh5bFRrhJ346?=
 =?us-ascii?Q?+7RbGHR5zi+HX8O091DtIW01nX1+STT3MTFmGIAfeN2vcKmGlYllNt8AD7TM?=
 =?us-ascii?Q?REO36rwWJmGBDo9QNWlfOtcGBDsUXT9jQiewmgjJjyiqissWIhKqKHUmbZfn?=
 =?us-ascii?Q?H1QnPfg5e1dXkEdGXkN1KwmFsFycak3YHhUPXkFgyi1vA3R9dWGgr+XJtfr2?=
 =?us-ascii?Q?1gj1heLcfrAq2RvSH9FHU3ubv/jQlct3A27PqWUqwIZrmozzZHCJKps3lyQZ?=
 =?us-ascii?Q?qnL8fxmIBi1+tZce8kiIqTJoqykbPsZQ6Rfrs53HimYoDo3dytv8+iDgAxw0?=
 =?us-ascii?Q?baX1sv282sVeBWxR+Iv14SiFAvjC5RLy86uXDe1gK5/M7hJClyegc8Xggmqw?=
 =?us-ascii?Q?raPYSPVu5+zaelhtof5z/YyNp+fwohLn6/BVCCxHEASTTzIJW/nB5niepzw1?=
 =?us-ascii?Q?BBhIRjxs66eahTF6s0WAkY0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0404deb0-4283-45ec-396f-08d9f81ead67
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:21:29.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLSx4S+rWuov/45E6TYb8o0WxoWQPB8cftNx/3Iqv7h05ICYG2hMs8TX/TlGWZCsOgShM7Zbvd+ADgzpQTB2rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250027
X-Proofpoint-ORIG-GUID: 5gL7qaOR0P-_HOnu7_D_yarAmL3Vfabm
X-Proofpoint-GUID: 5gL7qaOR0P-_HOnu7_D_yarAmL3Vfabm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to change underlying mutex locking, without needing to change
the users of the lock. For example next patch modifies this interface to
use hashed mutexes in place of a single global kernfs_open_file_mutex.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c            | 26 +++++++++++++++-----------
 fs/kernfs/kernfs-internal.h | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 7aefaca876a02..99793c32abc39 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -30,7 +30,7 @@
  * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
  */
 static DEFINE_SPINLOCK(kernfs_open_node_lock);
-static DEFINE_MUTEX(kernfs_open_file_mutex);
+DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
 	atomic_t		refcnt;
@@ -519,9 +519,10 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
+	struct mutex *mutex = NULL;
 
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	spin_lock_irq(&kernfs_open_node_lock);
 
 	if (!kn->attr.open && new_on) {
@@ -536,7 +537,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -570,9 +571,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
+	struct mutex *mutex = NULL;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 	spin_lock_irqsave(&kernfs_open_node_lock, flags);
 
 	if (of)
@@ -584,7 +586,7 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 		on = NULL;
 
 	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	kfree(on);
 }
@@ -724,11 +726,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
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
@@ -745,11 +747,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
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
@@ -764,6 +767,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
@@ -776,7 +780,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -788,7 +792,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
+	mutex_unlock(mutex);
 
 	kernfs_put_open_node(kn, NULL);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1b..91b7cfb8a1105 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -147,4 +147,22 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+extern struct mutex kernfs_open_file_mutex;
+
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	return &kernfs_open_file_mutex;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock;
+
+	lock = kernfs_open_file_mutex_ptr(kn);
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
-- 
2.30.2

