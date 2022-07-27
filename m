Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F125833C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiG0Tjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0Tjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B94F1B5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5216619D7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88645C433C1;
        Wed, 27 Jul 2022 19:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658950775;
        bh=6QrAfTvkNV6NZKSnM4GFiCYvG9mCQyTGm1wjf+gju7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGH/vNOWi7C6FWQk9KzV2m0O+irt0iEntrgyypDc3vAc1QOIwc4IakO9QVE7OPY9M
         ju80zSFCipphEOr2u5vf3g80FJFR8JxIAGQ4RxSRADSXKybeKYl60/QKc6+fGN7BB3
         C8VHhhm2zeohFEvJCplqSx4WDxcOGSA3HIiYH146h7RWZPOC3q1y7IkldwVjMmjH8+
         WYjWH17eeImpsGufgfSCiFks/xlIsRumpCqKsJh+jamgOaJQ7fy6BFKOVptNGPg/AP
         8kJY1711kbQqW3HO7EEE/5GIEuVX4Mi2kqE3sdklDf8TGroG7w3JFaqMsknw2VHinI
         mDUqjCIkkUjuA==
Date:   Wed, 27 Jul 2022 12:39:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Justin Stitt <justinstitt@google.com>, ndesaulniers@google.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, rostedt@goodmis.org,
        senozhatsky@chromium.org, trix@redhat.com
Subject: Re: [PATCH v4] lib/test_printf.c: fix clang -Wformat warnings
Message-ID: <YuGUdHVhfwjobDJP@dev-arch.thelio-3990X>
References: <CAKwvOdnN67xFL22oWfqrKjvES4vjSB3KNhm401LtoC7igO+4Vg@mail.gmail.com>
 <20220718230626.1029318-1-justinstitt@google.com>
 <Ytag6youpnmli3E1@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytag6youpnmli3E1@alley>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Tue, Jul 19, 2022 at 02:17:47PM +0200, Petr Mladek wrote:
> On Mon 2022-07-18 16:06:26, Justin Stitt wrote:
> > see warnings:
> > | lib/test_printf.c:157:52: error: format specifies type 'unsigned char'
> > | but the argument has type 'int' [-Werror,-Wformat]
> > test("0|1|1|128|255",
> > | "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
> > -
> > | lib/test_printf.c:158:55: error: format specifies type 'char' but the
> > | argument has type 'int' [-Werror,-Wformat] test("0|1|1|-128|-1",
> > | "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
> > -
> > | lib/test_printf.c:159:41: error: format specifies type 'unsigned
> > short'
> > | but the argument has type 'int' [-Werror,-Wformat]
> > | test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
> > 
> > There's an ongoing movement to eventually enable the -Wformat flag for
> > clang. Previous patches have targeted incorrect usage of
> > format specifiers. In this case, however, the "incorrect" format
> > specifiers are intrinsically part of the test cases. Hence, fixing them
> > would be misaligned with their intended purpose. My proposed fix is to
> > simply disable the warnings so that one day a clean build of the kernel
> > with clang (and -Wformat enabled) would be possible. It would also keep
> > us in the green for alot of the CI bots.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Looks good to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Would you be able to take this for 5.20 or should we ask Andrew to pick
it up? It seems you two seem to split applying patches to this file and
we are trying to get -Wformat enabled for clang in 5.20.

Cheers,
Nathan
