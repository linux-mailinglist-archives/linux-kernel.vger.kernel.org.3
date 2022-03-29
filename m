Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BAA4EB1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbiC2QOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiC2QOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:14:34 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB31890C4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648570367;
        bh=N4oazMyRxgfyyzwKDfheJCYvuPkBFIKFycEMpS8jt70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z276OQmcJfsDrBZpaajFlxeRIYd5ohH52vBEl8FGMgToIW45euBB8/CLhYqAT0OEm
         CD7ran4IJcGyid/0CMw9LFTSrkipP/yRyPlNuiUfdbUFeriFefY5jopgMTRelyu+0J
         lDSyMHwJB/C7Bk9Ma2FM+FG9yBPD08Xu9ftUVcHs=
Received: from localhost.localdomain ([120.245.132.52])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 32C96631; Wed, 30 Mar 2022 00:12:44 +0800
X-QQ-mid: xmsmtpt1648570366truq3wpuv
Message-ID: <tencent_D9F2E3B84F62AA514CF2332F90E521A9CF05@qq.com>
X-QQ-XMAILINFO: NgiXOM0lDIKdlfD9qqmp/lF6r0XM2twCukjeb5ROVHoDHFtlu3Kb4ggKK8CBIQ
         5HjRKXhBED6dZCBmcENUiNu/kRziAGLaMS2qCfrbrS87AhTSjQoRKho8Xv/5aOjynnyZ9o44RCUW
         tW7SYHD/coCYm1p6Wgm490Qgw70iy4PDUHsEe2ayJcdi0TZGQh0FJQjekmBx3E7UOMYdOQExkDLK
         schjDCJIZoLHNzNr4XpekNkbxUjceYTXgkusTWK/IUmfsEsfEw9f5nZjm1bC0R/TvgvFxmKLRje6
         n4DmEg18b+3a78IFh0bQ2M6ENeaMEe+unonvCKjXRfDFGK4JaQUGumoNulN0YxVOeCGVnir6d4rA
         RejKUmeVz+4fUMidtxN+V5QAd1nYdsgFAcvZftCYOa4RwzoV5eBpvBtUxjJuEcqmceVskF/d8llO
         wpTTHYzhC/5Lq2TaucUuT9y9HZGms3L8+Yqw8V6cz8wmij3uRt0W7AXS1Qu99I8rRix13hru/TEk
         ARzXMCDm7iUFHfXlznXdccy6jVU+OjMoernyLDrKS5B48U3ui/aqf/Z3cDP/wxwUwcEJqNQstsWH
         0SVHDkPgmf8vcglF2WV7sWdNENRF8jDDCao2UeC5Yg2um3aY8sw2k37h7e162obIkyyIthmNPiv1
         Ri/FWnZKSpwySckvlNvDyXeusVnpUVSyMNkJnl9IiG/Ydkt3NcpfCGRxC+UJkHpxJufIHufWNZCf
         ndBKB8xwA6umhdD1l4+9z/XmcV7VRPojgGovPYJgCAHvSdpge+pZj3jbFrNSR4Ea5uY1XXLmNu3A
         +YeWLfoljPBAwcxDzJYE/BLBeoHNITCSr4xLrM5Xhfu7RkWa2fMBUe94W/DbjfaCmjsB+gfhkur2
         CMAXgU//UB94v87ILgY40lT51v7hC776DuUpGpHLiriq1cUf4+xn3IKo6b72S1+xOu0bxrYgfzHy
         RzWvWDCDUc85H31HU+sA==
From:   Chen Guanqiao <chen.chenchacha@foxmail.com>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v2 1/4] ipmi: msghandler: Add a limit for the number of users
Date:   Wed, 30 Mar 2022 00:12:39 +0800
X-OQ-MSGID: <20220329161242.76457-2-chen.chenchacha@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329161242.76457-1-chen.chenchacha@foxmail.com>
References: <20220329161242.76457-1-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The administrator sets the limit for the number of users by modifying
/sys/module/ipmi_msghandler/parameters/default_max_users.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index c59265146e9c..7886c8337368 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -145,6 +145,12 @@ module_param(default_max_retries, uint, 0644);
 MODULE_PARM_DESC(default_max_retries,
 		 "The time (milliseconds) between retry sends in maintenance mode");

+/* The default maximum number of users per intf */
+static unsigned int default_max_users = 50;
+module_param(default_max_users, uint, 0644);
+MODULE_PARM_DESC(default_max_users,
+		 "The maximum number of users per interface");
+
 /* Call every ~1000 ms. */
 #define IPMI_TIMEOUT_TIME	1000

@@ -579,6 +585,9 @@ struct ipmi_smi {

 	atomic_t stats[IPMI_NUM_STATS];

+	/* The number of user in this interface */
+	atomic_t user_count;
+
 	/*
 	 * run_to_completion duplicate of smb_info, smi_info
 	 * and ipmi_serial_info structures. Used to decrease numbers of
@@ -1182,9 +1191,11 @@ static void free_user_work(struct work_struct *work)
 {
 	struct ipmi_user *user = container_of(work, struct ipmi_user,
 					      remove_work);
+	struct ipmi_smi *intf = user->intf;

 	cleanup_srcu_struct(&user->release_barrier);
 	vfree(user);
+	atomic_dec(&intf->user_count);
 }

 int ipmi_create_user(unsigned int          if_num,
@@ -1230,6 +1241,12 @@ int ipmi_create_user(unsigned int          if_num,
 	goto out_kfree;

  found:
+	if (atomic_inc_return(&intf->user_count) > default_max_users) {
+		atomic_dec(&intf->user_count);
+		rv = -EBUSY;
+		goto out_kfree;
+	}
+
 	INIT_WORK(&new_user->remove_work, free_user_work);

 	rv = init_srcu_struct(&new_user->release_barrier);
@@ -3548,6 +3565,7 @@ int ipmi_add_smi(struct module         *owner,
 	spin_lock_init(&intf->events_lock);
 	spin_lock_init(&intf->watch_lock);
 	atomic_set(&intf->event_waiters, 0);
+	atomic_set(&intf->user_count, 0);
 	intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
--
2.25.1

