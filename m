Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449A8579086
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiGSCHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiGSCHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:07:11 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535703CBC1;
        Mon, 18 Jul 2022 19:07:09 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26INZLSP002294;
        Mon, 18 Jul 2022 19:07:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=date : message-id :
 in-reply-to : references : from : subject : to : cc; s=pfptdkimsnps;
 bh=WgGVOB8Ap/20zmrB/FXibF8XifuR+mhQyeOI03RIZ3E=;
 b=ZHkbnsgprY+5h2ry9sWFgkjFTFHCbhNooyxJ4IOfJJ5htPnY3rSAc9Tnz53RBpr7LZYS
 vm0zKHGSWORGrG30VgK70v0iRSU5xnZmXrcbQT/WTySFoxLSHbJHlxxYWm5X66UKr8JA
 lrV+rGmkkH4g914K+LwPbx4bqILvtNDafHfR05ATRVO8m9oisWpvEmfkSGsAbBAkEgcs
 JCcxCICnJVSbOd8RRW1xl3pjpxLM4mlH2upF2kjtpnBbjzqhHB9WDe5FETBORUV/G6f/
 KxUeS9j3J+iUDiMRGnsTwxakDnmcoDBtrLwDp/CgYSM78iPKdO2mdMiXZCXoFs4MQKfK ug== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvbmwp3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 19:07:07 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9C6CC4008A;
        Tue, 19 Jul 2022 02:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658196427; bh=YQOi3Xh6MI9X20tUJ2V6XY2RbBF8uzpSd/E7E0vuObc=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=D6x514FqWwBqzTosZ5OqADj/gJvU6JOnPCxoGgID+q4pAMT06F4t8gUd2Z8CrrbUY
         BuUpGwbhpa3icQe0vam3wZRpSsAibi4GEYWwrRfApZTp2uk38WVrVtKry7iBI0eAjj
         w5X6oeFqgdRGJ8DMtqfWN7U/DHXlPxqRjuB1h+SbuiRrqKM7ZVtiWgRLkscvKBMYdv
         TP7oDChBKljEanbsRCfhdHgNBV33VpL6pBWUMEPfusREwMt0cwMv2RhhL4q/mlfUUc
         FQHMz7cVjXj0mBXUeUsEZ29DyQHe5E2u1VoTZ1IuDiRW1SgC9qG+XvSyqKEdP0QMw0
         U1PPdAsYww3+g==
Received: from te-lab16-v2 (nanobot.internal.synopsys.com [10.204.48.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 7BD1CA0096;
        Tue, 19 Jul 2022 02:07:06 +0000 (UTC)
Received: by te-lab16-v2 (sSMTP sendmail emulation); Mon, 18 Jul 2022 19:07:06 -0700
Date:   Mon, 18 Jul 2022 19:07:06 -0700
Message-Id: <7d31722a7e07bc24ea37b5841a17545003eeddb4.1658195608.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
References: <cover.1658195608.git.Thinh.Nguyen@synopsys.com>
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v2 2/4] target: Implement TMR_ABORT_TASK_SET
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org
X-Proofpoint-GUID: s81H--f_BuqU9qPK3droKXqHJNdkqXkT
X-Proofpoint-ORIG-GUID: s81H--f_BuqU9qPK3droKXqHJNdkqXkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207190006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Task ABORT TASK SET function is required by SCSI transport protocol
standards (SAM-4 r14 section 7.3). It is similar to ABORT TASK
function, but it applies to all commands received on a specified I_T
nexus rather than a specific referenced command. Modify
core_tmr_abort_task() to support TMR_ABORT_TASK_SET.

Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/target/target_core_tmr.c       | 16 +++++++++++-----
 drivers/target/target_core_transport.c |  2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index bac111456fa1..1ea72e15f872 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -131,11 +131,13 @@ void core_tmr_abort_task(
 				continue;
 
 			ref_tag = se_cmd->tag;
-			if (tmr->ref_task_tag != ref_tag)
-				continue;
+			if (tmr->function == TMR_ABORT_TASK) {
+				if (tmr->ref_task_tag != ref_tag)
+					continue;
 
-			pr_err("ABORT_TASK: Found referenced %s task_tag: %llu\n",
-			       se_cmd->se_tfo->fabric_name, ref_tag);
+				pr_err("ABORT_TASK: Found referenced %s task_tag: %llu\n",
+				       se_cmd->se_tfo->fabric_name, ref_tag);
+			}
 
 			spin_lock(&se_sess->sess_cmd_lock);
 			rc = __target_check_io_state(se_cmd, se_sess, 0);
@@ -158,7 +160,11 @@ void core_tmr_abort_task(
 			       ref_tag);
 			tmr->response = TMR_FUNCTION_COMPLETE;
 			atomic_long_inc(&dev->aborts_complete);
-			return;
+
+			if (tmr->function == TMR_ABORT_TASK)
+				return;
+
+			spin_lock_irqsave(&dev->queues[i].lock, flags);
 		}
 		spin_unlock_irqrestore(&dev->queues[i].lock, flags);
 	}
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 7838dc20f713..8c386142ef90 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3519,9 +3519,9 @@ static void target_tmr_work(struct work_struct *work)
 
 	switch (tmr->function) {
 	case TMR_ABORT_TASK:
+	case TMR_ABORT_TASK_SET:
 		core_tmr_abort_task(dev, tmr, cmd->se_sess);
 		break;
-	case TMR_ABORT_TASK_SET:
 	case TMR_CLEAR_ACA:
 	case TMR_CLEAR_TASK_SET:
 		tmr->response = TMR_TASK_MGMT_FUNCTION_NOT_SUPPORTED;
-- 
2.28.0

