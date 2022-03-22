Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D344E4001
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiCVOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiCVOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:04:39 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 172A02558E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:03:11 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22ME2smt011112;
        Tue, 22 Mar 2022 15:02:54 +0100
Date:   Tue, 22 Mar 2022 15:02:53 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Message-ID: <20220322140253.GJ10306@1wt.eu>
References: <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
 <81569a1c-a6d3-ceb2-a1f1-f229a024d684@gnuweeb.org>
 <20220322133413.GG10306@1wt.eu>
 <58cb5455-d065-b508-b328-20b57c3a67a7@gnuweeb.org>
 <3b8984ecfbcd4c93aeb468d01728cd74@AcuMS.aculab.com>
 <20220322134100.GH10306@1wt.eu>
 <9cfcb296-9dfe-aef1-4209-20a3a95c50ba@gnuweeb.org>
 <98304cd4-a443-5e5e-9764-654ecd1d458b@gnuweeb.org>
 <8f11bc01-4b63-eaf7-6da3-77556cfb0118@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f11bc01-4b63-eaf7-6da3-77556cfb0118@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:56:44PM +0700, Ammar Faizi wrote:
> On 3/22/22 8:54 PM, Ammar Faizi wrote:
> > 
> > Willy, something goes wrong here...
> > 
> > ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$ taskset -c 0 gcc -ffreestanding -nostdlib -nostartfiles test.c -o test -lgcc
> > /usr/bin/ld: /tmp/ccHiYiks.o: warning: relocation against `environ' in read-only section `.text'
> > /usr/bin/ld: /tmp/ccHiYiks.o: in function `getenv':
> > test.c:(.text+0x1f76): undefined reference to `environ'
> > /usr/bin/ld: test.c:(.text+0x1fc3): undefined reference to `environ'
> > /usr/bin/ld: test.c:(.text+0x1ffc): undefined reference to `environ'
> > /usr/bin/ld: test.c:(.text+0x2021): undefined reference to `environ'
> > /usr/bin/ld: test.c:(.text+0x2049): undefined reference to `environ'
> > /usr/bin/ld: warning: creating DT_TEXTREL in a PIE
> > collect2: error: ld returned 1 exit status
> > ammarfaizi2@integral2:~/work/linux.work/tools/include/nolibc$
> > 
> > 
> > I suspect it's caused by commit:
> > 
> > commit c970abe796019b3d576fd154a54b94efb35c02b1
> > Author: Willy Tarreau <w@1wt.eu>
> > Date:   Mon Mar 21 18:33:08 2022 +0100
> > 
> >      tools/nolibc/stdlib: add a simple getenv() implementation
> >      This implementation relies on an extern definition of the environ
> >      variable, that the caller must declare and initialize from envp.
> >      Signed-off-by: Willy Tarreau <w@1wt.eu>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > I will take a look deeper on this...
> 
> This bug only exists when compiling without optimization.

Indeed, reproduced. I can bypass it by adding __attribute__((weak)) on
the environ declaration in getenv(). Will send a patch later.

Thanks,
Willy
