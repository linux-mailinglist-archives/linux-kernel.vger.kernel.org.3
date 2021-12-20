Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0333F47A53E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhLTHAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbhLTHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:00:17 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2C8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 23:00:16 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t19so14472868oij.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 23:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOWHMfUqWgS66PgQYYet33MLKueM0ddFZqC4iawf0eo=;
        b=EhTOwMFaKZI9Jc0S3FLUHeHgNZW+azpNir8KH/VrP5S/q0y/3AOZjr1zWLXrpNYBX2
         Mzp+4L8bKsAjfPRlbONenEwbuhMhHOM6FO8qSMITDd+droYp+xnPV3k+06tJ976mZiJR
         oF+qh6lCPn/+aDX3OxXe3P3blZXRd6QjiBE/l9NmSCQU/xcTi4ANTEMHJIedw3AEPOmY
         YW7AfOEfldV2VkNhHXLclHAcJSzDb2LjogbFmEaRRz6BDFFtZP45zDURm/VRdiSuiHVR
         3JrA/20ul6M6/yzgTLEtCMAT2ayYyphFIvO8s4H1G0DVT51A1nNF5mUkxhJ/mzK+KnNO
         cVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOWHMfUqWgS66PgQYYet33MLKueM0ddFZqC4iawf0eo=;
        b=hP6RqlEM29X4RUSgCiNpKHLYJ334dP5uUUeckmBE0qVmDP/oVhVxQ+anoMVdMeAwZp
         Q+iJu0aYYAdiNPcEdcrXjZt78LT+Ascm+tA3PZHXHU8pifk2fVl6/+OVbuMH44pk55tm
         c9jn1/l96CHYjVr4GJqtuy64udue5ntzpoE5NXKqoYISCBVtRbT33hNfCxMPnfsmtQLx
         Cxw1/UCr7qwmQCWCDXtta/1jEYbtKH9mL4HFbTZHlDbS4d33EwpuGx6FJI/hYnSOhajb
         l03LOFmHKY9OMMLX2cEPaBDWFWhjGNsLrKqKqBPJScnuAJ0344BxsH0n/FIzZteSAAiF
         xmHA==
X-Gm-Message-State: AOAM5305yAnIq58QNKoD7kWGNI3+tLbNgJ2W6FGI+eFppiSGM5Tt2FuR
        3+ON0XJesp2bQ/gxndxozKw+qUDwOQuzByPWERfu2w==
X-Google-Smtp-Source: ABdhPJx5Mh/dkzyGPzJF57IaS36QpKLdrS0B5NBIdJYTPkT2PN892GsWzomJqWkjhL/oqgJcA03tECRpPMH/GB+4WEk=
X-Received: by 2002:aca:af50:: with SMTP id y77mr11164327oie.134.1639983616081;
 Sun, 19 Dec 2021 23:00:16 -0800 (PST)
MIME-Version: 1.0
References: <YbHTKUjEejZCLyhX@elver.google.com> <20211209201616.GU614@gate.crashing.org>
 <CANpmjNN4OAA_DM_KNLGJah3fk-PaZktGjziiu8ztf6fevZy5ug@mail.gmail.com>
In-Reply-To: <CANpmjNN4OAA_DM_KNLGJah3fk-PaZktGjziiu8ztf6fevZy5ug@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Dec 2021 08:00:00 +0100
Message-ID: <CANpmjNM3eSd9sxi-1tV0cRthJ0hudrME8nYdhYP=ttcWDoPNfg@mail.gmail.com>
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

On Thu, 9 Dec 2021 at 21:33, Marco Elver <elver@google.com> wrote:
> On Thu, 9 Dec 2021 at 21:19, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
> > > Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> > > default since dcb7c0b9461c2, which is why this came on my radar. And
> > > Clang also performs auto-init of allocas when auto-init is on
> > > (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> > > aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> > > allocas.
> >
> > The space allocated by alloca is not an automatic variable, so of course
> > it is not affected by this compiler flag.  And it should not, this flag
> > is explicitly for *small fixed-size* stack variables (initialising
> > others can be much too expensive).
> >
> > >       C. Introduce a new __builtin_alloca_uninitialized().
> >
> > That is completely backwards.  That is the normal behaviour of alloca
> > already.  Also you can get __builtin_alloca inserted by the compiler
> > (for a variable length array for example), and you typically do not want
> > those initialised either, for the same reasons.
>
> You're right, if we're strict about it, initializing allocas is
> technically out-of-scope of that feature.
>
> So, option D: Add a param to control this, and probably it shouldn't
> do it by default. Let's see how far that gets then.

Just an update: after some discussion, the Clang side says that
alloca() is in scope, because the intent is that trivially initialized
"automatic stack storage" should be handled by ftrivial-auto-var-init.
And alloca() is automatic stack storage:
https://www.gnu.org/software/libc/manual/html_node/Variable-Size-Automatic.html

So currently it looks like the builtin is the only solution in this case.

Thanks.
