Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883BE4AFD74
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiBIT3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:29:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiBIT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:29:03 -0500
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F88C0DE7E2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:29:03 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u6so6195239lfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 11:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2TraJDARUY3WXKDZEaeZC1Cg5Xz36jm3AjN1xE8ZI8=;
        b=Lp4sdJ97My/Y9Ta1fSRoHp6J507Vuc5Vy0rZHOrZxjUYLfHz6HN64dlLooI0IRmUt1
         jAyAk3pVE2l4/fWK3EtwJVBVMJAGmHFDLeIwAUKahBjewVMoxxo3tDpM065oKtQklm1c
         KEeojNSCm5P8OroFRT+5X7T2xlhQAWE1HjHbaiNyFs1c82s0fhwK9FDAPN/JjCoChflM
         AAGMQIG3Je8HAi9baxNDms9qNmoPu1jvcocX3EngIqW6kelrX/NSa6HZ8wSI9/X5Wq5W
         jZDezRPK8uriRVvD+O7dj5puL62qSeKYYJW4ll+OkkAhTfPkeI3G2gLa8z+2FewyrpXE
         54sw==
X-Gm-Message-State: AOAM531J2MSucrVJXmX1odgYRPOyNxbPmgGeByMx+dySlFrqw1Lrj4DN
        3aPOLgf5CBmrqi9iuwq8vmTmet7qF/glAsyop3u/8Bt/
X-Google-Smtp-Source: ABdhPJy/1yAok0JIcHZXq+aM5wvLB/AKCt1/te+VjUfFoZY67uThIQmfgtX3WoAkaMzKrx7vOFGoIXmdouYQRP+F8yw=
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr1899843lfu.99.1644434941866;
 Wed, 09 Feb 2022 11:29:01 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-6-namhyung@kernel.org>
 <87y22lp4xx.fsf@intel.com> <CAM9d7ci0By5zioo+52+14RuFrTqZfzbupJuP-908HhYB2Ovc9A@mail.gmail.com>
 <87iltonoaa.fsf@intel.com> <20220209112703.1679e48b@gandalf.local.home>
In-Reply-To: <20220209112703.1679e48b@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Feb 2022 11:28:50 -0800
Message-ID: <CAM9d7cg56onNLfpUwMDDJaMpJiYpwgk=UT7jFF5rhH0U2dH-Pw@mail.gmail.com>
Subject: Re: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 9, 2022 at 8:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 09 Feb 2022 15:49:01 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> > > Because I want to use the lockdep annotation for other purposes.
> > > But the workqueue lockdep_map was defined under LOCKDEP
> > > only.  Please see the description in the cover letter.
> > >
> > > https://lore.kernel.org/all/20220208184208.79303-1-namhyung@kernel.org/
> >
> > So lockdep_init_map() might still be there and build just fine for
> > CONFIG_LOCKDEP=n, but now we're actually required to wrap all call sites
> > in #ifdefs depending on the purpose? I'm not convinced yet.

Because work_struct.lockdep_map is there only if CONFIG_LOCKDEP=y.

>
> I addressed this already. I suggested to add a "raw" variant that turns to
> a nop when LOCKDEP is not enabled. That is, for those locations that are
> only for working with LOCKDEP, the call will be:
>
>         lockdep_init_map_raw()
>
> This will differentiate the locations that are for just lockdep and those
> that are for both lockdep and tracing.

Yep, this should be fine if it's actually defined on CONFIG_LOCKDEP=y.

Thanks,
Namhyung
