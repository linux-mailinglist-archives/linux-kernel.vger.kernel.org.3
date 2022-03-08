Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA24D0D35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiCHBHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiCHBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:07:17 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B830F68;
        Mon,  7 Mar 2022 17:06:21 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227NH5Qk000527;
        Tue, 8 Mar 2022 01:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=hcFMovqlH/jOOwTXgwe1gQwTDAUcRamv/YkzwgfvOn8=;
 b=nnyx8Vhgw0BhPxx32egfaJJ/6C56qKNNzSZfm2UkoSIbAhjWWyNEof3wtOXIoaWhZXNG
 ry5qx2xmGJoEkeMg4cwJjJms2aAMD/jvOf1aewv/2RY6HDqtnZIbH4y9G9DokyhdHxmZ
 7+yx+zbXT23sDoFU+z4vo2HtiLtmCVSjfHjNPGK0WAebtAtKQyuusQPZzWJ3mC2fknd9
 9PW+c83bz3ts9YgrNGxJ7xn+cJtjpE90/WRJ3BHlAzh8q9r3I/9EUVNFwJls9iIHgGWm
 bWkKBtRD2rafOqzLYhAcLKPy1QyfGnPe/lX/eWxlv3kvRCYwR3EDj3C/M97KUjznChme 0A== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ensnqsjta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 01:05:52 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 83D3E5C;
        Tue,  8 Mar 2022 01:05:51 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 9099662;
        Tue,  8 Mar 2022 01:05:50 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/4] x86/platform/uv: Update TSC sync state for UV5
Date:   Mon,  7 Mar 2022 19:05:36 -0600
Message-Id: <20220308010537.70150-4-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220308010537.70150-1-mike.travis@hpe.com>
References: <20220308010537.70150-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kfqP2Sn8__RXnLC9SdmU4NrQTBiqvjMH
X-Proofpoint-GUID: kfqP2Sn8__RXnLC9SdmU4NrQTBiqvjMH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_12,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Update TSC to not check TSC sync state for uv5+ as it is not
available.  Therefore it is assumed that TSC will always be in
sync for multiple chassis and will pass the tests for the kernel
to accept it as the clocksource.  To disable this check use the
kernel start options tsc=reliable clocksource=tsc.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f5a48e66e4f5..387d6533549a 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -199,10 +199,16 @@ static void __init uv_tsc_check_sync(void)
 	int mmr_shift;
 	char *state;
 
-	/* Different returns from different UV BIOS versions */
+	/* UV5+, sync state from bios not available, assumed valid */
+	if (!is_uv(UV2|UV3|UV4)) {
+		pr_debug("UV: TSC sync state for UV5+ assumed valid\n");
+		mark_tsc_async_resets("UV5+");
+		return;
+	}
+
+	/* UV2,3,4, UV BIOS TSC sync state available */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
-	mmr_shift =
-		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
+	mmr_shift = is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
 	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
 	/* Check if TSC is valid for all sockets */
-- 
2.26.2

