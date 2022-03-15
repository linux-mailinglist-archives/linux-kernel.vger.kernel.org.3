Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536414D9EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349733AbiCOPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349701AbiCOPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:44:57 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DC12A88;
        Tue, 15 Mar 2022 08:43:44 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FEP12T027492;
        Tue, 15 Mar 2022 15:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=EqEV7oOPRCwvP9zFRtxS2amJ0sojOOK340QCkQmT5GQ=;
 b=MmbDNkZcN0nDJ/dIAy0JV5+9mSxYT+G5aSV76VaEeid11XLoJzABNDBNuI69a4n6Egqf
 oA4eAx2t7m6ByKzIzF+CmR9yNsKOV1PnCrgggwHE6ivDkCElQok1IVujap1MR2bd9f6f
 K+1snqnxI/v4bFnmeGMMLhrdObFohMHAa75bBa9F/6Clg46N+AgLWc/L6MxV7y/g/HL7
 //V8/46GALm+6TrpdjYCk9PfffoZFT+U1LpfCCkU71+u2ntQdg6n+dGGxJlOcQjkduup
 OJGsidMIvW6bFpo+p0BU06VFmM0X+sDivrxeDfq4cJjvzEW5sT4qrsLz5ZHevUsBqOef tA== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3etvhvrsny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 15:43:09 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id B87D865;
        Tue, 15 Mar 2022 15:43:08 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id D81E448;
        Tue, 15 Mar 2022 15:43:07 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 3/3] x86/platform/uv: Log gap hole end size
Date:   Tue, 15 Mar 2022 10:42:49 -0500
Message-Id: <20220315154249.201067-4-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220315154249.201067-1-mike.travis@hpe.com>
References: <20220315154249.201067-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BE3uXUHf4-i6l9HxgDzanucSqv8fiPR1
X-Proofpoint-GUID: BE3uXUHf4-i6l9HxgDzanucSqv8fiPR1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=901
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150101
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show value of gap end in the kernel log which equates to number of physical
address bits used by system.  The end address of the gap holds PA bits 56:26
which gives the range up to 64PB max size with 64MB of granularity.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
v2: Update patch description to be more explanatory.
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 387d6533549a..146f0f63a43b 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1346,7 +1346,7 @@ static void __init decode_gam_params(unsigned long ptr)
 static void __init decode_gam_rng_tbl(unsigned long ptr)
 {
 	struct uv_gam_range_entry *gre = (struct uv_gam_range_entry *)ptr;
-	unsigned long lgre = 0;
+	unsigned long lgre = 0, gend = 0;
 	int index = 0;
 	int sock_min = 999999, pnode_min = 99999;
 	int sock_max = -1, pnode_max = -1;
@@ -1380,6 +1380,9 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 			flag, size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
+		if (gre->type == UV_GAM_RANGE_TYPE_HOLE)
+			gend = (unsigned long)gre->limit << UV_GAM_RANGE_SHFT;
+
 		/* update to next range start */
 		lgre = gre->limit;
 		if (sock_min > gre->sockid)
@@ -1397,7 +1400,8 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 	_max_pnode	= pnode_max;
 	_gr_table_len	= index;
 
-	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x) pnodes(min:%x,max:%x)\n", index, _min_socket, _max_socket, _min_pnode, _max_pnode);
+	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x), pnodes(min:%x,max:%x), gap_end(%d)\n",
+	  index, _min_socket, _max_socket, _min_pnode, _max_pnode, fls64(gend));
 }
 
 /* Walk through UVsystab decoding the fields */
-- 
2.26.2

