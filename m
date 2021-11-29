Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD4462103
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379824AbhK2TxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20714 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351456AbhK2TvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:51:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJV3JG028124;
        Mon, 29 Nov 2021 19:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=t+1J6I93p7f+Ev8sgYTgkZeZmeDTejd/vmGxSYA4Ung=;
 b=vIir2JSwhMWft5ZTlkDOaFiNvVyeqxyyhILlKm9o9baANPt1W9tLYHw8IUAdiSJ9zxSy
 lA52JAdXXIO4OOdYSDGylYYZ3FLqNFNuY69Vn1BLGLAVremkDIhaMwcZK4fUxAi0d16J
 GZJajUthlFemTt74bSq/WdiE7GR2YrCUGNg9Q8a02B6z0/aaJkgIshUB7Koul0D0OxTb
 xP1Stw2RmHafhgD+Ys3vOWDODDUM7YGM12u5DVs0iYG29RNXR5igvAdXkDu1hUVNMIcz
 3LO4k0wVkf1xmr2Nl9LDq3OJLEq+APHZski5dP7WiCWmClE0Mf+CSsCw08AhQU6YH7Mw QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wbqxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8d181733;
        Mon, 29 Nov 2021 19:47:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Joy5Nk3CbHV31zqKIjUe5y6t7P0aBDF6ySkoMvyG+42ci1rwE0a81sAlKxsykxrTOGmpxcuZyusk5/JSKaIW5wOjw1deij4VUOnc4VV5OLSG4/fiKhHTZ9K4yN5iBDm/1/mhxZHiaklcyEyQsMnJKmawMj1rDYmLqlykRm0HJKo4aKFW7x2tNq9DryadZQrKWHcM5yidoMxgIUCjTwFS+V+jaL52s2vs8pTjHoY7W6//mPhIMjyQdM0lZgV82fqiY0IGyp5mbJNgBzf73ZsXGna+7M1iJ7gFIuCnPzKfBayEpI/QIhvQSCe9s/s5A2tNRwKRmqJ1dn4HUmjN7J7vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+1J6I93p7f+Ev8sgYTgkZeZmeDTejd/vmGxSYA4Ung=;
 b=Sko46a4OmhD09/XgFGvT3c02tylz72glSnfmhL1ZSsxksQY0gpINw5KWKQtEK3+RKTL6WYxz8rCGg0AX4iJOODnmfrQM4bniqXgW25nYYNaIKHhJNsM3Hk5pc+cfDWynT56LvCg+XBRByrA4qXU8iD6nW8vbMjVaCFn84bwNuIkOg2Jbes3+T5Ajh6eAVXVu7kYTM/E9CgIipxsScuKc025lCpr905BZ34y/vfNFh9JWAy1aEAvlkmLtYbm2d4kUVdaxK1dU4VFXdyT7eK7M6JX4AjwbfQVbNl0Qh4q78a5dnXfDBqAANrDMxAKPKt+77DFX3nv8reFORkWR4YsNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+1J6I93p7f+Ev8sgYTgkZeZmeDTejd/vmGxSYA4Ung=;
 b=RsQG4NaHE0eH++SbKWyPEfl7KditNXMTBT2GzSijfuKQjed2rdaAFyMR/7S09isTGw2Y/2yO0bk+qxpdedVtrwAJ2ZGKYUNSTHEiX6KX0FQhJTePv2MSnbaiBLUVE798v6zFSF8Z04JMwRKPBKRQRgGMHBo2GlccOMtNa/UTNA4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:20 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:20 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V6 05/10] signal: Perfom autoreap for PF_USER_WORKER
