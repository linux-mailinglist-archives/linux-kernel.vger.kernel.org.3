Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE264B014B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiBIXaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:30:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiBIXaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:30:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7DE055264
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:30:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KSAZo020152;
        Wed, 9 Feb 2022 23:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Vs8tFpLTMOGvTyZKGEuCsbE6CFo8oWe+4mPnhyqiYJc=;
 b=msY3xQDppPI6SNEIw3axBRq8SfCDVcSDuTb4v5WGn5YtH0kElqvgudA+cuDZ9siAxair
 417uUJJo7adkRCYm4VvLZ0CbxVxtkYK04Dy4jiP0yL1IVAaWxD/I0uHa1S9XcHNqeDBh
 uqosb1XgByiRlB1LE6mggN6g5zMRx8S/MvQ5UHHKqOn6modD1NNRAd/d/1LVneSW+8TZ
 nZ50ye7JrkqDv3kbLEKwiX0XLvETngIM7ZI81WiZqhnC7FYOKdq4NkKIhxqOjnmEEeNi
 up7XPNR/BRchd20K0s4/wVkzlCnHsOti1xoP4ENS9BVDP3ViaNX9PQt2u7mbT/k+jQ1z Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wyd4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFZ117827;
        Wed, 9 Feb 2022 23:29:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLW+gwRRKezKXwtJ9sag3WkDWsGUJ3aayttwdzl7RuvSfD7umhsSMmbI17vN9GQRtcUC+H1+0O5lNiSnWJtQxVUziiYjkuU5txCtjrnk1AoynBrZ/m21Ocr6vZL7B5D8vMUzg+PT21MRrXQXgm3VX03+ZWDhcPGy2y43XwdoQ67nj1LMgf5Wg0S6klTr5cF8rR42RWkKDqOkxu+BIGIdlw6SnzrCUOcmjvcTSndE5KH+VcJ5CBjBs8kVxXguVFim0DI7Weo/2sfZxx8GfK9GdlbRw/1oe5kXJejHz0qK9EdoKjRPR+qWTNqu45bqpzmxPvSWAJDIFz1TodJFrWoKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs8tFpLTMOGvTyZKGEuCsbE6CFo8oWe+4mPnhyqiYJc=;
 b=AyhvNwtfNGnpVH4h7Hxisz9QLxTW5Jv6kDzaa4n8RRTdCPsGNunif5zspipKQciVR+wsaxfroZnJtQMVTfIg80bSz4CEI3Ve84Z0eSo2xfTcpyTxsTZNsBsj8ACFSHUEEWnpYsU/TnCy+M8BvtDpMzQLVXDsGyRl84AV9YP9mf6DS+lSpxJgLNv6hQcGlaZ2uEBsoG7df3EQW98eLCnBmtUes4MiBxQajlVb/eZim6kBvVf5zeUOSvZbzUnr5LXZT8ctiXDeRd5LMXSZvc0+d6+jp4h8+HBQRVy94TJqvshUk6WYSdChqwQFtjHlv7pkLUiSLgLvCxE1ApKuBW3hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs8tFpLTMOGvTyZKGEuCsbE6CFo8oWe+4mPnhyqiYJc=;
 b=uOZE3F4xdqFFg8ztpPt1vF7qRvsLQVcbGShUo1MlKSZSksQma1J/QugQGAm/niQNDxZhqtSUjqY7xnxWgJgUHTNQcN3WEltgLrIQQxkXpAZtDmv7jzSkGt1+b+SHunBTEyn0rfWooFkgna5IzzNLza8xTw77mDf5noaxkIdy6vU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:52 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:52 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V8 5/8] fork: allow kernel code to call copy_process
