Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9E46AB25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352055AbhLFWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:01:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbhLFWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:01:17 -0500
Date:   Mon, 06 Dec 2021 21:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638827867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlLmLnWsWGl2+BSZ6bnTFxRnxTy876ydh9Ihc8/UC0w=;
        b=aAl9LBM/1WPK5x2CmBhDxjfhMS1RZwptI0X5+Sm9zfiU3lTGyYlL/ma0mlLvCvQDATPUo9
        2yxLNsQFyR5pe/e5m7P6UUmLMdUPG1yvZskFX6U6AE3phRl6kFY6kXFlJQ7Vr37gKlVwl7
        fXaBl/1AciGOPOw+6wxfyqXfF7sRl9McGnGNfZ/8SIUeFbilZCnlJb1YDGAHEikq0n725s
        Ve2RSPdCgK4lvbgCAAmNUdm6g2wVqkEnW1JblsYSHf7/Zkf3YqWNirPHDgZp7Ptwd0bi3Q
        FHL4nMyZlC25G8Gewp6mfqpn6sWFm5DmieUoO0gfGiBh1ypbU1oBmkae62UfHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638827867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlLmLnWsWGl2+BSZ6bnTFxRnxTy876ydh9Ihc8/UC0w=;
        b=yOIsXxcZCOHSo+mGzbu1/WwjT5F0K4Hg/BdzvayqMxnZVWVoOXbp/DV2wQfTVY9UmFy5NM
        ULwgX1oEXo/g9MAQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/realmode: Add comment for Global bit usage in
 trampoline_pgd
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211202153226.22946-2-joro@8bytes.org>
References: <20211202153226.22946-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <163882786606.11128.8257479627147747846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     9de4999050b5f2e847c84372c6a1aa1fe32bb269
Gitweb:        https://git.kernel.org/tip/9de4999050b5f2e847c84372c6a1aa1fe32bb269
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Thu, 02 Dec 2021 16:32:23 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 04 Dec 2021 13:50:08 +01:00

x86/realmode: Add comment for Global bit usage in trampoline_pgd

Document the fact that using the trampoline_pgd will result in the
creation of global TLB entries in the user range of the address
space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211202153226.22946-2-joro@8bytes.org
---
 arch/x86/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1895986..4ba024d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -714,6 +714,11 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 static void __init init_trampoline(void)
 {
 #ifdef CONFIG_X86_64
+	/*
+	 * The code below will alias kernel page-tables in the user-range of the
+	 * address space, including the Global bit. So global TLB entries will
+	 * be created when using the trampoline page-table.
+	 */
 	if (!kaslr_memory_enabled())
 		trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
 	else
