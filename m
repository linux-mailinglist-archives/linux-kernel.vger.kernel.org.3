Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B05A9BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiIAPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiIAPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:37:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA80792DC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:37:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q9so16729207pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YDVYQsuU6s5buwUKaoSyW52HU9Fi2XFtlERumB7twbo=;
        b=KGMOWmXOe9YjIfL0P64s9lFGHXuwn6yFmDKdS6PIMG++a9Z5mLZRtVjeAnEFWOcsbs
         e1826Z3KC6WjicbpfIvpiXYvI/KLqGTvH7IUl6AVRH3HbX92gJWKsFS0ynvE3SuUnZDZ
         9Jm5aJVgrUjBwA4PVUoEuPLiD+gPSv9wUkwEKqEHxl5gzC8fOt7fWEOnpN7yyDvd0WgN
         B1P8PFDzGw7IOS5nteeN3AB7/9A/sQCtHMxzz23OabfcYWLlrjdynO7XQS1giPoGOYDM
         ddJeeJnyB+5oYgQd557BiHjEtvkMch4Gi4FgusEThqZ8eHEOOhTIdfa6LEoEUhMkl/7W
         +QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YDVYQsuU6s5buwUKaoSyW52HU9Fi2XFtlERumB7twbo=;
        b=4X/26sqwaQuozgm8A1gzHg28IFEjB6V+uuX3W3xV/XMNveXv5azq7RU5ugV8DVz9Ln
         1txvm3j/873CwYr2iisLHgxu0WTOhg+HgR4+DbqJc6AEetFEkET20N5MAIlVHsLqrp06
         7C/BKsCaSQvBjPjO/XsHbcNfmTMkuqR6Zc0nN/abKCDrVBUuXoSqx2mCFsuOMBLuooJd
         wdhRf34pYGYOvFbZmpCaZSFqyFYL92udYCdpbsJyGiSWEoVJyI7iJI+7cz9kR2X+m5mB
         oB7Dl1JMErlIrmJqY7w8E9wW5pvtFecQBoeR5i/8UPQ8QY6CG7JGwLKnz6bcQdgROc1g
         h1Jw==
X-Gm-Message-State: ACgBeo3AoIGkQP3jSNTgYLMySwl5NoLmF35UqF83CbAtMZxvqkbupPwO
        gfjSND89SxEp0K+DuMdqBKlOZH573QnlXg==
X-Google-Smtp-Source: AA6agR4Q1iERWrDzRCPXOpgw719iTo4GnEe1MELTduwlobtAUHlRvqlwucUS5iHfDldQaVGmbIbP5A==
X-Received: by 2002:a65:6216:0:b0:41d:8248:3d05 with SMTP id d22-20020a656216000000b0041d82483d05mr27501504pgv.36.1662046638926;
        Thu, 01 Sep 2022 08:37:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b00172e19c5f8bsm6194235plb.168.2022.09.01.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:37:18 -0700 (PDT)
Date:   Thu, 1 Sep 2022 15:37:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] KVM/VMX: Do not declare vmread_error asmlinkage
Message-ID: <YxDRquTx2piSX66J@google.com>
References: <20220817144045.3206-1-ubizjak@gmail.com>
 <Yv0QFZUdePurfjKh@google.com>
 <CAFULd4bVQ73Cur85Oj=oXHiMRvfrxkAVy=V4TfHcbtNWbqOQzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4bVQ73Cur85Oj=oXHiMRvfrxkAVy=V4TfHcbtNWbqOQzw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022, Uros Bizjak wrote:
> On Wed, Aug 17, 2022 at 5:58 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > +PeterZ
> >
> > On Wed, Aug 17, 2022, Uros Bizjak wrote:
> > > There is no need to declare vmread_error asmlinkage, its arguments
> > > can be passed via registers for both, 32-bit and 64-bit targets.
> > > Function argument registers are considered call-clobbered registers,
> > > they are saved in the trampoline just before the function call and
> > > restored afterwards.
> >
> > I'm officially confused.  What's the purpose of asmlinkage when used in the kernel?
> > Is it some historical wart that's no longer truly necessary and only causes pain?
> >
> > When I wrote this code, I thought that the intent was that it should be applied to
> > any and all asm => C function calls.  But that's obviously not required as there
> > are multiple instances of asm code calling C functions without annotations of any
> > kind.
> 
> It is the other way around. As written in coding-style.rst:
> 
> Large, non-trivial assembly functions should go in .S files, with corresponding
> C prototypes defined in C header files.  The C prototypes for assembly
> functions should use ``asmlinkage``.
> 
> So, prototypes for *assembly functions* should use asmlinkage.

I gotta imagine that documentation is stale.  I don't understand why asmlinkage
would be a one-way thing.

> That said, asmlinkage for i386 just switches ABI to the default
> stack-passing ABI. However, we are calling assembly files, so the
> argument handling in the callee is totally under our control and there
> is no need to switch ABIs. It looks to me that besides syscalls,
> asmlinkage is and should be used only for a large imported body of asm
> functions that use standard stack-passing ABI (e.g. x86 crypto and
> math-emu functions), otherwise it is just a burden to push and pop
> registers to/from stack for no apparent benefit.

Yeah, this is what I'm confused about.  Unless there's something we're missing,
we should update the docs to clarify when asmlinkage is actually needed.

> > And vmread_error() isn't the only case where asmlinkage appears to be a burden, e.g.
> > schedule_tail_wrapper() => schedule_tail() seems to exist purely to deal with the
> > side affect of asmlinkage generating -regparm=0 on 32-bit kernels.
> 
> schedule_tail is external to the x86 arch directory, and for some
> reason marked asmlinkage. So, the call from asm must follow asmlinkage
> ABI.

Ahhh, it's a common helper that's called from assembly on other architectures.
That makes sense.

Thanks much!
