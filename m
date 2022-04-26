Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FFF510AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355024AbiDZUos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiDZUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:44:47 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2EA6E32
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:41:39 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id d2so11607049vsd.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJBy1hbZt68WEk6SIaZM+0UU7boTE8o9Xhoq4o3jH4Y=;
        b=QbjLcZhsGv3ygkk2GSkkObLN6QykS2ivoxR+4z3i/LEp+tG3DOQQOeWfscLmuGyzQP
         NdFQpxsfGhHvbZoFyjdoMeTC4LQe7hboGX7WVKB0PQS1bEHMJI/ZLDH97X8sNIdIv30i
         y1cdMlCKJ1Yf8GAiO0x9fQmy5Ov00A20wV956c18lTy4ZD3vvT8J2+EZtZt9PRUY3/fW
         ZN3i6XGa0tPTHQIldqDgJO3Skqonv9Ws4oGHQLvUODGoJX4210WxLWr17pqphzX4xL/i
         vdsTT3kWxGsN7Fs7+EWk+XyKIZItevWsbsOyuDS1AtOlCI2ICY6nxGof01SfTJrU4pPU
         3iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJBy1hbZt68WEk6SIaZM+0UU7boTE8o9Xhoq4o3jH4Y=;
        b=48WZo6pSd08VBnpIdnEuQg208vBsqR+zHJPvtDWvxZO8E/LqSB80eJE+MCTqgMwMTX
         4LZ/H1lQHdBtS0/BOegFJB2Cf45P49BuNkWPog27hkBNF5dQxaV5CgKQo4cQaEOkh6An
         KvhMkhzkmvfMFZOSo3cp5FiIUieLN5IMUCi/s6uOQ0FkX0KnInkgEiVxLgRgCwntqclK
         fB3o1QWLGxAEIKqXa7hkBKm3d742V6GWaRykzOXRhEAq0gKbHt5saw6Uh0tcSGx+qTwJ
         B6zpNB7eObHnX2cpSXM3NvZHO8rH8Nc1fu1c8CH9DTI7F/eFrQSvFo4Px610RwU4LxyD
         HUyQ==
X-Gm-Message-State: AOAM5315usUXb44cA9mU9lPUORvQTB0EiZRim7oEs1yLiHzl72aLtq7P
        2pfQ0ZsF5ubrlLOuddoUY64r3DEWfVH3rd3ZpyrVzUtCtOpa
X-Google-Smtp-Source: ABdhPJxZSyX4HNi4z4KG+5TQK9ohWRnHzLmb5Yv36YBL7fDsIHDVenXZtclDj8gqE9u/r0Uo9yGJVED3zA+nmlTL9rs=
X-Received: by 2002:a67:f749:0:b0:32c:dd5a:ace4 with SMTP id
 w9-20020a67f749000000b0032cdd5aace4mr2716361vso.25.1651005697085; Tue, 26 Apr
 2022 13:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk> <alpine.DEB.2.21.2204240148220.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204240148220.9383@angie.orcam.me.uk>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 26 Apr 2022 13:41:25 -0700
Message-ID: <CANDhNCpL1S0s0nLfWKsHF+59kaO1Aj5N3NbEYMgazHVaRwJX9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched_clock: Fix formatting of frequency reporting code
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 4:47 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> Use flat rather than nested indentation for chained else/if clauses as
> per coding-style.rst:
>
>         if (x == y) {
>                 ..
>         } else if (x > y) {
>                 ...
>         } else {
>                 ....
>         }
>
> This also improves readability.
>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 32fea568aec5b ("timers, sched/clock: Clean up the code a bit")

This patch seems fine to me. Though as Ingo was the one to introduce
the change, his style preference may override in this case.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
