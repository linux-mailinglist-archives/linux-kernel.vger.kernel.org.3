Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8685AB7FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIBSJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIBSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:09:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3C1037E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:09:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id nc14so5431548ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JyntNzc9hzuaj3nr0osrxHTy6k2DuFd1979TPD9JLwg=;
        b=EVMKlGRoqiBowwUsR9klBSlEZmEf3zkPBbmydY3GxU04Pu2Ha912oAzUDBIwtGfKCk
         U7fppUa0DMBas23VtkV/KbNCX+cjHmzpAXb30xBC0MiMF/kx5S9MIjgDqSNnU2z5jcOz
         RJytNCQ5Xb3iBta1IgGsesmANWTFy3p6ZY0ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JyntNzc9hzuaj3nr0osrxHTy6k2DuFd1979TPD9JLwg=;
        b=AxrVQoteZTawT2JrLiOqrdbOkmm15iU6xZ++eaJdS5oUu0de/4ngvfdTvXTIKIuTUC
         JJekQzdzDY9wIqpc8IUYDWMImLNZkJ2rUPF552pLOx2SOABrre8dAMIve5A9Icav5MRu
         Nx/RJmuWly/BBupx4t/GooJcluv0I0PZSugRvgWFcCU/lkyU59/pyx9k3gSpdWUy+gr9
         UQi02YBZMcQhhDh8odSSKdoFMgberVUfz15n7rups5O+VaqiFoMT7rC2I4758RVvQORD
         v/ETaB2e9DsUe+4ubRrLtw5AXldwSHuiA+Ee+rr30W4NCvCpdgPk3iKQjUt6AExXh5Gh
         eUGg==
X-Gm-Message-State: ACgBeo2QVmAj+sJhZV4+wzLOFod4HUlnxlU/BrGoVVn0cRm3YUe0mh6t
        GTrAm93aIHelTiNTdItN9HwGuEsK+uw3jTP7fvg=
X-Google-Smtp-Source: AA6agR4sZ0EHn4VwLT/dnrsncfM2zqveg9J8TpTg/ESNv4PHWssvJY//SkGogkpc0uOfxy2KtmVUfA==
X-Received: by 2002:a17:907:3e81:b0:726:9615:d14d with SMTP id hs1-20020a1709073e8100b007269615d14dmr27368960ejc.517.1662142152895;
        Fri, 02 Sep 2022 11:09:12 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id d10-20020a1709061f4a00b0073dc5bb7c32sm1579801ejk.64.2022.09.02.11.09.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 11:09:11 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id k9so3332288wri.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:09:11 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr18487105wrv.97.1662142150888; Fri, 02
 Sep 2022 11:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130625.217071627@infradead.org> <20220902130947.190618587@infradead.org>
 <CAHk-=whdvPcHmH5eG+FUrbQw1e-05n__EWobMqbxcCTP7dtZAg@mail.gmail.com> <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net>
In-Reply-To: <YxI+K8Y+f/FHSQCU@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Sep 2022 11:08:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
Message-ID: <CAHk-=wjRLehUO=u8HDJGRFv+wz7hakSc=z6eTg547pAmb0UKHg@mail.gmail.com>
Subject: Re: [PATCH v2 08/59] x86/build: Ensure proper function alignment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 10:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> There is a DEBUG case that increases the thing to 32.

Well, but that should be part of the Kconfig rules too.

In fact, I think that argues for moving that FUNCTION_ALIGNMENT into
the generic Kconfig, since we already have that much hackier debug
thing there.

That would then get rid of the conditional in asm-generic too, and get
rid of the horrid hack in the main Makefile as well.

I love how commit cf536e185869 ("Makefile: extend 32B aligned debug
option to 64B aligned") took that previous random debug entry and just
made it 64B instead of 32B. What a crock that all is.

Let's just do this right.

             Linus


               Linus
