Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A1E538C08
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiEaHfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiEaHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:35:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE980223;
        Tue, 31 May 2022 00:34:51 -0700 (PDT)
Date:   Tue, 31 May 2022 07:34:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653982489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnPHXbgpqLop1QnGODoiMQQZ3bUEAgAygb/g5Zim1mk=;
        b=OCd2uyKy5j1PxWdt6XhPlIiV+MWriAF0nyTQSsIVWl31nF67dHZTluKrX6ralOkXBTJ9Sl
        RYAX7XQRSuWDLQ4yo1Kq+DXsEC1UXerjugHGE6t3SUwkZKA1mvDbzIK4kJfCgKNbKqeOR0
        oNINz20Vq5gOF5GEbkBokcgbpBMa+VY6w0EUeTvixUAJIsw1a7i35XXMtaBIQ+NqRiMcBK
        OQ2fOu5vk7FRniQ4FOl6gQa73mwBMVD8ghZRHhqOggmBPsX75pWCDVqWsXHFUQAMYp3gkp
        QWEPznSTzHHbdAVTfatjoLsHRIrpLZwUicUPxyaW0rKImLWMDlMh1BMNWS/rtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653982489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnPHXbgpqLop1QnGODoiMQQZ3bUEAgAygb/g5Zim1mk=;
        b=CZrA5eI1QNN6gpGMGyQB1hf6d790P5+kuQVIvN7G0ZTLW6j+aFQyGuoj650PgHBnvI/I0z
        aM2a4xmIKT5UOJDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Remove unnecessary perf callback
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220525161232.14924-5-bp@alien8.de>
References: <20220525161232.14924-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165398248772.4207.14917659484682510526.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     0c0fe08c76485fe0178ebb0fa1a2052c727abe94
Gitweb:        https://git.kernel.org/tip/0c0fe08c76485fe0178ebb0fa1a2052c727abe94
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 25 May 2022 18:12:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 31 May 2022 09:31:19 +02:00

x86/microcode: Remove unnecessary perf callback

c93dc84cbe32 ("perf/x86: Add a microcode revision check for SNB-PEBS")
checks whether the microcode revision has fixed PEBS issues.

This can happen either:

1. At PEBS init time, where the early microcode has been loaded already

2. During late loading, in the microcode_check() callback.

So remove the unnecessary call in the microcode loader init routine.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220525161232.14924-5-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 801b44a..ad57e0e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -756,10 +756,7 @@ static int __init microcode_init(void)
 
 	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
-
 	error = subsys_interface_register(&mc_cpu_interface);
-	if (!error)
-		perf_check_microcode();
 	mutex_unlock(&microcode_mutex);
 	cpus_read_unlock();
 
