Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28054F383A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376450AbiDELWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiDEIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC32AC4D;
        Tue,  5 Apr 2022 01:36:49 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DjoZ6iN+ZHvNby1ojx7qIUJF9VuqAzgvC7aEtWptK4=;
        b=nWX+Fw92tPFnB5ReiW0R7KpfMkn9hfnhW3gE2Eyr6VY/COi6Rzdd1VNXUHK1yhIYl6JAqA
        JHV8NimnNqGqSfHT+XweLmzyvMF4H/N7GqqYFZVU7wscGeQWYe7RoS6tMsg8T+6AgMeEzm
        tBi3bwT/tPGrJm3u9vDTnEZPWx11m4F+8EQ89dQETdxpQl2NBqjMA+u3gOLrH4qlS13IyC
        f4uGrgnbDe6X7sPlKkeWJTk56bu6apksBo5wuCkVy2qtG2Z/tUzQlDxm0wFikKtW9Eq9dx
        0OhPWWTx124FyARkInwXHPCFDK2LZaV3Hmura6/VsO8N4EK+gMK4XQm+nfAPmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DjoZ6iN+ZHvNby1ojx7qIUJF9VuqAzgvC7aEtWptK4=;
        b=LDsrdYBUzLZfj+9NJG4ovVgApTs3mUl6y9+m/98DeeldyKksNjI2BNj+taTrSFMinwjkPs
        eidQzmW+JkYcqCAw==
From:   "tip-bot2 for Yang Jihong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Unify format of events sysfs show
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220324031957.135595-1-yangjihong1@huawei.com>
References: <20220324031957.135595-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Message-ID: <164914779656.389.16359217733489178236.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7bebfe9dd802b80abff5a43e00ab68d98893a22c
Gitweb:        https://git.kernel.org/tip/7bebfe9dd802b80abff5a43e00ab68d98893a22c
Author:        Yang Jihong <yangjihong1@huawei.com>
AuthorDate:    Thu, 24 Mar 2022 11:19:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:39 +02:00

perf/x86: Unify format of events sysfs show

Sysfs show formats of files in /sys/devices/cpu/events/ are not unified,
some end with "\n", and some do not. Modify sysfs show format of events
defined by EVENT_ATTR_STR to end with "\n".

Before:
  $ ls /sys/devices/cpu/events/* | xargs -i sh -c 'echo -n "{}: "; cat -A {}; echo'
  branch-instructions: event=0xc4$

  branch-misses: event=0xc5$

  bus-cycles: event=0x3c,umask=0x01$

  cache-misses: event=0x2e,umask=0x41$

  cache-references: event=0x2e,umask=0x4f$

  cpu-cycles: event=0x3c$

  instructions: event=0xc0$

  ref-cycles: event=0x00,umask=0x03$

  slots: event=0x00,umask=0x4
  topdown-bad-spec: event=0x00,umask=0x81
  topdown-be-bound: event=0x00,umask=0x83
  topdown-fe-bound: event=0x00,umask=0x82
  topdown-retiring: event=0x00,umask=0x80

After:
  $ ls /sys/devices/cpu/events/* | xargs -i sh -c 'echo -n "{}: "; cat -A {}; echo'
  /sys/devices/cpu/events/branch-instructions: event=0xc4$

  /sys/devices/cpu/events/branch-misses: event=0xc5$

  /sys/devices/cpu/events/bus-cycles: event=0x3c,umask=0x01$

  /sys/devices/cpu/events/cache-misses: event=0x2e,umask=0x41$

  /sys/devices/cpu/events/cache-references: event=0x2e,umask=0x4f$

  /sys/devices/cpu/events/cpu-cycles: event=0x3c$

  /sys/devices/cpu/events/instructions: event=0xc0$

  /sys/devices/cpu/events/ref-cycles: event=0x00,umask=0x03$

  /sys/devices/cpu/events/slots: event=0x00,umask=0x4$

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220324031957.135595-1-yangjihong1@huawei.com
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 54f992e..b08052b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1852,7 +1852,7 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, cha
 
 	/* string trumps id */
 	if (pmu_attr->event_str)
-		return sprintf(page, "%s", pmu_attr->event_str);
+		return sprintf(page, "%s\n", pmu_attr->event_str);
 
 	return x86_pmu.events_sysfs_show(page, config);
 }
