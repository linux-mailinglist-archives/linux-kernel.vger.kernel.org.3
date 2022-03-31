Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91914ED9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiCaMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCaMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:44:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBB1480CE;
        Thu, 31 Mar 2022 05:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EFD3B8211D;
        Thu, 31 Mar 2022 12:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D969C340F2;
        Thu, 31 Mar 2022 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648730551;
        bh=jAIyaTwyj1j8wmQlC12/XbUSwBTVGLUZWKMUFMR6Ekk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fArRSMKtjQ/S+3oe4X61SF2THyPDES4UTJbZDnDbQY7xGAy6Fn+ysMtXW5bqBxXod
         U4fIbryJOIebBK7npOhbc9iTl6B3vFHBrPJd8DH3vbwUsxRCZ08Rt8qF7Cg1kvAMhk
         H2VZUeFyCluIlAqsDiQhCaUofZZJ8WHCcLQUamtU=
Date:   Thu, 31 Mar 2022 14:42:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>
Subject: Re: [PATCH v5 06/20] rust: add `alloc` crate
Message-ID: <YkWhs1GffuUmZ4SC@kroah.com>
References: <20220317181032.15436-1-ojeda@kernel.org>
 <20220317181032.15436-7-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317181032.15436-7-ojeda@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:09:54PM +0100, Miguel Ojeda wrote:
> This crate is a subset of the Rust standard library `alloc`, with some
> additions on top.
> 
> This is needed because upstream support for fallible allocations
> is a work in progress (i.e. the `try_*` versions of methods which
> return a `Result` instead of panicking).
> 
> Having the library in-tree also gives us a bit more freedom to
> experiment with new interfaces and allows us to iterate quickly.
> 
> Eventually, the goal is to have everything the kernel needs in
> upstream `alloc` and drop it from the kernel tree.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Matthew Bakhtiari <dev@mtbk.me>
> Signed-off-by: Matthew Bakhtiari <dev@mtbk.me>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/alloc/README.md              |   32 +
>  rust/alloc/alloc.rs               |  440 ++++
>  rust/alloc/borrow.rs              |  498 +++++
>  rust/alloc/boxed.rs               | 2008 +++++++++++++++++
>  rust/alloc/collections/mod.rs     |  156 ++
>  rust/alloc/fmt.rs                 |  601 ++++++
>  rust/alloc/lib.rs                 |  231 ++
>  rust/alloc/macros.rs              |  126 ++
>  rust/alloc/raw_vec.rs             |  561 +++++
>  rust/alloc/slice.rs               | 1279 +++++++++++
>  rust/alloc/str.rs                 |  632 ++++++
>  rust/alloc/string.rs              | 2862 ++++++++++++++++++++++++
>  rust/alloc/vec/drain.rs           |  186 ++
>  rust/alloc/vec/drain_filter.rs    |  145 ++
>  rust/alloc/vec/into_iter.rs       |  356 +++
>  rust/alloc/vec/is_zero.rs         |  106 +
>  rust/alloc/vec/mod.rs             | 3353 +++++++++++++++++++++++++++++
>  rust/alloc/vec/partial_eq.rs      |   49 +
>  rust/alloc/vec/set_len_on_drop.rs |   30 +
>  rust/alloc/vec/spec_extend.rs     |  174 ++
>  20 files changed, 13825 insertions(+)


This is a huge patch.  Why not break it into 2, one that adds what is
upstream, and then the second adds the "stuff on top" that you need for
the kernel.  Otherwise it's hard to know what is, and is not, upstream
for us to be able to review from a kernel point of view.

I think you are trying to do this with the "kernel" keyword, but if so,
why are you picking a "since" of 1.0?  None of that is described in the
changelog :(

thanks,

greg k-h
