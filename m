Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA46529E82
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiEQJxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiEQJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F5631343
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B584161544
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF6BC385B8;
        Tue, 17 May 2022 09:53:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cUA+r6l1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652781226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uufBfqp+dyikrgi7EQF08HCobGO63jPO+3+qprnr4ZU=;
        b=cUA+r6l1Sc1LKKGUOr/b1cKwOG5+4MPmKIK3H/8IhW1D/10PLknxorQJLVvbBU52u0GGv/
        22WFqYOSAaP6vpNbHDRA+ZKAWAufJ54eB97xygqA2glRa/nTGOwpGAc8OwYBMeJsuavIG2
        IrPMOQPNc3qbOIVne7oPqYxi7aGZRj8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4ef7c049 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 17 May 2022 09:53:46 +0000 (UTC)
Date:   Tue, 17 May 2022 11:53:43 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Use sched_clock() for random numbers.
Message-ID: <YoNwp+9ko89Tf1ep@zx2c4.com>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoNn3pTkm5+QzE5k@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Interesting RT consideration. I hope there aren't too many of these
special cases that would necessitate a general mechanism. Fingers
crossed this is the only one.

On Tue, May 17, 2022 at 11:16:14AM +0200, Sebastian Andrzej Siewior wrote:
> -			cookie.val = 1 + (prandom_u32() >> 16);
> +			cookie.val = 1 + (sched_clock() & 0xffff);
>  			hlock->pin_count += cookie.val;
 
I have no idea what the requirements here are. What would happen if you
just did atomic_inc_return(&some_global) instead? That'd be faster
anyhow, and it's not like 16 bits gives you much variance anyway...

Jason
