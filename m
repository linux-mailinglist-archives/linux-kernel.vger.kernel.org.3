Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A03540253
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbiFGPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbiFGPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:23:11 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2EA3B57E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:23:09 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 257FFidN003178;
        Tue, 7 Jun 2022 10:15:44 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 257FFfLo003176;
        Tue, 7 Jun 2022 10:15:41 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 7 Jun 2022 10:15:41 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Michael Ellerman'" <mpe@ellerman.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: outside array bounds error on ppc64_defconfig, GCC 12.1.0
Message-ID: <20220607151541.GG25951@gate.crashing.org>
References: <YpbUcPrm61RLIiZF@debian.me> <87mtepns81.fsf@mpe.ellerman.id.au> <d38aeb0d6f2040369256ee640b44fafe@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38aeb0d6f2040369256ee640b44fafe@AcuMS.aculab.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:23:25PM +0000, David Laight wrote:
> > I don't see a really simple fix. I tried clamping the size parameter to
> > do_byte_reverse() with max(), but that didn't work :/
> 
> I had a quick look at the code - it is somewhat horrid!
> Not really surprising the compiler is confused.
> Although it shouldn't be outputting that error message
> unless it is certain.

No.  It is a warning message, and the compiler should output it for all
code it finds suspicious.  The conditions for this could be improved for
sure, but it is and will remain a heuristic affair, so using -Werror
with is is akin to self-flagellation.

It is not an error, it is a warning.  The correct response to it when
you determine it is not an error, or even you do not want to deal with
it now, is to ignore it.  Which -Werror prevents, one of the ways that
that warning flag is counterproductive to use.

> Could it be re-written to read the data into an __u128
> (or whatever the compiler type is).
> Optionally byteswap the entire thing (swap the words and
> then byteswap each word).
> The do a put_user_8/16/32/64() to write out the value.
> 
> I think that would remove all the memory accesses and make
> it a lot faster as well.

Yes, the warning sometimes fires for correct code that is "merely" next
to impossible to read.  It may well improve even the performance of the
code if the code is rewritten.

But it also may introduce new bugs, or anything else detrimental.  It
is yakshaving extraordinaire to do this every time a compiler warning
points out something doesn't smell quite right :-)


Segher
