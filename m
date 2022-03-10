Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBBF4D45B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiCJLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbiCJLdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:33:09 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E49141FE8;
        Thu, 10 Mar 2022 03:32:08 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22A9tGWr015844;
        Thu, 10 Mar 2022 11:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=h77jBWy4YBRVvU33BdLHk/MO9J9b7N4G7Dc/7IeUT/M=;
 b=G87bDTF0X8DGI7eM1fgnHBBgguQiHPpTO76GrqifgNZvLeYQCMNmgFzMsbeRKpfJDJGY
 N45OnLCfbFlVXAjK2l6x7OZBPTev1DXHr6/7LNMef3QWj0zHBaUpFf1mUi6MBViedP/H
 vKz3i42qRJYelSx76uhgpHzdu6pa8DGXod6qDlWuHvT29o4sImMzqjQY1Avd2boJKk2I
 SCVKrntjq6yRtr2Mu5NYWUI40yzaEoeBwNt/xUP9JXTWwK6lDdHA8+OC1VNjBp8yuDV+
 ScFzhudp7AnnbeS6ij/R7Vo4TRol31NlVhgYRSmQxw2R+s/ShlpMcbmWugJ2DjyWGkeR aA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ekxu848pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 11:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik/emHNVF91KqDmZ1qmwJFw9ic0+xWi80Csl+teEkPQX4j6BMWvhx+yty+dt4Y6Q1YfkR/X9nzOQnqMwt5S4AFUBIbV9zux2yeF83cweheyWsEVwKPeJ2YcbZFSdj/jhRsK3Bw5dm5B2DY84w2Hm9JWhGwGCZfe6kQDN5JJ3KuyWI5xRMU14whSWtrRt4X4Hi16VoMRx6VyvCBqMAZ69NmvvBFxbyQmWRtKpxp1Gwk0tLcoopfso060GB1m67eMCpPePZXT0MudcYYicUIutkQuhhaA4WshIcqVtzczvGquebHAvaGQWJB6EvKtCTzibg8SIfD+3xv4hFxA6RzjCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h77jBWy4YBRVvU33BdLHk/MO9J9b7N4G7Dc/7IeUT/M=;
 b=ethLFJgHYP/jqx1WEskHEJmsh7itlpazd3ewHOMHZ7dbCmSpJtCLBIhwuJ5qbOQhOzeUmUaEtXaZ8tcWwriZzx9jFhDzSCNn94QA/X9vqoT7qcfQ8R8biql+FmE7rJN5679yP+7DQPRWdRWj/hJvw6ldaJD2QvT08FKnKIHtOXFrfdBNdkrftPwJfNPrdnAW7qWNYUIFalSgIl8ls7b6HCeCmxJDLWydnMNbYBW1tFBBhaKG/Q0kpzepvWg4viMivr3Tl9JPp0liCwyzbXamwXjVgRFpmfdI8sVYg5eD1C5/KeF6MMHsjLl4othr/ibmuBntAfum+hVBe77qm/nZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20)
 by DM5PR11MB1706.namprd11.prod.outlook.com (2603:10b6:3:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.23; Thu, 10 Mar 2022 11:31:34 +0000
Received: from SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::8d2c:1e0:27d3:ea31]) by SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::8d2c:1e0:27d3:ea31%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 11:31:34 +0000
From:   yaliang.wang@windriver.com
To:     rppt@kernel.org, tsbogend@alpha.franken.de, huangpei@loongson.cn,
        akpm@linux-foundation.org, kumba@gentoo.org, geert@linux-m68k.org,
        anshuman.khandual@arm.com, Yaliang.Wang@windriver.com,
        penberg@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
