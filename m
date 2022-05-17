Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED178529E76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbiEQJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbiEQJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:48:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E12703;
        Tue, 17 May 2022 02:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403C861548;
        Tue, 17 May 2022 09:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE19C385B8;
        Tue, 17 May 2022 09:48:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="abHaLabl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652780914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8EjMB/R6K+/QDIlIcRX9HLNcLCkjYvb0CHORmYy0Cjc=;
        b=abHaLablPHG6ukIN2wi5hyKKMIQRr0gtXEsiGrkVbnwhqKxIy1D7NWq/KCBpGnJgUOEfnG
        U0PwWS9RfK9leath1ssIE8ELlso7UTi1ONrUG75gVENVxXUXJfzXKkvVr0H0PfxLvJOLlU
        FFlziV+L1Iw6TzIo8ydF9o16fTbvfBc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67a09773 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 17 May 2022 09:48:34 +0000 (UTC)
Date:   Tue, 17 May 2022 11:48:31 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] random: remove mostly unused async readiness notifier
Message-ID: <YoNvb265RG5pOObU@zx2c4.com>
References: <YoD7hn4yBHE0RYUa@zx2c4.com>
 <20220515131927.474097-1-Jason@zx2c4.com>
 <YoNlNs7vGcAy8rU3@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoNlNs7vGcAy8rU3@alley>
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

On Tue, May 17, 2022 at 11:04:54AM +0200, Petr Mladek wrote:
> I would go even further. The workqueue is needed only because we are not
> able to switch the static branch in an atomic context.
> 
> But the static branch looks like an over-optimization.
> vsprintf() is a slow path. It will be enough to use a normal
> variable.
> 
> Well, it would be nice to check it without the spinlock to keep it
> fast and avoid problems with the spin lock during panic().
> 
> What about?

That all makes sense to me, but I'm a bit worried about changing too
much from the original design in a commit mostly intended on removing
things from random.c. Maybe we can do the patch I sent here, and then
once that lands in 5.19, we can do some more simplifications as
standalone commits that you can assess. Or if you're adamant about doing
this now, maybe you can send a patch that I can apply on _top_ of this
commit here?

The reason I'm a bit cautious is because I recall the original code from
Tobin way back had some smp_wmb() just like this, but it got removed and
replaced with that static branch. So at least somebody felt differently
about it. Which means it'll probably be a whole discussion with more
people, and I'm probably not the right person to lead that.

> Well, your approach with static_key is fine as well. Feel free
> to use:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>

Okay, I'll do this. And then let's circle around the memory barriers
whenever you feel like it later.

Jason
