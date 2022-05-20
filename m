Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB37952F485
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353514AbiETUjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiETUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:38:59 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6935F19FF45;
        Fri, 20 May 2022 13:38:58 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFjYX9028627;
        Fri, 20 May 2022 20:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=5EP4WWdQHl2GA9A4nkZcKwln/XTzNpHsE6OOEXMtWg4=;
 b=cdxLViPCAOfi0bOw7sm7GiypYJ9YO1GmWP9ujXzYTeLUOzaqqfHu7cdHR/ubef1LF+Ph
 9uxaAGamAQtwMt795mlZYeDqnuvYvu3AAbhUijPmHv1ZxVyWID2bneg2V1goaOxSBXiP
 z2awl1oqtv0wLR5cBJXMSaSVDKBZ0QtMbJb921GiRObxQiQ7DDfOrhw7/iwjwxDYEL42
 y96D2OG0U6ti/83+08Ff/RYhcd9qs2+5S3qr5zOYh90gniR+M4cgHrWYo6xkCkKLqbfv
 kWM/Usebx8Nr/nVDKCq0Xf5cmRFfhUuBqOEG5tj5Zcz7pmgZAvV/4Ank6m+DRQc6lJUU NA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g6athkpuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 20:38:12 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 6EFFA81;
        Fri, 20 May 2022 20:38:11 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id C04CF37;
        Fri, 20 May 2022 20:38:09 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Dont use smp_processor_id while preemptable
Date:   Fri, 20 May 2022 15:37:55 -0500
Message-Id: <20220520203755.266337-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m21svjX_-GCqeTwK_FVQ7dSkUI5r4ybe
X-Proofpoint-ORIG-GUID: m21svjX_-GCqeTwK_FVQ7dSkUI5r4ybe
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_06,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=915 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200126
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid a "BUG: using smp_processor_id() in preemptible" debug
warning message, disable preemption around use of the processor id.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/platform/uv/uv_time.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index 54663f3e00cb..094190814a28 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -275,14 +275,17 @@ static int uv_rtc_unset_timer(int cpu, int force)
  */
 static u64 uv_read_rtc(struct clocksource *cs)
 {
-	unsigned long offset;
+	unsigned long offset, time;
+	unsigned int cpu = get_cpu();
 
 	if (uv_get_min_hub_revision_id() == 1)
 		offset = 0;
 	else
-		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
+		offset = (uv_cpu_blade_processor_id(cpu) * L1_CACHE_BYTES) % PAGE_SIZE;
 
-	return (u64)uv_read_local_mmr(UVH_RTC | offset);
+	time = (u64)uv_read_local_mmr(UVH_RTC | offset);
+	put_cpu();
+	return time;
 }
 
 /*
-- 
2.26.2