Date:   Mon, 29 Nov 2021 13:47:02 -0600
Message-Id: <20211129194707.5863-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66efda5c-8e4f-4931-4c37-08d9b3710e83
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307C155E98D90D74D49074AF1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: caHFaO54x/NALnBVb4WU+IGAlqvbLm5EQuD7G2SncBF9TVhHbb2CsEMj7dejsDbtxHQjgNkUmd5nic0CRg/cifm6qqCaW1zhHJfEkPimLKY80NdxqqJySojjbM9TOdMPJ7pwaGmgvBmV+rpOT8q6ZmAvn74nuGbwaXobYg0nhTFAEUcMpRafzpd/sdNElGey/uh4r4AI3X2gzsdGPoMLhS6Lc7+2Qy36wRQqBYBMPqu/VNX3W5vOgOUT9Navq3KL9HRkEKtFf1mUGOQr9gdHR5p+Vo/JScq0U1yrfClUVh5QLkMXd6oBAE0P8busEGB7Q8MSrzkqsW7ScmJr9PAr9HlTTRnPPfePTpQ4DtngZEhao/cBf0BXlt9C01invbu79LGtlIMfEHn64P6kCd89BG2vBPOF9hWFUy+UhiVtSDSI/WShWBgtJX2K66ownbtufCKVLp6wnx+XGwj8k6qzkH2VjXiZsznaxlBi6n5flPkxV6c0lSFysH1nWek7U5IZafUo2SiJAiCxl5d8TYNeOMjsgH3QEoaXNAfjBDrlm/PXzJyUGSrKp/f9lh9LJzj6KzLWJueR/0s16tx95iidN5tNeuG2PTmfE6DQiTA8bxysFAFzQ9teA7MilIW+dDT2hbvPItmMe+tp/Dd4ynsnzjCjCIkA+UtOaoy8FoQW8gTM48NK5c6LeG5QMXMm4cqikMUczt159dWU1nvGtjx5PoQajV3QHrMNYTvQGgScXHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(107886003)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txr98QuS0FRQCYRN17U59QXJGkyGnT/XsFDSPpzsZ84ivJ/fy6QKMmU2I4IU?=
 =?us-ascii?Q?ycf7csHC77RFpqyNe5eJFHfhSCtsKOZqChdtTNUYA1GIFqAR0Uy1YXd7sgoq?=
 =?us-ascii?Q?ULhUs02Q7Wf9ZI6D4MBEDcIzFVC6NIfoWuFBKSeE6mbGb9p0lpruGcPE61rP?=
 =?us-ascii?Q?ghreoCNKUASzk8pU6INy3ZMLTqKyNcFuELC9iSG8WKLR1GKU6kGQPxiqIgnG?=
 =?us-ascii?Q?Q+Pd9blVIAL3tvN1X74rCOQuQslQmgbRqkRUuuYUEZ4nO2Eaq1nVhK8jEJaN?=
 =?us-ascii?Q?4wYNWoXIKVJNwsOyu1N9vVpiO9irCcXXJKe+sy+sI7//DG3iSuTT3RC+YWVF?=
 =?us-ascii?Q?zEYcA7IgG0QhVcEvSS6LW2IosrpjJZW6tHT0NpNWGg9TafmDuQVAx36OuEAb?=
 =?us-ascii?Q?yBl+8Rnz2llZvUFpGpu6UY4d+FBLna61qTTKhZq0chHbZWPV77d832AjI+T6?=
 =?us-ascii?Q?Bic5rxq+/LkIPHcjlVADZLsHyT67jrCtEo1ViXldpvaJc906RiWd97+F2LNQ?=
 =?us-ascii?Q?XDLnX5p5CB8XYqIJPCTEx7+xJ/vUrh7tO7C2p0baKSKA+LWq4TE+leMwFCO9?=
 =?us-ascii?Q?tYNND6n5BnGmGZeVVZANvS+QDyQu28/hxBRKHTrvdD1IgFmofx5mYAhFcaZU?=
 =?us-ascii?Q?HzMUFtkRhTzcHlD2aPlCzNLLE3Qb48U3t5uM1xeQ9Qqx7uwJlCp8IWY28HcN?=
 =?us-ascii?Q?5QFiu7jWuFsFVG/76kAp8rBcZojXuHWeenAmViOcSbG+OPd/dH9FyVXF+mBy?=
 =?us-ascii?Q?IAZEYXn5NrtuXicLkwaD5XH7UAoF/xZyTyF9EYCIDFwTCXU3ZbJ+QHDvAO3P?=
 =?us-ascii?Q?Zej3rgb7Rm3zj131bZdx1Az7EF/AJWH5jmMChydQXyd/WQxhGwyyiSKt5Abu?=
 =?us-ascii?Q?iS/uX9L27HC3NPyWCfivfKHROVEHhiPazbaOrKy+YNKgQA84hpRdgt8OxDo+?=
 =?us-ascii?Q?Lqct4bNQ2qqkH7gM/JUsHpmhG04r7zRfuDkVTdUgMMCvKwbxFZ1L2Tp/2XCe?=
 =?us-ascii?Q?8/c/jIzJ6EBsIr0H2Y3SAX81Rc6Pp0IrPaepUM0X8vigtXB0pLbi5hglzI60?=
 =?us-ascii?Q?qchW/WG9r/LuottzFJJ0A18++DDeUfgMF2ky0PKjhXXmwbswpRflZe5MuoiM?=
 =?us-ascii?Q?VbSQxRR3XHOEqyywJeLunCGUO1AiZLcgJlb7inxFi6AT3jjkszHKABvasNKa?=
 =?us-ascii?Q?uhzjTDVG+IaJF3FsdlqCqwqTj++m/CRz5fDIZUzhFNfdF+JuaNRhRr1BotBr?=
 =?us-ascii?Q?hSZQks55vWEMiILT/7P9wOsRAG/R0avJvxyjR1Sc/RVwiFcyTtj6jQdR+02B?=
 =?us-ascii?Q?qRzV/KudFe6mSOi/ymvHEUExcglBrmfZbuSGIuXBMu0wJwiULH6XFMbeKDsj?=
 =?us-ascii?Q?Gbth1BPfLaUjFVmwUUapfNvFPJcFvjs+ECbEJNFmnlLv5viHhYGtwKEt454K?=
 =?us-ascii?Q?SWPWQdUHx5LITYO8HS6wkS2XlRt+QIEboOurTyq7B97pC5emPRYhO7UXBLg8?=
 =?us-ascii?Q?Zp5HX+kE8VDTzr81poxKNNTQzj9UfiD5cyFbSgTwUXqLzeY8JeIoOrHCErBw?=
 =?us-ascii?Q?qFCoh/uNiK6G/KEdphgn0i2j7mIS3Qekhl8BmKMTRXDn6sSgXRo6RxrBAe+I?=
 =?us-ascii?Q?G+Lq6/aizehpBgoQVQWuRFn/KZPh/NHxXIeLzFQ4SmwltiRu9dgeduv8nhJk?=
 =?us-ascii?Q?jqi9Ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66efda5c-8e4f-4931-4c37-08d9b3710e83
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:20.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/vQcVq5rkb9xgMqYfxVqxO3OwGcx+PcGVFHdQrZNL+2ZenFxw2jvbLlwoxYmosxT9cE+msTMvMxRLbJBtluuJ9qbjlWOD/jSxd9fAbuRqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: UVyqP-tiHiTS7zV0s2ZZCijEvF_0lVsY
X-Proofpoint-ORIG-GUID: UVyqP-tiHiTS7zV0s2ZZCijEvF_0lVsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace doesn't know about PF_USER_WORKER threads, so it can't do wait
to clean them up. For cases like where qemu will do dynamic/hot add/remove
of vhost devices, then we need to auto reap the thread like was done for
the kthread case, because qemu does not know what API the kernel/vhost
layer is using.

This has us do autoreaping for these threads similar to when the parent
ignores SIGCHLD and for kthreads.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a629b11bf3e0..4ce2cc195269 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2071,9 +2071,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 
 	psig = tsk->parent->sighand;
 	spin_lock_irqsave(&psig->siglock, flags);
-	if (!tsk->ptrace && sig == SIGCHLD &&
+	if (!tsk->ptrace && (tsk->flags & PF_USER_WORKER || (sig == SIGCHLD &&
 	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
-	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
+	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))))) {
 		/*
 		 * We are exiting and our parent doesn't care.  POSIX.1
 		 * defines special semantics for setting SIGCHLD to SIG_IGN
-- 
2.25.1

