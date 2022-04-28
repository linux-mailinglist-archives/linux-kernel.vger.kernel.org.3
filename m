Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45ED512B84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiD1G2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbiD1G21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:28:27 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074067521A;
        Wed, 27 Apr 2022 23:25:10 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S6HAJf019758;
        Wed, 27 Apr 2022 23:24:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=jcM04rkaaZDza5PLVUxfFVHLWveiakrCUOr8eW3fUmM=;
 b=ZkshTkgEqyIKI4vSitEbjXRf9fdBXrAJOxfyF1N5qJ1alUugMbXn0lLs0Pho1CofcgLt
 Z3tel5MBv4Ew3mulMJAN+GdatUjKbs0/LbP4L16DmyXSdgnlVqyRW+UlJOFP8qZ1Q2sa
 ordECR1jHzuSfFBps9N7RhJi0uN1LUQBdRFKrm8nSUICZprQ82ebnEtfVvLBQBjY0J2N
 hr6eUCh+hTmIDnUjgwgfw1H1l+KQLdA9IMA0Z6HgpcGC7Z9Tag/1cUcHhDcOmk8c9vjX
 Q2Sgdle4+wn+NyUHFotsmRBdxCBudWSLfkXdT3t1U4NUMMbbHqj4NqYTNul5w3mTC57l RA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fps57s3ua-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 23:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+3+nRlIudDdM3XAX2dnuZqvMGBpJ7JdHDz89w/fCx9I0hgR/45RcmO85Jrlfkr7edvRpaM2iW2LXF9dQMEtqDiRGeySkJn/4rj9d61Pb+G7QbXe0d3V8cCwZtmaa/N40n8DNUDL1cBmDFt54UEtDys040wxy7MI1I03OYWY8ipCs3dlPpMjcA2Bj0EZP+ltaCeZqFX7HHB91GI9NeWraKMnzVFtsC/TILu9LW8+ck938wWpARFWXrHAE23K1u0BT+Ub5LaxgHo9aC8Oaos6ibJPOG38A5Z5eXjq0pyHB9SPSJKog1mxrhsT26AfpLJXe+X6zQBwcGzrtPep4vMOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcM04rkaaZDza5PLVUxfFVHLWveiakrCUOr8eW3fUmM=;
 b=HTtphQVahofc5tijehlqp7MPsSrJ7tJUQJkMbEtnlLq0+gdqDJr4hlzujkdB09pxz3LoLW3euS6rAUM1uMTXgeL/cAGz/HpwitvuYfmGaFLYdKhecGjrhCSA5phBPceSmudSodOpf9bdPb2G4HVu6n2+NwIB7qhrhjXxk/f3arcujN+wha7MUwnMax1ceOZg90GNkmmbyxnAX1LEej2j0XdPx6Jf2BRNt7bPKcljmGE0A2YtXgbkiz+H5gdJSb1OKeY2a0iCQvO4KyXyrUj1hB3KFXW032gEDXrUR4KyizDrC47V/u55mhUNnRPRxv6xg7qmkXI0Jfma9Xgwux6fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 06:24:48 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 06:24:48 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/4] platform/x86: pmc_atom: remove unused pmc_atom_write()
