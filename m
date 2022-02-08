Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6814AE594
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiBHXoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiBHXo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:44:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2770C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97BBEB81DB5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123CAC004E1;
        Tue,  8 Feb 2022 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644363865;
        bh=cR+ULfFQ6WBrXBJ0KAj9oQfc/nEUAc3t664hCR1VpV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=au3oGqMAYQU0Oerx3qI/4+O7y1KpQGPEF0nrdR6pd8jSQbg0n1ue/yh8WRe9vr/mQ
         tEa8PkCp1/T0g6k720t2a2HZEnv/RWYo7eRqeBEK3K2Cx+mO2jTa8aCXwBVFqE4bhK
         QSFUV/bHlRV7RQchp5eWj0X7N+Lyznj0gpPC7Fj+SrjAMmGjm1Pk+RhPmHMgNY5rle
         tR3/sD5ib+BqXKmqAy/6BOPxTknubevt3U/6kJwJvx5xTtAybWiYLhBF/R+gR158cl
         TvjtQCbNu11prXOB5UmD2q6sP50X1HzChMILzAv4HzF9RTt6/zU6KqvBj7RfptKu/r
         ufoy5/Zc4WCiQ==
Date:   Tue, 8 Feb 2022 15:44:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH v3 1/2] random: remove batched entropy locking
Message-ID: <YgMAV2Ps/k80w48M@sol.localdomain>
References: <20220207153914.365931-1-Jason@zx2c4.com>
 <20220207153914.365931-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207153914.365931-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:39:13PM +0100, Jason A. Donenfeld wrote:
> Rather than use spinlocks to protect batched entropy, we can instead
> disable interrupts locally, since we're dealing with per-cpu data, and
> manage resets with a basic generation counter. At the same time, we
> can't quite do this on PREEMPT_RT, where we still want spinlocks-as-
> mutexes semantics. So we use a local_lock_t, which provides the right
> behavior for each. Because this is a per-cpu lock, that generation
> counter is still doing the necessary CPU-to-CPU communication.
> 
> This should improve performance a bit. It will also fix the linked splat
> that Jonathan received with a PROVE_RAW_LOCK_NESTING=y.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Reported-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Tested-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Link: https://lore.kernel.org/lkml/YfMa0QgsjCVdRAvJ@latitude/
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 51 ++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 25 deletions(-)

Looks good.  The comment above invalidate_batched_entropy() needs to be updated,
though.

Also, please Cc patches for random.c to linux-crypto.

- Eric
