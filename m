Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE04E645C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350644AbiCXNtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350584AbiCXNst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB6A94DE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:16 -0700 (PDT)
Message-ID: <20220324134623.681768598@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fRGoaQA9ELB/t/I5jAlbmPcCoZHznW4PsontUd5UTeo=;
        b=oE6v15/Qr061F27NHTDBHMCy1kFOhASSrrCQiStooXcTJAXQG+pFtUX5J9HJjCH8s5bBNk
        NNJliAJODG9mFvr4W0GMPdvQ0+ww9lLHcZoVXXvwII5i3wptTgjmq9RFekjZqBXWMlzNi8
        85BQnggxNt+n7de4gQqe15rIjVTuZzIhtUeK/2bdz+66libTsBqZmgNsr369uqvmmg188m
        3s+t5O7bTElghz2XMvbSpl3Y14qzHLbSndImAH/+oKFFXBiKP/f/N84S4epbZheqwHi78s
        ZUIiwN07yNrXZoMvMwU1WIm+k4fR0EGNX1kdS6dnM0Xemus0ugQLZ/5+bLkDTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fRGoaQA9ELB/t/I5jAlbmPcCoZHznW4PsontUd5UTeo=;
        b=jqP05jj4pbBR0I3vIXgYP0K9j+8+EXNgovD4tMBlSEyEp1YhEZrHTEh5mbzO4mhuaBzGz0
        VyfZhs5N+ZWk4EAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
        Paolo Bonzini <bonzini@gnu.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [patch 6/7] x86/fpu/xstate: Handle supervisor states in XSTATE permissions
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:14 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size calculation in __xstate_request_perm() fails to take supervisor
states into account because the permission bitmap is only relevant for user
states.

Up to 5.17 this does not matter because there are no supervisor states
supported, but the (re)enabling of ENQCMD makes them available.

Fixes: 7c1ef59145f1 ("x86/cpufeatures: Re-enable ENQCMD")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <bonzini@gnu.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/fpu/xstate.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1566,6 +1566,9 @@ static int __xstate_request_perm(u64 per
 
 	/* Calculate the resulting kernel state size */
 	mask = permitted | requested;
+	/* Take supervisor states into account on the host */
+	if (!guest)
+		mask |= xfeatures_mask_supervisor();
 	ksize = xstate_calculate_size(mask, compacted);
 
 	/* Calculate the resulting user state size */

