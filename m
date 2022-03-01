Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5854E4C91F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiCARkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiCARkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:40:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9992C651;
        Tue,  1 Mar 2022 09:39:42 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221Gk4Co027265;
        Tue, 1 Mar 2022 17:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=IHLVHiLcgA1hx29GPP9MdjjcZ1z20pST8NuiURmdQsu8wd8XITLmk3tTxJovygrljHKr
 Mn57L2ROzgd4HDSrdyvkjCsdINrTMJJh00YTt8FCaFJDPbxh+hSLmJxxVTdNcz46mpoF
 R8mQCqK7B4oQUmuU4hVXRPYf3OIikZWQCabZ87ZtosE191r6DQQwLTRv08j6s3/dVZok
 KOUoYlpQddE+/YnegToU84zkEDnJWp0zr+LFGEJuTIoLxybbn0+/pZSXJogPvq1p7+bM
 wA3+wTAdhp+hDuuXkQ15jPd2vaOiFwQEsnCCrcXY2JeDWP1rFjwbzwqK9olGLOKAOzL+ mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15akewa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221Hb72q059897;
        Tue, 1 Mar 2022 17:39:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3efc14xcvg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZH5p9thXmFZsjD8XUCRuw6ovQPsV7cITFsCXF51fT7HbngVibqaF9KiRukh8wqya9z6AH0bk/losUiMwK3CwpfFsj3GJwAYZJsqqd/FJyCBiowNTtocZmLg7oRD3Y/yZD4MpBUg6/J7XlFF1Mky4eRM0CRcMBTnVXcbS+ahoO+ASKDmTX4MsMBns3jqjjewqyNBdOFYu58XCd/WKsn7wr8mHXDHrSjTO+Ye1fJecZ6INQxT0oFGXhd+Ygg9M6pREzq6J54FIjDSbASzjhvPbd0n0Ti4Vox+jdYddYs8jEaVwKhXvGvBdqxYZzGuUsNJX/lpuJYzs3lwEWaxeR98VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=GSs5SLO9kf2CbaVyrcQ3B6ymzfgG+Zo51PQlRvdXVDyYeAmP7jWN9qyTZv9j6jHMFm8rRAHYlj+tzMo6PvVKQWoJLDpqH1muxWUgtwHiNA+3wWSNRZvkaThcvPPlsMhQ9oCKUY0UMqjFiIB6wxiEHVO/KdKgIpLd9tGr1J+byoCqedmjWtVrDYew6qODdQqV1nSX1YTp55ELvu4+82gOHRWZ1thseEdATSy3PMrSAjoWCY1MefRS20aMIcNiJU3WubHRXRgJGSAc3e7DmYsewF32mjbay5GDTUmFET4gDPYWWBrkWJes0qJYn8vSMsSmVLlDwNd27sl8IWxGdvYBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=UILk7cLQyvHqNRY8E5AVzITOg7MW7WxxwqcVFzB1hhLj0iVAkgI8cCJ5J9RmF7t19k8lGE8FZ4EXXzIYGFSXJsQL7Rtex/CpL/M0J70Lp8W3fEz8qEJCvkaEm2KMaK30dNKo5WF70dfTJBq3+6pyvag1W8vS40hn5N2+q3svRFE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 17:39:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:39:03 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, jarkko@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        stefanb@linux.ibm.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 1/4] KEYS: Create static version of public_key_verify_signature
