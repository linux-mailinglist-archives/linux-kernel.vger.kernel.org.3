Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8146F2B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbhLISFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLISFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:05:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56FDC061746;
        Thu,  9 Dec 2021 10:02:18 -0800 (PST)
Date:   Thu, 09 Dec 2021 18:02:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639072937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDHPldRWYu0AJwOvQF4mSEuydyx2IFn+k1caMyajHpM=;
        b=Z0yyGRkq1ieUQDIX9sD7jWmtYw7avRE+wtOOkDXmuYWEXjCHuptaCKZXhozVPHeAnRZPPb
        FclXmYloVbwdJyKY4b7Ir4Z6DRk47CTML+Qv0UcpJ6vFNOLZoK8mUb69cFDl90LZZd8zqY
        LrPmhj6KRi5i08zPNX1iCM9tquAKrYbFKNUFNxEWrCThWMxTMjl5mbRdYVTC7PK/9+lv7m
        5K3LLFQLjVFTASHSbZKFn+L8Lqdckw8mt/41BnnWzOrBsX71ab9uE0O23/DjFro56JQBqH
        MdJL9QQ7BqMVb5m0AF98AikcSo+QuBIyFiy7j3nA3eLseD4Pm+MvytR8uD92HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639072937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDHPldRWYu0AJwOvQF4mSEuydyx2IFn+k1caMyajHpM=;
        b=iDayt/p6r9m4dOqkcScSmPM/sP5j+L2CTkneutQFeRPFUL8okQh678nE2b3xEsjXs2zkGP
        NZrKYEigiBkPdMBQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove redundant assignment to variable chunks
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211207223735.35173-1-colin.i.king@gmail.com>
References: <20211207223735.35173-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Message-ID: <163907293500.11128.5399694627664847434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     df0114f1f8711dbf481324c44cf5a8349130b913
Gitweb:        https://git.kernel.org/tip/df0114f1f8711dbf481324c44cf5a8349130b913
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Tue, 07 Dec 2021 22:37:35 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 09 Dec 2021 09:57:16 -08:00

x86/resctrl: Remove redundant assignment to variable chunks

The variable chunks is being shifted right and re-assinged the shifted
value which is then returned. Since chunks is not being read afterwards
the assignment is redundant and the >>= operator can be replaced with a
shift >> operator instead.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/r/20211207223735.35173-1-colin.i.king@gmail.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c9f0f3d..eaf25a2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -282,7 +282,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	u64 shift = 64 - width, chunks;
 
 	chunks = (cur_msr << shift) - (prev_msr << shift);
-	return chunks >>= shift;
+	return chunks >> shift;
 }
 
 static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