Date:   Thu, 28 Apr 2022 02:24:27 -0400
Message-Id: <20220428062430.31010-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220428062430.31010-1-paul.gortmaker@windriver.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8558d4c-68fa-4ed6-6f98-08da28dfcb7e
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB4921F904DE6C583AF3C7C3E383FD9@SA2PR11MB4921.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+ohchjzLxyQjVSZb+82Fj3JaByySPZ4sy9mec+SB4OaQHt3UQfgGpqv410k1OQs6M/yqo1xPbr3zu6XAZlC+ryAC46070Qu9P1S1zhmcK1psIsNqeaU1/u5etZxDDDXFa1hrJNc/oh5625FlQ5StO/7kQQeqPdw/wmSpDAaqwljO33xVOs+VqhIQgoj8YozpIyPw1zG44wgM4hp3OH8o+D5wIq+TdCJcXIopILR1MtwHkVIq8ZO/XcQ1lh7xyB9VNAUAd3KfDxvfFXFIkM37YL9qs5xUGLOTlwR6xnM0LbpaWCSEv2zF3ML8M0XmdygB4vFoSkxfFUAp1JxAiIwu6SdZjDCEio65f/FnrHd+3eCG6Yp49LhrpNAeWzjRyFNjZbCAv6KKUI2fYKyDLQkpKvLlxIbNOUdGMS9rEUVCu3Tu0cC7K9C857Y8TZYpVyXUaKA29VQDxuABnBO8WPl9JLONFpXJ8/uR1Ois07sCndihyLPsMqYp0SS+hsZg9n1Eb0bEALw12c0vWJ28oI/HPor2bHS08wEyDStdac6YcW1Tax1dqzxVJIXrIGK3fLJp6mjqlQV4Ua+2sLfV9BWhzUcluhmh+ayf1SqhnVj0VtWyco7KzaASxQhnJdpKiGEBTs49b0yB3oCbAtjxuMNx2WL8l+fY/nlxrDBSB9YZMIfP4N6xzFm/FKyORknHQoA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(107886003)(2906002)(44832011)(508600001)(5660300002)(38350700002)(38100700002)(6486002)(8936002)(54906003)(6916009)(1076003)(66556008)(8676002)(4326008)(36756003)(316002)(2616005)(186003)(66476007)(52116002)(86362001)(6666004)(6506007)(26005)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H+M0NarkTARysmqLrEsEjCbJaXif7PssWkdfzlEM6GaBdqYuZCyLv/O3+wYK?=
 =?us-ascii?Q?fWQ37BL6Q/rqPCGJ4OYNPmNjop5+glikd/inzEmc9ojFIgGGU9yzA0TH8LFr?=
 =?us-ascii?Q?j7eGp3IT7DoziEnhj6ccqI7zb2fS6eIOMhloTuSJXk+5aT40t5p41MnHw8UG?=
 =?us-ascii?Q?OL1VkPizYL7uBYyia6r4rlXe7sPxoFKdYwAaMimJj+bU12JRoAHkeFBxRTVu?=
 =?us-ascii?Q?sDPZYfGRPay7dFp7JOuYVz/dwsFl4huiKWGOF4PtU65TiD+4QwZJdgjr0uxQ?=
 =?us-ascii?Q?Nqh3uEdVFB32p8RyuxIM87NlWPkKPyQJKqZn6/4vkcSk7OYuN9BPuVdSKG8j?=
 =?us-ascii?Q?CGRp4F9AfWTBMXtl5vECTnXRcI4+CcAxDPxVlV24Pl8WJACbKbGnWWqdww+S?=
 =?us-ascii?Q?JVmgmnpAOwXLFByJrnVCpD5hU8yBqCDHkeHZiq3O8GJndQ8DM5r8Lo7nxkJ4?=
 =?us-ascii?Q?HX/EgiE521xfzQ+2+rfQGttKiNh0UZ8GOD0LnLxMOT/xHK7n/H16d5QBCZHG?=
 =?us-ascii?Q?vz1PhsBaXoSpU41TY/d7BqP3KOlIHoEF2GfyCtfoCpsqdUpjeyMNQhgHioNM?=
 =?us-ascii?Q?j1fNJxyC0bc4Z/YX19CGguYLk1b34TwEfTSHyOj98Qb/IjlP0iyx1a3e0gPm?=
 =?us-ascii?Q?1lig3QmjnowP2WQmNWK2/qRPzBUH5IRJfTTxmWIqGv1uvxv2Gf/hF3BZXUyX?=
 =?us-ascii?Q?p7QZOBJbxv7xEs4DJYqsNYz7LiTMl96uMvmhMAyAKQnfS7ZWHQ9JwRhkgaH7?=
 =?us-ascii?Q?4cjCIDMxVkTE6FeTeJEMvRyw+0uanSjtBkdTUqiV+vL7snkeA8nlZ9HP+Ruk?=
 =?us-ascii?Q?Y6F54Vj5DrOl14cyiBAGuPJYfRTdcWtKrpyIEbrSiThWhbRVLz+1FkIuHQas?=
 =?us-ascii?Q?xRtofOmYRurTQBcXhT6fBAYBwd4BUwRmb+4aejAJV9Jer57qvDHGbelPHY06?=
 =?us-ascii?Q?kye0TxwQ9pMeMGg29kL+KVesS5wE/bl4uI51kfVBTn4/q/3W8bepG+fU+mAw?=
 =?us-ascii?Q?RRtbT9FpsNZwC0DDUwTHk7KgYk9r0x7AxIvX4eQYqtyF6isTjNQ7TrYSTMJT?=
 =?us-ascii?Q?F76sf2lxuTiRpXDaoye4/7tLXRco+AT/yT8/gH/OUwNzol0K/TDgB4BYjpSf?=
 =?us-ascii?Q?qkDQ9h0IZURhx8vT8Ypa8ZK+Kbi1FwCYej1Dfag/vqh37tMOfS2nKMQd0BzW?=
 =?us-ascii?Q?5oEG8ctUQgkaDX1NuRd7udQ4ScMailmg11xDIBdV/baexOnfC7Jb+UGu0pwM?=
 =?us-ascii?Q?dAVmnLMtE/Dq3lKO52IP8DNTUtUhz4p8Fp1qeXireEiAMnGgzGVCIFoZqAnc?=
 =?us-ascii?Q?LJdFyYNFrRDsR1iYpv3uR8GSMTUUnX5EECOrlbZsllvCKaw0v2ei1PrWKzmw?=
 =?us-ascii?Q?MXvemrmLjr3tdqAGG7xh4++f3kScEqhxiAneb34sNcFAC2UWY+LgCgTReeI0?=
 =?us-ascii?Q?AlDU7fc6wNZ5r0pKGx9SUZkkWfLl9qSnvDwDSvN3p4FrIfUrJeE/W1bjPTyR?=
 =?us-ascii?Q?j4IMRxDO3KGR7Duv+hxpf5Gdhy0bhbpW0IdAB6TX7yf8OcLUwf5eAED771P+?=
 =?us-ascii?Q?R3emb+TEa8GXwrTw4ZGLZpymqgBXYrT8uGeqp3fWwTPFSClId5JnH+5T+q5h?=
 =?us-ascii?Q?e/JJhQx5fq5QvEYng4SJIi55Rt+kO8bmsTHkMTqYmy/zRU1nva8tlw0HdvVk?=
 =?us-ascii?Q?H0o/KsBwf00W1ebsMsgN9MXqSyJCBGMaauvkATTZCVImNF3AwzKwu+o+p8es?=
 =?us-ascii?Q?VVfRmO0zDmDKpEXAORFacrn3qh0H8Gc=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8558d4c-68fa-4ed6-6f98-08da28dfcb7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:24:48.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dDa8S+9Z58AamKBbfzKE0mqzjyxE25AAGM4LkmFEGdXHNmgE8vR3qNmwIU6hsoPKhXXXedcDeTxPbZukSywNuHiqkwDu/NYOTELl6kpmeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-Proofpoint-GUID: HI9GPboFp3qO_ZcRGMmbJEtDVdytcmF5
