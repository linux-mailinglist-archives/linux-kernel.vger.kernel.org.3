Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D443586AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiHAMbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiHAMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7376969F1F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FCD160EE6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B018C433C1;
        Mon,  1 Aug 2022 12:11:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="of8795Qp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659355904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ec9m+bkHcs7kSLZ7WnnfBVOiBP4SdMr+uo7n0QyASHg=;
        b=of8795Qpckq663rDSszVZP+HRDateWgKjGmeGXcTkgFVZVzW4ci/su25PNYqMGexuK5Ffb
        9GQQSDrBIXvzDbvdz7aJFx46sv6iP4pD3BE6HSWsAyieBdTF/bQiFkUfDi3r5MBdlcdIr5
        ky1KXmG4uViN4oxqx0iZAu3C9Sw5V9k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 16016793 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 12:11:43 +0000 (UTC)
Date:   Mon, 1 Aug 2022 14:11:33 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2 v2] lib/vsprintf: Remove static_branch_likely() from
 __ptr_to_hashval().
Message-ID: <YufC9XCej2qmcH8p@zx2c4.com>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220729154716.429964-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 05:47:15PM +0200, Sebastian Andrzej Siewior wrote:
> Using static_branch_likely() to signal that ptr_key has been filled is a
> bit much given that it is not a fast path.
> 
> Replace static_branch_likely() with bool for condition and a memory
> barrier for ptr_key.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  lib/vsprintf.c |   19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -750,12 +750,7 @@ static int __init debug_boot_weak_hash_e
>  }
>  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
>  
> -static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
> -
> -static void enable_ptr_key_workfn(struct work_struct *work)
> -{
> -	static_branch_enable(&filled_random_ptr_key);
> -}
> +static bool filled_random_ptr_key;

This should be __read_mostly, right? Just like ptr_key.

Jason
