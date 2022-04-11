Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81674FC026
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbiDKPSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347720AbiDKPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:18:49 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9613F62
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:16:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 99E6B120FEA;
        Mon, 11 Apr 2022 15:16:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 267B51213A2;
        Mon, 11 Apr 2022 15:16:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649690192; a=rsa-sha256;
        cv=none;
        b=X9dWjYgRJFSKJjEJ2CwTVUDJX/MbEl9pzlqwSgBiacP/zqkCA6N/HLcc6uxBRtty5yW2C2
        j/JocxH84EZhazlK0GgJIv7TvGV0zi08CQuxgrpwmgIomZFPTgJCuaLdJFEv39aBu7fmXF
        8fGZOm3DH+CfS6IMtpxKLRJGqwTRGkSbr9ifVG6Me4WTCS+/XluYkfFp9VWQqo4ejzLiQt
        VK0LZ7w3XSu0Ud7aEAXkderEdp+EeiHQ1NHLVVkqPM0WOlHsZJmQDNqR+3TCRMMHrk/t6W
        U+Q6SW4InXgLKFgubHleGsKdXIGESBP/Ku+zGXQFvWQW3AmavMpqBCKSJRQ7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649690192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lIguktC5KCMG4rpmY997A98Ux+1JhMsjoSX+Pjzet1E=;
        b=Fr7+ULlg8KMNbSqtWWKJkbrDCuFFv1klE0+9h2qBuu/bJlkPFEy9LLvx/id5mJXCcUskAM
        4Ib1McX6gqS7E7l4XLxCqJ/nvYeaZyDhjJOL/ijSsvZDe7Uub8wJtXLWxyYWSmen3oH0K+
        0yY8VOcqNgFvA7Kxxy7ieNQ9nlUYx4wT3anzHoMW/8o9mu/uT1JpgpPprubnccozytuWKj
        7yGR6pM+EGZxyNtryBCVJu9U1uDp9BFMTLIL2IMVm7/k2BCaiYCDCOfW+fgRO9fLWg/fvZ
        HTrj05UJ2EGO/kN90CveS8xzSdgxT8li9Y5RGhAtpLWFLj213PFpK8rexdYzMw==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-2ngq6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.113 (trex/6.7.1);
        Mon, 11 Apr 2022 15:16:32 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Towering-Versed: 0591524c1969835e_1649690192430_1198574487
X-MC-Loop-Signature: 1649690192429:4073867858
X-MC-Ingress-Time: 1649690192429
Received: from localhost.localdomain (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4KcXWM0wsBz1dm;
        Mon, 11 Apr 2022 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649690191;
        bh=lIguktC5KCMG4rpmY997A98Ux+1JhMsjoSX+Pjzet1E=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=IB+0+Z5hpyC3OimGXmN18sF5uF3nNuMrP2A6o+Lhf52ij2V7LpppOeqmLCqPMXSrq
         25IOhswIhSbqVWfn09P42ELHRMVFjZwRP8kAi1S9A+2J9bIYHGa1iFUYJEVlG2u9Ff
         qR5Ymhg7fyPseNysEaGnALcLqaVeWjmdl9TfigmHPbKJjZV99NYkhvK9hEn5Y8L/OH
         LuJYZ2BfHF4BRoHyjcyNLMhi8jZ3BxmgEVPp+aDxEq60BFDPjlnH9AunZCpUvU8Gyl
         V49QOzKIbXT8HIxPZQomedBvaMbyZZL7IXo4BeIxMLKn/gAzmum2Zsq24dEADXS6IF
         0i/waCOB9gCaw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 4/6] staging/ks7010: replace SME taslet with work
Date:   Mon, 11 Apr 2022 08:16:18 -0700
Message-Id: <20220411151620.129178-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220411151620.129178-1-dave@stgolabs.net>
References: <20220411151620.129178-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so.

The execution of the SME event will now occur in task context. There
are, however, changes in concurrency. Workqueues, unlike tasklets,
are not serialized among themselves and can run concurrently
updating sme_i.qhead. However, the current code is already exposed
in same ways, regardless of the deferral mechanism, in that
hostif_sme_enqueue() does unserialized enqueues updating sme_i.qtail.

Also get rid of the bogus (power save) tasklet enabling, as it
is never disabled to begin with.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/ks7010/ks_hostif.c | 21 ++++++++++-----------
 drivers/staging/ks7010/ks_wlan.h   |  2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 1c63d595313d..f1aa3be4261d 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -84,10 +84,6 @@ static void ks_wlan_hw_wakeup_task(struct work_struct *work)
 			return;
 		}
 	}
-
-	/* power save */
-	if (atomic_read(&priv->sme_task.count) > 0)
-		tasklet_enable(&priv->sme_task);
 }
 
 static void ks_wlan_do_power_save(struct ks_wlan_private *priv)
@@ -2200,10 +2196,13 @@ static void hostif_sme_execute(struct ks_wlan_private *priv, int event)
 	}
 }
 
-static
-void hostif_sme_task(struct tasklet_struct *t)
+static void hostif_sme_work(struct work_struct *work)
 {
-	struct ks_wlan_private *priv = from_tasklet(priv, t, sme_task);
+	struct ks_wlan_private *priv;
+
+	priv = container_of(work, struct ks_wlan_private, sme_work);
+	if (!priv)
+		return;
 
 	if (priv->dev_state < DEVICE_STATE_BOOT)
 		return;
@@ -2214,7 +2213,7 @@ void hostif_sme_task(struct tasklet_struct *t)
 	hostif_sme_execute(priv, priv->sme_i.event_buff[priv->sme_i.qhead]);
 	inc_smeqhead(priv);
 	if (cnt_smeqbody(priv) > 0)
-		tasklet_schedule(&priv->sme_task);
+	        schedule_work(&priv->sme_work);
 }
 
 /* send to Station Management Entity module */
@@ -2229,7 +2228,7 @@ void hostif_sme_enqueue(struct ks_wlan_private *priv, u16 event)
 		netdev_err(priv->net_dev, "sme queue buffer overflow\n");
 	}
 
-	tasklet_schedule(&priv->sme_task);
+	schedule_work(&priv->sme_work);
 }
 
 static inline void hostif_aplist_init(struct ks_wlan_private *priv)
@@ -2254,7 +2253,7 @@ static inline void hostif_sme_init(struct ks_wlan_private *priv)
 	priv->sme_i.qtail = 0;
 	spin_lock_init(&priv->sme_i.sme_spin);
 	priv->sme_i.sme_flag = 0;
-	tasklet_setup(&priv->sme_task, hostif_sme_task);
+	INIT_WORK(&priv->sme_work, hostif_sme_work);
 }
 
 static inline void hostif_wpa_init(struct ks_wlan_private *priv)
@@ -2312,5 +2311,5 @@ int hostif_init(struct ks_wlan_private *priv)
 
 void hostif_exit(struct ks_wlan_private *priv)
 {
-	tasklet_kill(&priv->sme_task);
+	cancel_work_sync(&priv->sme_work);
 }
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 7aaf8d780939..3e9a91b5131c 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -449,7 +449,7 @@ struct ks_wlan_private {
 	struct sme_info sme_i;
 	u8 *rxp;
 	unsigned int rx_size;
-	struct tasklet_struct sme_task;
+	struct work_struct sme_work;
 	struct work_struct wakeup_work;
 	int scan_ind_count;
 
-- 
2.26.2

