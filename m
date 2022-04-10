Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAA4FAD55
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiDJKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiDJKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B952B1C;
        Sun, 10 Apr 2022 03:47:06 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649587625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4DvrRiBliTnNxzv/WZdw0whMDx63qjdwBl3NhxmHFE=;
        b=VoUWQcmpe7cDD4kJO6T4W55+qxOlIpOAFknlOmYtu1PLwSqLT11Ll7tOt1dmv6vpZI3EvF
        IlZ/gf2zUGEN7q2WCSoNfR+Ex95y4jAHSL84nvPrlzWqeP9p1CJ5nhEvneMulO91zOswep
        UgV/VQoidVdxv1GqTcQSXOc455Ozf5I4L9S5xkPbJetRLOfSujAOmY/9y4Vqe+AsWnKYwr
        SdSXO+uzL2Ng7PVxv60etPvJsZqSUjflqfzN89Q9flc2kg1J3mAHhPwUomzQ2uvOF744Vx
        yn/bku0hnFQ3HjPUVTVSimCjihxlEcdnV7+lMfl2904XjFBbJ+NuB5DoVXYs6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649587625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4DvrRiBliTnNxzv/WZdw0whMDx63qjdwBl3NhxmHFE=;
        b=G9CL6wzvgc8CFqFjK4/83zscUYytF1RDopffJ4xysmjXRQyv8WX22WPxqrFAMTFjfgmtct
        lUoJMOGMPgvpYgCw==
From:   "tip-bot2 for Jakob Koschel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Use dedicated list iterator variable
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220331215707.883957-1-jakobkoschel@gmail.com>
References: <20220331215707.883957-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Message-ID: <164958762429.4207.13314961588650668115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2966a9918dfab183a1cb6be6794981ebe2abff83
Gitweb:        https://git.kernel.org/tip/2966a9918dfab183a1cb6be6794981ebe2abff83
Author:        Jakob Koschel <jakobkoschel@gmail.com>
AuthorDate:    Thu, 31 Mar 2022 23:57:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:38:45 +02:00

clockevents: Use dedicated list iterator variable

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Link: https://lore.kernel.org/r/20220331215707.883957-1-jakobkoschel@gmail.com
---
 kernel/time/clockevents.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf3..5d85014 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -690,7 +690,7 @@ static ssize_t unbind_device_store(struct device *dev,
 {
 	char name[CS_NAME_LEN];
 	ssize_t ret = sysfs_get_uname(buf, name, count);
-	struct clock_event_device *ce;
+	struct clock_event_device *ce = NULL, *iter;
 
 	if (ret < 0)
 		return ret;
@@ -698,9 +698,10 @@ static ssize_t unbind_device_store(struct device *dev,
 	ret = -ENODEV;
 	mutex_lock(&clockevents_mutex);
 	raw_spin_lock_irq(&clockevents_lock);
-	list_for_each_entry(ce, &clockevent_devices, list) {
-		if (!strcmp(ce->name, name)) {
-			ret = __clockevents_try_unbind(ce, dev->id);
+	list_for_each_entry(iter, &clockevent_devices, list) {
+		if (!strcmp(iter->name, name)) {
+			ret = __clockevents_try_unbind(iter, dev->id);
+			ce = iter;
 			break;
 		}
 	}
