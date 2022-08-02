Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8804587D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiHBNec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:34:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76717E3A;
        Tue,  2 Aug 2022 06:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CF5EB81EFB;
        Tue,  2 Aug 2022 13:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F88AC433C1;
        Tue,  2 Aug 2022 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659447264;
        bh=FtHGa4GAb7Wv5gMgYrY9d3VJP1ZXtm3ZJZTT33K2diY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXsbUmWphF15LCQVZteM5bYujnkwxYbOryBRiGJSVPbtnM4uQ9xB93UUKwATZx/Lr
         yZIgc+tyBC+atNhr+0msSXNKjYAFtnDj8xPrqlI1JbhvD+1F9oFb3uEX0zEjndtdAQ
         S52uK9l/0UQFbcDQZcNFy6AisNEC/Oc0+qDyRcwc=
Date:   Tue, 2 Aug 2022 15:34:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        =?iso-8859-1?Q?N=E1ndor_Istv=E1n_Kr=E1cser?= <bonifaido@gmail.com>,
        David Gow <davidgow@google.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v8 17/31] rust: add `kernel` crate
Message-ID: <Yukn3vNJ8iGuXgiz@kroah.com>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-18-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802015052.10452-18-ojeda@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:50:04AM +0200, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> The `kernel` crate currently includes all the abstractions that wrap
> kernel features written in C.
> 
> These abstractions call the C side of the kernel via the generated
> bindings with the `bindgen` tool. Modules developed in Rust should
> never call the bindings themselves.
> 
> In the future, as the abstractions grow in number, we may need
> to split this crate into several, possibly following a similar
> subdivision in subsystems as the kernel itself and/or moving
> the code to the actual subsystems.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
> Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Co-developed-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> Co-developed-by: Dan Robertson <daniel.robertson@starlab.io>
> Signed-off-by: Dan Robertson <daniel.robertson@starlab.io>
> Co-developed-by: Viktor Garske <viktor@v-gar.de>
> Signed-off-by: Viktor Garske <viktor@v-gar.de>
> Co-developed-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Co-developed-by: Léo Lanteri Thauvin <leseulartichaut@gmail.com>
> Signed-off-by: Léo Lanteri Thauvin <leseulartichaut@gmail.com>
> Co-developed-by: Niklas Mohrin <dev@niklasmohrin.de>
> Signed-off-by: Niklas Mohrin <dev@niklasmohrin.de>
> Co-developed-by: Gioh Kim <gurugio@gmail.com>
> Signed-off-by: Gioh Kim <gurugio@gmail.com>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Milan Landaverde <milan@mdaverde.com>
> Signed-off-by: Milan Landaverde <milan@mdaverde.com>
> Co-developed-by: Morgan Bartlett <mjmouse9999@gmail.com>
> Signed-off-by: Morgan Bartlett <mjmouse9999@gmail.com>
> Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Co-developed-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Co-developed-by: Nándor István Krácser <bonifaido@gmail.com>
> Signed-off-by: Nándor István Krácser <bonifaido@gmail.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Co-developed-by: John Baublitz <john.m.baublitz@gmail.com>
> Signed-off-by: John Baublitz <john.m.baublitz@gmail.com>
> Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/allocator.rs                 |  64 ++
>  rust/kernel/amba.rs                      | 261 +++++++
>  rust/kernel/build_assert.rs              |  83 +++
>  rust/kernel/chrdev.rs                    | 206 ++++++
>  rust/kernel/clk.rs                       |  79 ++
>  rust/kernel/cred.rs                      |  46 ++
>  rust/kernel/delay.rs                     | 104 +++
>  rust/kernel/device.rs                    | 527 ++++++++++++++
>  rust/kernel/driver.rs                    | 442 +++++++++++
>  rust/kernel/error.rs                     | 564 ++++++++++++++
>  rust/kernel/file.rs                      | 887 +++++++++++++++++++++++
>  rust/kernel/fs.rs                        | 846 +++++++++++++++++++++
>  rust/kernel/fs/param.rs                  | 553 ++++++++++++++
>  rust/kernel/gpio.rs                      | 505 +++++++++++++
>  rust/kernel/hwrng.rs                     | 210 ++++++
>  rust/kernel/io_buffer.rs                 | 153 ++++
>  rust/kernel/io_mem.rs                    | 278 +++++++
>  rust/kernel/iov_iter.rs                  |  81 +++
>  rust/kernel/irq.rs                       | 681 +++++++++++++++++
>  rust/kernel/kasync.rs                    |  50 ++
>  rust/kernel/kasync/executor.rs           | 154 ++++
>  rust/kernel/kasync/executor/workqueue.rs | 291 ++++++++
>  rust/kernel/kasync/net.rs                | 322 ++++++++
>  rust/kernel/kunit.rs                     |  91 +++
>  rust/kernel/lib.rs                       | 267 +++++++
>  rust/kernel/linked_list.rs               | 247 +++++++
>  rust/kernel/miscdev.rs                   | 290 ++++++++
>  rust/kernel/mm.rs                        | 149 ++++
>  rust/kernel/module_param.rs              | 499 +++++++++++++
>  rust/kernel/net.rs                       | 392 ++++++++++
>  rust/kernel/net/filter.rs                | 447 ++++++++++++
>  rust/kernel/of.rs                        |  63 ++
>  rust/kernel/pages.rs                     | 144 ++++
>  rust/kernel/platform.rs                  | 223 ++++++
>  rust/kernel/power.rs                     | 118 +++
>  rust/kernel/prelude.rs                   |  36 +
>  rust/kernel/print.rs                     | 406 +++++++++++
>  rust/kernel/random.rs                    |  42 ++
>  rust/kernel/raw_list.rs                  | 361 +++++++++
>  rust/kernel/rbtree.rs                    | 563 ++++++++++++++
>  rust/kernel/revocable.rs                 | 425 +++++++++++
>  rust/kernel/security.rs                  |  38 +
>  rust/kernel/static_assert.rs             |  34 +
>  rust/kernel/std_vendor.rs                | 161 ++++
>  rust/kernel/str.rs                       | 597 +++++++++++++++
>  rust/kernel/sync.rs                      |  48 +-
>  rust/kernel/sysctl.rs                    | 199 +++++
>  rust/kernel/task.rs                      | 239 ++++++
>  rust/kernel/types.rs                     | 705 ++++++++++++++++++
>  rust/kernel/unsafe_list.rs               | 680 +++++++++++++++++
>  rust/kernel/user_ptr.rs                  | 175 +++++
>  rust/kernel/workqueue.rs                 | 512 +++++++++++++
>  52 files changed, 15518 insertions(+), 20 deletions(-)

This is huge for a single commit, and pretty much impossible to review
as-is.

Any chance you can turn this into a series of commits, that starts with
the basics and builds on top of that?  Right now you are mixing many
many different subsystems all at once into one commit, guaranteeing that
no one can review the whole thing properly :(

thanks,

greg k-h
