Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93864E897B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiC0TFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiC0TFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:05:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED01BC9B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:04:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r23so14699991edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2orOPhSthq7Tg6UfPGlytX1VwJbl+VEjNFxFh0EGLHs=;
        b=PLPIIB9XHmE87Gc0TZyTHwR630Rbjz+UseftuTOUrgLSRF1ChM+Yn+o1HnzsVz9ua+
         LJPdoDqqdIQDypT/rDGcAl6u7ulVvgTKZh78//pCGTxJDo6ORpciOcnvHl3E1L+d8seU
         rt1j0g+KEsHDNJiNX9XWIMaWHdhnPi+iGfj+wGYNe94iT3SOrO/t6HiT59OZmFBoFmsE
         wTLFNDqD55JKSQe2ZfGSGPozWTuAG/g93T1h8NT3e7N+RS9RUxfbbZPfSwAmrk09J32H
         qxrJnI/JdDjPV5G6NaxAUuDLoguUAflvMKoaG3zkzvm4YZ+2oIdNnq3zD8j3RVUz3ZK6
         r2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2orOPhSthq7Tg6UfPGlytX1VwJbl+VEjNFxFh0EGLHs=;
        b=YbwLk+yJyyrQZ3z9F4URQphisWEjr84nS0DwVOq1PjnPlZWwQX1uFFqKsJtsnDo0YU
         6Vb9HaXPduDC7A9Kwln6A+7FRrxnnscMVvsqDqp+5iUg3Lx/9x0DCNMEXwkipI6hq0ux
         lWqOpYnuAbA1wmoScl1mTBmsJCCpOmY9E9UI1Cm4v6SvNwj8/DOijEH/mxQ0LJhXQICy
         5lIzwVaD+s/hJfV2luO64/dhwYeGsJUfGAqBQe//FBQaEclxQFWAfLEtkuQJgpOTdrAw
         MMLLhELi93yiVimqBnOs5hOo1wxkqWf2rLB56VmqNCAujgSLn6l0FmKtA6V2p7N0ySHO
         RxQQ==
X-Gm-Message-State: AOAM533OWWqXJR56XnsZcOB/qU9ebf2SPOKE/4GkYhZPCEGG/prf9+fT
        T7EsqFz84kj7fKuVzS3Hyao=
X-Google-Smtp-Source: ABdhPJwcMrETwQYq8H/G0Z9gFX4bx8lpbSY7tsGjoLBfv4qGYANpysnRpxKzWVet6C4laiRDhGp7iQ==
X-Received: by 2002:a05:6402:1c1e:b0:416:5b93:eacf with SMTP id ck30-20020a0564021c1e00b004165b93eacfmr12055754edb.302.1648407849365;
        Sun, 27 Mar 2022 12:04:09 -0700 (PDT)
Received: from gmail.com (0526F2AE.dsl.pool.telekom.hu. [5.38.242.174])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm6046889edv.65.2022.03.27.12.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 12:04:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Mar 2022 21:04:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
Message-ID: <YkC1JkTOExpBOY6J@gmail.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic>
 <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com>
 <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <Yj2s8WZ4Pv1QuckE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj2s8WZ4Pv1QuckE@smile.fi.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 24, 2022 at 08:47:27AM -0700, Nathan Chancellor wrote:
> > On Thu, Mar 24, 2022 at 09:31:13AM +0100, Ingo Molnar wrote:
> 
> > > --- a/arch/x86/configs/i386_defconfig
> > > +++ b/arch/x86/configs/i386_defconfig
> 
> > > -# CONFIG_64BIT is not set
> > 
> > I don't think this is right, this is repeating the problem that was
> > fixed by commit 76366050eb1b ("x86/defconfigs: Explicitly unset
> > CONFIG_64BIT in i386_defconfig").
> > 
> > $ make ARCH=i386 savedefconfig
> > 
> > ?
> 
> +1 here, there are still branches in use that have i386 defconfig as
> as base and making this problem again is not okay.

Absolutely - fixed in the latest version.

Thanks,

	Ingo
