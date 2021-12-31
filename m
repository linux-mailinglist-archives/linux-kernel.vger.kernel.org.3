Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E804825AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 20:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhLaTyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 14:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhLaTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:54:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:54:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b73so17821023wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hbbP5REJxkzE277o6NN+bUvjhJlIyki9X9Dnozc3Rz8=;
        b=DuUnSYWsG02OZpc9hsYB/UUB+xWsXPlBLfiPiKf3FqVMVZjcsYQ7A0J9xHlOmkkw6A
         J4A30ryxeIvJlr43OXoIlyKth58mIOrlv+DEarLJ6PwWe5pPj6HxisKWZgNEYC0HRoa4
         /hGtR1dqfuZRRPh0T2dLkYQMeTqbJze0zsYrk7RTwOw3WVltd4InSTnzuwp5LUMos6kf
         i3EKgaoBjl3N0rdq0WfbMj7SoNUn9cPc+j/8JatXcKhcYihzybfadOs3p0xSBdLjRy78
         H3FgrSu4sQ+m4IUkcTcbV1dTAd9c/K3jENrTfANo5sh5763W8anDBWm5W7dcG1qTljlj
         2fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hbbP5REJxkzE277o6NN+bUvjhJlIyki9X9Dnozc3Rz8=;
        b=XssBN1gyoXj0N3X0xGeH14I8ReJFgGz86VBnlrQBqA6lKxqVB0kxxI+szN8KHl5blb
         62HtWkYeiHT+Z0URlMq17OdXZjMzZXkjOWx2hEmA41oAF27vg3J0f+Mw1Ug0v3TmlN7a
         tbONiQzpnIRCI+K5dZ6iL12yYgxxDyCZWyuJJ2DOIDcIpOc08Ykt+ty3wdkx3geKjbeK
         yoq/2OZN5Xl7A55EYIPznJgie0ae4iwarB6/S45IlWegzt3FgY3Z4XhsVRm1IfJQVUjU
         gt1R0nfUTlzb5WqcYKp4TiCgXd6eetGbsVZhnezA877fL0VrBXTfL6L3M/d+xGz5V9P7
         ijgA==
X-Gm-Message-State: AOAM533Mgs3hPCmxfTlwUAShBi2nQBLSwxWrTCCbZatPlmtV79lm2mKd
        +U/39QAERLKPaDy7Fyu6Vbo=
X-Google-Smtp-Source: ABdhPJwMHckgo1feARnLZwukFr92TNoIKNgay3r5XkVgfFok+B5fqFHrWmdVqdsLweXRfX8tyXnWsA==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr30848930wmj.3.1640980478902;
        Fri, 31 Dec 2021 11:54:38 -0800 (PST)
Received: from pswork.fritz.box (i5E86B4D2.versanet.de. [94.134.180.210])
        by smtp.gmail.com with ESMTPSA id o64sm26730164wme.28.2021.12.31.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 11:54:38 -0800 (PST)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        treasure4paddy@gmail.com, Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v3] staging: vc04_services: Fix RCU dereference check
Date:   Fri, 31 Dec 2021 20:54:03 +0100
Message-Id: <20211231195406.5479-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211231185611.GA4463@pswork>
References: <20211231185611.GA4463@pswork>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In service_callback path RCU dereferenced pointer struct vchiq_service
need to be accessed inside rcu read-critical section.

Also userdata/user_service part of vchiq_service is accessed around
different synchronization mechanism, getting an extra reference to a
pointer keeps sematics simpler and avoids prolonged graceperiod.

Accessing vchiq_service with rcu_read_[lock/unlock] fixes below issue.

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
Change in v3:
	Taking an extra reference for service pointer to keep semantics
simpler to accesses in different synchronization mechanism.

Changes in v2:
        RCU dereferenced pointer need to be accessed inside rcu
read-side critical section.

 .../interface/vchiq_arm/vchiq_arm.c           | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6759a6261500..3a2e4582db8e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1058,15 +1058,27 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 
 	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 
+	rcu_read_lock();
 	service = handle_to_service(handle);
-	if (WARN_ON(!service))
+	if (WARN_ON(!service)) {
+		rcu_read_unlock();
 		return VCHIQ_SUCCESS;
+	}
 
 	user_service = (struct user_service *)service->base.userdata;
 	instance = user_service->instance;
 
-	if (!instance || instance->closing)
+	if (!instance || instance->closing) {
+		rcu_read_unlock();
 		return VCHIQ_SUCCESS;
+	}
+
+	/*
+	 * As hopping around different synchronization mechanism,
+	 * taking an extra reference results in simpler implementation.
+	 */
+	vchiq_service_get(service);
+	rcu_read_unlock();
 
 	vchiq_log_trace(vchiq_arm_log_level,
 			"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
@@ -1097,6 +1109,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 							bulk_userdata);
 				if (status != VCHIQ_SUCCESS) {
 					DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+					vchiq_service_put(service);
 					return status;
 				}
 			}
@@ -1105,10 +1118,12 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 			if (wait_for_completion_interruptible(&user_service->remove_event)) {
 				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+				vchiq_service_put(service);
 				return VCHIQ_RETRY;
 			} else if (instance->closing) {
 				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+				vchiq_service_put(service);
 				return VCHIQ_ERROR;
 			}
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
@@ -1137,6 +1152,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 		header = NULL;
 	}
 	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
+	vchiq_service_put(service);
 
 	if (skip_completion)
 		return VCHIQ_SUCCESS;
-- 
2.17.1

