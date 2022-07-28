Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65BB583A68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiG1Ies (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiG1Iep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:34:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA421624B8;
        Thu, 28 Jul 2022 01:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 587F0B81F65;
        Thu, 28 Jul 2022 08:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3562C43470;
        Thu, 28 Jul 2022 08:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658997282;
        bh=/iqXB4sLqfkAmIly9U+AknKUxpbzNoD0MnbOOsfK7Ng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TYqJAbqLdN8M3xs9HZReajmGzxvKVejhfd2cQh7aHwiwro+NOjg1KO9lnY2my2gIT
         YeJGsbiSn7Js28Nw/4jCJaFbZy3dNBd8G4FGPu6JSbrKSME1wcYtUIf2lLRp3WaUhb
         LZptqu8IlAtBZCIW0gzapu+XE15Oy7Z7xjLQcpNDF4KbxNnLNorWEIuj4xri0imEQV
         KDvxvL9hi0I3tV/u2niDHalJINw9z1rNcHXIlmAt4XqBqBPqHO/OC2iM0rW8352VR3
         1Ay9NbwBwY4rVzQLh+hCiar9lgqkv3ipsw4xSYtr3Ta7iZXo/WcjymT2afo+w+41Ay
         Ig63TZEJ2i4zQ==
Received: by mail-lf1-f47.google.com with SMTP id d17so1776403lfa.12;
        Thu, 28 Jul 2022 01:34:41 -0700 (PDT)
X-Gm-Message-State: AJIora9Zq8PiMkcMqvGUOHeD8sXe2vzZJa+dpJjSosDDtJZcakV9IrAG
        DJmhUBaR/wB1qIUoFOIHvL77lAFxMygoZoxDq70=
X-Google-Smtp-Source: AGRyM1uXUEQAfs9KiWv7b6I8p+YLZZk8OQY2G+P3Cpr48Xxlen88hCbjTlhYSi9lr0dYrkzKEoSCAWeHCCrd9KwYuI4=
X-Received: by 2002:a05:6512:1516:b0:48a:3da4:3411 with SMTP id
 bq22-20020a056512151600b0048a3da43411mr9316179lfb.229.1658997279895; Thu, 28
 Jul 2022 01:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220724122517.1019187-8-guoren@kernel.org> <202207280822.VHS6qieH-lkp@intel.com>
 <CAJF2gTQRV+6CZVkvhtsY19zv6XVbyDeRY-SdLPhkF0akHqvBWA@mail.gmail.com> <CAK8P3a2X3R40S5F2fDzUz+ZoxJLEjO8iaGGk7zBDaiRwJ_oGLg@mail.gmail.com>
In-Reply-To: <CAK8P3a2X3R40S5F2fDzUz+ZoxJLEjO8iaGGk7zBDaiRwJ_oGLg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 28 Jul 2022 16:34:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQDASUaszVL64_D0GeCZ67svko7Grn2zmjmbSqgQoDzXQ@mail.gmail.com>
Message-ID: <CAJF2gTQDASUaszVL64_D0GeCZ67svko7Grn2zmjmbSqgQoDzXQ@mail.gmail.com>
Subject: Re: [PATCH V8 07/10] riscv: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Muellner <cmuellner@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 4:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 28, 2022 at 5:35 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi Palmer,
> >
> > The warning is from a clang problem.
> >
> > drivers/net/wireguard/queueing.c:
> > static void __wg_prev_queue_enqueue(struct prev_queue *queue, struct
> > sk_buff *skb)
> > {
> >         WRITE_ONCE(NEXT(skb), NULL);
> >         WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
> > }
> >
> > The queue->head is 64bit pointer size.
> >
> > #define __xchg_relaxed(ptr, new, size)                                  \
> > ({                                                                      \
> >         __typeof__(ptr) __ptr = (ptr);                                  \
> >         __typeof__(new) __new = (new);                                  \
> >         __typeof__(*(ptr)) __ret;                                       \
> >         switch (size) {                                                 \
> >         case 2: {                                                       \
> > ... Clang shouldn't give warning from here, because code won't enter the path.
> >                 break;                                                  \
> >         }                                                               \
> >         case 4:                                                         \
> > ...
> >                 break;                                                  \
> >         case 8:                                                         \
> > ... The case would enter this path.
> >                 break;                                                  \
> >         default:                                                        \
> >                 BUILD_BUG();                                            \
> >         }                                                               \
> >         __ret;                                                          \
> > })
>
> I assume it's this warning you are referring to?
>
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>
> I don't consider this a bug in clang, it just performs the normal type checking
> before dead code elimination and complains about code that clearly violates
> the type rules.
>
> I would suggest you split out the 16-bit xchg() into a properly typed inline
> function and add type casts when calling it.
Okay, I would try that style.

> In fact, I would love to
> completely eliminate the 8-bit and 16-bit cases from the regular xchg()
> and cmpxchg() interface and require all callers to explicitly call the
> xchg16()/cmpxchg16() instead, as we require for cmpxchg64() on 32-bit
> architectures already. This is something to do for another time though.
>
> > >    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> > >            val = __raw_readb(PCI_IOBASE + addr);
> > >                              ~~~~~~~~~~ ^
> > >    include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> > >            val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>
> Not your bug, but I see that CONFIG_MMU=n risc-v has the same bug that s390 has
> with missing I/O space support.  The correct workaround for this is to mark all
> drivers using PCI I/O space as 'depends on HAS_IO_PORT' or similar and then
> leaving out the definitions from the asm-generic header. Niklas Schnelle has
> spent a lot of time working on patches for this, but they are somewhat stuck
> in review. If RISC-V has the same problem, I hope we can get more people
> interested in it. I think OpenRISC and C-Sky have this as well, but I'm not
> sure if there is any plan to upstream clang support for those.
C-SKY hasn't any plan to support clang, as I know.

>
>         Arnd



-- 
Best Regards
 Guo Ren
