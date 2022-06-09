Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034645457A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbiFIWsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFIWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:48:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874EA45D;
        Thu,  9 Jun 2022 15:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4399ECE317A;
        Thu,  9 Jun 2022 22:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D3BC36AFF;
        Thu,  9 Jun 2022 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654814909;
        bh=fXQHcxnj09/NTw2WTFOlO+YMcNuPa2JywCYJxs8h+OI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rbv9z7QeT/QQKBgEuJO5H6O/pF2I3A5hVtn+qNA4aWH96FTU6yVTEQwHQGjqaoYkT
         tFPL3zBi5AVCAkOoC2eoAi0xj+emtB7yPU39cgTU3RScBvLEpnCwZQqYQ8sLffVfQ8
         Sx8qjpReQ0YkIwWrENf5Q0+QiPCd0A+cMbePFKYcfvT1TxMgB++pQoN4KkNxaqlLbw
         9HBuekMBTr0Sf4IFP0xEd650ha3tmpj+fTktT3OylX/fHTt7m1VpHFcnD+AKYIqrH3
         JmEUaeHvP+BNUIuP94Iqjo+6JRsKgf6ujoTYj4eO+d0UL22utEkOROjGi3GlR6kseU
         Ldl3iwq16Jcbw==
Received: by mail-yb1-f180.google.com with SMTP id y188so14709363ybe.11;
        Thu, 09 Jun 2022 15:48:29 -0700 (PDT)
X-Gm-Message-State: AOAM530xFRfgRJ3qRdVmUqP21HqcSPX/NrqYfXddDqdA165zUT8PNFGT
        HOY2zwXJCafTyzHLA/eacP9xc48fGvPt1pC/z6o=
X-Google-Smtp-Source: ABdhPJzemSM5GrpgirpnnQNTEDsYpAOxmoxNmoSmK2+phEV9mudE18JL5yVLSDRq4A8vq3lyLIBxhhDyWWNd79LGZgg=
X-Received: by 2002:a25:3b49:0:b0:664:5a43:5895 with SMTP id
 i70-20020a253b49000000b006645a435895mr1766286yba.9.1654814908410; Thu, 09 Jun
 2022 15:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220608000014.3054333-1-jarkko@profian.com> <CAJF2gTQgCn2CyZ4+VBqEEBT2b4+1KxoEXxrd+Ritk=58+U8EFA@mail.gmail.com>
 <YqAy0qjI4Lktk/uJ@iki.fi> <20220608232115.ccd4399f4a1d133e9b65c2a9@kernel.org>
 <CAPhsuW6iUieQvA6KqzSLgtxmjkVSWCuVwNA338DATb_myHxo7w@mail.gmail.com>
 <CAPhsuW6BzUtqnjvaGJScXRpghs0_V_phpdyd4_oAKhvmkX-GFw@mail.gmail.com>
 <YqEF6+YKqCHsWZJW@bombadil.infradead.org> <20220609034852.GA30873@lst.de>
 <YqH0iEgsi6+bwS3x@bombadil.infradead.org> <e7dedb9086193ca7682edc10fabc4195894e5146.camel@intel.com>
In-Reply-To: <e7dedb9086193ca7682edc10fabc4195894e5146.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 9 Jun 2022 15:48:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4rF1cFmdSUZD=Tw4QRmOf=v+V_2EhEphzJA5teqOrH0Q@mail.gmail.com>
Message-ID: <CAPhsuW4rF1cFmdSUZD=Tw4QRmOf=v+V_2EhEphzJA5teqOrH0Q@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Enable tracing for mololithic kernel images
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "zepan@sipeed.com" <zepan@sipeed.com>,
        "iii@linux.ibm.com" <iii@linux.ibm.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>,
        "egorenar@linux.ibm.com" <egorenar@linux.ibm.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>,
        "luis.machado@linaro.org" <luis.machado@linaro.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jniethe5@gmail.com" <jniethe5@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "dja@axtens.net" <dja@axtens.net>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "huschle@linux.ibm.com" <huschle@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "dave.anglin@bell.net" <dave.anglin@bell.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "atomlin@redhat.com" <atomlin@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "nathaniel@profian.com" <nathaniel@profian.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "Sakkinen, Jarkko" <jarkko@profian.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "ashimida@linux.alibaba.com" <ashimida@linux.alibaba.com>,
        "elver@google.com" <elver@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "changbin.du@intel.com" <changbin.du@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 11:41 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2022-06-09 at 06:24 -0700, Luis Chamberlain wrote:

[...]

>
> Like say for a next step we moved prog pack out of bpf into core code,
> gave it it's own copy of module_alloc(), and then made kprobes use it.
> Then we would have something with improved W^X guard rails, and kprobes
> would not depend on modules anymore. I think maybe it's a step in the
> right direction, even if it's not perfect.

I was also thinking about where to put the prog pack allocator eventually.
Shall it be part of mm code or module code?

Btw, prog pack has more challenges with W^X requirement:
1. The arch need to have text poke mechanism;
2. Some users of prog pack need to learn to use the ROXbuffer with text poke,
  for example, how to calculate relative address differently.

Thanks,
Song
