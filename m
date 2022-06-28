Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC755EF81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiF1UYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiF1UWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:22:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F3420180
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:20:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31772f8495fso128804437b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g64p9P5l4RjiVPNQvTNHhvlhE0ueWTzWMizHVjEi9o8=;
        b=If5kmTn0bvdypLHA6ECF3zWEbgF/CSXXmPswReas42KJSRaXB/EuQSgYHpbwmLJ89d
         X+QhmnhrPSbkfvfHGLvSRQQ15nE2dVcqIF0chkzSy6D9JRLX6CNWkaaX7KEmSzK2yHsD
         G71m0ZLx4KQVjhgxN8iTOR1Eq6Wsm07zWt2HziLfTFoErtVU5y6ALXeQRPozcVmC0pVm
         YuwuBEDVZOQ30nLEMgTdBdpCzbamw0djQKn27WoyNEWTRHdGtBdYQa+QiVkJ0y6V8X3B
         rYnOo3wKb1tDi+P4PgoZ7ECg+5byUC57pBRYqB0i08SQ9PmPAfHrPwpt67qoB7gMupmS
         Ki0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g64p9P5l4RjiVPNQvTNHhvlhE0ueWTzWMizHVjEi9o8=;
        b=Z5JUreigVfYPYZ9ahfKBZJ9/FjALoED4DZqOCNDtCIvbeW+kc7RhE5/WpynmfWUpC9
         ItvZjupz8mEk6/aE5HQIygDwF9fLwTHn8ouG087W4rRyVg65zETbD2BBiYHRDONXuUEm
         Q8nlccmhkKXnQ/+nhS3lISIGBcm+scP9bKk9Heqcquy87xxMPvm85cZt26c4qC/27dYJ
         9iE3u0HO3BYm0pl/SUKQWwgegc3stEbdvL4/IIncEfINK1nw9g5QBXdHlyVxvks146ef
         cEI1xzitKN25SLTr3RDWDyHt5vsA/cKbBCSLwKUWEug9PEpa+xSAxknM4waMeUphr+Be
         oMDA==
X-Gm-Message-State: AJIora8qK6NgzjW8vcBg1ZnrnGFzcO0E+fHIJhJSZnAXCXj9aNsHS+oG
        p2ZFwZiW7Va1CwECvkura7133eqpjS65R2lvdeElpw==
X-Google-Smtp-Source: AGRyM1u/io1Pqriv9LROXyMpAcWMfzeV+H+sxx0JZd70i0nBfnq/F66yqtdKNrQ5ykhlq5ORCprWuwKoJkbo2HxdhjE=
X-Received: by 2002:a0d:cc54:0:b0:317:752c:bcf3 with SMTP id
 o81-20020a0dcc54000000b00317752cbcf3mr23794929ywd.437.1656447615120; Tue, 28
 Jun 2022 13:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com> <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com> <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com> <086370dd-281f-5ac6-3a0f-f1b80500c668@intel.com>
In-Reply-To: <086370dd-281f-5ac6-3a0f-f1b80500c668@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 22:20:02 +0200
Message-ID: <CACRpkdYTNuszctk=stB+RLr5kKwhR2ebF2MJCYQwMwYYPPReLg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and x86
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Paolo Valente <paolo.valente@unimore.it>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Jun 28, 2022 at 5:47 PM Dave Hansen <dave.hansen@intel.com> wrote:

> On 6/27/22 02:36, Linus Walleij wrote:

> > The right way to solve this is to make the Linux kernel contain the
> > necessary heuristics to identify which tasks and thus cores need this
> > to improve efficiency and then apply it automatically.
>
> I agree in theory.  But, I also want a pony in theory.
>
> Any suggestions for how to do this in the real world?

Well if the knobs are exposed to userspace, how do people using
these knobs know when to turn them? A profiler? perf? All that
data is available to the kernel too.

The memory access pattern statistics from mm/damon
was what I suggested as a starting point.

We have pretty elaborate heuristics in the kernel to identify the
behaviour of processes, one example is the BFQ block scheduler
which determines I/O priority weights of processed based on
how interactive they are.

If we can determine things like that I am pretty sure we can determine how
computing intense a task is for example, by using memory access
statistics and scheduler information: if the process is constantly
READY to run over a few context switches and PC also stays in a
certain rage of memory like two adjacent pages then it is probably
running a hard kernel, if that is what we need to know here. It
doesn't seem too far-fetched?

We have the performance counters as well. That should be possible to
utilize to get even more precise heuristics? Maybe that is what userspace
is using to determine this already.

I'm not saying there has to be a simple solution, but maybe there
is something like a really complicated solution? We have academic
researchers that like to look at things like this.

> Otherwise, I'm inclined to say that this series incrementally makes
> things better in the real world by at least moving folks away from wrmsr(1).

I don't know if yet another ABI that needs to be maintained helps
the situation much, it's just a contract that we will have to
maintain for no gain. However if userspace is messing with that
register behind our back and we know better, we
can just overwrite it with the policy we determine is better in the
kernel.

Yours,
Linus Walleij
