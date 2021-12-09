Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8709846F4FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhLIUgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhLIUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:36:47 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5EEC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:33:13 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id m6so10379209oim.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkfMK5PB8QI1XOoT83uXuffhKjgO17IGbJlqxB7Wwjw=;
        b=GvTTIDuouZQMVVXAnpmcyU3Gx53MZYuELZzUGCQqpaCUDzPEn3riEDFzRpwKQdMFZb
         nfl/1sGVtEAdgILK3aYLue6HOJUbPwu+QAUSi+hTSRja7ul8GzpWv4NMi7dYhpJhB4/z
         iwOVw/IqHOAdoP7Uk53PQKv2whQaj31Ed+LI+mbLQ8D1nzjU9fwymLhZKdqObEwM7VnY
         9BWc8tmCfg0B/swTogcVoToAzGTAXyhoYVdtEoI6oJOSSS/qLjbsDIpDL/IVwUXqC7vV
         3QxrF2COmUd6jmV06TbzH87thULXjLQwXsSsibrYss2+xM2ydBzBieDrGjMVhMOLtvZF
         pIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkfMK5PB8QI1XOoT83uXuffhKjgO17IGbJlqxB7Wwjw=;
        b=mURtk2a8EgNV2c/OmGIc2og4i/kKPvnIMOgXd0EhPGWwvMw/u1OZhjGFjF3ySylqL6
         EpCALV/4nAGKOeS5NfJ+EiPrXwKThN96R8o23vGI7cVoflWsrHfgNeZy2YatKst/XYNQ
         JbS2On7ztk7iFCO5AcWj6xe9ddvGDndyN0YevBNri25+faWQi//e7TlZ8HVWagJqimVp
         tGUMyjkpKjPqbNX+qQY2cDSCtB0B6hJcYtTk8h4JHN/K+EarvFfNY2EldhX5VYbz5+M5
         lddnursfucph00liOZH58RqGZcm4LCethIo8qakgyBq+d0uk0vmZdDZoC0dEpgy5IhLb
         E+xg==
X-Gm-Message-State: AOAM530Nll3By50mowA6YPffAYW0wGfpBs2D6yQPm+74+fyrqa34ohjP
        446BZxmeYFctOXw4ZWU6sZrSH8HyIP0D+NTAFELW1Q==
X-Google-Smtp-Source: ABdhPJzORI+4/1cecMt2bxtxnQkSHfNLFChARuXfNE1C35htwXuJdGA5pt88aLuZATfaLyL88OsMelcreW+SKZQzifY=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr8384470oib.7.1639081992787;
 Thu, 09 Dec 2021 12:33:12 -0800 (PST)
MIME-Version: 1.0
References: <YbHTKUjEejZCLyhX@elver.google.com> <20211209201616.GU614@gate.crashing.org>
In-Reply-To: <20211209201616.GU614@gate.crashing.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Dec 2021 21:33:01 +0100
Message-ID: <CANpmjNN4OAA_DM_KNLGJah3fk-PaZktGjziiu8ztf6fevZy5ug@mail.gmail.com>
Subject: Re: randomize_kstack: To init or not to init?
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 at 21:19, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
> > Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> > default since dcb7c0b9461c2, which is why this came on my radar. And
> > Clang also performs auto-init of allocas when auto-init is on
> > (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> > aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> > allocas.
>
> The space allocated by alloca is not an automatic variable, so of course
> it is not affected by this compiler flag.  And it should not, this flag
> is explicitly for *small fixed-size* stack variables (initialising
> others can be much too expensive).
>
> >       C. Introduce a new __builtin_alloca_uninitialized().
>
> That is completely backwards.  That is the normal behaviour of alloca
> already.  Also you can get __builtin_alloca inserted by the compiler
> (for a variable length array for example), and you typically do not want
> those initialised either, for the same reasons.

You're right, if we're strict about it, initializing allocas is
technically out-of-scope of that feature.

So, option D: Add a param to control this, and probably it shouldn't
do it by default. Let's see how far that gets then.
