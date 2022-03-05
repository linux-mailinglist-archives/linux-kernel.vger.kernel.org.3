Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41B4CE629
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiCERGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 12:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCERF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 12:05:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D2141463
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 09:05:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D966090A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 17:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146E0C004E1;
        Sat,  5 Mar 2022 17:05:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kPvDz/zM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646499905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/GAJKVN6Yd0y16J1H2ziPUNbfPK/uHlz6EiSpfX2wCc=;
        b=kPvDz/zMeFF/GOSyJ47AnhcUNGQr32DtURB2/heaUakiT642yUMW2l0EOTafmN3SQVHtr/
        jgsc1qxq0Sbu8ijZLSveQOVzEPbHAow/vdr6s5+KVfCMdfmdCHdv2IH7jtmlPrEbS3Fgj0
        297V4oDREndky5C+Eb6Irt35Ibf/iBg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7604d99c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Mar 2022 17:05:05 +0000 (UTC)
Date:   Sat, 5 Mar 2022 10:05:02 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <YiOYPvleCsTT9vGu@zx2c4.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley>
 <YgoGNmYER8xni34K@google.com>
 <YguCuFYeZ52mkr4r@alley>
 <87zgm8h1tt.fsf@jogness.linutronix.de>
 <YiI2x6K5IhsADEmK@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiI2x6K5IhsADEmK@alley>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Fri, Mar 04, 2022 at 04:56:55PM +0100, Petr Mladek wrote:

> Just for record, the right commit ID in the mainline is
> 1b710b1b10eff9d466. It used printk_deferred() in _warn_unseeded_randomness():
> 
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1687,8 +1687,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
>  	print_once = true;
>  #endif
>  	if (__ratelimit(&unseeded_warning))
> -		pr_notice("random: %s called from %pS with crng_init=%d\n",
> -			  func_name, caller, crng_init);
> +		printk_deferred(KERN_NOTICE "random: %s called from %pS "
> +				"with crng_init=%d\n", func_name, caller,
> +				crng_init);
>  }

Are we able to revert this yet? Or is it still required because of
locking issues? Would gladly take a patch to revert that if the
non-deferred function is fine for 5.18.

Jason
