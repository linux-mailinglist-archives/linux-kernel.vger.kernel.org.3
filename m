Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791914B39E6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiBMG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:57:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiBMG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:07 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0625DE65
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:02 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C7BA42013FE;
        Sun, 13 Feb 2022 06:56:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 366FB80A2B; Sun, 13 Feb 2022 07:55:20 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:55:20 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/3] random: unify early init crng load accounting
Message-ID: <YgirWF8p24lW7+gp@owl.dominikbrodowski.net>
References: <20220212231022.679926-1-Jason@zx2c4.com>
 <20220212231022.679926-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212231022.679926-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Feb 13, 2022 at 12:10:20AM +0100 schrieb Jason A. Donenfeld:
> crng_fast_load() and crng_slow_load() have different semantics:
> 
> - crng_fast_load() xors and accounts with crng_init_cnt.
> - crng_slow_load() hashes and doesn't account.
> 
> However add_hwgenerator_randomness() can afford to hash (it's called
> from a kthread), and it should account. Additionally, ones that can
> afford to hash don't need to take a trylock but can take a normal lock.
> So, we combine these into one function, crng_pre_init_inject(), which
> allows us to control these in a uniform way. This will make it simpler
> later to simplify this all down when the time comes for that.

I thought the call to crng_fast_load() from add_input_randomness() is on its
way out?

Otherwise, patch looks fine:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
