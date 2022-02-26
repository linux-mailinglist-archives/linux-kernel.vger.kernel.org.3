Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1654C525D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiBZACd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiBZACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:02:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8B1D683C;
        Fri, 25 Feb 2022 16:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC666195F;
        Sat, 26 Feb 2022 00:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30787C340E7;
        Sat, 26 Feb 2022 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645833718;
        bh=BooAGY/hhrBDZBSySQP/8P16m40+4PwEwwvGBs0SX8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gEEIn0s5wBSEY2vhiOTZBAmbSkuLlHV/NRyR/Ow4IyirgPycAL6SEEekKPtmUZ2cJ
         QJFTrZbM28gkQL49MGfHQv6yabdQ0W+uMnXpOffr+8R8HGlGgt0CDNw83JJSs62A9W
         5y5I1B/Y/mmocuqyUOijNkX1xbn5zzr4qvByDbH4=
Date:   Fri, 25 Feb 2022 16:01:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-mm@kvack.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] usercopy: Check valid lifetime via stack depth
Message-Id: <20220225160157.680ecdea21ce81183059bb63@linux-foundation.org>
In-Reply-To: <20220225173345.3358109-1-keescook@chromium.org>
References: <20220225173345.3358109-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 09:33:45 -0800 Kees Cook <keescook@chromium.org> wrote:

> Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
> is not available (i.e. everything except x86 with FRAME_POINTER), check
> a stack object as being at least "current depth valid", in the sense
> that any object within the stack region but not between start-of-stack
> and current_stack_pointer should be considered unavailable (i.e. its
> lifetime is from a call no longer present on the stack).
> 
> Introduce ARCH_HAS_CURRENT_STACK_POINTER to track which architectures
> have actually implemented the common global register alias.
> 
> Additionally report usercopy bounds checking failures with an offset
> from current_stack_pointer, which may assist with diagnosing failures.
> 
> The LKDTM USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests
> (once slightly adjusted in a separate patch) will pass again with
> this fixed.

Again, what does this actually do?

> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

A link to that report would shed some light.  But actually describing
the user-visible impact right there in the changelog is preferable.

It sounds like a selftest is newly failing, which makes it a
userspace-visible regression, perhaps?

If so, do we have a Fixes: and is a cc:stable warranted?
