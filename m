Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA29552420
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbiFTSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244951AbiFTSjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAF71FA5B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25B0761596
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9837BC341C0;
        Mon, 20 Jun 2022 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655750344;
        bh=vNynxaYqyr2RVDIp9MKcC7hRaMgnO6YGziFW+RsJ+NY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bRrHV5rO+hTCli7L0NKyTBRHLVURSlVN719clWuqm3nED8Kd7RpX0xqRxY+BWgjOc
         n6P7cVnWuXHiJGf4N02VGNKjgbG1uL0X/9gAYvbkgIazxMD6k5vLZVshU3BGoHr59m
         zmsjzukcHQO0Pdc5o/Ei4mQfMAgF19aGZK456vlkGy+5dX/r4syKz1155KSKRGgMXO
         cnus/FxoPNNIOX4YP6GV1IMh/47vaSL5AFqwZdxLw8Gis6SALSEOtABIMaeVkTZ+fT
         Ml/83TJSVRgJlsnJCo3pRqngUuAYz5r7Neruv2IPCjIU5f5Gb+nfbsI0bNRDo0QJij
         uf+YWDI0oRDzw==
Date:   Mon, 20 Jun 2022 20:38:36 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Message-ID: <20220620203836.0f323667@thinkpad>
In-Reply-To: <YrCO04oNncE1xF5K@alley>
References: <20220619204949.50d9154d@thinkpad>
        <87r13kwawb.fsf@jogness.linutronix.de>
        <20220620112936.48fcb2a4@thinkpad>
        <YrBdjVwBOVgLfHyb@alley>
        <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
        <YrCDNqsPrY+Hs9ju@alley>
        <YrCO04oNncE1xF5K@alley>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 17:14:27 +0200
Petr Mladek <pmladek@suse.com> wrote:

> The console kthreads uncovered several races in console drivers.
> All problems were in situation when a console was being properly
> initialized and registered while an early console, using the same
> port, was being used.
>=20
> These problems are pretty hard to debug because they often result
> into silent boot crashes. It would be nice to fix them but it
> looks like a can of worms.
>=20
> Prevent these problems by delaying the use of console kthreads
> after all early consoles are gone. It might later be optimized.
> But let's close this can of worms with a big hammer for now
> so that they do not break first impression on the kthreads
> that solve other real problems.
>=20
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@sams=
ung.com
> Reported=3Dby: Marek Beh=C3=BAn <kabel@kernel.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

This solves the issue. You have a typo in the reported-by tag
('=3D' instead of '-').

Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>
