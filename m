Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40F46D1CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhLHLRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhLHLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82803C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:13:46 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0714A1EC0535;
        Wed,  8 Dec 2021 12:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmEtQXYPQ1xrD5+obcLWYXq7bC6T6kZdJvcnsVu3Ysw=;
        b=UtYRwhoa2dstY9v4LzxvlMCpgrb1tf3AeBTLdOBhCYDqgUI4gLDcFFpzRSn9EtObgGkoZq
        fbCaAc0a4njJNzQsH5vPku0AvdSevplFNisEbNN+KYqAwao0tMA1RfihCNh+OJJExmwJP0
        cXbE05LZhgdpYdpbUAn1mzLMSaa92pk=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 02/12] x86/mce: Remove function-local cpus variables
Date:   Wed,  8 Dec 2021 12:13:33 +0100
Message-Id: <20211208111343.8130-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208111343.8130-1-bp@alien8.de>
References: <20211208111343.8130-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Use num_online_cpus() directly.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7c264ee18c95..f15efa242f44 100644
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
-- 
2.29.2

