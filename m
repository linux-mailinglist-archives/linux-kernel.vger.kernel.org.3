Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5C94FE0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354490AbiDLMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355776AbiDLMsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FE3A72E;
        Tue, 12 Apr 2022 05:19:33 -0700 (PDT)
Date:   Tue, 12 Apr 2022 12:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649765971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NpdWSphFBid/89npUSGNL3SE9N2vITi79LW7flhQo0=;
        b=bJ4qf9vs5GCHSOfa9qWJqlDRSzPXB7lpJs7B8Pl/88MmEQEQyG0TOQrW61AKfmVGLL06Li
        6JRE/xn4S4flWn79dlR5SnY/vKvYBMKH3CjxqVWu3ovyJJL5rHhNaZLpvR9r3qeqUI7LK7
        cHdENRhXerWmez36gXOSkY5jzlCvbN5KfWIAb+/vHym+K27c3MrBs0A6S4rgH17VMYIhny
        DRH54NliV5RLFF/ctlDmYuZAuAOxUbKOELm1LRBC4UoSOLKR04fMgDhxsclpMtn+ZEf9+h
        7jj4mB1tWevAl1GGAIFMVznwxCUdsRVBuE7U+ffMWxQcu3V25OaN3rhnV7mIRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649765971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NpdWSphFBid/89npUSGNL3SE9N2vITi79LW7flhQo0=;
        b=ZHqFNVVjVF1xqbPTQpUG3DA+XYa53sadQfbjTDqT6nekpvdbiZIOW3pTPSryq6BFFN+0+e
        Jm41LGGG1lTzYhAA==
From:   "tip-bot2 for Longpeng(Mike)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to
 be brought up again.
Cc:     "Longpeng(Mike)" <longpeng2@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Henry Wang <Henry.Wang@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220209080214.1439408-3-bigeasy@linutronix.de>
References: <20220209080214.1439408-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164976597017.4207.3233698884104111909.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c7dfb2591b23856182e2c9da6b1d526ef7fd6b2e
Gitweb:        https://git.kernel.org/tip/c7dfb2591b23856182e2c9da6b1d526ef7fd6b2e
Author:        Longpeng(Mike) <longpeng2@huawei.com>
AuthorDate:    Wed, 09 Feb 2022 09:02:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Apr 2022 14:13:01 +02:00

cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up again.

A CPU will not show up in virtualized environment which includes an
Enclave. The VM splits its resources into a primary VM and a Enclave
VM. While the Enclave is active, the hypervisor will ignore all requests to
bring up a CPU and this CPU will remain in CPU_UP_PREPARE state.

The kernel will wait up to ten seconds for CPU to show up (do_boot_cpu())
and then rollback the hotplug state back to CPUHP_OFFLINE leaving the CPU
state in CPU_UP_PREPARE. The CPU state is set back to CPUHP_TEARDOWN_CPU
during the CPU_POST_DEAD stage.

After the Enclave VM terminates, the primary VM can bring up the CPU
again.

Allow to bring up the CPU if it is in the CPU_UP_PREPARE state.

[bigeasy: Rewrite commit description.]

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Henry Wang <Henry.Wang@arm.com>
Link: https://lore.kernel.org/r/20220209080214.1439408-3-bigeasy@linutronix.de

---
 kernel/smpboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f6bc0bc..b9f5454 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
 		 */
 		return -EAGAIN;
 
+	case CPU_UP_PREPARE:
+		/*
+		 * Timeout while waiting for the CPU to show up. Allow to try
+		 * again later.
+		 */
+		return 0;
+
 	default:
 
 		/* Should not happen.  Famous last words. */
