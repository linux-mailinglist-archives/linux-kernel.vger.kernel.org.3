Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94BF4FC02D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbiDKPTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347731AbiDKPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:18:53 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26712B1D3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:16:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6A05A22400;
        Mon, 11 Apr 2022 15:16:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7FD7922A57;
        Mon, 11 Apr 2022 15:16:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649690193; a=rsa-sha256;
        cv=none;
        b=uFmirawn8VXJ17kg3ctxX2LHmz75Cb7Kqz0QaA/8ErahmBRId03fpO7BKDwCWWukbp8ue6
        SSL777fQgBhuK29qqBGYUBNX7jnbM4BRwt63+ndI/JowDn7qS4YVJM0lGKOdJDdayDaCt8
        c3K44JZ6IF2ZssV++E41QLWNZpxbpN49kepZRv5QAW2G2LNy8LRVslxI7gzepySGJe9+ta
        j46sK9nDKqgGWxdfKY3GG4QEXvboN/ax0aAGYsvNkoScfcgCig9P8HU+mKBf9y46gudgz6
        F6Fj1NEjUsOurCs8XDYB4bro9//PE3DeW+Ap1Ml76lao7mRrjZbLMsOPBu4lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649690193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KnsgWCrmXA8Rcv/KOO/9y4OP+M/ua1Izb2uMyIZ9qZ4=;
        b=xcBDrmH1m/Y1M0KVp0kvqVyIGxVAjYfKB2dl3DCd1Eq9lGBexa/r/euYBzWo1/YOyDEaFi
        IQuSNuMbZnV7LhmbGAxXJ/D3E4F0CoizhULf1xX9HLgYT/p7I9aqSxwZhAtui5NnGXWqdH
        oH38kZby9cij80qIxbf2m7KTn9cU2FkYwRSuf2JWzrspP/+QRYYQJu+Jg/EXM7N0go2Rye
        pby9EeUzKZDUQY7Vz15SKmjk5hHJWvHtIOWqWfqnJc5yDKBUR8z1+vbSf6rG3OfRHs/mYq
        CoHgYjwIjHrLYTQ9b4/t3z4pDq2LINThUyXQQU6opRMtwQQW2O8ArKb2w9+NGg==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-8mcww;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.135 (trex/6.7.1);
        Mon, 11 Apr 2022 15:16:34 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Bubble: 583918570618a022_1649690193995_4056338885
X-MC-Loop-Signature: 1649690193995:1015188680
X-MC-Ingress-Time: 1649690193994
Received: from localhost.localdomain (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4KcXWK2tWtz32;
        Mon, 11 Apr 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649690189;
        bh=KnsgWCrmXA8Rcv/KOO/9y4OP+M/ua1Izb2uMyIZ9qZ4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=rbYqobj07NcPFsyO7asS4G/CP1GQ+vYYxTg35zI8quU7AhqKeVfuyDSH9LrhjeZdD
         Gd5l+U0UM8QUE5OREci8G22/AE5Q7uUOOUigUaxk1dknA1d1rDfHG1lSBQMRhZQjiV
         O1q0pyKw/nTsX8jF5Q12m5SBrD18deAQExbzogpW9oKga9VBB10JmSXY99bDUKNHaz
         Ik+amL+/MMURiNKrx/CcUBTMmbG3v6F3B9d3XS5su4++2BL5Cjy4QO2j4T8sEm/qkR
         txaSp1Q8bNXCN9JzycSlXI0QAel+YHkFc8eL0o7mIRxK6NT1aiBVCnfU83U7i5otgY
         tBHcPGe8LHhag==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 1/6] staging/most, dim2: convert dim2_tasklet to threaded irq
Date:   Mon, 11 Apr 2022 08:16:15 -0700
Message-Id: <20220411151620.129178-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220411151620.129178-1-dave@stgolabs.net>
References: <20220411151620.129178-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so. A more suitable equivalent
is to converted to threaded irq instead and service channels in
regular task context.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/most/dim2/dim2.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 29f8ce2a47f5..97dff82b7a5f 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -45,9 +45,6 @@ MODULE_PARM_DESC(fcnt, "Num of frames per sub-buffer for sync channels as a powe
 
 static DEFINE_SPINLOCK(dim_lock);
 
-static void dim2_tasklet_fn(unsigned long data);
-static DECLARE_TASKLET_OLD(dim2_tasklet, dim2_tasklet_fn);
-
 /**
  * struct hdm_channel - private structure to keep channel specific data
  * @name: channel name
@@ -361,15 +358,9 @@ static irqreturn_t dim2_mlb_isr(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
 
-/**
- * dim2_tasklet_fn - tasklet function
- * @data: private data
- *
- * Service each initialized channel, if needed
- */
-static void dim2_tasklet_fn(unsigned long data)
+static irqreturn_t dim2_task_irq(int irq, void *_dev)
 {
-	struct dim2_hdm *dev = (struct dim2_hdm *)data;
+	struct dim2_hdm *dev = _dev;
 	unsigned long flags;
 	int ch_idx;
 
@@ -385,6 +376,8 @@ static void dim2_tasklet_fn(unsigned long data)
 		while (!try_start_dim_transfer(dev->hch + ch_idx))
 			continue;
 	}
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -392,8 +385,8 @@ static void dim2_tasklet_fn(unsigned long data)
  * @irq: irq number
  * @_dev: private data
  *
- * Acknowledge the interrupt and schedule a tasklet to service channels.
- * Return IRQ_HANDLED.
+ * Acknowledge the interrupt and service each initialized channel,
+ * if needed, in task context.
  */
 static irqreturn_t dim2_ahb_isr(int irq, void *_dev)
 {
@@ -405,9 +398,7 @@ static irqreturn_t dim2_ahb_isr(int irq, void *_dev)
 	dim_service_ahb_int_irq(get_active_channels(dev, buffer));
 	spin_unlock_irqrestore(&dim_lock, flags);
 
-	dim2_tasklet.data = (unsigned long)dev;
-	tasklet_schedule(&dim2_tasklet);
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 /**
@@ -654,14 +645,12 @@ static int poison_channel(struct most_interface *most_iface, int ch_idx)
 	if (!hdm_ch->is_initialized)
 		return -EPERM;
 
-	tasklet_disable(&dim2_tasklet);
 	spin_lock_irqsave(&dim_lock, flags);
 	hal_ret = dim_destroy_channel(&hdm_ch->ch);
 	hdm_ch->is_initialized = false;
 	if (ch_idx == dev->atx_idx)
 		dev->atx_idx = -1;
 	spin_unlock_irqrestore(&dim_lock, flags);
-	tasklet_enable(&dim2_tasklet);
 	if (hal_ret != DIM_NO_ERROR) {
 		pr_err("HAL Failed to close channel %s\n", hdm_ch->name);
 		ret = -EFAULT;
@@ -821,8 +810,8 @@ static int dim2_probe(struct platform_device *pdev)
 		goto err_shutdown_dim;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, dim2_ahb_isr, 0,
-			       "dim2_ahb0_int", dev);
+	ret = devm_request_threaded_irq(&pdev->dev, irq, dim2_ahb_isr,
+					dim2_task_irq, 0, "dim2_ahb0_int", dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request ahb0_int irq %d\n", irq);
 		goto err_shutdown_dim;
-- 
2.26.2

