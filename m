Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA64596E39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiHQMLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiHQMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:11:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C0883EA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:11:01 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAC791EC04E4;
        Wed, 17 Aug 2022 14:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660738255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S3cBS4v+Qikhrp7lNpliwl8WSYfYa+IrcHrTLvuTVTA=;
        b=lJo43ZW6+6qDlyMH1nICaHqZ6i2x6IMB0oQGq00t0matO3FaWY6b+jl7g0rfSKu4jDYwbG
        3q5l268bn5Hz0md1OuoxNol4iscPiBaZ+cFSB2WemTiahDuTIq1+G1ibUwKUuZPDuju7eH
        kx+8jcoRnFKAh0dOGq6Nq01NAYvcS2M=
Date:   Wed, 17 Aug 2022 14:10:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <Yvzay5jOu5XBJpWa@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
 <Yvyfi9XC8bu0cOG+@gmail.com>
 <YvyiHGMbp2MtV0Vr@zn.tnic>
 <YvzXsf0mGEcOlZC5@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvzXsf0mGEcOlZC5@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:57:37AM +0000, Ashok Raj wrote:
> You have this reversed. if you get an MCE and MCIP=1 -> shutdown

Yeah yeah.

> When MCE's happen during the update they are always fatal errors.

How did you decide that?

Because all CPUs are executing the loop and thus no user process?

> What we do here by setting MCIP=1, we promote to a more severe shutdown.

It probably should say somewhere that a shutdown is possible. Because if
the shutdown really happens, you get a black screen and no info as to
why...

> Ideally I would rather let the fallout happen since its observable vs a
> blind shutdown is what we are promoting to.

What fallout do you mean exactly?

> Shutdown, shutdown.. There is only 1 MCE no matter how many CPUs you have.

Because all CPUs are executing the loop? Or how do you decide this?

> Exception is the Local MCE which is recoverable, but only to user space.
> 
> If you get an error in the atomic we are polling, its a fatal error since
> SW can't recover and we shutdown.

Aha, I think you mean that: the MCE is fatal because if it happens on
any CPU, it will be in kernel mode.

> Overthinking :-).. If there is concensus, if Boris feels comfortable
> enough, i would drop this patch.

This is what we're doing right now - thinking about the consensus. And
Boris will feel comfortable once we've arrived at a sensible decision.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