Date:   Wed,  9 Feb 2022 17:29:36 -0600
Message-Id: <20220209232939.9169-6-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: f97110d6-5020-4e8e-6359-08d9ec2412b1
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007239687C2E10CC320468EF12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqlFk+Dl9Qo46DLF6fjRz+nMnAF1gXR9P7Tv/6saQCNulcmB+KhCNLG5AGRsToucroN2yd6J3cbMtiYqXr2sQinN7uthS5YmH9rLPmsm2ut9G2IJ9p7311DdWN3rJ0EuQ2OpkHO7Ll/hqKEkaxw9dSrzORKz7WAWUdgBfo5XjWPtwmDArVc8OM0uaKIcZ3WRmmRMbIKTqDoCd9brg6XEcafnUg2Fl01ywYbRvT78TLTL4nrjzfXFqo5PHqWvjwDZVg7SUezlYtzHClkg/tDTdGuu5/PD/RvTb2Y5Qhjv0VRRrY4IPadkRu5GqKlD1/rpz6TlwlvbUsiI18PRQwla6LhnNkcs8suB5cC/pXAmml4Mi8NuU7grXL3ihzup5kLyeoI4gFL8DEOGxJX3vUgQ1rUPyadPgIGLRmW0seAjU7ev6UanC0+cMDsqS7Cl5xiNoUQ6YBLhgGp4ArOpfzdvvzfIINVD1W7m1IrJ3xw5m1tstdXgNW8VR6BDsS66zFOB6+lbqsrxfyJjiHCh2IQ6/EsO5EvhfB8fqD8Kx+U0QlqEd2rrZbcdBCR2GYkqhmjuMCDIxQu7RH82BvB0EByufzPrqZUS8Vu91NNflgQCATpApoq/K/1gG31GywuWGkPlhbG4cZX/bJgtzhZ9RnEfA1pTZkIeesqOKk/Z/HClJhj8gBqgCdkZAE6idgflF6ekw7bVFQdCnXRGsH+58+gAACaxs3/RYLqOdGGoJaQzTDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(107886003)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhBVI2OZGGTTMVIgNvBH7e0QBRy4qogpme381Ibsc2LvhgzoiOShsXzTuVJJ?=
 =?us-ascii?Q?4Tin/XTqidZYteHJkiZMx2eFkax4DK55gloepjxRMqwzBFFs+aA5J2NPOnsP?=
 =?us-ascii?Q?hExk6PCPiga7wSbTN3/jVPcUfuarVPCZ076S2MIhr/hFQiyhBRBL02tEDJDl?=
 =?us-ascii?Q?aIlnrHOJBbCbXCNES7ftO/fPZdDya6wVEubaATE7HzX2hoxTcaQoEuL0733T?=
 =?us-ascii?Q?gzXzTboPMgT1xBY0mZ2IWAFvy82WDQg8PnnLA+K6CVQ4VK/luKJDhyPdj1Sm?=
 =?us-ascii?Q?TuukgE1DHFFYHTWEMAEPI2gBRrj9/Ff2S08l7Sup2dWFfvfDigAQ3uEhvL8b?=
 =?us-ascii?Q?ctdlUMDmErQFBYE+PR/QLtTsKCXe3BPWz2fpZF4j3zFCq6vSXJpw/qeb3zpG?=
 =?us-ascii?Q?dfAVuFfxnFBywFU8l0KJLe9r0/59LKyuOrBDqALtpek+COuLA5LnZ5cel5+n?=
 =?us-ascii?Q?c4G6/5yQnWuspmEUacukuXAxax3rNidr7nidTBODWUTXU7zBljWpynPOTegy?=
 =?us-ascii?Q?emU1Ml+F/xXmBNleQP1M1enBue4bXSArgYAD5ACmR+hHs0UxPElZBXSgNrty?=
 =?us-ascii?Q?MYJsE52j7LV09KEhFxUac7taatZTBq2cecqkIWgfjBW6Df1WXp1f1KBw58li?=
 =?us-ascii?Q?toGIeQSJKuV6ARGbXQsCimJZYWrfNttMaLhyKfcYmhZ01SoEU39nMd/hQS5R?=
 =?us-ascii?Q?mGhK1ac/kNmOZoOi6y7nQhsWjrn2DrAGoklU7THfy28/oWRoyItNuV/+XtAc?=
 =?us-ascii?Q?bLqJadw8xn3fP90qL3GD/ijeIlbmVTlLhvMsv+KpRzOqhHlUB0LkzLs2SUIl?=
 =?us-ascii?Q?vs0HjQwy8E5s14S1ZXodxDyKjMEOLX5ly/+FmZfaf4SlEGBO3ErVv+YyE9nl?=
 =?us-ascii?Q?ZcOB64fXxWDvowHvJvy2tuM5bTp+achykoReoEcSm3/+HF6wt3MWRttWY21v?=
 =?us-ascii?Q?Ln2GngABwVYlU+w7BDoKdO6GozOVdjdNok8jDaG7VvfO8Tu2t/num0oGXcHA?=
 =?us-ascii?Q?XqnPKiKr98sh2RkJCtyWY22dIqhkLVWlVL7HOtAPXJYQux4Y3JJHvY9QJlRj?=
 =?us-ascii?Q?fIaZzbMYN35M71gzeFqFYuAds+rLHF+9Z7v+ihDmisTD6Mx/7UEyzEdpYrPx?=
 =?us-ascii?Q?Z0aTs8LqoMMCv5OU9eFt30QiUIq18Kkt/ewE0969uhb9ZAOW0Nr6KMj2fO2r?=
 =?us-ascii?Q?Ljaj/zkZxutIEj+LTM6z+FmILoPRFUZm3DTaFhBh9vLuA4jzRdylIZp/ythQ?=
 =?us-ascii?Q?Ufyb47Mo+N8CwgZXlHrRcaaaBRWAczHKk0dc0UnPzPrpUwDTeWdHu8ySqNa6?=
 =?us-ascii?Q?zY2L3z0YLMjtVLgxclVxxIJ4F7VPM2AkGWQbQ6Hww9NSqjEJTI99eZ72xPmc?=
 =?us-ascii?Q?7inMzM7RDoqqHWLFxewL96JRttenoG/eIFwzrDnThpO7bciLXzVQw3ysrX37?=
 =?us-ascii?Q?ebYgPJ6A4eNfDEgytPmYejUTVG2TRJuQSDpOQh7p4BGk3oQCthpaF8CVJnKj?=
 =?us-ascii?Q?XuquJlme3cFWrjJ8cNUVS190FJPrIJRwBT5FqUijrX9Z9vs1Amh3fjvBkAYG?=
 =?us-ascii?Q?Glp8KWju94M8BXKSkFBdCmKJwdXFuM6wShHWgz/yuUQhC/nmurNRFHxKWpsU?=
 =?us-ascii?Q?nyDNymfbA3IX2/19sUrKfaL4RVZqlTRoiVLduF0maH7fQKM0TEByT+Sqr0gN?=
 =?us-ascii?Q?oeS93A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97110d6-5020-4e8e-6359-08d9ec2412b1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:52.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqSyih47tZBEmzIVuDr8dFYNWkUfxXFjkjsHeEUnMI5MNUXOxjmAxbc6Hpt8PjE54DOrr32in7ZuxL8prbO9aVcBmKHvV64SDuXurT3pXoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: H7TRreMLSnA-bpw2zlOagYOdsOD98RfN
X-Proofpoint-ORIG-GUID: H7TRreMLSnA-bpw2zlOagYOdsOD98RfN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds helpers like create_io_thread, but for use by the
vhost layer. There are several functions, so they are in their own file
instead of cluttering up fork.c. This patch allows that new file to
call copy_process.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h | 2 ++
 kernel/fork.c              | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index c001d0fa1426..787e6108fd65 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -90,6 +90,8 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
+struct task_struct *copy_process(struct pid *pid, int trace, int node,
+				 struct kernel_clone_args *args);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 6a04860fa1ae..04eb7fc50a13 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1905,7 +1905,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
  * parts of the process environment (as per the clone
  * flags). The actual kick-off is left to the caller.
  */
-static __latent_entropy struct task_struct *copy_process(
+__latent_entropy struct task_struct *copy_process(
 					struct pid *pid,
 					int trace,
 					int node,
-- 
2.25.1

