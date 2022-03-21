Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5B4E31C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353326AbiCUUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCUUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813D2CE13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52D8061181
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F08C340F2;
        Mon, 21 Mar 2022 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647894548;
        bh=xOTQryI23D4fd45PxEF4sV7yJJkeUPCp0luMO8URSjI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H7X9yFiNEkwRWk6MXMuj0nUftp+lO7xx1BxemuP7qK9Av/dx96P2J1nsH+vrJM0oK
         8dh8Ok+jecifczKXc0l8lU+dP2gLdfYm8PtrAAnVnNEzxvIYyaxo0uVuFY77kztaBU
         ogM7salA6gsRxpPDbR2dr0kJenQK5rs7Bn2ql//4LxBkyDj55vfs7QXv9vC5vbyL8G
         3QB96Era+0bqQ9K6nnorQsq/rkwTAsw7P2TeJ6GoKE24gnkQiSPSZuFI3BYJj5+AsK
         LLTCLIwABYpib9YcXwoA1WZdOfPYsWO9gIMAJ3jbTrrBku7Uf+mLtQabk/oNz7716X
         mSM/TlbYeUdEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67AA75C0338; Mon, 21 Mar 2022 13:29:08 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:29:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 0/8] nolibc: small updates required for the self-tests
Message-ID: <20220321202908.GI4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220321173314.7519-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 06:33:06PM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> while developing the nolibc self-tests, I naturally faced a few
> limitations ranging from missing POLL* flags to missing strcmp() or
> getenv(), as well as the ability for printf() to print "(null)" on
> "%s" instead of crashing.
> 
> This series adds a makefile and a headers installation target that
> creates a sysroot made of kernel headers and nolibc headers, which
> significantly ease building programs.
> 
> I already have some test code with roughly 75 tests, but I find it
> misplaced in the nolibc dir, I need to move it to testing/selftests/
> before sending it to you.
> 
> This series is intended to be an add-on to what you already have in your
> dev branch. I don't intend to send you much more stuff on top of this,
> but I expect to see an update from Ammar's patch set (CCed). With all
> this I think we'll have a good basis to easily add new tests.

I have pulled this series in for review and testing, thank you!

It won't go into -next until v5.18-rc1 comes out, in about two weeks,
but it will at least be in -rcu.

I removed an ostensibly extraneous blank line from the end of
tools/include/nolibc/Makefile.  So please let me know if that blank line
is actually necessary.

							Thanx, Paul

> Thanks!
> Willy
> 
> ---
> Willy Tarreau (8):
>   tools/nolibc/stdio: make printf(%s) accept NULL
>   tools/nolibc/stdlib: add a simple getenv() implementation
>   tools/nolibc/stdio: add support for '%p' to vfprintf()
>   tools/nolibc/string: add strcmp() and strncmp()
>   tools/nolibc/sys: add syscall definition for getppid()
>   tools/nolibc/types: add poll() and waitpid() flag definitions
>   tools/nolibc: add a makefile to install headers
>   tools/nolibc: add the nolibc subdir to the common Makefile
> 
>  tools/Makefile                |  4 ++++
>  tools/include/nolibc/Makefile | 43 +++++++++++++++++++++++++++++++++++
>  tools/include/nolibc/stdio.h  | 32 +++++++++++++++++---------
>  tools/include/nolibc/stdlib.h | 23 +++++++++++++++++++
>  tools/include/nolibc/string.h | 23 +++++++++++++++++++
>  tools/include/nolibc/sys.h    | 17 ++++++++++++++
>  tools/include/nolibc/types.h  | 10 ++++++++
>  7 files changed, 141 insertions(+), 11 deletions(-)
>  create mode 100644 tools/include/nolibc/Makefile
> 
> -- 
> 2.35.1
> 
