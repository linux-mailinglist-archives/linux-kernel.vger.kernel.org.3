Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8189E4B394F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 05:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiBMESL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 23:18:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiBMESI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 23:18:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990793BA7E;
        Sat, 12 Feb 2022 20:18:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e7so26631367ejn.13;
        Sat, 12 Feb 2022 20:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Ti2nk4zjdGL9qCHPI+wkzn/Zj6E+wju9LT/x+vfYco=;
        b=SJ6s05Ho3VIte1Mhbqxs8Q947UYeapNKgS4LOd6Axu7Z8VB6gv8gJZ9AINJY1KcmOH
         h36FRJQk0+lQUzhfc62qbJmbP+xH3+aWmiVe+Jj7U22WCA3UXwIEauB5ZElfOFAgryyx
         yfhhEwpu2SM4gF7Gq38FM8mJszOxGLFqOjEwq3Ll/qeMlQLbRvCsB3VkLDaovvSoRX87
         jlaEfHDD8lmDMWXLrVl3dar/7CbcBtrd/EEss3XFvivZBEmZSd1IHF9YCRbSyE4biYiY
         kVy0u87wlNNfdYFK0DHxCsS0FEURSP9j5NVjvuHqdFRNUJ8GPXMOxkSXKonydSxM4Kiv
         xDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ti2nk4zjdGL9qCHPI+wkzn/Zj6E+wju9LT/x+vfYco=;
        b=Ms8lVNNsS2yxSaYc106sSwPLETi+WJa5Ghdj0d9+BERcKNurpFpz4t3yumi6reXsGF
         JHrn3XnI6o1MAczVmBeZuhViLKASkdf60aU+EQTydvO9e0Rduw0ECkCJjZgbXihkxAf3
         wyYaq9My9yag2sJTXcdwnc9DFc6nOq/RjyhewpcYPtmk6xUt7c6HUylOe/9RI0zd1jAL
         XmQMb+Hdj8t1200IHHW4f1zFFf/SGQP0LgH3sHDd2dpJqX2CwKsngP8NCT9e3FQHPEqs
         fi/2zadOJlnIY9xu2QULBHJuelDBvfqsG48ICSyfmgXwcuxiZtX5Vc3oQzpw/goNhv6e
         3buw==
X-Gm-Message-State: AOAM532aTrKpMf5t+InD2NeStAqWHVGM0WqOOw3T763I0zYtrivTND4d
        fDF37ZBPVzum+TWxJ3DW08rf93ZfVjI8ZCjv6Cs=
X-Google-Smtp-Source: ABdhPJwxvsg2Ij6Z1o4x4TJvJwWJbP3hliNKXgonsOvcal8S7E6rhGePIR3CkCEEU3tglVkveoHAxt8qUGlZFAWHAJI=
X-Received: by 2002:a17:906:77d5:: with SMTP id m21mr1660225ejn.486.1644725882017;
 Sat, 12 Feb 2022 20:18:02 -0800 (PST)
MIME-Version: 1.0
References: <244218af-df6a-236e-0a52-268247dd8271@molgen.mpg.de>
 <CAABZP2ycCjiZ0CySc2Lgr_DnUfuDf1iagEKnWwNEkVkR9-gADA@mail.gmail.com> <YgiEeHzz4JZFszJD@casper.infradead.org>
In-Reply-To: <YgiEeHzz4JZFszJD@casper.infradead.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 13 Feb 2022 12:17:50 +0800
Message-ID: <CAABZP2wNEUpM0OyhpKb+EtKY2RynpeU2N2tu9Jw_9B6iv6jGNQ@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:256
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Matthew for correcting me

On Sun, Feb 13, 2022 at 12:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Feb 13, 2022 at 11:19:09AM +0800, Zhouyi Zhou wrote:
> > I think the key to the problem lies in your attached console.log
> > (pasted below), at times 0.014987 and 0.015995, I see there are two
> > locks (cpu_hotplug_lock and jump_label_mutex)  holded while
> > kmem_cache_alloc calls __might_resched (0.023356).
>
> Those are both sleeping locks (a percpu_rwsem and mutex, respectively).
> There is no problem with sleeping while holding a mutex or rwsem.
From console.log, I see
[    0.012154][    T1] BUG: sleeping function called from invalid
context at include/linux/sched/mm.h:256
[    0.013128][    T1] in_atomic(): 0, irqs_disabled(): 1, non_block:
0, pid: 1, name: swapper/0
From ___might_sleep, I see

9506         if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
9507              !is_idle_task(current) && !current->non_block_count) ||
9508             system_state == SYSTEM_BOOTING || system_state >
SYSTEM_RUNNING ||
9509             oops_in_progress)
9510                 return;

I guess it is irq_disable which cause the bug.

Thanks
Zhouyi
