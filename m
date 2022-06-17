Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD754FE17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbiFQUGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiFQUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:06:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3E5B898
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:05:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u2so5027200pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVRxoQn7AiO7gd76vj7+dz8M6TQagl0KShpJJUpQGGI=;
        b=QjF7kc43eYBmG0w8ifoYZTIss00kABg2PBjxvBFNwNGsG3PoOUuTdVrmbUbxXJ/Hxd
         NttQU77Jb+buy+tG0Uq0kI/kTJVyr/TkcnlSv/RdpsvDtehLCa0qfgKXgnpnLIhx2BXJ
         GzrIZ0ENJBiT4loorikudoKlk6C1cRg9ojPTI1KZ5N/NEgiqSHOQ4e94ElVEPiFVW2dF
         k+pgTxOubFE0f6wB0CF6PU9Qr7SmQfvEuyXmoCcEoPkzyw780smdlx8ABkCyHFPcbYSe
         hmoRs6lyFtHshpJpepRkaylYSD3iPY7Z1UnVxIlruBFKxTD38TevtKQn+haiwYuOVQ4K
         EqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVRxoQn7AiO7gd76vj7+dz8M6TQagl0KShpJJUpQGGI=;
        b=q6Mr1p6knSwsXELnbxo31o7EeEuVoVMn0scGIzRtOnubBRCM0b0G8mBCQUvGYyoafT
         uHt3hduvtCyet7yTEoypz4Pn2ekLQfhuOvQOXBC3UhTKXwMe0O+G1DDX+Nk9TK7d6Izo
         8/GuviCVhjLYKHFDPVMLAyei+ajlo05IXJrA4+DB7e2jwBJjQyNOLQugtCnbgQ2YBwlw
         jnYywa29DBUxbo74eISg7ZlUamRMALQSNLT1K1McKxi1olxfeHTtT8SEKdKZjuD9ejJg
         s2UOqE5av0Sja+pdhgquPBlkf9r8FsdwuPzeLFKNizjWbelhnf4CckRMh/WTvb/8Uxqi
         bvRQ==
X-Gm-Message-State: AJIora/TSN9egy1HCxtu58ptEeEU6Bjft342eV9JknTxxzhd0v1DFCiU
        4g3epIjFherOKbSmc0q8c2azrA==
X-Google-Smtp-Source: AGRyM1st2CG2AdmtntN9Jqu1IV3b6SNwk+wp9wcEH0NpBFa/YvSGrL4jwiO2gM2uS4gjE32LtiffRg==
X-Received: by 2002:a63:91c2:0:b0:3fc:bcef:5681 with SMTP id l185-20020a6391c2000000b003fcbcef5681mr10853869pge.236.1655496357755;
        Fri, 17 Jun 2022 13:05:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3e97:dac1:ecec:f016])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b00162037fbb68sm3930796plm.215.2022.06.17.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:05:57 -0700 (PDT)
Date:   Fri, 17 Jun 2022 13:05:53 -0700
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
Message-ID: <20220617200553.kg7jmkvwdp7yqfkm@google.com>
References: <20220616104541.16289-1-jslaby@suse.cz>
 <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
 <CA+icZUXDGdPrPKUnevt99LUpTRPe=ogqF33uHQRYrQ6Kh-iTAw@mail.gmail.com>
 <CAK7LNATHY88PbJ_=A6g7v8NMQnBcQ9g06k1+SCe+NM+xd5dLwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNATHY88PbJ_=A6g7v8NMQnBcQ9g06k1+SCe+NM+xd5dLwA@mail.gmail.com>
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

On 2022-06-18, Masahiro Yamada wrote:
>(+LLVM list, Fangrui Song)

Thanks for tagging me. I'll clarify some stuff.

