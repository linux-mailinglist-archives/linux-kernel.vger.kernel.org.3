Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510325AB7FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIBSJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIBSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:09:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9174FE355
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:03:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b142so2247082iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DsSYyvFRX7OXTQcg53ZJE+LnyNTxlorHM7slCEXW1is=;
        b=s49s0x8Ap3YZB8Nrgbh1MSaxaMzcT1YE9yzG4odKqHlffOpfQVqq/hUsP1TUKeRGJu
         QRVO7pNCfKVJo7u0MvpvsqS9M9gsQH53ZIyBJT7Afz7N92Tr6RFIIeLVoKLWGB1Vvbmv
         /v6VMZrnnX0C5PbrAYGI+ME5XeEoy8hdNqfZjMc6kN9SwutOVQdQaOefZalIqjwGWgb/
         tb9eEhxr8IDSLO7C5T9xgeAR59Ilnzo1PAbjQLdy2bLHiyeMQ85AuCV7Pu4kiCF92+eV
         1FcyjOi7DtqyQozwRRjXiWNRSOrN057Fj1lzJobm015Kc/y47DMkuwoqOLBzADB2PQsb
         1obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DsSYyvFRX7OXTQcg53ZJE+LnyNTxlorHM7slCEXW1is=;
        b=wP5+V/I75afLYdmnHHHlyAcble4WYr42xogg004FCSEix32QXGcLneQnVs7hm9sH6T
         0dz7izS2KiQYOmJXvJENogaIrV/aWjy3vbeRPyq/9IzGW9ogtvv9BD0t9Hc8AgNMAjJT
         DnGS81/xlu7E7IrWcZYIZeIcPURZSvYRrWTXVCzGjdw4U+djqsG8NfKTIYM9ooVYblgv
         L1DPAm8PqoswcfQsDUsmCBQk/84zayk/EXhfG8mSbGoEPlG/1lAuuIOhoR51ETv5hcfH
         fFib4gKawigXlZCh2dJFPBRV6BjknTaPNY6g7nzEzYzcN8GL86oNZf/gBRXWSyoMRdCv
         RWIQ==
X-Gm-Message-State: ACgBeo2mePQqGFTgsgBC8CU2fuL7PFW3jibREhAvaRlBwZLy0jmImvOX
        P1b+esAQ1pIZrg9vXvvH40fRr8APxwFB24Yjw9/hmA==
X-Google-Smtp-Source: AA6agR7KFZlUy2pvfIV3UweeLdnL2W9zoROxivfRRaX8xm4LeDOW1Axpu3vJAjTM1oWttoJXdRXvxik2dVQ/xnaxZAM=
X-Received: by 2002:a05:6638:2042:b0:346:e51a:da4e with SMTP id
 t2-20020a056638204200b00346e51ada4emr20421153jaj.164.1662141803111; Fri, 02
 Sep 2022 11:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130948.643735860@infradead.org>
In-Reply-To: <20220902130948.643735860@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Sep 2022 20:02:46 +0200
Message-ID: <CAG48ez07c2ThydovaHtBZ+u137eaXdEut4J-zycvPn7io4MySw@mail.gmail.com>
Subject: Re: [PATCH v2 22/59] x86: Put hot per CPU variables into a struct
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 3:54 PM Peter Zijlstra <peterz@infradead.org> wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The layout of per-cpu variables is at the mercy of the compiler. This
> can lead to random performance fluctuations from build to build.
>
> Create a structure to hold some of the hottest per-cpu variables,
> starting with current_task.
[...]
> -DECLARE_PER_CPU(struct task_struct *, current_task);
> +struct pcpu_hot {
> +       union {
> +               struct {
> +                       struct task_struct      *current_task;
> +               };
> +               u8      pad[64];
> +       };
> +};

fixed_percpu_data::stack_canary is probably also a fairly hot per-cpu
variable on distro kernels with CONFIG_STACKPROTECTOR_STRONG (which
e.g. Debian enables), so perhaps it'd make sense to reuse
fixed_percpu_data as the struct for hot percpu variables? But I don't
have any numbers to actually back up that idea.
