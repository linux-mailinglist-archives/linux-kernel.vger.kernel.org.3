Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AF579D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiGSMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiGSMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:45:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A573D88CF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:18:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 46F06201A9;
        Tue, 19 Jul 2022 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658233069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13gPMWrRlmdyk8ojlK1rRPdrqyG9NrHs9vtFvS8xT00=;
        b=mS3OSjlIJCXp1y0uvJD1Dn1BnM8y14fg6LY7hJR2JDXMrCJUorwwOO0QXNqD33sWpwuGMs
        GMT2kWsRi1PfqWSFYzDaBaBV16pSC3WOIqOfhvCq+byDM16TWcDRuYYcQwbz0thIsDpttb
        zOkx5I7P4lUmesjf9R6Oaro3i/OvAL8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3EA72C141;
        Tue, 19 Jul 2022 12:17:48 +0000 (UTC)
Date:   Tue, 19 Jul 2022 14:17:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     ndesaulniers@google.com, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        trix@redhat.com
Subject: Re: [PATCH v4] lib/test_printf.c: fix clang -Wformat warnings
Message-ID: <Ytag6youpnmli3E1@alley>
References: <CAKwvOdnN67xFL22oWfqrKjvES4vjSB3KNhm401LtoC7igO+4Vg@mail.gmail.com>
 <20220718230626.1029318-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718230626.1029318-1-justinstitt@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-07-18 16:06:26, Justin Stitt wrote:
> see warnings:
> | lib/test_printf.c:157:52: error: format specifies type 'unsigned char'
> | but the argument has type 'int' [-Werror,-Wformat]
> test("0|1|1|128|255",
> | "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:158:55: error: format specifies type 'char' but the
> | argument has type 'int' [-Werror,-Wformat] test("0|1|1|-128|-1",
> | "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:159:41: error: format specifies type 'unsigned
> short'
> | but the argument has type 'int' [-Werror,-Wformat]
> | test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
> 
> There's an ongoing movement to eventually enable the -Wformat flag for
> clang. Previous patches have targeted incorrect usage of
> format specifiers. In this case, however, the "incorrect" format
> specifiers are intrinsically part of the test cases. Hence, fixing them
> would be misaligned with their intended purpose. My proposed fix is to
> simply disable the warnings so that one day a clean build of the kernel
> with clang (and -Wformat enabled) would be possible. It would also keep
> us in the green for alot of the CI bots.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
