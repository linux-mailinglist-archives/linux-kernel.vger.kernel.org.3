Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608DA591C96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 22:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiHMU2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 16:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbiHMU2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 16:28:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05347248DD
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:27:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so7371286ejp.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oRpYei+SmJcP8P910pdqSqQpbCLQB5yTd8wkGHmweb0=;
        b=LrAc11OhRwNceo3Fj0qtfaTLLCaTq4uavay9GA4096z/3cohl0CX/3887l6Fi54g+Y
         BmetoIl6GUBLCUrN4l7jXhOPQCIVdzSwpr7PSRpGumvtkMDAXIWj+xRrzcWzTeHhlyIU
         YzCXKSe7o3/2K5mvl0EahIaGdMBkoXBVmUJLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oRpYei+SmJcP8P910pdqSqQpbCLQB5yTd8wkGHmweb0=;
        b=JIsdDx6BSxN+6Hvcn6qzpHQXYdiUifBiCLaVxB4C0R3MV79QAuamrM78vGsChguCmq
         r7iUHmmn3It2HEcHG7nRcdU3ifYZJ+alpVtgLctmOl/V6RUS96G2BZpwvkTMSVduDlxw
         83ibyIqaXrCjpA41aAQD+DGkKA2w5EgOpWx+/8+/nz3FPTiwf8yTJ6cLCuyAxqon36a3
         +M+LD8FcPsyH30RtL2Sun60SGHxLCe/GHDj/1geqfhWE7koKXHibpAJW/23RRheg9Jog
         ORVtD1FVqHuVENJ7uUPsqbBRPD1BpWR0Ua4XeQLK2/tLMvoS5A5OnQ/5v55pijFisiBH
         Xwww==
X-Gm-Message-State: ACgBeo2cgsc+dZBQIgilUGqhbVHu/AJFvRdDSH6pO/OAwI1AEmi7RQWn
        mN3giVxvZeYqvHsJ5ZplAsjnEw+uBDKcViJm
X-Google-Smtp-Source: AA6agR5IVU96hQTku9RPoUk4gP3hm++EIKMzMa32U1fL+K8QSrYuwHwlNLVCj8Ia78Lm+taDvw5IPQ==
X-Received: by 2002:a17:906:847c:b0:730:b6a0:e0d with SMTP id hx28-20020a170906847c00b00730b6a00e0dmr6439080ejc.126.1660422477239;
        Sat, 13 Aug 2022 13:27:57 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id h23-20020a50cdd7000000b0043d3e06519fsm3532875edj.57.2022.08.13.13.27.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 13:27:56 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id n4so4629259wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 13:27:56 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr4727954wri.442.1660422476300; Sat, 13
 Aug 2022 13:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <Yvd8L0qIbLarxrOQ@gmail.com> <YvfQUGLGY7cfZ9gf@zn.tnic>
In-Reply-To: <YvfQUGLGY7cfZ9gf@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Aug 2022 13:27:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
Message-ID: <CAHk-=wi+K-LQ121sPbsQonja3Sx-_kXZc6ntauUC2=JPsUrC+g@mail.gmail.com>
Subject: Re: [GIT PULL] timer fixes
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>
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

On Sat, Aug 13, 2022 at 9:25 AM Borislav Petkov <bp@alien8.de> wrote:
>
> That task_struct.sighand is marked __rcu and thus noderef and sparse
> complains:

I think that RCU marking is misleading.

Doing a

        git grep -e '->sighand'

shows that we basically never treat that as some kind of RCU pointer.

Adding a

        grep -i rcu

to the above shows that we have a couple of places that do this
carefully, but they are the exception rather than the rule.

I think the issue is that "current->sighand" is always safe (and that
"me->sighand" is the same thing), and that sighand has RCU-delayed
freeing so that __lock_task_sighand() can safely try to take the lock
of another process' sighand.

And we have no real way to explain to sparse that *some* cases are
fine, others are not and need the sighand lock (after that careful
__lock_task_sighand thing).

              Linus
