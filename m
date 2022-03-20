Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD84E1CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiCTQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiCTQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:48:29 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0DA02FFC0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 09:47:05 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22KGkruP026950;
        Sun, 20 Mar 2022 17:46:53 +0100
Date:   Sun, 20 Mar 2022 17:46:53 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 5/6] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
Message-ID: <20220320164653.GA26917@1wt.eu>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
 <20220320161644.GF8067@1wt.eu>
 <c7129520-5e9a-f9d1-cc12-5af9456c917f@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7129520-5e9a-f9d1-cc12-5af9456c917f@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 11:36:55PM +0700, Ammar Faizi wrote:
> And this is what GCC doc says about __attribute__((__aligned__)):
> """
>   The aligned attribute specifies a minimum alignment for the variable
>   or structure field, measured in bytes. When specified, alignment must
>   be an integer constant power of 2. Specifying no alignment argument
>   implies the maximum alignment for the target, which is often, but by
>   no means always, 8 or 16 bytes.
> """
> 
> Link: https://gcc.gnu.org/onlinedocs/gcc-11.2.0/gcc/Common-Variable-Attributes.html#Common-Variable-Attributes

OK then that's fine, thank you. I thought it would force the alignment
to the type itself.

> Simple experiment on Linux x86-64...

That's even easier checked like this:

  $ cat > c.c <<EOF
  struct blah {
          char a;
          char b __attribute__((__aligned__));
  } blah;
  EOF
  $ gcc -g -c c.c
  $ pahole c.o
  struct blah {
          char                       a;                    /*     0     1 */
  
          /* XXX 15 bytes hole, try to pack */
  
          char                       b __attribute__((__aligned__(16))); /*    16     1 */
  
          /* size: 32, cachelines: 1, members: 2 */
          /* sum members: 2, holes: 1, sum holes: 15 */
          /* padding: 15 */
          /* forced alignments: 1, forced holes: 1, sum forced holes: 15 */
          /* last cacheline: 32 bytes */
  } __attribute__((__aligned__(16)));

Thank you!
Willy
