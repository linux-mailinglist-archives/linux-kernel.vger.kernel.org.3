Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1485511A62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiD0OAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiD0N7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:59:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284E3A18F;
        Wed, 27 Apr 2022 06:56:17 -0700 (PDT)
Date:   Wed, 27 Apr 2022 13:56:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651067776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+WCmIMpdE6ZL8xRCWpf09nKfFO/3+T4D+j4Fj8b2AY=;
        b=ciBdKy1fE/qgTaWPSluvfcdhppEAvfTG8OHOS7ZEnvBjbpApnq6k0BIdEREpUiNAa4i3HJ
        4wzYFIwfKCMjrZHQYtIe/UjOpOLRRLySe/3D4MLN4VGmOQ47mrvNeX+AZt32/7Cvm3ucVH
        xQt/vxPLTyJipvZjLMvZvaixe7LS8z5gLKtd2uC2XdTnDfw9WEe3AhIFQexZHaKhZ51dLz
        +t7EgtQdUhEvm132Fh3fRi6IQKM7sEylE5C3uSdcUm2/VXaGEjuqvaI4KeSEBy3K+y4cPY
        tNPLkvWTX7EYXP+od1b2xv7akQiVynGbdlHlz0kOovlF2SX42XK33XXv6CyB5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651067776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+WCmIMpdE6ZL8xRCWpf09nKfFO/3+T4D+j4Fj8b2AY=;
        b=8/a7pbJn0NEwVRdhSJehvOrPXLApIDr+dq8dxSexBi52DH9YPIQXoqJqHsTWcEzk7Op7m4
        LpHWxboi6ump/8Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/aperfmperf: Dont wake idle CPUs in
 arch_freq_get_on_cpu()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415161206.419880163@linutronix.de>
References: <20220415161206.419880163@linutronix.de>
MIME-Version: 1.0
Message-ID: <165106777486.4207.5052612554422681700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     6d108c96bf23598cc3b4f91d60e9b7694abcd2a7
Gitweb:        https://git.kernel.org/tip/6d108c96bf23598cc3b4f91d60e9b7694abcd2a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Apr 2022 21:19:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Apr 2022 15:51:08 +02:00

x86/aperfmperf: Dont wake idle CPUs in arch_freq_get_on_cpu()

aperfmperf_get_khz() already excludes idle CPUs from APERF/MPERF sampling
and that's a reasonable decision. There is no point in sending up to two
IPIs to an idle CPU just because someone reads a sysfs file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20220415161206.419880163@linutronix.de

---
 arch/x86/kernel/cpu/aperfmperf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 9ca008f..ea9160f 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -139,6 +139,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
+	if (rcu_is_idle_cpu(cpu))
+		return 0;
+
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
 		return per_cpu(samples.khz, cpu);
 
