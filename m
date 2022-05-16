Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665952933C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349505AbiEPV5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348377AbiEPV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:57:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EC046153
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBAADB8167C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E395AC385AA;
        Mon, 16 May 2022 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652738234;
        bh=2UX7VEgWXWplRyuYdw1siYA11iPaD+OUY4Jd+8EeMa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDmKHFOu9IFpLO2Wyz/Hx0s2TDB4CJS6B9cKO7EHAKBz4GNJR5e2sVf3Tr2akBjcE
         Uq0qyjaONDDsWYkqLqXBmqNQSV5HWBokg53FFZ1c6vbv9aJReqfGhHoJsGOxNF0+w+
         lMEoq/gnk2V2gy96ns7i1qVlD0o5c7rL3hR7snvS36rgKB2qTye7gyLaBDrBOX370U
         M93q7aT4S/Ul5BiaGn9Wzm+PguIGzQe/OsoHps0RFkXCizs8niVZ0urQHuqFg0rueq
         53xB1n+amXVZy9Soj4spMPxkwVXo2IbR5ZH83Fcx+b/Gn3JBUgx2Yzpqyqhtv5tnaS
         Q81R7FbGnXhIw==
Date:   Mon, 16 May 2022 14:57:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        arnd@arndb.de, gregkh@linuxfoundation.org, ricky_wu@realtek.com,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
Message-ID: <YoLIuKf/1OcRtjdX@dev-arch.thelio-3990X>
References: <20220516130047.3887590-1-trix@redhat.com>
 <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
 <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
 <CAKwvOd=-H+rvt83rgrR3GyXdSDe+n0aG8CFLEshij9jNAzCQtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=-H+rvt83rgrR3GyXdSDe+n0aG8CFLEshij9jNAzCQtw@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:22:50PM -0700, Nick Desaulniers wrote:
> On Mon, May 16, 2022 at 10:06 AM Tom Rix <trix@redhat.com> wrote:
> >
> >
> > On 5/16/22 8:56 AM, Nathan Chancellor wrote:
> > > On Mon, May 16, 2022 at 09:00:47AM -0400, Tom Rix wrote:
> > >> The clang build fails with
> > >> rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> > >>          } else if (efuse_valid == 0) {
> > >>                     ^~~~~~~~~~~~~~~~
> > >>
> > >> setting_reg2 is set in this block
> > >>    if (efuse_valid == 2 || efuse_valid == 3) {
> > >> ..
> > >>    } else if (efuse_valid == 0) {
> > >>      // default
> > >> ..
> > >>    }
> > >> But efuse_valid can also have a value of 1.
> > >> Change the 'else if' to 'else' to make the second block the default.
> > >>
> > >> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
> > >> Signed-off-by: Tom Rix <trix@redhat.com>
> > > I am not sure if this fix is correct from a functional standpoint (i.e.
> > > is treating efuse_valid == 1 the same as efuse_valid == 0 correct?) but
> > > it is better than not handling this value altogether. For what it's
> > > worth:
> >
> > I looked at how the code used to work, this seemed better than
> > initializing to NULL.
> >
> > >
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > As a side note, it is unfortunate that this change made it into -next
> > > when there was an outstanding report about this warning:
> >
> >  From the clang side, this is a build break and my static analysis infra
> > goes down.
> >
> > These build breaks seem to happening every week, is there a precommit
> > clang gating test that could be done for -next ?
> 
> Probably worth asking Stephen, though I don't think there's _any_
> gating (i.e. presubmit testing) for -next, since that'd increase the
> build capacity needed. -next is tested post-merge (i.e. post submit
> testing) IIUC.

Stephen does do build testing during the merges ("Between each merge,
the tree was built with a ppc64_defconfig for powerpc, an allmodconfig
for x86_64, a multi_v7_defconfig for arm and a native build of
tools/perf"), in addition to testing after the final tree is done.

https://lore.kernel.org/20220516205718.2c5a52f9@canb.auug.org.au/

Increasing the "during merge" testing is not a reasonable request (IMO)
due to the additional time it would add to the entire -next process.  I
am not sure that having Stephen do builds with clang post merge is any
different from all the existing build coverage that we already have (the
tree is already done at that point), other than maybe people listen to a
human complaining more than a robot... :)

Cheers,
Nathan