X-Proofpoint-ORIG-GUID: HI9GPboFp3qO_ZcRGMmbJEtDVdytcmF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=908 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function isn't used anywhere in the driver or anywhere in tree.
So remove it.  It can always be re-added if/when a use arises.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/pmc_atom.c            | 12 ------------
 include/linux/platform_data/x86/pmc_atom.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index a40fae6edc84..31cf25d25d66 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -223,18 +223,6 @@ int pmc_atom_read(int offset, u32 *value)
 }
 EXPORT_SYMBOL_GPL(pmc_atom_read);
 
-int pmc_atom_write(int offset, u32 value)
-{
-	struct pmc_dev *pmc = &pmc_device;
-
-	if (!pmc->init)
-		return -ENODEV;
-
-	pmc_reg_write(pmc, offset, value);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pmc_atom_write);
-
 static void pmc_power_off(void)
 {
 	u16	pm1_cnt_port;
diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
index 022bcea9edec..6807839c718b 100644
--- a/include/linux/platform_data/x86/pmc_atom.h
+++ b/include/linux/platform_data/x86/pmc_atom.h
@@ -144,6 +144,5 @@
 #define	SLEEP_ENABLE		0x2000
 
 extern int pmc_atom_read(int offset, u32 *value);
-extern int pmc_atom_write(int offset, u32 value);
 
 #endif /* PMC_ATOM_H */
-- 
2.17.1

