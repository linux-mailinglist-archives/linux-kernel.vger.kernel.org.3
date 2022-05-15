Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81724527741
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 13:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiEOLNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEOLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 07:13:35 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835542CE1A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 04:13:34 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8E89F20000E;
        Sun, 15 May 2022 11:13:31 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 7493C80051; Sun, 15 May 2022 13:13:28 +0200 (CEST)
Date:   Sun, 15 May 2022 13:13:28 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: move initialization functions out of hot pages
Message-ID: <YoDgWDBJaXWHv/R6@owl.dominikbrodowski.net>
References: <20220513142908.341220-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513142908.341220-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, May 13, 2022 at 04:29:08PM +0200 schrieb Jason A. Donenfeld:
> Much of random.c is devoted to initializing the rng and accounting for
> when a sufficient amount of entropy has been added. In a perfect world,
> this would all happen during init, and so we could mark these functions
> as __init. But in reality, this isn't the case: sometimes the rng only
> finishes initializing some seconds after system init is finished.
> 
> For this reason, at the moment, a whole host of functions that are only
> used relatively close to system init and then never again are intermixed
> with functions that are used in hot code all the time. This creates more
> cache misses than necessary.
> 
> In order to pack the hot code closer together, this commit moves the
> initialization functions that can't be marked as __init into
> .text.unlikely by way of the __cold attribute.
> 
> Of particular note is moving credit_init_bits() into a macro wrapper
> that inlines the crng_ready() static branch check. This avoids a
> function call to a nop+ret, and most notably prevents extra entropy
> arithmetic from being computed in mix_interrupt_randomness().

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
