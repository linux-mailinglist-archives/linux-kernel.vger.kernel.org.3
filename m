Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995FA48147E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbhL2Pdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbhL2Pdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:33:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:33:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v7so45051171wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=yaFPtv68FbWYXGv8VLXk7KGh6SEfuXe5S0bPe1jKtfY=;
        b=jk3C/jHTfzsqW+Hy0loflhYtDDtvEBT1DbQxyp9C1LBXQ035oUqiFLlEDD4T2wYXZT
         SCmD1VlLZyOj3aL5xF81F0v5KDmA36PJYj/2Jfm4rTSNCk7TeHtcFgmDWzzgoWdsJwdU
         xLumxBO11BthYZoeqFrA/+gSaY6UvZLmDY2joWg6jKogL6Y12sdkYp2LgxIke7u52ros
         ZpvOZlPvJFIVdJtzWPn1xDZNkBjnsbIDkhaKj+AcXwwQpi6ydMp1lBfFd6YI3oRtasCl
         B+B0kCbfyDflM7pC9gDTWfisOc0AvXuRcCMWGv6Ljq3z8hC4ricTVwoQ+Zv+JhrlPf+a
         ZT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yaFPtv68FbWYXGv8VLXk7KGh6SEfuXe5S0bPe1jKtfY=;
        b=v5Ap7Gh0ZeEILrOxzfIDBKlqExpYERfqBir75LOIFnzY5cLy7L5NJqn9l3ATV8kBDk
         FQMfKpT9yMWRGWKK08Xlfmrcb8DtG2a79tvkFm7D+3IgXULoExGWQl+WS/Trh3lD4Iib
         0ssqHdb8gszm6z4wNo03on6yynSIkX8DMxiffK9Oa7bV//npRKgRkeB3KIqbbyW8zIUx
         pnvu2lcDW8UWe2DYb6gDmo23piO2tCpZITwsrY4WOaA5gr4jEv6L8uZiKLRryTRVadv4
         UcDmg9JXFSDgzgP+y5xr+jMqGCpII0LuDNCyVERSISxHMtsEbHU49AfWl5m38XecSuOY
         Lw2g==
X-Gm-Message-State: AOAM53220L3wRs9H/kGwO07WuDUvsGElvhmuUKnLuuCMBswcyo8IqTYG
        64EhLdPP251FVVyFKKVYwiwci3DFVwswO9Cw
X-Google-Smtp-Source: ABdhPJxHX/R+GnbR8HnzoKbDUijAmc3zIEpe+luqaDUulZ5jxVlaVvrMbn4pLGtC37tYfdBm/4Y1Tg==
X-Received: by 2002:adf:e8cd:: with SMTP id k13mr21643961wrn.10.1640792025183;
        Wed, 29 Dec 2021 07:33:45 -0800 (PST)
Received: from pswork.fritz.box (i5E86B42B.versanet.de. [94.134.180.43])
        by smtp.gmail.com with ESMTPSA id l10sm6801522wmq.7.2021.12.29.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 07:33:44 -0800 (PST)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        treasure4paddy@gmail.com, Stefan Wahren <stefan.wahren@i2se.com>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] staging: vc04_services: Fix RCU dereference check
Date:   Wed, 29 Dec 2021 16:32:40 +0100
Message-Id: <20211229153243.6064-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In service_callback path RCU dereference done without
rcu_read_[lock/unlock] pair, fixing same by using them.

[   32.201659] =============================
[   32.201664] WARNING: suspicious RCU usage
[   32.201670] 5.15.11-rt24-v8+ #3 Not tainted
[   32.201680] -----------------------------
[   32.201685] drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:529 suspicious rcu_dereference_check() usage!
[   32.201695]
[   32.201695] other info that might help us debug this:
[   32.201695]
[   32.201700]
[   32.201700] rcu_scheduler_active = 2, debug_locks = 1
[   32.201708] no locks held by vchiq-slot/0/98.
[   32.201715]
[   32.201715] stack backtrace:
[   32.201723] CPU: 1 PID: 98 Comm: vchiq-slot/0 Not tainted 5.15.11-rt24-v8+ #3
[   32.201733] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[   32.201739] Call trace:
[   32.201742]  dump_backtrace+0x0/0x1b8
[   32.201772]  show_stack+0x20/0x30
[   32.201784]  dump_stack_lvl+0x8c/0xb8
[   32.201799]  dump_stack+0x18/0x34
[   32.201808]  lockdep_rcu_suspicious+0xe4/0xf8
[   32.201817]  service_callback+0x124/0x400
[   32.201830]  slot_handler_func+0xf60/0x1e20
[   32.201839]  kthread+0x19c/0x1a8
[   32.201849]  ret_from_fork+0x10/0x20

Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6759a6261500..ee1b48db9681 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1058,7 +1058,10 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 
 	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 
+	rcu_read_lock();
 	service = handle_to_service(handle);
+	rcu_read_unlock();
+
 	if (WARN_ON(!service))
 		return VCHIQ_SUCCESS;
 
-- 
2.17.1

