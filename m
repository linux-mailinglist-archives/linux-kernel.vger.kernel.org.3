Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F804584D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiG2IFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiG2IFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8319C0E;
        Fri, 29 Jul 2022 01:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ECB261B7A;
        Fri, 29 Jul 2022 08:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DCBC433C1;
        Fri, 29 Jul 2022 08:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659081898;
        bh=x5iwixgmr+VlHTq5scaZuKlrBeunluPiau3t1p/QL+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z29jy6PIELGGQT8XQSEzLMZZ5GLdTrUTDj7XQovl+Q/4gaRXiykfo/ePYeA1z/GN8
         G8zBCFz0o/lX+RMFz6y6kP+HgOkPMf2cbgt713Nki676wrHFLvjWsTQPk5hmrgT7H/
         g1nv7G+mLKURrlGg0ixEZOAWfgYbIFgAZyA/IZiM=
Date:   Fri, 29 Jul 2022 10:04:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Olliver Schinagl <oliver+list@schinagl.nl>
Cc:     Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YuOUp+7gam0UUu1+@kroah.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net>
 <YuJ8lWGKXEk03u3M@kroah.com>
 <5bd688b0-7694-0a96-67e6-7137c018c9a5@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd688b0-7694-0a96-67e6-7137c018c9a5@schinagl.nl>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:45:08PM +0200, Olliver Schinagl wrote:
> Hey Greg,
> 
> On 28-07-2022 14:09, Greg Kroah-Hartman wrote:
> > On Thu, Jul 28, 2022 at 11:21:14AM +0100, Gary Guo wrote:
> > > Rust requires braces around branches of if expression, and C doesn't.
> > > So in kernel coding style you often have:
> > > 
> > > 	if (condition) do_something();
> > 
> > That is not a valid kernel coding style, and our tools should catch this
> > and prevent it from being added to the kernel tree.
> Are you sure? I'm not sure if this isn't true today, but I've certainly seen
> old code where this definitely was done. Was all of this cleaned up in the
> last 2+ years?

Given that I wrote about this back in 2002, and it was true then:
	https://www.linuxjournal.com/article/5780
and:
	https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.2.8887&rep=rep1&type=pdf

that is not anything new at all.

Yes, old code still survives that might not be correct, and some
subsystems might have added code over time without the proper style, but
our tools check that the above is not correct, you can check it
yourself:

$ cat foo.c
// SPDX-License-Identifier: GPL-2.0
int foo(int baz)
{
	if (baz == 1) do_something();
}

$ ./scripts/checkpatch.pl --file --terse foo.c
foo.c:4: ERROR: trailing statements should be on next line
total: 1 errors, 0 warnings, 6 lines checked

thanks,

greg k-h
