Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5049A49AC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiAYGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:00:18 -0500
Received: from 6.mo584.mail-out.ovh.net ([188.165.36.253]:60817 "EHLO
        6.mo584.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbiAYF6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:58:10 -0500
X-Greylist: delayed 12603 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 00:58:10 EST
Received: from player772.ha.ovh.net (unknown [10.108.20.147])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 0714F21E2B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:34 +0000 (UTC)
Received: from lsferreira.net (176.45.37.188.rev.vodafone.pt [188.37.45.176])
        (Authenticated sender: contact@lsferreira.net)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id 5D39826BC40C1;
        Tue, 25 Jan 2022 02:20:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R0025a45659e-af8e-4b3e-a074-61450c3cdb5d,
                    A364C2FA6BBA4E3111F02E9B60B1C00A106F9C6B) smtp.auth=contact@lsferreira.net
X-OVh-ClientIp: 188.37.45.176
From:   =?UTF-8?q?Lu=C3=ADs=20Ferreira?= <contact@lsferreira.net>
To:     linux-kernel@vger.kernel.org
Cc:     bp@alien8.de,
        =?UTF-8?q?Lu=C3=ADs=20Ferreira?= <contact@lsferreira.net>
Subject: [PATCH] x86/fpu: remove memset call for xmm registers on xfpregs_set
Date:   Tue, 25 Jan 2022 02:20:15 +0000
Message-Id: <20220125022015.874422-1-contact@lsferreira.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6805220514716842232
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrvdekgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepnfhuvohsucfhvghrrhgvihhrrgcuoegtohhnthgrtghtsehlshhfvghrrhgvihhrrgdrnhgvtheqnecuggftrfgrthhtvghrnhepheegtdefjedtkedvieettdeigeejtdeikefgieehkeekffejledvudefhefgkeehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpudekkedrfeejrdeghedrudejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtohhnthgrtghtsehlshhfvghrrhgvihhrrgdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes https://bugzilla.kernel.org/show_bug.cgi?id=215524 by removing
the memset introduced by 6164331d15f7d912fb9369245368e9564ea49813, which
created a regression on ptrace PTRACE_SETREGSET request with NT_FPREGSET.
Particularly, it zeros some XMM registers on the wrong offsets. Fixing the offsets
only solves the problem for i686, which doesn't include xmm8-15 registers, so
the right way is to probably completely remove this call.

Signed-off-by: Luís Ferreira <contact@lsferreira.net>
---
 arch/x86/kernel/fpu/regset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 437d7c930c0b..aec6c49029b1 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -116,9 +116,7 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 	/* Copy the state  */
 	memcpy(&fpu->fpstate->regs.fxsave, &newstate, sizeof(newstate));
 
-	/* Clear xmm8..15 */
 	BUILD_BUG_ON(sizeof(fpu->__fpstate.regs.fxsave.xmm_space) != 16 * 16);
-	memset(&fpu->fpstate->regs.fxsave.xmm_space[8], 0, 8 * 16);
 
 	/* Mark FP and SSE as in use when XSAVE is enabled */
 	if (use_xsave())
-- 
2.34.1

