Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EDD57C28B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiGUDGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiGUDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:06:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892A1116F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:06:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso236351pja.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TiUiKyEX3P2FTO4aLOn8yapHjE3YzElb+5iwPs0aLt4=;
        b=AwPFAp9vg7loCycRBv7ruFJlX9iu0Nzv8V53msAgJVUqPD/2NKRfmTpN1ifPtsafY6
         53xqoR8A6APf4VP2aEDdkqgt52fTjmbzv81N/kVp6Ww8v+TiHxDTi36prHC/NjdP9Rr8
         eCDqv69Rz1fRrWb1CU/l7YXC5k4fferDKyjOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TiUiKyEX3P2FTO4aLOn8yapHjE3YzElb+5iwPs0aLt4=;
        b=NTl0lzZPmNbSd+A98u954I/JWDUN2djA+xC19g9FY7GhVg7sN7JPtqxbcpKVsP7U/b
         3qi7i16JYMk1o+zhtOnfST39IvIn8jmBAqq8PcuRlWM1oQzKKfLXysbygajyoAUod95d
         WB2xhdAH6knw/YEwJGudADMeSpbG4xWbur1pJdHA9wRVhkQipTfIcQV2rdMCD5SniUXU
         W+lu2Hr2Pfd4YrA8wHO5qcL+U4UjojN8PSJPEIt39rRXyNy6zIybR82OFWOzmd/Zm6fG
         AbIJMls6K5gGX29HgsSWEb0MuE1NikjQXFAQIiHmCWZ2uKF7iG2JTfsZiXYJvXbqFyUh
         7qMw==
X-Gm-Message-State: AJIora84pmIXUezaV2MQ+A2gA8gfrfEQP6jZYPzF7R7bHxIKsg3zReM6
        3h/cYE47gspstw/o0dXkoWL0Tg==
X-Google-Smtp-Source: AGRyM1sHrBqnfmTRT5zZKQL9tlhyWU5kypSQkeslha/B7sRfvo45mnKc5x2NlsMCz8vCxUqt/LW/PA==
X-Received: by 2002:a17:90b:1d02:b0:1f0:1c2c:cc64 with SMTP id on2-20020a17090b1d0200b001f01c2ccc64mr9043289pjb.52.1658372788156;
        Wed, 20 Jul 2022 20:06:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 36-20020a630e64000000b0040df0c9a1aasm232862pgo.14.2022.07.20.20.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 20:06:27 -0700 (PDT)
Date:   Wed, 20 Jul 2022 20:06:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] lkdtm: Keep the rodata test from causing retbleed
 WARNINGS
Message-ID: <202207202006.46F304D45@keescook>
References: <20220720155507.4f904a58@gandalf.local.home>
 <202207201311.775CB068@keescook>
 <20220720225615.lrt7xnxv3trmiyc7@treble>
 <20220720225809.wtnlgvof6wi4owkq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720225809.wtnlgvof6wi4owkq@treble>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 03:58:09PM -0700, Josh Poimboeuf wrote:
> On Wed, Jul 20, 2022 at 03:56:18PM -0700, Josh Poimboeuf wrote:
> > On Wed, Jul 20, 2022 at 01:13:05PM -0700, Kees Cook wrote:
> > > On Wed, Jul 20, 2022 at 03:55:07PM -0400, Steven Rostedt wrote:
> > > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > > 
> > > > The rodata test checks if executable code in the .rodata section will not
> > > > execute. But this also means that fix ups that the return hook code does
> > > > will not be able to change this code at boot up, and this causes a
> > > > warning.
> > > > 
> > > > By removing the RETHOOK_CFLAGS from the compilation of the rodata function
> > > > makes it hidden from objtool and it will not add its return hook into the
> > > > .returns section. This keeps the fix up code from trying and failing on
> > > > modifying the rodata return call.
> > > > 
> > > > Link: https://lore.kernel.org/all/20220720125736.48164a14@gandalf.local.home/
> > > > 
> > > > Fixes: ee88d363d1561 ("x86,static_call: Use alternative RET encoding")
> > > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > 
> > > Yeah, this matches a portion of what was suggested:
> > > https://lore.kernel.org/lkml/20220713213133.455599-1-keescook@chromium.org/
> > > 
> > > But it still needed objtool fixes:
> > > https://lore.kernel.org/lkml/20220715032333.neywlazczbb35w3b@treble/
> > > 
> > > Perhaps objtool has already had patches landed for this? (Otherwise the
> > > patch you suggested would fail to build on x86 with rethunk support.)
> > 
> > I send this patch out a few days ago, nobody picked it up yet:
> > 
> > https://lkml.kernel.org/lkml/8ec0039712f252693049c70ed3891d39a2357112.1658155446.git.jpoimboe@kernel.org
> 
> Actually Peter said he grabbed it and is planning to push it to -tip
> tomorrow.

Ah perfect; thank you!

-- 
Kees Cook
