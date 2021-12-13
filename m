Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3047331D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbhLMRfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbhLMRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446DBC061574;
        Mon, 13 Dec 2021 09:35:11 -0800 (PST)
Date:   Mon, 13 Dec 2021 17:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAjudYo3sWNdrPfYvZccCU/tUXD6BAONZa7e8dbUkWo=;
        b=WBGF9hzSEGsb9aY+HxegCWOpGXJSM5qcLsV2u8ClL+FPOVr3Ba6Ao2X70/VUoK5Lw1Y6Hg
        j+NJaAC6rGXjQ1sgG9GkZaxS6X86tuYedmozElbicUfrrgvreEuKLdbYB7DL9s3N+H1rPc
        E/JNgYe5zVSGjIZB86786cTZhK/5wXUQ5ZH2fT4OjjN089ddFvRsiczqSPOkXzarNvYoFK
        KiVqK4i2X+FiDWcZxxwlVBY3QhNRm389ZAY0SdSaVG/OcoqHfqIC5Zx5pOEie8n6c1gbJy
        RF9ZmBHXIc3o+kSJIw0a8I78sNQKNttN57pCv/vN1OsBQnH3Zs9YsRT0MzUbGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAjudYo3sWNdrPfYvZccCU/tUXD6BAONZa7e8dbUkWo=;
        b=LSs2JdktwIRmnEFuJrT8qywo/rIuvi4y3ZBG5Gnjj2RNNQgreosXkMaAA082iVUocl7W+Z
        HKYuXon8Sfu8H9Ag==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove function-local cpus variables
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-3-bp@alien8.de>
References: <20211208111343.8130-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690877.23020.17424736636812425971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     ad669ec16afeb0edb7d5bc4f92fdd059565281d2
Gitweb:        https://git.kernel.org/tip/ad669ec16afeb0edb7d5bc4f92fdd059565281d2
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 05 Oct 2021 20:06:57 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:11:53 +01:00

x86/mce: Remove function-local cpus variables

Use num_online_cpus() directly.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-3-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7c264ee..f15efa2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -985,7 +985,6 @@ static atomic_t global_nwo;
 static int mce_start(int *no_way_out)
 {
 	int order;
-	int cpus = num_online_cpus();
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
 
 	if (!timeout)
@@ -1002,7 +1001,7 @@ static int mce_start(int *no_way_out)
 	/*
 	 * Wait for everyone.
 	 */
-	while (atomic_read(&mce_callin) != cpus) {
+	while (atomic_read(&mce_callin) != num_online_cpus()) {
 		if (mce_timed_out(&timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
 			atomic_set(&global_nwo, 0);
@@ -1066,14 +1065,11 @@ static int mce_end(int order)
 	atomic_inc(&mce_executing);
 
 	if (order == 1) {
-		/* CHECKME: Can this race with a parallel hotplug? */
-		int cpus = num_online_cpus();
-
 		/*
 		 * Monarch: Wait for everyone to go through their scanning
 		 * loops.
 		 */
-		while (atomic_read(&mce_executing) <= cpus) {
+		while (atomic_read(&mce_executing) <= num_online_cpus()) {
 			if (mce_timed_out(&timeout,
 					  "Timeout: Monarch CPU unable to finish machine check processing"))
 				goto reset;