Date:   Thu, 10 Mar 2022 19:31:16 +0800
Message-Id: <20220310113116.2068859-1-yaliang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::28) To SA0PR11MB4766.namprd11.prod.outlook.com
 (2603:10b6:806:92::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7454d206-8f12-45ec-4ade-08da028987d1
X-MS-TrafficTypeDiagnostic: DM5PR11MB1706:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB170601D8104429FD3DEBA62E9F0B9@DM5PR11MB1706.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPookuRX5MMDRaLwKBK+4Jf39+9P59SK/r3DEWaKzWUB2wBVr1DrJKZZMF8kSyZ8w1qsE0s/Jj2RqwcA6NBt83ai/F+9qdABNqtYe4FrTInxBN4d0TaS97nvr/VzYi2EsKCcF9DBDF1fQ3GNc/7/PNzyEQRztjKgtGpK7DbipYZ18l1KKJtn7AAcwubhi91TXbH4xYbHer3rtnLm0Cm8CbCTvi2t+QLGxrDUSrpIeK6ieNWzrI8yMSZvWZDr7NHZFsryg7T4AQA1uw5B2mNL+1T3erelRy4IDZnP8ytssuRHyUUmfkrIB/OLiI/C8mybc1/rfBWB2RTdIHInUHIIWkOiXqxbHpYIhsjQDwPyYnh/3hXhLmdoCQ5+Dq7pt/wj8WBxBfPY9bXYpF42d4EH8sYY9pjIDa8z+9wEGKcN68vVmJjtHd0dkwREOKkEjYDXNOyA7PplBO6qJUIt2UNN/7Bx/yYhMTixImdd7rTtp9pbkGfy5ibdrmbH4CCf5bCO3NaYuldgLd7h8OmgvPquZpe5LQy89SPlxiOGjNfndYAXgKXkgffR1Ex34czPcjDlU7wKazhIc/nc0DYvpRh+nIKWw1YRubNqkf+hYlCVw4+6c1Jh5j5jHNg9v9C9ZRNwreHOw8DV8ef+1JEEkmrZrFtratsYHJbG8xXLPcKxwJfwhg3yN9tgqoBmK8UC/SnH9eYBXE4dh+v2lTxXzCPi4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4766.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(66946007)(38350700002)(66556008)(38100700002)(36756003)(6512007)(9686003)(4326008)(1076003)(66476007)(6506007)(52116002)(86362001)(5660300002)(2906002)(8936002)(186003)(508600001)(316002)(2616005)(83380400001)(6666004)(8676002)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xaz+Z1lvJ222ekaxPpJp5rWNIhZwMaHs7lVFGRanqceD37ufuGlK9w0ki2+B?=
 =?us-ascii?Q?obNaFwt2uYokR3g4+aGwDCeBXGuQ4CMF7D/ihSGtKG/AjhKagzsEUYvW9kGj?=
 =?us-ascii?Q?3SpQMQTWmor5VOk8mhTy/u6sm1PC+h5BdwEm3bZEKE90sNoBdlFr5trBQiWI?=
 =?us-ascii?Q?WPmwFirMid7eg9gJrH+gtB3P3W7Bw4vZfaesPn48Q6gG1anQbL7GaUFYWf56?=
 =?us-ascii?Q?Z4UKeDxndxj+vKK6QcIdTJTtwFTvvapDi74Ho65G/tUhyl7J9wZOa8LvBvBJ?=
 =?us-ascii?Q?n9V6LVo0yKU+2OcOdoCCRvTqRVR3POLWLTKnyRTC5oPEqFAEr9Fi8+WzPpgO?=
 =?us-ascii?Q?dJKRzOTLT2RMavhWa7ZKEcoaRreiXWPGdgC+irTJEZaWGCMHN73aP9q0egbl?=
 =?us-ascii?Q?43nzJNKCTH1PRoOdPDVoCZ2ypVA1xne1/VcXsnErtLH6MTu+U13Gr0NxxdMz?=
 =?us-ascii?Q?FXySpj1803dbMfsWk2GFjK1+HGZgWNcH+lW4XyGgrZGknWeo7VCgJYsKizav?=
 =?us-ascii?Q?mQNkaEMkKsYzVMrzTFwsgrVkSEbNdLRteVkzMemWvPp9np/yG0hkYEVUl/KS?=
 =?us-ascii?Q?MID8+H/CKRCp87ssgCHWvj+4oiHGSDBOG4LBS0L43nWv90D+nXqbiGCxX5tU?=
 =?us-ascii?Q?S2dXZ0giGbqh4MdPEQsQPTLAOjjJKTr38PYolLGPtAdhZG3M+lZcER05RYCK?=
 =?us-ascii?Q?9rc3sOkWILuwCLQGHUiRWJIsOnJnEFJdFg6XVSf7GTIidGG3fgTeiE7P4SEo?=
 =?us-ascii?Q?g88PwpdB6xsBCRi2nVJu8jx272ldOVLfLqb8kQ/SSFXiVYu8YoedoJeWv/pY?=
 =?us-ascii?Q?mw7CdhlLZqT42HJNvnLFwIOgkV02umwIr1OjSaAQeV1D2Htbfvs/ipN/7G9L?=
 =?us-ascii?Q?LcOcw0NgxJL/IeSn//emXoyH05LGlrD1SIREEa4P3qGDWCws7q21XV6wCK0g?=
 =?us-ascii?Q?asRa/9TDcj1pU80cEywSNL/jvHFve1DosloUJRaHlFbODb2zUSkxUSawwLd1?=
 =?us-ascii?Q?twvjJRt+YLnS+9+n/tGW4+LrEag0O2gG9rPr9iXBdyz8jaFEiMtVc6XsIcsN?=
 =?us-ascii?Q?lTIii4y8ZhJb/DfKz3twnBFoweXfiMpRrxP0VO8ii91cnCEyyLjtWaQcJ+nb?=
 =?us-ascii?Q?bsMH37QI9OxgzHeso8DrJhhIyy78g7+9ZiOFqOq1LLGfixcJbmjMGX7ObcUt?=
 =?us-ascii?Q?igyzzid8P7ar1axXcRc1SzV6/D0Iol8/DvvBOFxte4xwRojdwDTP42YPrn+C?=
 =?us-ascii?Q?FSxwmsowocpuNbFQo3cFIxrnrmyCyFj3MMVLxRr26P90fCUwNmsM2xZTK+4Q?=
 =?us-ascii?Q?Ng2ZsV7FTOBTE4dDiHMMmsqVhvp8HkKlRJEpYMp7nVUEe+coeM4/FEmtNLKj?=
 =?us-ascii?Q?CTy3Tc7SAt0345WuJgyfN+vF5YBqjZkAaXNhhJ2EOl0MEfAvk2JRcWeHKVin?=
 =?us-ascii?Q?+49apPJ5ukuRM+t6CiWtTK1HwzhcgP0/VzD0bF02EY9R2Q3VvQvd0Nz29foQ?=
 =?us-ascii?Q?CCmlK1M/ZpjmFeYG6U+R8FOSCIXhMPPbYv8kj458Bdj7uGIYbmNpHxsMSdCj?=
 =?us-ascii?Q?IUxBKJ+AFtimupFuitbWe35zUvrboCobMaYC6PRyHV5pjndNdLHaF5gzEtrF?=
 =?us-ascii?Q?AfUE1Dmihi8k6Iho8mV0JmfCatYK93aK6QNdim+uqIKEpjI3WLY5iO6P0azb?=
 =?us-ascii?Q?+isgEQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7454d206-8f12-45ec-4ade-08da028987d1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4766.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:31:34.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucFXb3blk8uY/iwwTxYk6ROSd/fVpeTFrqaoOxQJB6JK1h55emd5ttt2JU21T0lSldoMVG0QzJBOcs4zui6QdCxVyRJFk6PrBlosQ8DEWQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1706
X-Proofpoint-ORIG-GUID: Zjb_UH4to1Lkxlq3Re-r2JQXkVc4p2d2
X-Proofpoint-GUID: Zjb_UH4to1Lkxlq3Re-r2JQXkVc4p2d2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=790 clxscore=1011
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaliang Wang <Yaliang.Wang@windriver.com>

pgd page is freed by generic implementation pgd_free() since commit
f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()"),
however, there are scenarios that the system uses more than one page as
the pgd table, in such cases the generic implementation pgd_free() won't
be applicable anymore. For example, when PAGE_SIZE_4KB is enabled and
MIPS_VA_BITS_48 is not enabled in a 64bit system, the macro "PGD_ORDER"
will be set as "1", which will cause allocating two pages as the pgd
table. Well, at the same time, the generic implementation pgd_free()
just free one pgd page, which will result in the memory leak.

The memory leak can be easily detected by executing shell command:
"while true; do ls > /dev/null; grep MemFree /proc/meminfo; done"

Fixes: f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()")
Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
---
 arch/mips/include/asm/pgalloc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index c7925d0e9874..867e9c3db76e 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -15,6 +15,7 @@
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_ALLOC_ONE
+#define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
@@ -48,6 +49,11 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern void pgd_init(unsigned long page);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	free_pages((unsigned long)pgd, PGD_ORDER);
+}
+
 #define __pte_free_tlb(tlb,pte,address)			\
 do {							\
 	pgtable_pte_page_dtor(pte);			\
-- 
2.25.1

