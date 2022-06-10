Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309BD545E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiFJIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiFJIEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:04:38 -0400
X-Greylist: delayed 83 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 01:04:37 PDT
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E734EDCE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:04:37 -0700 (PDT)
Received: from pps.filterd (m0264209.ppops.net [127.0.0.1])
        by mx0a-00015a02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A4f9ej024575;
        Fri, 10 Jun 2022 04:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=podpps1; bh=FBM65lOE0QCie1fmK0Dd5CZzENs7e6mZHCY1s9tNCus=;
 b=40rJpqa42+ZIlfW9PLXuqWEoJZ9LKPH7fPq+P8kqGOAnS3genJXPa1kh2BiN0/0Jwwgx
 xCM3Q7F8ZT6KDcKYX6rQchzfy3CAQIsEgi5pAvpvlTjImfnkZyMwAKAjc3Lh1Z7jxWO3
 fbBLpUPa1Ok13U2ac3aVFpzCzuu0R35NOJH7bC2CzhKZiShoejxLc+SpdLKJi3N0jmUv
 FuczLaFiOVBJR9DezeNqhALgjYh0vNK+Msy6ZRHNfzgRYbysXuNw7bffVgGC/2k3vTZL
 V939NM2yMMU7xnzXaBVfgx2y2xxDXaciMIy9xJrF/ZjfhtdIE/fKQamsZKXy/kbuuQbx MQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 3gjqryrh2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 04:02:46 -0400
