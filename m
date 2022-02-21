Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2464BD3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbiBUCbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:31:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245416AbiBUCbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:31:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B0443D9;
        Sun, 20 Feb 2022 18:30:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D99B80DAA;
        Mon, 21 Feb 2022 02:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B475C340E8;
        Mon, 21 Feb 2022 02:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645410643;
        bh=2uZ8sUorAwc5X3MugMskJmqF4rEOcD2jddBSqZuXQ94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4p4Olw7vCl4s6q6MSZpDlvKV/OoTwTavJHkHfDKou9FFFeX4dwMnS68tB/2h0TPM
         eQLy4baewlJdqhFvQxmmpRnVqrIFSLlOG7ap4E+wwlGs9IXSkWAy0j7LUDApSP61k4
         qB7BzfIPtLdWa7QqnKuTEeFTyVmRtKfLJ+jzOq6Vx3xX+v33aShYjsQP42Q2IlR6/s
         JRCe3aKugs6BxFTzdyzKkxfe/sNK1qVoo2jnrlMpSskaZhMG5hJi5bhnSHxKgzJEJ/
         rXgwpbDNJ6JgM0dlKfNayyGmJcg5krpGZyr4OCzcgrHSqHyg2yzwC134TX2aAtXw1w
         YM31HHbU1No9A==
Date:   Sun, 20 Feb 2022 18:30:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 1/2] random: remove batched entropy locking
Message-ID: <YhL5Ur59uC+HQOY+@sol.localdomain>
References: <20220209125644.533876-1-Jason@zx2c4.com>
 <20220209125644.533876-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220209125644.533876-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 01:56:43PM +0100, Jason A. Donenfeld wrote:
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
>  drivers/char/random.c | 55 ++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
