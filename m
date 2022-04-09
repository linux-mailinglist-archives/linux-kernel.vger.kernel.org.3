Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9479C4FAB0C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 00:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiDIWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiDIWTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 18:19:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45727D54D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 15:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 052BBB8077B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 22:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C41C385A0;
        Sat,  9 Apr 2022 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649542631;
        bh=SSof2Ous81vQ0QbF3W9CmaDN73qqvK5z2RaO1OMDPHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2054lt6djFhf2sO5gwbOtenn6y9nH+QkjFDtSYieD+3eILv2qzBD80EDjIDNmRLz
         qWxoIQMnhCg/CLns7bysn4tvSM0cNxMZVE8OIKyPvboNPHrmHjNx79KjI+PnZ06z8K
         eCTMRQ5Oe/IqguOE4xaH4Ov+FR624HKgQE5Sn/iw=
Date:   Sat, 9 Apr 2022 15:17:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: Bug 215734 - shared object loaded very low in memory ARM 32bit
 with kernel 5.17.0
Message-Id: <20220409151710.2aa22be82ce554e779c42744@linux-foundation.org>
In-Reply-To: <b685f3d0-da34-531d-1aa9-479accd3e21b@leemhuis.info>
References: <e2b90c55-1a4a-4cf1-2dc7-2b2a4dc7d168@leemhuis.info>
        <b685f3d0-da34-531d-1aa9-479accd3e21b@leemhuis.info>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2022 13:52:17 +0200 Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
> 
> Hey, what's up here? Was this regressions fixed already?

I didn't know about these post-Mike regressions.

> H.J. Lu: reminder, this is caused by a patch of yours. One that causes
> two regressions I track, and it seem neither is getting addressed with
> the appropriate urgency. FWIW, the other regression can can be found here:
> https://lore.kernel.org/lkml/cb5b81bd-9882-e5dc-cd22-54bdbaaefbbc@leemhuis.info/
> https://bugzilla.kernel.org/show_bug.cgi?id=215720
> 
> Mike, if you have a minute: '925346c129da' ("fs/binfmt_elf: fix PT_LOAD
> p_align values for loaders") in 'next' contains a 'Fixes:' tag for the
> culprit of this regression, but I assume it fixes a different issue?

I'm assuming Mike's fix was indeed targeted at these regressions and
presumably only partly fixed them.

Thanks.  I have queued reverts for both Mike's fix (925346c129da117)
and for the original patch (9630f0d60fec5fb).  Both reversions have
cc:stable.

I'll hold onto these reversions for a week or so before sending them
upstream, if they are still needed.

