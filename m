Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BDD583BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiG1KF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiG1KFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:05:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BCC42AE0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:05:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B201235312;
        Thu, 28 Jul 2022 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659002719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4L3qc5+151HmmRgPtNa+xmMNqlZi95xVHkUHYV5uRo=;
        b=aYeJGV4wYLD8CmxhgkbWsJEdn9HsfBe7MX+7DSe3AF3YRhu1L4xhBOpnvoXbdSEw5Q+NnS
        Vxpl33lvejau2J9C/3PSb1CXCqc8r8V2uZuTUwStWJAgi0ZA3nmsWxwaxURC8Bd4yDAOql
        i82QsQyq8nUZRjRUOvPUnYalr2ZQ214=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0F63B2C142;
        Thu, 28 Jul 2022 10:05:18 +0000 (UTC)
Date:   Thu, 28 Jul 2022 12:05:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>, ndesaulniers@google.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, rostedt@goodmis.org,
        senozhatsky@chromium.org, trix@redhat.com
Subject: Re: [PATCH v4] lib/test_printf.c: fix clang -Wformat warnings
Message-ID: <YuJfXqYoN43YScTI@alley>
References: <CAKwvOdnN67xFL22oWfqrKjvES4vjSB3KNhm401LtoC7igO+4Vg@mail.gmail.com>
 <20220718230626.1029318-1-justinstitt@google.com>
 <Ytag6youpnmli3E1@alley>
 <YuGUdHVhfwjobDJP@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuGUdHVhfwjobDJP@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-07-27 12:39:32, Nathan Chancellor wrote:
> Hi Petr,
> 
> On Tue, Jul 19, 2022 at 02:17:47PM +0200, Petr Mladek wrote:
> > On Mon 2022-07-18 16:06:26, Justin Stitt wrote:
> > > see warnings:
> > > | lib/test_printf.c:157:52: error: format specifies type 'unsigned char'
> > > | but the argument has type 'int' [-Werror,-Wformat]
> > > test("0|1|1|128|255",
> > > | "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
> > > -
> > > | lib/test_printf.c:158:55: error: format specifies type 'char' but the
> > > | argument has type 'int' [-Werror,-Wformat] test("0|1|1|-128|-1",
> > > | "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
> > > -
> > > | lib/test_printf.c:159:41: error: format specifies type 'unsigned
> > > short'
> > > | but the argument has type 'int' [-Werror,-Wformat]
> > > | test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
> > > 
> > > There's an ongoing movement to eventually enable the -Wformat flag for
> > > clang. Previous patches have targeted incorrect usage of
> > > format specifiers. In this case, however, the "incorrect" format
> > > specifiers are intrinsically part of the test cases. Hence, fixing them
> > > would be misaligned with their intended purpose. My proposed fix is to
> > > simply disable the warnings so that one day a clean build of the kernel
> > > with clang (and -Wformat enabled) would be possible. It would also keep
> > > us in the green for alot of the CI bots.
> > > 
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > Looks good to me:
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Would you be able to take this for 5.20 or should we ask Andrew to pick
> it up? It seems you two seem to split applying patches to this file and
> we are trying to get -Wformat enabled for clang in 5.20.

I take most vsprintf-related patches via the printk git tree
last few years.

Anyway, I have just committed the patch into printk/linux.git,
branch for-5.20.

Best Regards,
Petr
