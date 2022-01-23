Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210EC497542
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiAWThz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiAWThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:37:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E34C06173B;
        Sun, 23 Jan 2022 11:37:53 -0800 (PST)
Date:   Sun, 23 Jan 2022 19:37:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642966670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9PJDDGsX+Gax6Ee5O2DMpYclOzeeXo4NHkRhjXmFkg=;
        b=w9L1mGHIFt1oEMN/iWi8/Ai06qHwvRpW7/lWnnLp/MK+/SSEn2EjKO2ccPpW4IneBSy0lD
        TzosknGcUqrLbd2Wxfid1OOoXMzcmBnCt03oU0dAw7x81btefiwp2QkhfgDNj9dfOskAqx
        L/nIbfWMOsCwzXwoYJJHU+tETSTRXaay++trOWurnayDC5SW+7YpNtUUMwz0hJ2roza76y
        RFAZNy+2AdHUPkd8I8hblA1lx4fBtmhSvZaR7Xj41t00rYznD4idow1zUrQhfgL1WnhMFy
        vseDuloYe068cKSOMgYKkX8R8e4C+0rG0zjNMqIkgMUZCBqgyyDe5wWc7FWajw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642966670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9PJDDGsX+Gax6Ee5O2DMpYclOzeeXo4NHkRhjXmFkg=;
        b=YM2yOecwL9FDKJ+K/XIhTfM+ao78yIyhZdNXlCCU8vA5yjJv+II8MSK4wKUE0nplVPjQpZ
        YCOM2nLPH7oTKECQ==
From:   "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Use default_groups in kobj_type
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220106103537.3663852-1-gregkh@linuxfoundation.org>
References: <20220106103537.3663852-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <164296666966.16921.15499044589039584350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7237727f8c4415fa925c723fc03be373834c21b9
Gitweb:        https://git.kernel.org/tip/7237727f8c4415fa925c723fc03be373834c21b9
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Thu, 06 Jan 2022 11:35:37 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:30:27 +01:00

x86/CPU/AMD: Use default_groups in kobj_type

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field. Move the AMD mce sysfs code to use default_groups field which has
been the preferred way since

  aa30f47cf666 ("kobject: Add support for default attribute groups to kobj_type")

so that the obsolete default_attrs field can be removed soon.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20220106103537.3663852-1-gregkh@linuxfoundation.org
---
 arch/x86/kernel/cpu/mce/amd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a1e2f41..c0660c1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -993,6 +993,7 @@ static struct attribute *default_attrs[] = {
 	NULL,	/* possibly interrupt_enable if supported, see below */
 	NULL,
 };
+ATTRIBUTE_GROUPS(default);
 
 #define to_block(k)	container_of(k, struct threshold_block, kobj)
 #define to_attr(a)	container_of(a, struct threshold_attr, attr)
@@ -1029,7 +1030,7 @@ static void threshold_block_release(struct kobject *kobj);
 
 static struct kobj_type threshold_ktype = {
 	.sysfs_ops		= &threshold_ops,
-	.default_attrs		= default_attrs,
+	.default_groups		= default_groups,
 	.release		= threshold_block_release,
 };
 
@@ -1101,10 +1102,10 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	b->threshold_limit	= THRESHOLD_MAX;
 
 	if (b->interrupt_capable) {
-		threshold_ktype.default_attrs[2] = &interrupt_enable.attr;
+		default_attrs[2] = &interrupt_enable.attr;
 		b->interrupt_enable = 1;
 	} else {
-		threshold_ktype.default_attrs[2] = NULL;
+		default_attrs[2] = NULL;
 	}
 
 	INIT_LIST_HEAD(&b->miscj);
