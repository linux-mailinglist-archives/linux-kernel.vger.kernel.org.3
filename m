Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B52B46D188
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhLHLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:07:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhLHLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:07:17 -0500
Date:   Wed, 08 Dec 2021 11:03:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638961424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPpaAUDIeRxeUuBTxplPgpncBDpMoQb7tz/ZQTmyVcE=;
        b=Y3KypIxzo3nBTcBdPxeM5Xysar1CdR5U6kvxHuEWwUXMe94gtX4I9ZLDiZyFyDkK0/ffnN
        N21niy6kU5vHt5ZF2acqYhZHSK89ca2sW2ZNJ0OV3n2tA63rBJxmDtPV2abUokZV5chNGa
        KpQ3er6jRjqfbT71YMaUCRYnhD9sf/UGPJymWhUP1gtX7/zDfTCS40vW7OpE4+L9QcmzW7
        HAA7ye/bebA13aC8uKrXGcTQ+nNUAcNgxywRwxu9ce+XAmHvAgVgVIWln+/mLAORIIrZyP
        GjMCuWLNYqFi0OU6++KhFmq962M7pcZ1PCbRuhD3P7HVXV3QMawVS7pU9knWTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638961424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPpaAUDIeRxeUuBTxplPgpncBDpMoQb7tz/ZQTmyVcE=;
        b=JYNx4WC/go2hI1VzPadAPptqCL49B9CXkEJfoI9RTros3wORWxvlAMdOmYnQAbh/cY7jAr
        kfI+otvy8jX0pZDQ==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/inject: Set the valid bit in MCA_STATUS
 before error injection
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211104215846.254012-3-Smita.KoralahalliChannabasappa@amd.com>
References: <20211104215846.254012-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Message-ID: <163896142328.11128.5805367812032987382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1e56279a49168f24b2b58e843ae92976f90a98a6
Gitweb:        https://git.kernel.org/tip/1e56279a49168f24b2b58e843ae92976f90a98a6
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Thu, 04 Nov 2021 16:58:42 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 12:01:01 +01:00

x86/mce/inject: Set the valid bit in MCA_STATUS before error injection

MCA handlers check the valid bit in each status register
(MCA_STATUS[Val]) and continue processing the error only if the valid
bit is set.

Set the valid bit unconditionally in the corresponding MCA_STATUS
register and correct any Val=0 injections made by the user as such
errors will get ignored and such injections will be largely pointless.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211104215846.254012-3-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 725e8e4..6eac840 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -503,6 +503,8 @@ static void do_inject(void)
 
 	i_mce.tsc = rdtsc_ordered();
 
+	i_mce.status |= MCI_STATUS_VAL;
+
 	if (i_mce.misc)
 		i_mce.status |= MCI_STATUS_MISCV;
 