Date:   Tue,  1 Mar 2022 12:36:48 -0500
Message-Id: <20220301173651.3435350-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220301173651.3435350-1-eric.snowberg@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0194.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36aa0204-3323-4486-59b6-08d9fbaa6065
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2795ADE3910FC8432C193CE187029@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwGw00cZstOi+TaSICGPSHvjy6jYTbH7SbUJV1H+AdJtuNe1abiPptasSeMlHRTXFMWuUuJ72IJcN4GQK730380w5orNMLqfCoGTN6pKz9qXDazcvhRwGGJFD9Gx94KMlp+NEYutYv21UzplqZH5DcVb3Zhr4J4BDXGIF17Qwe8JkU7nppp0fGXhBkPgKtsJJoVNXAXRyuzhfWEx7xG/OalKKX/A9W2/HAZvw6BsQoobr2psiu73StuHgYzqLWBsOjtFYkxxFLDh1I2IQuquvJx/Yrp4ZeJ79ry7eq/fSiYbcSDYjmZOPl/c+0yQSSs0JyBNIpFSpT26oCNXQ5W8xxb76F1wMnwRMHWlookIl4AEeti/9dIVQuSuRvDVutIVAwgW1TRW5f7mR8b3nAgoaA6Y09r3d2X9M275+hZp4uXMsOkEp41HT4nmuQ6rU0G6ZI+dqPQ2lV6vNDXSzS1vY7/zRzA3XtNSHNf9UKmLQ/BOS+jsvpB6HZSmrMW/Ae5bTWksYCWpAhdJN/mMK8wWrsxPt5F4HTfZCuiZArj2xsXYVKvUdEnQiT5S8mgf05C1Nu7BBAXZPR1Q7ZvQD3E1VMJmk5beeSB8xeYDY9bAPGYdNtOwgJ08+979M74heePOzub8jBg/UuaK+svjRMVbPzA0LR+t9mqfFbD/6iQexojzfOBBdi6Em7hV/djdSYb4/XEYHuFkfM4js5Sa/0Aegw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6512007)(6666004)(6506007)(52116002)(508600001)(2616005)(36756003)(86362001)(316002)(26005)(66946007)(4326008)(66476007)(66556008)(8676002)(186003)(44832011)(8936002)(6486002)(5660300002)(38350700002)(38100700002)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ioemPi3nVN4Y7O14zF61Q7uGsUT/0jrOtbqmLiT9QoiIZ8CipDpZ89zhFQc?=
 =?us-ascii?Q?lAjtbx2E8Q7zqNXFpdJI725xyB4Up111z35YsngtzOGZWhk+Ie9S8S6eb7Ya?=
 =?us-ascii?Q?Y27bLb4p6iZYlV2YGqJo8tdgaCuCTsQjtIFreyNBiBK8LkYG1m6y7OoQYeny?=
 =?us-ascii?Q?LD3UdT3/trT/ASVeLnmzV6WFamhRQx+Ulw+LRFNs0gFjhNk7rwnNkT43FKLu?=
 =?us-ascii?Q?cinAYT+vVGPTObkWFG8P0rEH0X9m5PXD30G+QBHkvrxrEIseBz+yiqSIuqW3?=
 =?us-ascii?Q?UkyHVba9MBjmfy4M5xUXLk28ZAnfzk6do045a1R834AXMqBE7uMF8bDt1Dn4?=
 =?us-ascii?Q?Vy3ztil669MV5imUTNnaqow5O/xvGFWkS/UwIYwUhROdIZfc5tWVw/d7ihbU?=
 =?us-ascii?Q?cfi9rm6Cdq6a8sLoQKVi+QdtB4hO55kn6fOdKY2/Og2Ol55l8ADIvHIa5jux?=
 =?us-ascii?Q?No0wREC19dtlt1Lmiqk/lJWAE202nHTsoGiqfMIGK+qLpZ/FbPNANaVinooB?=
 =?us-ascii?Q?z2MTBJWxoSJt3V9DbXyFCZFNAcO/Hq+5eXV/9qYVFbBBGLpJrvaw973zryfB?=
 =?us-ascii?Q?qR3wdnwcU5GHVkl18q3OOmBEkWZJ3JcNI5dQeYCRo4++D1rwSD7GCJYuPalA?=
 =?us-ascii?Q?1zq41HV5TNeDkbWY/xQdnKm+O+zgx3Pxu3842pCSRCo65kAxEtdVc1LseMGU?=
 =?us-ascii?Q?faSRan8EfV93wKncTZ/CVSjhTlhJo8b0zA46PVNcxbDzOvRZ4DOkePQ2VUTY?=
 =?us-ascii?Q?UPT1tNOY76FaElHRe6vX8MT/dW4kFjK9jKnutI4X9PaOJ45ZSP6SzlGmzSCx?=
 =?us-ascii?Q?O/9TTqd4Y7F9cIiAdd9abT4QDVPtPGZYUXw8z+7VuWQSS2eP4cFevxIriRTh?=
 =?us-ascii?Q?b9J84QR3IiB7EbVtVpSM5bOQuL2iYV+JNmQYr8qv/xHfd4QMPMIWSVCKkScz?=
 =?us-ascii?Q?ZQHICDhmtzKpJoTD9rR76ikugyrlXVurdXTbm/k9CbaL+YxztVq/Gr0DW+VA?=
 =?us-ascii?Q?S4+Hi8dDGCf3HIvMyyc6/hx9fwFz86wC4ec4b6qwiNQs7cBOUeXoPmTN81E6?=
 =?us-ascii?Q?DjMPdRTyYZKMnoa0NNK2RXH1623UbcpCrk9oHrYnbqNuGLTsmEgR1LUPtKXQ?=
 =?us-ascii?Q?bvMNk+ovhVHNJbTvi/AdaFajJdRQAf3JHGVRFetqff5YcV9IqtjpPG1V7f4s?=
 =?us-ascii?Q?FnNln7uAd5alc+bt6vbiTFQNKMuzVCK+DPpYgxhtUdQ8zGPNeOhM+sOkSrZF?=
 =?us-ascii?Q?8LT+iL4+kFwn1lf6QLhHlSmYPAd51x1GOAoqHZFtJQN/D45Ox3YtdcsA9QeE?=
 =?us-ascii?Q?ldJnK4WOB0124BRk2o6hUsifGsgLmeKUD6mcmgZExI1PyCjxnOfHw+xkdUY2?=
 =?us-ascii?Q?UAEqfk8Kq57XjE7O8yxQhK0cHclM53C+M5EPyHx3krA+eE/MvRIt9CpslxDS?=
 =?us-ascii?Q?iVvCdV/T949cJzxqnekbzHK5Svhmu/ore4J3UZWjqCD7P3PMFNEBj8vK4G8g?=
 =?us-ascii?Q?8OLMyG0yr/jtpWpVdsKep6bpmbKcQTreKAQmkWDt2+aXkEZRBxBRI/RV5u6r?=
 =?us-ascii?Q?OBA8qEeI1tWcvvnhN6j4ZzaCKfIRvqCBHglnKnayhYzgVxXw6CLS6eFhxDfj?=
 =?us-ascii?Q?IlAQ0dBB69oQ7UdNenkXaC6qw+KwRoBrTg7wObSv1Gn2W7FElwU8S7iwDP6W?=
 =?us-ascii?Q?DohdUA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa0204-3323-4486-59b6-08d9fbaa6065
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:39:03.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2QHQqSo28LfaAK0pQ1kPJkQQLo1ZfrsSoQjQeMTduGO+ChKfN/D0S74QNQzYdwIPUmUzQkrR9xm9seGvd8n0IqSA3nm/9uD+PiqbfTOURg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010091
X-Proofpoint-ORIG-GUID: K_BwSsW4TlIQJuVc7yFk-W4lJjVGKU3J
X-Proofpoint-GUID: K_BwSsW4TlIQJuVc7yFk-W4lJjVGKU3J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 68f7aa2a7e55..6d61695e1cde 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.27.0

