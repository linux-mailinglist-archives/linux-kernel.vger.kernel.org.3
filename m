Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69645133BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbiD1Mfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiD1Mfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:35:41 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB70AF1DA;
        Thu, 28 Apr 2022 05:32:27 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id g28so8706235ybj.10;
        Thu, 28 Apr 2022 05:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amQgG2NV0agE1gFMqpWGUu4pyR1fiuJMmDfgJJelPdE=;
        b=bVLMzhutNwwkZ4FUraWEI0jCdXUq6nJyZmC7+gmCSp3jFeDD1mcENDl7+9Cvr3vW4e
         eUa+mSve1dk8rLa9Pi9rQmeQ3OQK0ngurdc13Nku02dyAeBACDkTofZkTTOpq4u+dMsI
         KIgUfx+3TQw6qujwp2phpKsWSGZx0bdTU1AZ4gA12DNFts2sfBlqzH1LGHpK9j1OSMrM
         mVN0jfGlbVgcgP3SLNmyfpWqtNyeZhvSO1Mu5FbQnqxunnbPVIYZAlcs9IpF6Sw+kM80
         6SfJW47I0h7Tati+GJJu5bb2zyAbrWDy2VwXKXUU2l186mDLrNwCIu09dXRAffVajA8d
         Xogg==
X-Gm-Message-State: AOAM533xTrbZjp6E+5BookqKSOeTDAR6ylZ+27Rc650HKX0akqDO1pGh
        mAzmxcc49BRyMC9nA/3w1V7HW8hpf8C5WsOxrAOIodwi
X-Google-Smtp-Source: ABdhPJwB/+EX5t6EBt1I6NzQqBAxtEOgLKJBxNB7rsFDwFQlTIAs+vmPs2QnCqLkeGnc6TfFZ56SC22ETSFI9jCLGt4=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr29265812ybh.81.1651149146464; Thu, 28
 Apr 2022 05:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220428110030.7090a45b@canb.auug.org.au> <78577b67126a3f63424059f414702a799d6baf3e.camel@intel.com>
In-Reply-To: <78577b67126a3f63424059f414702a799d6baf3e.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Apr 2022 14:32:14 +0200
Message-ID: <CAJZ5v0gAnt3=NK9BgtWYawgyc2CaQ5xbx_fMznbuUJuqX1mn9A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pm tree
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:56 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Resend with linux-pm mailing list CCed.
>
> On Thu, 2022-04-28 at 11:00 +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the pm tree, today's linux-next build (x86_64
> > allmodconfig)
> > failed like this:
> >
> > drivers/idle/intel_idle.c: In function 'adl_idle_state_table_update':
> > drivers/idle/intel_idle.c:1701:17: error: 'disable_promotion_to_c1e'
> > undeclared (first use in this function)
> >  1701 |                 disable_promotion_to_c1e = true;
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/idle/intel_idle.c:1701:17: note: each undeclared identifier
> > is reported only once for each function it appears in
> > drivers/idle/intel_idle.c:1706:9: error: implicit declaration of
> > function 'c1e_promotion_enable' [-Werror=implicit-function-
> > declaration]
> >  1706 |         c1e_promotion_enable();
> >       |         ^~~~~~~~~~~~~~~~~~~~
> > drivers/idle/intel_idle.c: At top level:
> > drivers/idle/intel_idle.c:1854:13: error: conflicting types for
> > 'c1e_promotion_enable'; have 'void(void)' [-Werror]
> >  1854 | static void c1e_promotion_enable(void)
> >       |             ^~~~~~~~~~~~~~~~~~~~
> > drivers/idle/intel_idle.c:1854:13: error: static declaration of
> > 'c1e_promotion_enable' follows non-static declaration
> > drivers/idle/intel_idle.c:1706:9: note: previous implicit declaration
> > of 'c1e_promotion_enable' with type 'void(void)'
> >  1706 |         c1e_promotion_enable();
> >       |         ^~~~~~~~~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   39c184a6a9a7 ("intel_idle: Fix the 'preferred_cstates' module
> > parameter")
> >
> > interacting with commit
> >
> >   cc6e234b8264 ("intel_idle: Add AlderLake support")
> >
> > Presumably this should have been fixed up in commit
> >
> >   55ecda6f25ef ("Merge branch 'intel-idle' into linux-next")
> >
> > I have used the pm tree from next-20220427 for today.
> >
> TBH, I'm not quite sure about the Fixes tag below.
>
> Although commit 39c184a6a9a7 is merged later and breaks commit
> cc6e234b8264, but given that commit 39c184a6a9a7 is for -rc material
> and commit cc6e234b8264 and this patch are for next merge window, so I
> still use the orginal ADL intel_idle commit for Fixes tag.

Thanks for the fix.

I think I'll redo the ADL support commit with the below folded in.

> From 9b784d7f9ea5593a92eb6d616523b5f47464e981 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 28 Apr 2022 09:37:10 +0800
> Subject: [PATCH] intel_idle: fix C1E handling for AlderLake
>
> commit cc6e234b8264 ("intel_idle: Add AlderLake support") disables the C1E
> promotion using the 'disable_promotion_to_c1e' variable, but enables the
> the C1E promotion by invoking c1e_promotion_enable() directly.
>
> Then, commit 39c184a6a9a7 ("intel_idle: Fix the 'preferred_cstates' module
> parameter") removes the 'disable_promotion_to_c1e' variable and introduces
> a new tri-state 'c1e_promotion' variable that can be used for both
> enabling and disabling C1E promotion, on a per CPU basis.
>
> Switch to use the new 'c1e_promotion' variable to fix the build failure,
> and also to do C1E promotion bit update on all CPUs.
>
> Fixes: commit cc6e234b8264 ("intel_idle: Add AlderLake support")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/idle/intel_idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 7c081ed26b64..2de6e0a2d9a1 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1698,12 +1698,12 @@ static void __init adl_idle_state_table_update(void)
>                 cpuidle_state_table[1].flags |= CPUIDLE_FLAG_UNUSABLE;
>
>                 /* Disable C1E by clearing the "C1E promotion" bit. */
> -               disable_promotion_to_c1e = true;
> +               c1e_promotion = C1E_PROMOTION_DISABLE;
>                 return;
>         }
>  end:
>         /* Make sure C1E is enabled by default */
> -       c1e_promotion_enable();
> +       c1e_promotion = C1E_PROMOTION_ENABLE;
>  }
>
>  /**
> --
> 2.17.1
>
>
