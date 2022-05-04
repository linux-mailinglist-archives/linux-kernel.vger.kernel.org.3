Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5851ACAE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355245AbiEDS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353866AbiEDS1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:27:38 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA6AFAF1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:53:54 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e9027efe6aso1925781fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m1/VxZhDQIDVJV9LQRE+rFB6N3QsuG7coPFVQ3e0ALY=;
        b=QHQvO5no9I7c6RBxmfD9Q9o4MEkwRV5xTn4HxEDgMT9zqCaJnhBPQS1APHVrZ6FALh
         9fqFHSsqMJBSybivp7kp5ktdSRmARgdGsq/Oq68OmOpVgQuYZNpwtmI6CgoaEZkhRsjK
         fXNvg/na7Kq7JHX18k+wUC5F4qqusSR2aZ5CX/Q66JT4JDQRFPj4FDYMC9QupOzotFUz
         uZ0ipmyvb0/WinwODLl8d9LxvtkIqCLIo8qcmamWN2PjgwDP0r+i1Z5EzvZo08Ji1UzP
         atm+PgMq52G0FUfLq/djw8JO6eS8JYfSp446t01B6BIDwHzX+d/B6P09522aNRcGb7M7
         f3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m1/VxZhDQIDVJV9LQRE+rFB6N3QsuG7coPFVQ3e0ALY=;
        b=ltkuuz7+PRi8KFQpvyPFyX5q2JPUVhNgNspMjZro2D2auXWnfNGLNoJPOygKMN+Yyp
         MneiNQctZXMwqJhcJ9bWtCO+W5zmr1gxvQMOjU74Iex3BgnjK4zb97c7lVfvIiWU35fg
         +4ugQ+W8EKWmvysKByJH1Q06nfEX1zkBN7snoaAJ3sfgqTZnroz7QL0iJmYBhdehEy72
         wERl53bNJl+VM18dFSLlsbIhLwX/OMuTWl8o8mmSAQoMcTMQGVfI+opRq5sE4a6yoj/k
         CRZuTslBhEv7tuj9IrbLDYZJsB7EiTNQMvwHJM34pZS31mpMlUMTnRJ2FuyD7EDMFToc
         Nkeg==
X-Gm-Message-State: AOAM530SC7nSuE658Srv9CZHpptU3nFTt2WjmmmaduNY1dixKUERc15I
        s4fRCmw54k2A3oYoVs0vIHEDb2eNNwrXsPQDnOg=
X-Google-Smtp-Source: ABdhPJwSVkrbn5wEDKnvmkUQqolBhLLvUBq8PTdpjkOhDOvUPuUBbVH8lsFDhmJ+uooCz1L5seydRMIzGVbvElNGgn0=
X-Received: by 2002:a05:6870:f146:b0:db:c90:99bb with SMTP id
 l6-20020a056870f14600b000db0c9099bbmr319149oac.55.1651686834074; Wed, 04 May
 2022 10:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220502184050.1792743-1-jcmvbkbc@gmail.com> <165163539094.74407.3838114721073251225.stgit@devnote2>
In-Reply-To: <165163539094.74407.3838114721073251225.stgit@devnote2>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 4 May 2022 10:53:42 -0700
Message-ID: <CAMo8BfJF_HTZc-PUrK4y5yLEdwWPmpKu2NyzJusjGd1Ste0b3g@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Fix build errors with CONFIG_KRETPROBES=n
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 8:36 PM Masami Hiramatsu <mhiramat@kernel.org> wrote=
:
>
> Max Filippov reported:
>
> When building kernel with CONFIG_KRETPROBES=3Dn kernel/kprobes.c
> compilation fails with the following messages:
>
>   kernel/kprobes.c: In function =E2=80=98recycle_rp_inst=E2=80=99:
>   kernel/kprobes.c:1273:32: error: implicit declaration of function
>                                    =E2=80=98get_kretprobe=E2=80=99
>
>   kernel/kprobes.c: In function =E2=80=98kprobe_flush_task=E2=80=99:
>   kernel/kprobes.c:1299:35: error: =E2=80=98struct task_struct=E2=80=99 h=
as no member
>                                    named =E2=80=98kretprobe_instances=E2=
=80=99
>
> This came from the commit d741bf41d7c7 ("kprobes: Remove
> kretprobe hash") which introduced get_kretprobe() and
> kretprobe_instances member in task_struct when CONFIG_KRETPROBES=3Dy,
> but did not make recycle_rp_inst() and kprobe_flush_task()
> depending on CONFIG_KRETPORBES.
>
> Since those functions are only used for kretprobe, move those
> functions into #ifdef CONFIG_KRETPROBE area.
>
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/kprobes.h |    2 -
>  kernel/kprobes.c        |  144 +++++++++++++++++++++++------------------=
------
>  2 files changed, 72 insertions(+), 74 deletions(-)

Tested-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
