Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32DB4D0D37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiCHBHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiCHBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:07:17 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878430F5E;
        Mon,  7 Mar 2022 17:06:21 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227NHeiv008676;
        Tue, 8 Mar 2022 01:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=z9ljuQb1bGjLceb2+CmKlwOgYsd7hWDTy5Iu5bfRm+M=;
 b=Yv4n9sPi9qFYICgjBOME0DR4Hk0RDW8SWT6TRe/29tPEU54+0TSbBLhPSdW3U2oWOxvC
 UhH2dsxU4T/15d2Bf4b7Pi80yVxJqsXYW7r/g+qAZn5zfTl+WmcObQxPb5k3ejCDtSHu
 snK9oBeY+D/QdLJS0CNWuFnuSadMvzaJbk4mdWGupbFZuj8IbtS7amXaS4y7ygJ3KBCC
 eHPENPFdVRLG/zCmZpdRtRHNselUZ59kNz7TiaBmOsqRVJJ4MX4/bf/dB2naHZYpGtjq
 cn3jgL8R+xkiqkGqdZgDjXicPfju79T0L2eDu85gi+CouTnMNTDVe1qvxkl8KTjl+3TE Lg== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3enu2yrw1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 01:05:50 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id A977BAF;
        Tue,  8 Mar 2022 01:05:49 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 977EC60;
        Tue,  8 Mar 2022 01:05:48 +0000 (UTC)
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
Subject: [PATCH 1/4] x86/platform/uv: Remove Obsolete Scratch5 NMI handler
Date:   Mon,  7 Mar 2022 19:05:34 -0600
Message-Id: <20220308010537.70150-2-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220308010537.70150-1-mike.travis@hpe.com>
References: <20220308010537.70150-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OMJDI3ASZF6Mmzu497SKdfDBPYnz7uEN
X-Proofpoint-ORIG-GUID: OMJDI3ASZF6Mmzu497SKdfDBPYnz7uEN
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_12,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080000
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes obsolete scratch5 NMI handler only used in UV1 and early UV2
systems.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h | 6 ------
 arch/x86/platform/uv/uv_nmi.c    | 5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index d3e3197917be..958c18f94146 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -729,12 +729,6 @@ extern void uv_nmi_setup_hubless(void);
 #define UVH_TSC_SYNC_VALID	3	/* 0011 */
 #define UVH_TSC_SYNC_UNKNOWN	0	/* 0000 */
 
-/* BMC sets a bit this MMR non-zero before sending an NMI */
-#define UVH_NMI_MMR		UVH_BIOS_KERNEL_MMR
-#define UVH_NMI_MMR_CLEAR	UVH_BIOS_KERNEL_MMR_ALIAS
-#define UVH_NMI_MMR_SHIFT	63
-#define UVH_NMI_MMR_TYPE	"SCRATCH5"
-
 struct uv_hub_nmi_s {
 	raw_spinlock_t	nmi_lock;
 	atomic_t	in_nmi;		/* flag this node in UV NMI IRQ */
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 1e9ff28bc2e0..926a4e006e5a 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -280,10 +280,7 @@ static void uv_nmi_setup_mmrs(void)
 		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
 		pr_info("UV: SMI NMI support: %s\n", uvh_nmi_mmrx_type);
 	} else {
-		nmi_mmr = UVH_NMI_MMR;
-		nmi_mmr_clear = UVH_NMI_MMR_CLEAR;
-		nmi_mmr_pending = 1UL << UVH_NMI_MMR_SHIFT;
-		pr_info("UV: SMI NMI support: %s\n", UVH_NMI_MMR_TYPE);
+		pr_warn("UV: NMI handler not present or not supported\n");
 	}
 }
 
-- 
2.26.2

