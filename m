Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB251F329
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiEID7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiEIDze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:55:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913E0308
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:51:39 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KxRxl6KpyzhZ3T;
        Mon,  9 May 2022 11:49:31 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 11:49:56 +0800
Date:   Mon, 9 May 2022 11:49:51 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Changbin Du <changbin.du@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <llvm-dev@lists.llvm.org>,
        <llvm-bugs@lists.llvm.org>, <hw.huiwang@huawei.com>
Subject: Re: riscv: llvm-compiler: calling convention violation: temporary
 register $t2 is used to pass the ninth function parameter
Message-ID: <20220509034951.trbbxhmgedocoxqm@M910t>
References: <20220509034658.kzwh7ocn4ilo4aed@M910t>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220509034658.kzwh7ocn4ilo4aed@M910t>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc hw.huiwang@huawei.com

On Mon, May 09, 2022 at 11:47:01AM +0800, Changbin Du wrote:
> Hello, folks,
> 
> Recently I encountered a kernel crash problem when using ftrace with 'perf ftrace'
> command on risc-v kernel built with llvm.
> 
> This crash only exists on llvm build, not reproducable with GCC. So I hope llvm
> guys can take a look :)
> 
> The llvm versions I have tried are llvm-13.0.0 and mainline (commit 102bc634cb
> ("[runtime] Build compiler-rt with --unwindlib=none")).
> 
> [  612.947887][  T496] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000001
> [  613.050789][  T496] Hardware name: riscv-virtio,qemu (DT)
> [  613.087976][  T496] epc : __find_rr_leaf+0x128/0x220
> [  613.107493][  T496]  ra : return_to_handler+0x22/0x24
> [  613.125322][  T496] epc : ffffffff80a1915a ra : ffffffff80009506 sp : ff20000011e43860
> [  613.150124][  T496]  gp : ffffffff81812f40 tp : ff6000008bb01580 t0 : ff600000806cf0f0
> [  613.173657][  T496]  t1 : 000000000001b29a t2 : 0000000000000001 s0 : ff20000011e43920
> [  613.187311][  T496]  s1 : ff600000848c2a00 a0 : 0000000000000002 a1 : 0000000000000002
> [  613.202731][  T496]  a2 : fffffffffffffffd a3 : ff6000009d287000 a4 : 00000000000002c0
> [  613.213723][  T496]  a5 : ff6000009d259b40 a6 : ffffffffffffff9c a7 : ffffffffffffffff
> [  613.226648][  T496]  s2 : 0000000000000001 s3 : ff20000011e439d8 s4 : ffffffff8160d140
> [  613.246571][  T496]  s5 : 0000000000000002 s6 : 0000000000000000 s7 : 0000000000000000
> [  613.264681][  T496]  s8 : 0000000000000064 s9 : 0000000000000000 s10: 0000000000400000
> [  613.277999][  T496]  s11: ff600000848c2aa8 t3 : 0000000000000290 t4 : 00000000004002c0
> [  613.303729][  T496]  t5 : 00000000ffffffff t6 : ff6000009d2872d0
> [  613.322145][  T496] status: 0000000200000120 badaddr: 0000000000000001 cause: 000000000000000d
> [  613.346228][  T496] [<ffffffff80a12526>] ip6_pol_route+0xb6/0x602
> [  613.365722][  T496] [<ffffffff80a1321a>] ip6_pol_route_output+0x2c/0x34
> [  613.386374][  T496] [<ffffffff80a1c028>] fib6_rule_lookup+0x36/0xa0
> [  613.401865][  T496] [<ffffffff80a131da>] ip6_route_output_flags_noref+0xd6/0xea
> [  613.412776][  T496] [<ffffffff80a13274>] ip6_route_output_flags+0x52/0xd4
> [  613.432013][  T496] [<ffffffff809ffb3a>] ip6_dst_lookup_tail+0x68/0x23a
> [  613.456198][  T496] [<ffffffff809ffec6>] ip6_sk_dst_lookup_flow+0x132/0x1cc
> [  613.513174][  T496] [<ffffffff80003cd8>] ret_from_syscall+0x0/0x2
> [  613.518973][  T496] [<ffffffff800094e4>] return_to_handler+0x0/0x24
> [  613.563961][  T496] Kernel panic - not syncing: Fatal exception
> [  613.572278][  T496] SMP: stopping secondary CPUs
> [  613.587449][  T496] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> The crash happened when dereferencing the point 'mpri' at route.c:758.
> 
> (gdb) l *__find_rr_leaf+0x128
> 0xffffffff809da9c4 is in __find_rr_leaf (net/ipv6/route.c:758).
> 753
> 754             if (strict & RT6_LOOKUP_F_REACHABLE)
> 755                     rt6_probe(nh);
> 756
> 757             /* note that m can be RT6_NUD_FAIL_PROBE at this point */
> 758             if (m > *mpri) {
> 759                     *do_rr = match_do_rr;
> 760                     *mpri = m;
> 761                     rc = true;
> 762             }
> 
> Adding some logs, I found the problem. The ninth passed parameter of function
> __find_rr_leaf() which is the address of local variable 'mpri', is changed to
> value '0x1' when inside the function __find_rr_leaf.
> Here is the code snippet and full link
> https://github.com/torvalds/linux/blob/9cb7c013420f98fa6fd12fc6a5dc055170c108db/net/ipv6/route.c.
> 
> static void find_rr_leaf(struct fib6_node *fn, struct fib6_info *leaf,
> 			 struct fib6_info *rr_head, int oif, int strict,
> 			 bool *do_rr, struct fib6_result *res)
> {
> 	u32 metric = rr_head->fib6_metric;
> 	struct fib6_info *cont = NULL;
> 	int mpri = -1;
> 
> 	__find_rr_leaf(rr_head, NULL, metric, res, &cont,
> 		       oif, strict, do_rr, &mpri);
> 	...
> }
> 
> Then debugging with gdb, I found this probably is a compiler bug. We can see the
> local function __find_rr_leaf() is not optimized out and the compiler generates
> a local symbol for it. The find_rr_leaf() (inlined by fib6_table_lookup) invokes
> this function with 'jalr' instruction.
> 
> (gdb) disassemble fib6_table_lookup
> Dump of assembler code for function fib6_table_lookup:
>    [snip]
>    0xffffffff80a1240e <+412>:   beqz    a1,0xffffffff80a12436 <fib6_table_lookup+452>
>    0xffffffff80a12410 <+414>:   slli    a1,s9,0x20
>    0xffffffff80a12414 <+418>:   srli    a1,a1,0x20
>    0xffffffff80a12416 <+420>:   sext.w  a2,a1
>    0xffffffff80a1241a <+424>:   addi    a7,s0,-125
>    0xffffffff80a1241e <+428>:   addi    t2,s0,-124
>    0xffffffff80a12422 <+432>:   li      a1,0
>    0xffffffff80a12424 <+434>:   mv      a3,s10
>    0xffffffff80a12426 <+436>:   li      a4,0
>    0xffffffff80a12428 <+438>:   ld      a5,-152(s0)
>    0xffffffff80a1242c <+442>:   mv      a6,s8
>    0xffffffff80a1242e <+444>:   auipc   ra,0x7
>    0xffffffff80a12432 <+448>:   jalr    -686(ra) # 0xffffffff80a19180 <__find_rr_leaf>
>    [snip]
> 
> And at line route.c:758, the value of point 'mpri' is stored in temporary register
> $t2 and $s3 (copied from $t2).
> 
> (gdb) info scope __find_rr_leaf
> [snip]
> Symbol mpri is multi-location:
>   Base address 0xffffffff80a10564  Range 0xffffffff80a19190-0xffffffff80a191ae: a variable in $t2
>   Range 0xffffffff80a191c0-0xffffffff80a191d6: a variable in $s3
>   Range 0xffffffff80a19200-0xffffffff80a19208: a variable in $s3
>   Range 0xffffffff80a1921e-0xffffffff80a192fe: a variable in $s3
>   Range 0xffffffff80a1930a-0xffffffff80a19356: a variable in $s3
> 
> Let's see when register $t2 is corrupted with single-step mode. Obviously, register
> $t2 is changed by mcount function ftrace_caller(). This is why the bug happens
> to ftrace.
> 
> Dump of assembler code for function __find_rr_leaf:
>    0xffffffff80a19180 <+0>:     sd      ra,-8(sp)   #  $t2 = 0xff200000120db7b4
>    0xffffffff80a19184 <+4>:     auipc   ra,0xff5f1
>    0xffffffff80a19188 <+8>:     jalr    -1744(ra) # 0xffffffff80009ab4 <ftrace_caller> #  $t2 = 0xff200000120db7b4
> => 0xffffffff80a1918c <+12>:    ld      ra,-8(sp)    #  $t2 = 0x1, bug, $t2 is corrupted!!
>    0xffffffff80a19190 <+16>:    addi    sp,sp,-176
>    [snip]
> 
> So now we can come to a conclusion. The generated local function __find_rr_leaf()
> violates the risc-v calling convention and leads to the panic. It should use stack
> but *not* temporary register $t2 to pass the ninth parameter! It's okay if the
> callsite can take care of local symbol callees, but the Function Instrumentation
> features should be considerated carefully.
> 
> For comparison, here is the result from gcc (9.2.0):
> (gdb) info scope __find_rr_leaf
> [snip]
> Symbol mpri is a complex DWARF expression:
>      0: DW_OP_fbreg 0, length 8.
> 
> I also built a simple test function with 9 parameters by clang and same cflags,
> but cannot reproduce it. Maybe it is conditional?
> 
> Simple test code:
> __attribute__ ((noinline))
> void test_func(int *a, int *b, int *c, int *d, int *e, int *f, int *g, int *h, int *i)
> {
>         printf("__find_rr_leaf: %d\n", *i);
> }
> 
> int main(void)
> {
>         int a,b,c,d,e,f,g,h,i = 100;
> 
>         test_func(&a,&b,&c,&d,&e,&f,&g,&h,&i);
>         return 0;
> }
> 
> -- 
> Cheers,
> Changbin Du

-- 
Cheers,
Changbin Du
