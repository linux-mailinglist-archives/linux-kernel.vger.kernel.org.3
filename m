Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C444C511E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiD0Rs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiD0RsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:48:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA98D6BA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:45:09 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 894441EC0543;
        Wed, 27 Apr 2022 19:45:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651081504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G0Q3GrO1KjrQ8+uZ5Y50vi8ZqJ/8f5t/iAJXEhYcSLo=;
        b=ZR6G3Zyz5WdU8O6IwNPa1GeNys7WPDOF55dgwvo3JSOX380Kkq4YxbBooI9SVcOzkOP0b+
        jPB7/9ortP+rxXeMRVRkvtbtRCVwAP/BHXbcz8yN5jNpQlmMriw9Eo0Gbifl9V9VolntZc
        M1zuYZg/yHUbPwdc9UtQcEzLSgLqGL4=
Date:   Wed, 27 Apr 2022 19:45:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V6 3/8] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Message-ID: <YmmBHABKMk7Ctx46@zn.tnic>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421141055.316239-4-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:10:50PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> The macro idtentry calls error_entry() unconditionally even on XENPV.
> But the code XENPV needs in error_entry() is PUSH_AND_CLEAR_REGS only.
> And error_entry() also calls sync_regs() which has to deal with the
> case of XENPV via an extra branch so that it doesn't copy the pt_regs.

What extra branch?

Do you mean the

	if (regs != eregs)

test in sync_regs()?

I'm confused. Are you, per chance, aiming to optimize XENPV here or
what's up?

> And PUSH_AND_CLEAR_REGS in error_entry() makes the stack not return to
> its original place when the function returns, which means it is not
> possible to convert it to a C function.
> 
> Move PUSH_AND_CLEAR_REGS out of error_entry(), add a function to wrap
> PUSH_AND_CLEAR_REGS and call it before error_entry().
> 
> The new function call adds two instructions (CALL and RET) for every
> interrupt or exception.

Not only - it pushes all the regs in PUSH_AND_CLEAR_REGS too. I don't
understand why that matters here? It was done in error_entry anyway.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
