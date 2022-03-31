Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640594ED5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiCaIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiCaIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:37:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4601EA2A5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:35:53 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 678571EC050F;
        Thu, 31 Mar 2022 10:35:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648715748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hT8ac5njJtTMhJKWZciijjzrsqUJEAFxs91osx/w2OE=;
        b=S/N6cRwE9jV1AbZutuSzSsMPn4N6eY2WRSf1Z6MJf/1LcL+TFtGb9SJigDffklOPFA6oRQ
        NJ5vvIhTykY16NFcujLKCMdeVi4a1sY/aUSOmTmAtyYNL8YIAdSXL/ILBzb8Vr0hO+BIsg
        G+UZsqR37S7szBs6kAtQsxXsgxZleeA=
Date:   Thu, 31 Mar 2022 10:35:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation
 off when not supported
Message-ID: <YkVn4wSDoTHl5Icd@zn.tnic>
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
 <YkS3OKLS1Cixs9up@zn.tnic>
 <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:48:14AM +0200, Ricardo Cañuelo wrote:
> I agree that the more explicit the better, I'll give this a try. I saw
> Pawan's suggestion as well but that one is similar to the originally
> proposed patch in that the logic/checks are split between two functions,
> this solution based on clearing the bug flag seems clearer considering
> the comment just before the code block:

Yeah, and I have some reservations with clearing that flag because,
technically speaking, that CPU still has X86_BUG_SRBDS - it's just that
it hasn't been exposed due to TSX being disabled. And no SRBDS microcode
has been uploaded.

Btw this is exactly the reason I want this to be crystal clear -
the insane conditionals around those things just to salvage *some*
performance with a lot of "but but" make everyone who deals with bugs.c
cringe...

Anyway, Pawan's suggestion makes more sense with the aspect that, yes,
the CPU is affected but the MSR is not there. And we already have
similar logic when dealing with TSX so that no new territory.

So yeah, let's do his but *actually* document why and put it in a
separate line:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..d879a6c93609 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -446,6 +446,13 @@ void update_srbds_msr(void)
 	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
 		return;
 
+	/*
+	 * A MDS_NO CPU for which SRBDS mitigation is not needed due to TSX
+	 * being disabled and it hasn't received the SRBDS MSR microcode.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
+		return;
+
 	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
 	switch (srbds_mitigation) {

---

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
