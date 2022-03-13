Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1F4D750E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiCML56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 07:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCML5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:57:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112914553E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 04:56:45 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 956901EC04F9;
        Sun, 13 Mar 2022 12:56:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647172598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bdt/r45E/OY7x64TsV90QsSkjrqS/lCvNHK3HLJeCVI=;
        b=dvLTlFaAYeZdRHMw313vw58e1/WabPrhrO4nmsijzpiPY6fBv5O6iZptUNBsctSMq328e+
        X/gcHjxScBP4FbN7yfT/4RhyoB063htWxeZHvz8SdI22oohHd6bncNvDUtLhIe6zlx8YGD
        4siPK4XOgWtFPe79Lmj2ETExvoSm86E=
Date:   Sun, 13 Mar 2022 12:56:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Jones <linux@theinnocuous.com>
Cc:     keescook@chromium.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <Yi3b/GpUuhkI5lv7@zn.tnic>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 06:06:26PM +0000, James Jones wrote:
> > Sorry for taking so long to complain, but I have been meaning to note
> > that I and a few others are still using a.out. I saw it go by in my
> > morning Google news skim that this went in, and figured it was now or
> > never. The use case is running an old set of tools to build programs for
> > the Atari Jaguar. Namely, Atari's assembler (mac) and linker (aln). The
> > alternative is running windows versions in dosbox, or using some
> > replacements that have been developed based on an even older,
> > less-featureful version of the source code for mac and aln, but which
> > still haven't managed to add back in all the features needed to build
> > some programs or use the Atari debugging tools (Also available in a.out
> > only).

Ok, for my own understanding only: you want to build those tools as
a.out binaries and run them on x86, correct?

Because wikipedia says that jaguar thing has a motorola m68k system
processor and looking at your makefile, you build some ancient gcc with
--target=m68k-aout so where does x86's a.out support come into play
here?

> > If others are open to it, I can share my small local patches along with
> > a revert of this change. I'd also like to ask whether much is gained by
> > deleting this code as far as reducing maintenance burden. It has
> > survived nearly untouched since the deprecation notice and still works
> > modulo a broken preprocessor macro in fs/exec.c.

I personally don't mind if you fix it up and take care of it going
forward, shouldn't be too much of a maintenance overhead - I'd just like
you to document somewhere in those files what is still using this so
that when you don't care for that project anymore or you stop needing
it for whatever reason, we can look up the URL and check whether we can
remove a.out support then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
