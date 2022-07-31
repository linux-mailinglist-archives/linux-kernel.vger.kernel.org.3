Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD0585F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGaP21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiGaP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:28:25 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A573FCDE
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:28:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o1so6792202qkg.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=kJfW6d1KSfPNL+r0nf2DTE5sjjqjC8+SBna7Wa9e31w=;
        b=TB0H7KAUOyaqQmbVjOPYpU1qyejrhpzBVdtDntReEnjS+jX/1qYLXjUlqoqj8l/dVE
         8vYjFHZpKuyI8b3nsp4zthh8ZqUdjbwEnTDoyWqB1Z+4WJXx3G7skyx5D12pguhBpmhH
         wgnLCOuO0Gn2gFeqDQKR9bY1OagE1eAn9dYAwUrmDEI83ToxrbJRM8eh1gdez+a3KVA3
         13aZMDEN0LaRCLv2Vp8UwYGbx/R+SBwZ1HagXtAxiUaW6lX6jcnA811L+/REZ3lItFev
         Ms3JMR5wVADkGgiXj+DIqy6DRX890gKmLW2QuyFFkxY8HB7MjQ4WOyaEM9jM5fYi8Xl6
         QAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=kJfW6d1KSfPNL+r0nf2DTE5sjjqjC8+SBna7Wa9e31w=;
        b=RM5AI1Ns+SohQx35k0FWRKos+vzK+Lpc68r2muhcQSjQo+tn03aLlSeU0ziK4Z+i/j
         KRXZfW/52CHrVLbB7ZQUN24fmbFV17Km4zmXJmQ93UZ8CHKWlvYYACHGZppiTewjh81p
         ymV7NBuKxBZlf2AfurelRyAoNeRkhBnLYZr8b8aXKaXQRQxidEwEU+oinMkVmQQTFvpO
         b790DLtvSVMvg6lGfGs6ZcGLAsOZOi1WyPXj5ellRv5iYMh7m6d8gq4al2ps4gXq1c5e
         CKbreLvb8UZ/xIxFVApW2JzPbIdsH8w+FBDlYlXY2bFp8gIWJqeRjRXK5qbdEhiHzmkv
         OXQw==
X-Gm-Message-State: AJIora+CbCEERJTvPoA293KCf1mHfU1xpFoSol4B5SkQoqKEvZoURvOP
        CeqMRXCfjJJU6dT16szlumU=
X-Google-Smtp-Source: AGRyM1sKZ8qe10IvNYuwp8n8X5khsRoeJArBQPMKGYXCMAcYA8O9hDOhSmBbmHESpELsotrIA+iAxA==
X-Received: by 2002:a05:620a:400b:b0:6b6:2010:3015 with SMTP id h11-20020a05620a400b00b006b620103015mr9173343qko.491.1659281303727;
        Sun, 31 Jul 2022 08:28:23 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:ac7a:fe76:f4fe:fa32])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a258f00b006a6ce613c7csm6766740qko.89.2022.07.31.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 08:28:23 -0700 (PDT)
Date:   Sun, 31 Jul 2022 08:28:24 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v5 0/5] cpumask: fix invalid uniprocessor assumptions
Message-ID: <YuafmMimidHkmUOy@yury-laptop>
References: <cover.1659077534.git.sander@svanheule.net>
 <YuV1J7Zt+NzkrWeV@yury-laptop>
 <a5b3bc76d48acb8fde00aa95c6a572d7922c050c.camel@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5b3bc76d48acb8fde00aa95c6a572d7922c050c.camel@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 03:02:55PM +0200, Sander Vanheule wrote:
> On Sat, 2022-07-30 at 11:15 -0700, Yury Norov wrote:
> > On Fri, Jul 29, 2022 at 09:01:17AM +0200, Sander Vanheule wrote:
> > > On uniprocessor builds, it is currently assumed that any cpumask will
> > > contain the single CPU: cpu0. This assumption is used to provide
> > > optimised implementations.
> > > 
> > > The current assumption also appears to be wrong, by ignoring the fact
> > > that users can provide empty cpumasks. This can result in bugs as
> > > explained in [1] - for_each_cpu() will run one iteration of the loop
> > > even when passed an empty cpumask.
> > > 
> > > This series introduces some basic tests, and updates the optimisations
> > > for uniprocessor builds.
> > > 
> > > The x86 patch was written after the kernel test robot [2] ran into a
> > > failed build. I have tried to list the files potentially affected by the
> > > changes to cpumask.h, in an attempt to find any other cases that fail on
> > > !SMP. I've gone through some of the files manually, and ran a few cross
> > > builds, but nothing else popped up. I (build) checked about half of the
> > > potientally affected files, but I do not have the resources to do them
> > > all. I hope we can fix other issues if/when they pop up later.
> > > 
> > > [1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule.net/
> > > [2] https://lore.kernel.org/all/202206060858.wA0FOzRy-lkp@intel.com/
> >  
> > Hi Sander,
> > 
> > I tried to apply it on top of bitmap-for next, and there are many conflicts
> > with already pulled patches. There's nothing really scary, just functions
> > changed their prototypes and locations. Can you try your series on top of
> > bitmap-for-next from git@github.com:/norov/linux.git (or just -next)? 
> > 
> > I'm asking you to do it instead of doing myself because I don't want to
> > screwup your code accidentally and because many cpumask functions in -next
> > are moved to the header, and it would be probably possible to avoid building 
> > cpumask.o in UP case.
> > 
> > Briefly looking into the -next code, cpumask.c hosts  only cpumask_next_wrap()
> > that is not overwritten by UP code, and in UP case it can be simplified.
> 
> Sure. I've rebased my patches and added a UP-version for cpumask_next_wrap(), so
> cpumask.o doesn't have to be built anymore in that case.

Thanks!
 
> How would you like to proceed with these patches? It's fine by me if you take
> them through your tree to avoid more merge conflicts with your changes, but then
> Andrew woud have to drop the series from mm-nonmm-stable.

I also thing that it should go through bitmap thee. Andrew, are you OK with
that?