Received: from PH0PR18MB5069.namprd18.prod.outlook.com (2603:10b6:510:169::8)
 by BN7PR18MB3697.namprd18.prod.outlook.com (2603:10b6:406:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.20; Fri, 10 Jun
 2022 08:02:42 +0000
Received: from PH0PR18MB5069.namprd18.prod.outlook.com
 ([fe80::f5ab:d45e:69de:f99c]) by PH0PR18MB5069.namprd18.prod.outlook.com
 ([fe80::f5ab:d45e:69de:f99c%3]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 08:02:42 +0000
From:   Ariel Miculas <ariel.miculas@belden.com>
To:     linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org
Cc:     Ariel Miculas <ariel.miculas@belden.com>
Subject: [PATCH] powerpc/32: Fix FPR index validation and fpscr access
Date:   Fri, 10 Jun 2022 11:01:59 +0300
Message-Id: <20220610080159.190353-1-ariel.miculas@belden.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To PH0PR18MB5069.namprd18.prod.outlook.com (2603:10b6:510:169::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bab8852-1017-48c9-c12b-08da4ab7981c
X-MS-TrafficTypeDiagnostic: BN7PR18MB3697:EE_
X-Microsoft-Antispam-PRVS: <BN7PR18MB369743B2EA51183996BEACCD80A69@BN7PR18MB3697.namprd18.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7+sf5fzCZeb3jefNxNqPnu+WLmuIKoP25T6p1Pqc5kYXmDI/PIkM6VIxuLWLt9F9hdh0+JFsTXCFMxe+BgiVfZckOzKfyc0U7RFwMmoMKnEN4J1tnWVQrXelcb2xBGxU0e/0HdbDV328+c7Ppgr8MpnydDkE1MPZUfD7jXe5bA4zimTLdQPmJknNVLwELAEbwfEVla0becUyyjbRkQx1JtK69kj8JP9qMy5wNIyKc5HFLu+XKvPmB3z5rm3EjmnLHB4qQcY53uS7zp3ZYYsGK3ZEJAEdaH4kgB9pQeMk16S0gxe543vJslEI7DZvIy3u0cRWDYn6J8P8xqwX3Ki5HvPrKgft4QB3cUpWxtXU+mKVUSkHieBiPZEEYNiY8nMhZE/0aq64/B4RPYWlPu+EdlJLtLjY5xzv2C9MKRjCymYI5wk+mILjk+peEvAFy91/vTsjhgLcGaUdfmsxU6IzDQM1zjnKAlXeJRLxOKT5UWAtvxpA3m5FsTYUeRku/+8iAkkDhFsyYvXLARwHtSOPbAdk9LEazF89r3EpAdFH1rPIFB4qAERwLNZ0agaNV0finYJEahPehZtCXsoFANfeZpvkTmUxadF9Obok5wc5Ajwoxh8PeCnGuXCUip/TuvoXZHfnD9lJjln9s6Fgl+uzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5069.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6486002)(52116002)(6512007)(86362001)(44832011)(508600001)(2906002)(5660300002)(4326008)(36756003)(8936002)(2616005)(66556008)(8676002)(66946007)(66476007)(83380400001)(107886003)(186003)(38100700002)(6666004)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMjhCXrNU9CZuHi5t1AzDTOdEOdsTfbHslOzfliMGz0KyOn4w22Xmr1h9olm?=
 =?us-ascii?Q?PY7TN+4xVYKDXkAQpn45z7UL+MOMAKrsV3bRW3l82VRIg6lrxIzmqqJogmMs?=
 =?us-ascii?Q?VHvXJ6viomgutaBxKidY0GELVMY89wYFPb5fdMk9SdZcf9wNoYfIAV1Q8ID2?=
 =?us-ascii?Q?L4ZuGh+8LSkSRY/PocV92PBWzyIQUFFEhC9pEZ7C54DTUpBRtExoRebKuCfL?=
 =?us-ascii?Q?Ayj0hoJKZbxDvShCd1hjGrIM5sNMPaqHwnFJ6tprUp7cuY58aK1UDVPGd0rO?=
 =?us-ascii?Q?XZ8l/Lr0VgUB/at7NGDcS748mrn0GMhd16vJ1YZ//Y2H7fe7zXuJttUAWA0Z?=
 =?us-ascii?Q?WvENUpLpMnF27YUiN2Pkr8phySxRWFveAAYS+xr/V3/VndUfcH5Z6qzhdfjC?=
 =?us-ascii?Q?d36RrJKvP1YXKfohi1szgUWbD7svcwPPjefivxJY05n/nu4Go/nI6f2wd2jc?=
 =?us-ascii?Q?V3bJmdq/1bi00ORQVlhjnCIz6aa3jTkP3H6rNbVKwdLRXuMLNZM/d3FoTizI?=
 =?us-ascii?Q?qXVNxExP7/oHi1puuodpceEgoeRuxVjyhKPH1vSPWUB2clgSlO/Pt1MZlg4e?=
 =?us-ascii?Q?DaqzvhodXYFsHRxC+6ib++MdGZxjxfDCB3RsfbDjBOeccbeGC1flVxX/NsTy?=
 =?us-ascii?Q?/mbl/+1mAAlmW3GuMMYSBv3shhHeH2UPbvXEZ5U+Pn3Pp1Mk6DvVJrELRJjx?=
 =?us-ascii?Q?qxnteAMJWT1dLGqVTA088My+42tvRZZ39FQlTEtyIvZgIabK5tjd5bewlKUI?=
 =?us-ascii?Q?C2b3od89skRa7iKV0w5uzZY1Ymcy31W6T0XkXZTUboGY/tW1n6pictLuMs1q?=
 =?us-ascii?Q?Rr2e4VqpJuxXi0Xzqa3vCSDJ7jzkulk/tLVqswVarkbfJgW7vvnsaKbTr0Wr?=
 =?us-ascii?Q?bO9vEPGbnCBgdmblXh+E4tLolvEpE8r040Y20jWbYx8plkfJQBqP5oNjSYiD?=
 =?us-ascii?Q?ac6BzfwtWbvpUrqk5zurrQSNvh+RslAsUR3KC/9ou5KSz+jSSvDjFRIB1M0Z?=
 =?us-ascii?Q?eeSdkN5cUJWw6GY3hfJBV6SD0qszLpFnPYvUl1EQJ99/zDvSd4kEbCCN0Dd5?=
 =?us-ascii?Q?kT5MopRB3WQIYdOcIAmv+zNQp4mXfmd4w6vpSoDnaajHI8uLev/k8TbDpLxF?=
 =?us-ascii?Q?7HNdwh272FjSLz+4JWLb0ckcfkZ1aIrHBNu9cZLT7sh0w89eYhb5f2zwUs5l?=
 =?us-ascii?Q?Bi72RjgnWw/PoJ376O5iMyApLkmu/mt92/zXVyYk2cRFSgUszMtg0fUnxDtS?=
 =?us-ascii?Q?kEKgYbBrFqk8iDjWCO+aJnGPBksjOvc1jYBHlFPeEz3lpxT5uI5AmdA9WXFy?=
 =?us-ascii?Q?+qyO53WDlSB4DCf064Lmvakju7xDmo0jkrMR+RCGz8YGmaUql9spaobNCQRz?=
 =?us-ascii?Q?G2hQkDrr+O5IT8kNzl+M4kDUTXRIEMyidSjcN+8ypg1hERCvi7XIx5dl3VF2?=
 =?us-ascii?Q?Vr3ZSshRvMpM+RQw3UuMHCH8f36SjWG29wEI2cbVbW2oFz8eXFnrTNyJTgg0?=
 =?us-ascii?Q?eLTe6le/3gSdTHhXBuudwn0ELfb+D+dSig/imcK8uFVrSKzFLidvFIWnWwUj?=
 =?us-ascii?Q?Q7OkE8jNM2aQhyk6cOgGjAOCmmG9PLrlHg97J8sIymK6Ls/00KAgwaaKi9lK?=
 =?us-ascii?Q?746ps13VqxklmIoulv4JvDjUMEaMHcT08jp27+lssf6wEnL7h3StyvF4/llW?=
 =?us-ascii?Q?C0g5J2PfRSbjgxntqJC15exuI4RZ4k2b3jA3MEAITDUqezWGUtilyhpdKdR4?=
 =?us-ascii?Q?CssqHEeUpZuXXLDPkrDv4147EjgcOfaiTi1tOrQif/a8supcz8kYGiYVWqhR?=
X-MS-Exchange-AntiSpam-MessageData-1: 3E4H8KsNS31KeJVgsCujIssO58XJ9Kim9/s=
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bab8852-1017-48c9-c12b-08da4ab7981c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5069.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 08:02:41.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wCbE8voq+p9F2aaGxS7janoOxm/81DlpYMDOdtS2MPH6LBAEoQCRWMu7AkmxOgLPR9MoTpbRiFBn7/fFuNSvs54oEg6rR5bQjxNSYe9y1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR18MB3697
X-Proofpoint-ORIG-GUID: Raq7t5fKxlL1fiPZwaaXnNr2-fZKxaKb
X-Proofpoint-GUID: Raq7t5fKxlL1fiPZwaaXnNr2-fZKxaKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=531 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100028
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PPC32, there are two indexes used for each FPR.

The last two indexes into the imaginary address space "USER area" are
used to access fpscr instead of the FPR registers. Fix the validation
condition so that the access of the FPR array doesn't overflow into
fpscr.  Also split the access of fpscr into high part and low part.

Signed-off-by: Ariel Miculas <ariel.miculas@belden.com>
---
 arch/powerpc/kernel/ptrace/ptrace-fpu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-fpu.c b/arch/powerpc/kernel/ptrace/ptrace-fpu.c
index 09c49632bfe5..eabc05b439f1 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-fpu.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-fpu.c
@@ -17,14 +17,18 @@ int ptrace_get_fpr(struct task_struct *child, int index, unsigned long *data)
 
 #ifdef CONFIG_PPC_FPU_REGS
 	flush_fp_to_thread(child);
-	if (fpidx < (PT_FPSCR - PT_FPR0)) {
-		if (IS_ENABLED(CONFIG_PPC32))
+	if (IS_ENABLED(CONFIG_PPC32)) {
+		if ((fpidx >> 1) < (PT_FPSCR - PT_FPR0) >> 1)
 			// On 32-bit the index we are passed refers to 32-bit words
 			*data = ((u32 *)child->thread.fp_state.fpr)[fpidx];
 		else
+			*data = ((u32 *)&child->thread.fp_state.fpscr)[fpidx & 1];
+	} else {
+		if (fpidx < (PT_FPSCR - PT_FPR0))
 			memcpy(data, &child->thread.TS_FPR(fpidx), sizeof(long));
-	} else
-		*data = child->thread.fp_state.fpscr;
+		else
+			*data = child->thread.fp_state.fpscr;
+	}
 #else
 	*data = 0;
 #endif
@@ -43,14 +47,18 @@ int ptrace_put_fpr(struct task_struct *child, int index, unsigned long data)
 
 #ifdef CONFIG_PPC_FPU_REGS
 	flush_fp_to_thread(child);
-	if (fpidx < (PT_FPSCR - PT_FPR0)) {
-		if (IS_ENABLED(CONFIG_PPC32))
+	if (IS_ENABLED(CONFIG_PPC32)) {
+		if ((fpidx >> 1) < (PT_FPSCR - PT_FPR0) >> 1)
 			// On 32-bit the index we are passed refers to 32-bit words
 			((u32 *)child->thread.fp_state.fpr)[fpidx] = data;
 		else
+			((u32 *)&child->thread.fp_state.fpscr)[fpidx & 1] = data;
+	} else {
+		if (fpidx < (PT_FPSCR - PT_FPR0))
 			memcpy(&child->thread.TS_FPR(fpidx), &data, sizeof(long));
-	} else
-		child->thread.fp_state.fpscr = data;
+		else
+			child->thread.fp_state.fpscr = data;
+	}
 #endif
 
 	return 0;
-- 
2.36.1

