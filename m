Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3604E5733
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiCWRNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245702AbiCWRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:13:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC827CB12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:12:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c15so2761952ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5cqrwm6NEPQjFiPbKAqninZQSMn4UOTnCh0iTsFNLo=;
        b=Inx3pPtFVYpWMK7FixLjIbC1jJxntgKxFxZ0jH6X3A3V4DayOw22Ok5qXfcDFVHksW
         5Z+y3J3Fpxdxt45EqV9ejbfr/BGgUPJVYjAt8PrdQK+Ldu47SVdHIt+TLQqEqo5qaN0k
         sSquUwe0j+WFE+jhk4cmjc8l4bgrN6x5TUmwzWlBNIgwdrfsm/To1mdKwqgs/hyp3KVw
         YlmGCRtvtdOGsveQAz8JBAto90omMtMgAZChFdGkZQQCsWMKgJxds1s315znXohhOVRJ
         BF8FWP31cfszkf7ExpfbNhunzTTF+m1FakIVwVrJu+J6eMnqRRMZJWa0AFxN/aigXAcf
         Nnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5cqrwm6NEPQjFiPbKAqninZQSMn4UOTnCh0iTsFNLo=;
        b=oTXecHK2JpD9JpTQHMflq4D+rRwkmp9o7UK6IaoayrxLbUAXjDueucsplbo7HuBRbR
         5RnVLp5+DZyGObbmr9oZ/E4Yy379KplXV5Tr6HFSyQDSXdUUTKM6qQyQNR/JMWXcMwZe
         dWmvUi/wi9M5U7gS+W4uAv2+tJQN9fxmxL98k6iVWWzgSlbIiJwVOx+vApCXCTXAsgbz
         udPL5fT5f3/iJar6TF7f6CS4+o0yX1CgjH/uIIxwNSGIQIaguHY9FitRv9WCDM4/EGAK
         +FPwgIAnue+YS8JsJyuqhaLBRpRFC1o2sadCND3QX4SLOFSGwuPKD7ebxlc6Cg7EIVOI
         /l1Q==
X-Gm-Message-State: AOAM531YMM/OONyth2kIcU5s1P3LeSdfRpbJDiMeF2JAYZIxQLkPqNTj
        Bpec1UoPIP+WGNL85YGZYXIZvbS4I571q81cH2sYow==
X-Google-Smtp-Source: ABdhPJznpm3ZCA3c5phLjI/3h2MA5pz20oijX4CrsCdzRosKuSDTTPndiUuGKIM12svCeiRr5Los/q9NoNLvrKzo2A0=
X-Received: by 2002:a2e:904c:0:b0:23e:d7ad:3fdd with SMTP id
 n12-20020a2e904c000000b0023ed7ad3fddmr805064ljg.239.1648055525198; Wed, 23
 Mar 2022 10:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <164724890153.731226.1478494969800777757.stgit@devnote2>
 <164724892075.731226.14103557516176115189.stgit@devnote2> <20220316191649.GA11547@pswork>
 <20220318101445.fdb151efe58c6c3a1c572500@kernel.org> <20220321183500.GA4065@pswork>
 <20220322120311.690f237b63ddfd9c0e4f78ec@kernel.org> <20220322190219.GA26859@pswork>
 <20220323091617.495bfdf5281a543b27f2656f@kernel.org>
In-Reply-To: <20220323091617.495bfdf5281a543b27f2656f@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 23 Mar 2022 10:11:53 -0700
Message-ID: <CAKwvOdk8is=R2qhgKuS_CddvtZzgeJC1Uht84x--TcYykfaiHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] bootconfig: Support embedding a bootconfig file in kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 5:16 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 22 Mar 2022 20:02:19 +0100
> Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
>
> > Hello Masami Hiramatsu,
> >
> > On Tue, Mar 22, 2022 at 12:03:11PM +0900, Masami Hiramatsu wrote:
> > > On Mon, 21 Mar 2022 19:35:00 +0100
> > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > >
> > > > Hello Masami Hiramatsu,
> > > >
> > > > On Fri, Mar 18, 2022 at 10:14:45AM +0900, Masami Hiramatsu wrote:
> > > > > On Wed, 16 Mar 2022 20:16:49 +0100
> > > > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > > >
> > > > > > Hello Masami Hiramatsu,
> > > > > >
> > > > > > Also noted that a change in default.bconf requries a clean build, is it
> > > > > > expected behaviour?
> > > > >
> > > > > default.bconf will be always updated if CONFIG_EMBED_BOOT_CONFIG=y. So you can
> > > > > do incremental build. (I tested it with the incremental build environment)
> > > > >
> > > >
> > > > Thanks, your observation made me to further experiment ther incremental build.
> > > >
> > > > Below are the observations I have:
> > > >
> > > > When I use GCC for a build; yes, the modified default.conf was observed on
> > > > the target.
> > > >
> > > > But when I use clang; either with FULL or THIN LTO, the modified
> > > > default.conf doesnt get reflected on the target.
> > >
> > > Hmm, curious. So you just add 'CC=clang' on the make command line, right?
> > Yes, CC=clang ARCH=arm64 LLVM=1. As specified here:
> > https://docs.kernel.org/kbuild/llvm.html.

You should just need LLVM=1 (and ARCH=arm64) at this point. LLVM=1
implies CC=clang.

Also, here's the start of the lore thread for folks:
https://lore.kernel.org/linux-doc/164724892075.731226.14103557516176115189.stgit@devnote2/

> >
> > > Can you confirm that following line in your build log,
> > >
> > >   GEN     lib/default.bconf
> > >
> > Yes, I do see above line. Indeed lib/default.bconf will get incremental
> > change.
> >
> >   GEN     lib/default.bconf
> >   CC      lib/bootconfig.o
> >   AR      lib/lib.a
> >
> > > and the timestamp of lib/bootconfig.o is built after lib/default.bconf file?
> > >
> > Yes, verified timestamp for all above artifacts including vmlinux.o.
> >
> > ex:
> > -rw-rw-r-- 1 psrinivasaia psrinivasaia 22K Mar 22 14:50
> > ../out/lib/bootconfig.o
> > -rw-rw-r-- 1 psrinivasaia psrinivasaia 355 Mar 22 14:50
> > ../out/lib/default.bconf
> > -rw-rw-r-- 1 psrinivasaia psrinivasaia 54M Mar 22 14:50 ../out/vmlinux.o
> >
> > As said incremnetal change was refelected in artifact default.bconf.
> > But not in vmlinux.o/vmlinux, used below command to verify.
>
> Interesting! This sounds clang's issue, because the make command rebuilds
> the object file including new default.bconf, but the linker (lld?)
> doesn't link it again correctly.

Sounds like missing FORCE directives in the Makefiles, perhaps?

Sami, do you recall any issues like this when implementing
commit dc5723b02e52 ("kbuild: add support for Clang LTO")
?

>
> >
> > llvm-objdump  -s -j .init.data ../out/vmlinux
> >
> > On target too, /proc/bootconfig shows old data.
> >
> > > And is that related to CONFIG_LTO? What happen if CONFIG_LTO=n?
> > >
> > Yes;  CONFIG_LTO_NONE=y  issue not observed even with LLVM binutils.
>
> And this issue is related to LTO. Maybe LTO ignores the '.init.data'
> section update. (Perhaps, LTO only checks the function code hash or
> something like that instead of the timestamp, and ignore whole object
> file if all of them are not updated.)

Sounds like this is a result of the above issue?
-- 
Thanks,
~Nick Desaulniers