>On Fri, Jun 17, 2022 at 7:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> On Fri, Jun 17, 2022 at 12:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> >
>> > On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> > >
>> > > On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> > > >
>> > > > On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
>> > > > >
>> > > > > Until the link-vmlinux.sh split (cf. the commit below), the linker was
>> > > > > run with jobserver set in MAKEFLAGS. After the split, the command in
>> > > > > Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
>> > > > > is lost.
>> > > > >
>> > > > > Restore it as linkers working in parallel (esp. the LTO ones) make a use
>> > > > > of i
>
>Hi Jiri,
>
>Please let me clarify first.
>
>Here, is it OK to assume you are talking about Clang LTO
>instead of GCC LTO because the latter is not upstreamed ?
>
>
>
>
>
>I tested this patch but I did not see any performance change for Clang LTO.
>
>
>[1] CONFIG_CLANG_LTO_FULL
>
>   lld always runs sequential.
>   It never runs in parallel even if you pass -j option to Make

"lld always runs sequential" is not accurate. There are a number of
parallel linker passes.  ld.lld --threads= defaults to
llvm::hardware_concurrency (similar to
https://en.cppreference.com/w/cpp/thread/thread/hardware_concurrency,
but uses sched_getaffinity to compute the number of available cores).

"lld always runs sequential" is only correct only when --threads=1 is
specified or the system only provides one thread to the lld process.

I think people may be more interested in LTO parallelism here.  Regular
LTO (sometimes called full LTO when there is mixed-thin-and-regular LTO)
supports limited parallelism which applies to code generation, but not
IR-level optimization.  (IR-level optimization has many interprocedural
optimizations passes.  Splitting will make LTO less effective. Code
generation is per function, so parallelism does not regress
optimization.)

>
>[2] CONFIG_CLANG_LTO_THIN
>
>   lld always runs in parallel even if you do not pass -j option
>
>   In my machine, lld always allocated 12 threads.
>   This is irrespective of the Make parallelisms.
>
>
>
>
>One more thing, if a program wants to participate in
>Make's jobserver, it must parse MAKEFLAGS, and extract
>file descriptors to be used to communicate to the jobserver.
>
>As a code example in the kernel tree,
>scripts/jobserver-exec parses "MAKEFLAGS" and "--jobserver".
>
>
>I grepped the lld source code, but it does not contain
>"MAKEFLAGS" or "jobserver".

>masahiro@oscar:~/ref/lld$ git remote  show origin
>* remote origin
>  Fetch URL: https://github.com/llvm-mirror/lld.git
>  Push  URL: https://github.com/llvm-mirror/lld.git
>  HEAD branch: master
>  Remote branches:
>    master     tracked
>    release_36 tracked
>    release_37 tracked
>    release_38 tracked
>    release_39 tracked
>    release_40 tracked
>    release_50 tracked
>    release_60 tracked
>    release_70 tracked
>    release_80 tracked
>    release_90 tracked
>  Local branch configured for 'git pull':
>    master merges with remote master
>  Local ref configured for 'git push':
>    master pushes to master (up to date)
>masahiro@oscar:~/ref/lld$ git grep MAKEFLAGS
>masahiro@oscar:~/ref/lld$ git grep jobserver
>
>
>So, in my research, LLD does not seem to support the jobserver.


Correct. lld does not support GNU make's jobserver.  On the other hand,
I don't think the jobserver implementation supports flexible "give this
target N hardware concurrency". A heavy link target does not necessarily
get more resources than a quick target.

If a make target knows how many hardware concurrency it gets, we can
pass --threads= to lld. LTO easily takes 95+% link time, so LTO
parallelism may needs a dedicated setting. lld has --thinlto-jobs=.

>
>
>
>If you are talking about GCC LTO, yes, the code
>tries to parse "--jobserver-auth=" from the MAKEFLAGS
>environment variable.  [1]
>
>[1]:  https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/lto-wrapper.cc#L1341
>
>
>But, as you may know, GCC LTO works in a different way,
>at least, we cannot do it before modpost.
>
>
>-- 
>Best Regards
>Masahiro Yamada
>
