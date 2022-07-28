Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7753658379E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiG1DgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbiG1Dfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:35:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D6C10F4;
        Wed, 27 Jul 2022 20:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2FE79CE23DF;
        Thu, 28 Jul 2022 03:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D6C43140;
        Thu, 28 Jul 2022 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658979318;
        bh=au+kwQgQmHtFfgr5KeR9B4+9JRSPO2Wa28WWxJN3FqM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fcWSsZ0fbIWgNMRI97wMttdLlJhbQBWYD7kuEURfcfZF5KFobxOb+habsoB6unXH3
         6OGwSus28ioDIdOP7wGI1WWLENhwd+x5ZuiWggLdz6ma1ZlTnpJrBYVp1mrpa5IRuO
         3/AZyFCfSnDK4Uhz4G2rWrPHMnNrScdZSD94D5sKEd9az+OgdUi2r7XSnZiATOsjy0
         xRa9KFCdxIvvv3NB7UcMh+TQuVioenXMrjj3JIhTAumyj/PCLH+LKXzVSGQUDXYa1V
         vSbmXAKDKY3cyCfOx6IHtznJtAS69wtM9RlJ2bYCJUgbu1XvlGKW4/PeClzV51LP+9
         /aMu0Vq02jWzw==
Received: by mail-lf1-f45.google.com with SMTP id a23so1013461lfm.10;
        Wed, 27 Jul 2022 20:35:18 -0700 (PDT)
X-Gm-Message-State: AJIora90H9/OmmP/v/YNikh0tm/9E463soKd4pNaLznFVKCgYPK3Xb2V
        x1gIOsrzZxtUzKnj5Tz1EzFO9gb3vfp1heKEXHw=
X-Google-Smtp-Source: AGRyM1uDk7g/TXHi7YU0u5F5W0WDTP8JtZAUD8vZgANdd+itx2kTEFhqdc3DjkIp+dODtCOog9Qn+oIGPX9bXdl+uZs=
X-Received: by 2002:a05:6512:ba7:b0:48a:be43:91d8 with SMTP id
 b39-20020a0565120ba700b0048abe4391d8mr1568824lfv.542.1658979316033; Wed, 27
 Jul 2022 20:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220724122517.1019187-8-guoren@kernel.org> <202207280822.VHS6qieH-lkp@intel.com>
In-Reply-To: <202207280822.VHS6qieH-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 28 Jul 2022 11:35:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQRV+6CZVkvhtsY19zv6XVbyDeRY-SdLPhkF0akHqvBWA@mail.gmail.com>
Message-ID: <CAJF2gTQRV+6CZVkvhtsY19zv6XVbyDeRY-SdLPhkF0akHqvBWA@mail.gmail.com>
Subject: Re: [PATCH V8 07/10] riscv: Add qspinlock support
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Muellner <cmuellner@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

The warning is from a clang problem.

drivers/net/wireguard/queueing.c:
static void __wg_prev_queue_enqueue(struct prev_queue *queue, struct
sk_buff *skb)
{
        WRITE_ONCE(NEXT(skb), NULL);
        WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
}

The queue->head is 64bit pointer size.

#define __xchg_relaxed(ptr, new, size)                                  \
({                                                                      \
        __typeof__(ptr) __ptr = (ptr);                                  \
        __typeof__(new) __new = (new);                                  \
        __typeof__(*(ptr)) __ret;                                       \
        switch (size) {                                                 \
        case 2: {                                                       \
... Clang shouldn't give warning from here, because code won't enter the path.
                break;                                                  \
        }                                                               \
        case 4:                                                         \
...
                break;                                                  \
        case 8:                                                         \
... The case would enter this path.
                break;                                                  \
        default:                                                        \
                BUILD_BUG();                                            \
        }                                                               \
        __ret;                                                          \
})

