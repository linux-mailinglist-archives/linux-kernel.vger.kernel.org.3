Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6630450A933
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391962AbiDUTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391697AbiDUTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:31:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA8E4D623
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:28:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x17so10447652lfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aU6fvCqxzFU63StVQlze3aMRu69ypxU3WuTt91+Ehwk=;
        b=dYiNQn5CkyRiXJAJMllX8T3Mod1ex1Xqfnebb1xDi5rqngCdLBibZWdbAhtADjTYBC
         A25meNOrLkpAu3lXdHfXaaQF7PsSmQ2xtX3y3yvt7208g3dju/DaJaB43C9EXTnE6WsE
         LPXzJ7sDNMPzHtvPf09nJNdDrSHgBuMkw7mGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU6fvCqxzFU63StVQlze3aMRu69ypxU3WuTt91+Ehwk=;
        b=2GpvJmfsERbVwaWiZMb4UKLxSIJuEUISBVxssuIG06UKg0ezH5EKbdmIPDpOCoyKWz
         cTjHY9T8/y+pFZFN8JpEdMrIOVQz4Mx9s+Xa+XARbTGiytW2kcEP3J62j0CwFKg8bXF/
         QsXc1pUb8kwKeu5o7cICb6TE/a1jhbHxg8EO5QKj57wYFoF/Bve48SGZmmVW2lPnvV7l
         pwh2vp9gHXqD1Qj/Y3+S8N4RS98kdrTlTPKmG+1vHV8/XgoVlebgwDUpwNUW4D5rtJDm
         S8wlVqnYxcjsZPzMTbEwhJjoOYlFJTDawcc3dL84JwHAFr9rAzcxPSrojdz8qKEqrnU8
         Y08w==
X-Gm-Message-State: AOAM532lY2zeJLN1nWcUKPKAFFZ60887p9xAmou4CISGcMU/mgeH6EfS
        fJUInaNe90X7Wgzo2DbZJSCRQuarThDtBnjPBH4=
X-Google-Smtp-Source: ABdhPJySMiDbJHCOrBc6j7rXwx17f65po80+G/Y/NNTEuKnMhpqF6EuJw/0PQ+bFYrSK0td1RIouwg==
X-Received: by 2002:a05:6512:169e:b0:470:2124:63fb with SMTP id bu30-20020a056512169e00b00470212463fbmr667825lfb.616.1650569322592;
        Thu, 21 Apr 2022 12:28:42 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j2-20020a196e02000000b00471a5bb39cfsm1010891lfc.170.2022.04.21.12.28.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 12:28:38 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h3so5744860lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:28:36 -0700 (PDT)
X-Received: by 2002:a05:6512:6d4:b0:470:f48d:44e2 with SMTP id
 u20-20020a05651206d400b00470f48d44e2mr667424lff.542.1650569316305; Thu, 21
 Apr 2022 12:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220420073717.GD16310@xsang-OptiPlex-9020> <CAHk-=wi6pJhsWLd7t9wEtq5tWh_2O61cSLk-wCgLwFrjW6+jbw@mail.gmail.com>
 <CANaxB-yVLCSHAi3QKMYzsSDRYC5Wz05iWx8yrb57cbiJ__5ThA@mail.gmail.com> <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com>
In-Reply-To: <CAHk-=wgSW3gB1=rf3atv=3Xvn0pNBtKUKJ2VF81ue-xagS7F4w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 12:28:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdCtgtQPZPTigMMniZaoMA_tHDu3EMBVM3w1GH5X+cOw@mail.gmail.com>
Message-ID: <CAHk-=wjdCtgtQPZPTigMMniZaoMA_tHDu3EMBVM3w1GH5X+cOw@mail.gmail.com>
Subject: Re: [fs/pipe] 5a519c8fe4: WARNING:at_mm/page_alloc.c:#__alloc_pages
To:     Andrei Vagin <avagin@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
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

On Thu, Apr 21, 2022 at 9:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The pipe part sounds like a horrible hacky thing.
>
> I also assume you already tried that, and hit some performance issues.
> But it does sound like the better interface, more directly what you
> want.
>
> So what are the problems with using process_vm_readv?

Actually, I take that back.

Don't use pipes.

Don't use process_vm_readv().

Use the system call we already have for "snapshot the current VM".

It's called "fork()". It's cheap, it's efficient, and it snapshots the
whole VM in one go. No stupid extra buffers in pipes, no crazy things
like that.

So just make your pre-dump code do a simple fork(), let the parent
continue, and then do the dumping in the child at whatever pace you
want.

In fact, you might just leave the child process alone, and let it _be_
that pre-dump.

You can create a new snapshot every once in a while, and kill the
previous snapshot, if you want to keep the snapshot close to the
target, and then use the memory tracking to track what has changed
since.

And you might not want to use plain "fork()", but instead some kind of
"clone()" variant. You might want to use CLONE_PARENT and some
non-SIGCHLD exit signal to basically hide the snapshot image from the
thing you are snapshotting.

Anyway, the "use vmsplice to a pipe to create a snapshot" sounds just
insane when you have a very traditional system call that is all about
snapshotting the process.

Maybe a new CLONE_xyz flag could be added to make that memory tracking
integrate better or whatever.

Any showstoppers?

                         Linus
