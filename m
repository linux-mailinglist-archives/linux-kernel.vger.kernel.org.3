Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B2589449
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiHCWJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiHCWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:09:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E96A26AD1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:09:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gk3so21617911ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FsfXSqaJQraxiba0yKE7C4urEnasCW26TAfDOCyD+rA=;
        b=D7xk4B/0uc5gGnqzfFElxKP+Iqc42KSnPce+upGB7rCrR4jPtMdmFjUR2TyN7QB4OP
         b+/beAlyubgUFEawoiWGHAmM/UFwEl0BIVLs9Gvi9qpIgY2phnW1G1SfFywK9rfRft+F
         nx8uD+1PQTNufdAH1gYGsaqjTN1kcFCXwg2Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FsfXSqaJQraxiba0yKE7C4urEnasCW26TAfDOCyD+rA=;
        b=Sykcj0KI7NWkrd/o9bhdTh6QU4b5zGfNl7mR7PZCiSYkAaCE7Ikc9e9t8JzdP4dhuK
         2FE7KqkU2eJ4FzQnsQOpdHYg4xr+IMTz1MATqtsr6z2yc5yCiD0GuH2ph2OVdhCsR9V0
         g77c/Z9m096fe5qfXsL6hiYJKH2fMkrzM11eo0aot9YbHz+V2uiI6Fe/d8hNTfVpwFW5
         doXZu5Csj9LjFff20EBkpmMtMCFcfoNKOricG8s+fejndLX/VnJbHxsn8VliDWGamTdV
         XRLOctdpwOmydLqWJKndoSMFeG046BJUqxjjrUeKdIMxf2/yne7F8x4fN9XEztj+dMqX
         Ixmg==
X-Gm-Message-State: AJIora9d9ldeNUPwC5XPIK4gkpu71yZjJdeCGB0b5DP+ymXLDdohbjp/
        s2Y1sDb16h1uWGdGytQ+hGGu/dnUDKA5Ux5e
X-Google-Smtp-Source: AGRyM1tgpxdc2wgc4jGr0jrmxBdrcohIzaMLGRiSPbyj0TZk/VapJIrXvcINgDZMty/kEStDa5C9rA==
X-Received: by 2002:a17:906:6a26:b0:72e:cee5:d1b0 with SMTP id qw38-20020a1709066a2600b0072ecee5d1b0mr22088528ejc.404.1659564580876;
        Wed, 03 Aug 2022 15:09:40 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id ec15-20020a0564020d4f00b0043c83ac66e3sm9955335edb.92.2022.08.03.15.09.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 15:09:40 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id l4so23079434wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 15:09:40 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr17429839wro.274.1659564579607; Wed, 03
 Aug 2022 15:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV> <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
In-Reply-To: <YuruqoGHJONpdZcK@home.goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 15:09:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
Message-ID: <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 2:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The original patch years ago use to have:
>
>  preempt_disable_rt()
>
>  preempt_enable_rt()

That may be visually simpler, but I dislike how it's named for some
implementation detail, rather than for the semantic meaning.

Admittedly I think "preempt_enable_under_spinlock()" may be a bit
*too* cumbersome as a name. It does explain what is going on - and
both the implementation and the use end up being fairly clear (and the
non-RT case could have some debug version that actually tests that
preemption has already been disabled).

But it is also a ridiculously long name, no question about that.

I still feel is less cumbersome than having that
"IS_ENABLED(CONFIG_PREEMPT_RT)" test that also then pretty much
requires a comment to explain what is going on.

            Linus