On Thu, Jul 28, 2022 at 8:05 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on arnd-asm-generic/master]
> [also build test WARNING on linus/master v5.19-rc8 next-20220727]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/arch-Add-qspinlock-support-with-combo-style/20220724-202743
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> config: riscv-randconfig-r026-20220727 (https://download.01.org/0day-ci/archive/20220728/202207280822.VHS6qieH-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/980c0acb7f432777e3473ab9a5696044e03b3f3d
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review guoren-kernel-org/arch-Add-qspinlock-support-with-combo-style/20220724-202743
>         git checkout 980c0acb7f432777e3473ab9a5696044e03b3f3d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/wireguard/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/net/wireguard/queueing.c:6:
>    In file included from drivers/net/wireguard/queueing.h:9:
>    In file included from drivers/net/wireguard/peer.h:9:
>    In file included from drivers/net/wireguard/device.h:9:
>    In file included from drivers/net/wireguard/noise.h:8:
>    In file included from drivers/net/wireguard/messages.h:10:
>    In file included from include/crypto/chacha20poly1305.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from drivers/net/wireguard/queueing.c:6:
>    In file included from drivers/net/wireguard/queueing.h:9:
>    In file included from drivers/net/wireguard/peer.h:9:
>    In file included from drivers/net/wireguard/device.h:9:
>    In file included from drivers/net/wireguard/noise.h:8:
>    In file included from drivers/net/wireguard/messages.h:10:
>    In file included from include/crypto/chacha20poly1305.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from drivers/net/wireguard/queueing.c:6:
>    In file included from drivers/net/wireguard/queueing.h:9:
>    In file included from drivers/net/wireguard/peer.h:9:
>    In file included from drivers/net/wireguard/device.h:9:
>    In file included from drivers/net/wireguard/noise.h:8:
>    In file included from drivers/net/wireguard/messages.h:10:
>    In file included from include/crypto/chacha20poly1305.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/riscv/include/asm/io.h:136:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:1107:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>                                                      ~~~~~~~~~~ ^
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'typeof (_x_)' (aka 'struct sk_buff *') [-Wpointer-to-int-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^~~~~~~~~~~~~~~~~~
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                ^~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>                                 ^~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'typeof (_x_)' (aka 'struct sk_buff *') [-Wpointer-to-int-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^~~~~~~~~~~~~~~~~~
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                ^~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>                                 ^~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'typeof (_x_)' (aka 'struct sk_buff *') [-Wpointer-to-int-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^~~~~~~~~~~~~~~~~~
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                ^~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>                                 ^~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'typeof (_x_)' (aka 'struct sk_buff *') [-Wpointer-to-int-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^~~~~~~~~~~~~~~~~~
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                ^~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>                                 ^~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^
>    note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'typeof (_x_)' (aka 'struct sk_buff *') [-Wpointer-to-int-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^~~~~~~~~~~~~~~~~~
>    note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                ^~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>                                 ^~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^
>    note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'typeof (_x_)' (aka 'struct sk_buff *') [-Wpointer-to-int-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^~~~~~~~~~~~~~~~~~
>    note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    drivers/net/wireguard/queueing.c:49:21: note: expanded from macro 'NEXT'
>    #define NEXT(skb) ((skb)->prev)
>                        ^~~
>    include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
>            __WRITE_ONCE(x, val);                                           \
>                         ^
>    include/asm-generic/rwonce.h:55:20: note: expanded from macro '__WRITE_ONCE'
>            *(volatile typeof(x) *)&(x) = (val);                            \
>                              ^
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^
>    note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    drivers/net/wireguard/queueing.c:49:21: note: expanded from macro 'NEXT'
>    #define NEXT(skb) ((skb)->prev)
>                        ^
>    include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
>            __WRITE_ONCE(x, val);                                           \
>            ~~~~~~~~~~~~~^~~~~~~
>    include/asm-generic/rwonce.h:55:20: note: expanded from macro '__WRITE_ONCE'
>            *(volatile typeof(x) *)&(x) = (val);                            \
>                              ^
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'typeof (_x_)' (aka 'struct sk_buff *') [-Wpointer-to-int-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^~~~~~~~~~~~~~~~~~
>    note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    drivers/net/wireguard/queueing.c:49:21: note: expanded from macro 'NEXT'
>    #define NEXT(skb) ((skb)->prev)
>                        ^~~
>    include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
>            __WRITE_ONCE(x, val);                                           \
>                         ^
>    include/asm-generic/rwonce.h:55:27: note: expanded from macro '__WRITE_ONCE'
>            *(volatile typeof(x) *)&(x) = (val);                            \
>                                     ^
> >> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
>            WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
>            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:1901:2: note: expanded from macro 'xchg_release'
>            arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:24:2: note: expanded from macro 'arch_xchg_release'
>            __atomic_op_release(arch_xchg, __VA_ARGS__)
>            ^
>    include/linux/atomic.h:68:2: note: expanded from macro '__atomic_op_release'
>            op##_relaxed(args);                                             \
>            ^
>    note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    drivers/net/wireguard/queueing.c:49:21: note: expanded from macro 'NEXT'
>    #define NEXT(skb) ((skb)->prev)
>                        ^
>    include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
>            __WRITE_ONCE(x, val);                                           \
>            ~~~~~~~~~~~~~^~~~~~~
>    include/asm-generic/rwonce.h:55:27: note: expanded from macro '__WRITE_ONCE'
>            *(volatile typeof(x) *)&(x) = (val);                            \
>                                     ^
>    21 warnings generated.
>
>
> vim +68 drivers/net/wireguard/queueing.c
>
> 8b5553ace83cced7 Jason A. Donenfeld 2021-02-22  64
> 8b5553ace83cced7 Jason A. Donenfeld 2021-02-22  65  static void __wg_prev_queue_enqueue(struct prev_queue *queue, struct sk_buff *skb)
> 8b5553ace83cced7 Jason A. Donenfeld 2021-02-22  66  {
> 8b5553ace83cced7 Jason A. Donenfeld 2021-02-22  67      WRITE_ONCE(NEXT(skb), NULL);
> 8b5553ace83cced7 Jason A. Donenfeld 2021-02-22 @68      WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
> 8b5553ace83cced7 Jason A. Donenfeld 2021-02-22  69  }
> 8b5553ace83cced7 Jason A. Donenfeld 2021-02-22  70
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
 Guo Ren
