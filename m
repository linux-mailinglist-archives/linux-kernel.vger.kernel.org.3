Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3686747A7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhLTKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:48:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhLTKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:48:18 -0500
Date:   Mon, 20 Dec 2021 10:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639997297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPp1LBQFD8V9zdIDydz0LHUmOd6euwTtWzO5ulnY73w=;
        b=AJ8fJk3xtWqPlap2rNfFQFEhLA+c1knjayGkqac5vV9MgA91GgorCQlBWvcE3qZQSsxS1k
        86BAgCBwOIrTsVI+XU6XGE7gP1HWpEVaZmdrDhJBGtHC+CCHImgUrtFDBG20WLXwflsnNl
        GZG2u6i1Msbzb6hk/jsuabtdATBq0EPTLS+ob6DWq3zInvKRjtazUiO1MXzXTwHfehreIk
        DeuQzX5q6ZP/Ae87jUfPD5ENI3uwMju98hcSeqBHmgTInoXMhWBpjjfunfM5dmjbGafztT
        79HlCl2D6tG+Y1Ny7W/UhjY8f20NrvcVabA9P1MjbmcD2kCugAaRTd9XIGYlQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639997297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPp1LBQFD8V9zdIDydz0LHUmOd6euwTtWzO5ulnY73w=;
        b=hqUPIR4MhAraJi5VTQSMAgxTcfcV/XezkgaAXzphCWYm48IzY3BZErnAkVtpH/K7o8X8OU
        3pXFME0WcZkyG9Ag==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Check regs before accessing it
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211217102029.GA29708@kili>
References: <20211217102029.GA29708@kili>
MIME-Version: 1.0
Message-ID: <163999729659.23020.13602058944330070928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1acd85feba81084fcef00b73fc1601e42b77c5d8
Gitweb:        https://git.kernel.org/tip/1acd85feba81084fcef00b73fc1601e42b77c5d8
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 17 Dec 2021 16:49:25 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Dec 2021 11:41:02 +01:00

x86/mce: Check regs before accessing it

Commit in Fixes accesses pt_regs before checking whether it is NULL or
not. Make sure the NULL pointer check happens first.

Fixes: 0a5b288e85bb ("x86/mce: Prevent severity computation from being instrumented")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20211217102029.GA29708@kili
---
 arch/x86/kernel/cpu/mce/severity.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index a326467..7aa2bda 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -222,6 +222,9 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	struct insn insn;
 	int ret;
 
+	if (!regs)
+		return false;
+
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
@@ -283,7 +286,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
 	case EX_TYPE_COPY:
-		if (!regs || !copy_user)
+		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
