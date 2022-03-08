Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9804D0D3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbiCHBHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiCHBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:07:19 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530AB30F5E;
        Mon,  7 Mar 2022 17:06:24 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227NHfRf029071;
        Tue, 8 Mar 2022 01:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=CBLZUvJwTvZgvVTiHXB3rzyC3r9whRr4WuoQWFxsV2I=;
 b=jLF/HikJgO7qO5jGq6tThm4T11a7HRepNkBffB1wnUkkgn+IYCUMRKjBP10pj0RVZ7FQ
 bzS/Ary2YmOOwURCe1Cpw+QXWUA6PaPjtxuB85/f033MhFhQdIA9N3NDnXHUDyVtc0j4
 UK5p1LX/FfjXC4XjgbUzPZpsPoiUtpXND7W+ecOy8563I7C9dFYGu974Vp9tP/kzWzBU
 WTJUGtJvM4DWsTdtSQp0dneId9cwV/a+paAW24Oc3lbWZVPS2mRxCFN2UbtUgmJOM0B7
 4n/vfyIQTYPbHrlU5bAUnehvc1JXLJCyII59cTp7PmdGElIJT8DVsiUpNIt+UqyoVbz5 Fg== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3enrj924cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 01:05:53 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id DC9275C;
        Tue,  8 Mar 2022 01:05:52 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 94D654A;
        Tue,  8 Mar 2022 01:05:51 +0000 (UTC)
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
Subject: [PATCH 4/4] x86/platform/uv: Add gap hole end size
Date:   Mon,  7 Mar 2022 19:05:37 -0600
Message-Id: <20220308010537.70150-5-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220308010537.70150-1-mike.travis@hpe.com>
References: <20220308010537.70150-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5387J3DsapA2vH0u7FrS17HrAxxFb92Q
X-Proofpoint-GUID: 5387J3DsapA2vH0u7FrS17HrAxxFb92Q
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_12,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=935
 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080000
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show value of gap end in kernel log which equates to number of physical
address bits used by system.  The structure stores PA bits 56:26, for
64MB granularity, up to 64PB max size.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
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

