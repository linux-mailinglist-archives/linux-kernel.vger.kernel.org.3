Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8A4C5322
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiBZBro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiBZBrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:47:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629282B1C96;
        Fri, 25 Feb 2022 17:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1DF61D17;
        Sat, 26 Feb 2022 01:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CEAC340E7;
        Sat, 26 Feb 2022 01:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645840018;
        bh=XOAz6ET5rcJ82aoCqycGO2AwFyZKFec2j0t25J+3Gis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DAuSj1O8gIXKuuNgtA6wwSA7e1XT42Y1zUEM/zWv6pYOK4OrY8b61jprjfdjl5+3W
         1unXrifjjxipUd0BKkzb2hCnBG1pEe4hNVEdBMU88ZjvWvoqwZE7NAM0Htz5QN95zY
         T8fZ2atZmt7vvsopoFQ3JkrSBJ2fp0aJHc6rT3tg=
Date:   Fri, 25 Feb 2022 17:46:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-mm@kvack.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] usercopy: Check valid lifetime via stack depth
Message-Id: <20220225174657.9e1af8ec59ce8dbf223f84c5@linux-foundation.org>
In-Reply-To: <202202251728.1634F405@keescook>
References: <20220225173345.3358109-1-keescook@chromium.org>
        <20220225160157.680ecdea21ce81183059bb63@linux-foundation.org>
        <202202251728.1634F405@keescook>
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

On Fri, 25 Feb 2022 17:35:49 -0800 Kees Cook <keescook@chromium.org> wrote:

> On Fri, Feb 25, 2022 at 04:01:57PM -0800, Andrew Morton wrote:
> > On Fri, 25 Feb 2022 09:33:45 -0800 Kees Cook <keescook@chromium.org> wrote:
> > 
> > > Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
> > > is not available (i.e. everything except x86 with FRAME_POINTER), check
> > > a stack object as being at least "current depth valid", in the sense
> > > that any object within the stack region but not between start-of-stack
> > > and current_stack_pointer should be considered unavailable (i.e. its
> > > lifetime is from a call no longer present on the stack).
> > > 
> > > Introduce ARCH_HAS_CURRENT_STACK_POINTER to track which architectures
> > > have actually implemented the common global register alias.
> > > 
> > > Additionally report usercopy bounds checking failures with an offset
> > > from current_stack_pointer, which may assist with diagnosing failures.
> > > 
> > > The LKDTM USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests
> > > (once slightly adjusted in a separate patch) will pass again with
> > > this fixed.
> > 
> > Again, what does this actually do?
> 
> [answers]
>

OK, thanks.  I think a new changelog is warranted?

What's your preferred path for upstreaming this change?


