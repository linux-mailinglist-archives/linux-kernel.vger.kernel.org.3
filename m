Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6128501C34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbiDNTyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbiDNTyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:54:06 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1862DA0AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:51:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id t4so3745190ilo.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+P+wsImsSqgDG2hoQ67vliU1rYUIP0GkvJhsdqYnn8=;
        b=Nkc9/u3KfmipvAsXBmHbJh57O0BT01HkCmXuqNm1U15HVrx/Z/rKAaIdelG5+Co03N
         5Xir5jQ+WN+/DdjMw8qEMHfSopdpz7mU9fOyTfg4KXevMno9m+urWSiI5V7WdRnQYCS6
         28LUE0mjH+DdzbFcLSPXwgsbIQ97red8g669w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+P+wsImsSqgDG2hoQ67vliU1rYUIP0GkvJhsdqYnn8=;
        b=ANlw9zgkV38hmQBG34CUj2xiiWK9g556Y5HgqRpp/M4Ht+TKAbfBecyWkpsfufyGCy
         Eu4QvoftqjblA/GoCYUSW6QZ7lEaJOMDaCsBCoGSS1NVZCCsbFZpR3E/KvSVTXlHWKJJ
         JNk4Hk3yRooeneUbuvGtsxRxV2gLHS3UX6Lo2tpQrrj3i1cOJTXMufmCTc6KOSn/Yism
         VPa+Mex/R4WNlaQy1TWDFPFDiGsWymHNikDgxPd6IDE0zQvzTTP1vMLfVTtUos3z+8LN
         BaNbq5P6WouJFd/opfF+67kbVRPv0oL4SPCh/F0szGjcPHXU6fHripG9y6oAzt8j9IhT
         +PiA==
X-Gm-Message-State: AOAM530W3dv4aZaS5bdpGGmsVhRRQpSc5BIp37g2tztEPluJ7zGPBBrW
        FrHdonfAz5HdXoAP/mlcLkC//hZOR9cBefk5yU0v2Q==
X-Google-Smtp-Source: ABdhPJz373v4S3G0sBN6NXoXEnnp889Ina7ELaooSCA7X6ZDRiDzcC0cAu+nbjWSF/jio16ppQ4b4vXXYiOKfgeNCkQ=
X-Received: by 2002:a05:6e02:1cad:b0:2ca:1e5e:80ab with SMTP id
 x13-20020a056e021cad00b002ca1e5e80abmr1556065ill.274.1649965900318; Thu, 14
 Apr 2022 12:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1> <Ylhz1LOIf+JyjH7n@google.com>
 <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
In-Reply-To: <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 14 Apr 2022 15:51:29 -0400
Message-ID: <CAEXW_YQPEoM0vhpjNHtPd6GRkosfzK95yGt4eB=-C2mC32LjmQ@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Apr 14, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 07:19:48PM +0000, Joel Fernandes wrote:
> > > On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
> > > [..]
> > > > > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > > > > >         and offloaded at runtime.  This is the same behavior that
> > > > > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > > > > >         rcu_nocbs=0-N.
> > > > >
> > > > > Yes, this is the behavior I intend. So then there would not be a need
> > > > > to pass a mask (and I suspect for a large number of users, it
> > > > > simplifies boot params).
> > > >
> > > > Very good, and from what I can see, this should work for everyone.
> > >
> > > Just to clarify, what I am going to do is, if this new option =y, then
> > > rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
> > > Let me know if we are not on the same page about it though. I do feel that is
> > > a sensible choice given =y. If we are on same page, please ignore my comment.
> >
> > I was assuming that the rcu_nocbs=??? for non-empty "???" would override
> > the CONFIG_RCU_NOCB_CPU_ALL=y.  If you choose not to do that, shouldn't
> > you at least issue some sort of diagnostic?  After all, the sysadmin
> > gave a kernel-boot parameter asking the code to do something and the
> > code is choosing not to do that something.
> >
> > Of course, such a sysadmin might want the CONFIG_RCU_NOCB_CPU_ALL=y
> > Kconfig option to affect only the default, that is, when no rcu_nocbs
> > kernel boot parameter is specified.  This would change the second "[4]"
> > in my original table to "[2]".
> >
> > Thoughts?
>
> I thought about that. I feel that since we are defaulting the new
> config option to =n , it is a conscious choice by the distro to set it
> to =y.  In such a case, they should be Ok with offloading all CPUs. If
> they decide to selectively offload some CPUs in the future, then they
> could revisit the config option at that time.
>
> I feel the kernel config should override the boot parameter behavior.
> It is the same effect as a sysadmin passing kernel parameter X
> assuming the kernel does something but the CONFIG option might not
> even build code corresponding to X.
>
> I feel to address your concern, we can document in kernel command line
> documentation that rcu_nocbs= does not have an effect if
> CONFIG_RCU_NOCB_CPU_ALL=y, would that work for you?

Along with documentation, I like your idea of printing a diagnostic in
such a situation. I will certainly do that.

Thanks,

 - Joel

>
> Thanks,
>
> - Joel
>
> >
> > > > > > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > > > > > however, I am suffering a senior moment on the right person for Android.
> > > > >
> > > > > I think for Android, Kalesh Singh is in the kernel team and Tim Murray
> > > > > is the performance lead. They could appropriately represent their RCU
> > > > > needs.
> > > >
> > > > Sounds good!  Please collect a Reviewed-by from one or both of them.
> > >
> > > Ok.
> >
> >                                                         Thanx, Paul
