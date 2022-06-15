Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0854D3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350117AbiFOVbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbiFOVb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902744924D;
        Wed, 15 Jun 2022 14:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 268F6617C1;
        Wed, 15 Jun 2022 21:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8F8C3411A;
        Wed, 15 Jun 2022 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655328687;
        bh=h/A3iOsL+jSiXeun+GclseG7VDKI7T9E6iC83VBXQmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRcv7OdG8w6WZvKDmpHu4ZTNDPKNmUeNwkF/5kyOU3kogbTfbnziKBi4Jemy89mPK
         VB9ZLSW8Ef+8WhlhpERgKh3C4AwlLVT0YSGP+NZY7Y8aQQnRCCTfxkla/ct4P4xzOS
         m384ySKBIIAd638YYDqCOcxaXX3uj/4hJTyxkYvLHgkuIFRDDkI8+xZ2gKK6GJvocM
         p6WIsw8yQJAavGl0gEUO2R8b7panqmJ9rBrYblYA0mmSsjYt6gOUgcj3KHSNIx9Iq4
         CevdQYGBbuq+VVg9ZAfGZt1g9BYutIbzx1PyMaX9HpjQg/PQYxJc+gN2u0EeJbcuw0
         5w3ycwJy5spww==
Date:   Thu, 16 Jun 2022 00:29:18 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     "hch@lst.de" <hch@lst.de>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        "song@kernel.org" <song@kernel.org>,
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
Subject: Re: [PATCH] kprobes: Enable tracing for mololithic kernel images
Message-ID: <YqpPLqW6/AWEQhGr@iki.fi>
References: <YqAy0qjI4Lktk/uJ@iki.fi>
 <20220608232115.ccd4399f4a1d133e9b65c2a9@kernel.org>
 <CAPhsuW6iUieQvA6KqzSLgtxmjkVSWCuVwNA338DATb_myHxo7w@mail.gmail.com>
 <CAPhsuW6BzUtqnjvaGJScXRpghs0_V_phpdyd4_oAKhvmkX-GFw@mail.gmail.com>
 <YqEF6+YKqCHsWZJW@bombadil.infradead.org>
 <20220609034852.GA30873@lst.de>
 <YqH0iEgsi6+bwS3x@bombadil.infradead.org>
 <e7dedb9086193ca7682edc10fabc4195894e5146.camel@intel.com>
 <Yqh/5nn0AhdwaCm8@iki.fi>
 <20220615063707.GA22930@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615063707.GA22930@lst.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:37:07AM +0200, hch@lst.de wrote:
> On Tue, Jun 14, 2022 at 03:32:38PM +0300, jarkko@kernel.org wrote:
> > > Like say for a next step we moved prog pack out of bpf into core code,
> > > gave it it's own copy of module_alloc(), and then made kprobes use it.
> > > Then we would have something with improved W^X guard rails, and kprobes
> > > would not depend on modules anymore. I think maybe it's a step in the
> > > right direction, even if it's not perfect.
> > 
> > So you're saying that I should (as a first step) basically clone
> > module_alloc() implementation for kprobes, and future for BPF 
> > use, in order to get a clean starting point?
> 
> I don't think cloning the code helps anyone.  The fact that except
> for the eBPF mess everyone uses module_alloc and the related
> infrastructure is a feature and not a bug.  The interface should
> become better than what we have right now, but there is few enough
> users that this can be done in one go.
> 
> So assuming we really care deeply enough about fancy tracing without
> modules (and I'm not sure we do, even if you don't use modules it
> doesn't hurt to just build the modules code, I do that all the time
> for my test machines), the general approach in your series is the
> right one.

OK, thanks for the elaboration!

However I bake it, I doubt that next version is going to be the final
version, given all the angles. Therefore, I mostly Christophe's
suggestions on compilation flags, and also split this into per-arch
patches.

That should be at least to the right direction.

BR, Jarkko
