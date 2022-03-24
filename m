Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90504E6457
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345731AbiCXNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350565AbiCXNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A528A332
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:10 -0700 (PDT)
Message-ID: <20220324134623.408932232@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k7ZwKCPvoxI5xqioe9wDMoAwUBZDO2Yad89sOWDbHAQ=;
        b=h38pHEDTkRb7pTSbSvahMDQW2Hpc2pG2Q27FZF6AExDGIjfH7Dt+17wvVHrNpCf20fK9sN
        dsMIQ5o3IPSzDR7k4s7wJcwc8Z4dkxAj6ivJCutMKJzl4zCmisG21mk0GB0kb0iT35VA0Q
        Dp3GMo+ZplFg0AEuyDns2JQ4CegwQDF7qE7IpuzJI3abYiU0RtGGb2spLfXRItuynz/YA+
        zIRFBXbzfzVz7J4WuLb0q4WHivDspydqoXuSWYDEl6lnCIYAv4J4iYN8zCGF8qn7rSCG0X
        v0KO9vY2ouWqvu6nrVy6ZkLJ8IKyzeYIyC8D9OZTpEbYqoBIbJiC90t3NhOvyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k7ZwKCPvoxI5xqioe9wDMoAwUBZDO2Yad89sOWDbHAQ=;
        b=g8OeO4Li57ezADORSDUAqGr9xaiPxB/7rIm12yvP/JK1c+Rk7rk7H122jiB75avmp3IQz5
        Wjc7qXHWsbp06AAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
        Paolo Bonzini <bonzini@gnu.org>
Subject: [patch 1/7] x86/fpu: Remove redundant XCOMP_BV initialization
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:08 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fpu_copy_uabi_to_guest_fpstate() initializes the XCOMP_BV field in the
XSAVE header. That's a leftover from the old KVM FPU buffer handling code.

Since d69c1382e1b7 ("x86/kvm: Convert FPU handling to a single swap
buffer") KVM uses the FPU core allocation code, which initializes the
XCOMP_BV field already.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <bonzini@gnu.org>
---
 arch/x86/kernel/fpu/core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -415,9 +415,6 @@ int fpu_copy_uabi_to_guest_fpstate(struc
 		xpkru = get_xsave_addr(&kstate->regs.xsave, XFEATURE_PKRU);
 		*vpkru = xpkru->pkru;
 	}
-
-	/* Ensure that XCOMP_BV is set up for XSAVES */
-	xstate_init_xcomp_bv(&kstate->regs.xsave, kstate->xfeatures);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);

