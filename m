Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022C24C2BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiBXMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiBXMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:40:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862F927FBAF;
        Thu, 24 Feb 2022 04:39:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AC5B1F44A;
        Thu, 24 Feb 2022 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645706372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmqTGqWk/V1AcHAty5MkYbIYWxEdphX+KA+WD4K5f6w=;
        b=G/AL7r3T/R1HIU1WsIy1DBghOmtuAQiMFkb59bTNQoeOE1ljAPo1qIYX/itle3BVf1pz/K
        TdpczjZQvKpiLLwM6MXrlG4pgd2ePfnBH6Sm8lmr7E6RuEVAuWHaMDORwPsE7eNlLcyopc
        WGr6PJHOk8VlZYZJjw95H2UwXThR1Go=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D6275A3ED1;
        Thu, 24 Feb 2022 12:39:29 +0000 (UTC)
Date:   Thu, 24 Feb 2022 13:39:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>, Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 10/20] rust: add `kernel` crate
Message-ID: <Yhd8f93+Pw/7KdRV@alley>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-11-ojeda@kernel.org>
 <YhSnnHpIeDReK/eL@alley>
 <CANiq72n0sg_fizEk_kK=p8ROmWTrwdzqu1LD4SQdKUNLbK9ENA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n0sg_fizEk_kK=p8ROmWTrwdzqu1LD4SQdKUNLbK9ENA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-22 13:48:16, Miguel Ojeda wrote:
> Hi Petr,
> 
> On Tue, Feb 22, 2022 at 10:06 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > What exactly should we keep in sync, please?
> >
> > I see only handling of KERN_* prefix in print.rs. I do not see there
> > any counter part of LOG_LINE_MAX, CONSOLE_LOG_MAX, or PREFIX_MAX.
> 
> Good catch! We had a buffer on the Rust side in the past, but that is
> not the case anymore since commit 9e8bd679ecf2 ("Support Rust
> `core::fmt::Argument` in vsprintf") on our side, so we will remove the
> comment.

Great :-)

> > I am sorry but I am not familiar with rust. What are these limits
> > 2 and 10 used for, please?
> >
> > I guess that 2 is the size of a single KERN_* identifier.
> > But what is 10?
> >
> > Note that printk() format prefix is typically just a single KERN_*
> > identifier. But there might be more. Well, in practice only the
> > following combination makes sense: KERN_CONT + KERN_<LEVEL>.
> 
> What we are doing here is generating compile-time format strings that
> are then used by the `pr_*!` macros (which call the C side `printk()`
> with one of the strings).

I see. We are on the safe side then.

> In other words, this is not parsing arbitrary `printk()` format
> strings (which I am guessing something like that is your concern --
> please let me know if I got it wrong).

Yes, this was my concern.

> > Finally, is there any way to test whether any change in the printk
> > code breaks the rust support?
> 
> One way is to compile the code, e.g. the `assert!`s in the `generate`
> function run at compile-time, thus they provide a first layer of
> defense.
> 
> Another way is to use `samples/rust/print.rs` which we run in the CI
> as a black box test.
> 
> Is that what you had in mind? Or something like unit tests or self tests?

I had in mind any tests that I might run [*] to be sure that changes in
the native printk code does not break Rust support.

The compile test and samples/rust/print.rs do some basic tests and
might enough for now.

[*] To make it clear. I am not going to run the tests at this stage.
    But I might be useful once this patchset is accepted upstream.
    But it also might be enough to wait for results from your CI.
    I hope that we will not break it that often.

Best Regards,
Petr
