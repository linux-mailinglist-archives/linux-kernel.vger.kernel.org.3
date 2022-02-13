Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C24B39E3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiBMG53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:57:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiBMG5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:10 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B45DE65
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:05 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 246FC201417;
        Sun, 13 Feb 2022 06:57:00 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 707DF80871; Sun, 13 Feb 2022 07:54:07 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:54:07 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 04/10] random: group initialization wait functions
Message-ID: <YgirDzvwEYRwvLHS@owl.dominikbrodowski.net>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-5-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Returns whether or not the urandom pool has been seeded and thus guaranteed
> + * to supply cryptographically secure random numbers. This applies to: the
> + * /dev/urandom device, the get_random_bytes function, and the get_random_{u32,
> + * ,u64,int,long} family of functions.
> + *
> + * Returns: true if the urandom pool has been seeded.
> + *          false if the urandom pool has not been seeded.

I think this comment should be updated, as there is no "urandom pool";
instead we should refer to the  "random pool" or the "random base pool".

> +/*
> + * Wait for the urandom pool to be seeded and thus guaranteed to supply
> + * cryptographically secure random numbers. This applies to: the /dev/urandom
> + * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
> + * family of functions. Using any of these functions without first calling
> + * this function forfeits the guarantee of security.
> + *
> + * Returns: 0 if the urandom pool has been seeded.
> + *          -ERESTARTSYS if the function was interrupted by a signal.

Same here.

> +/*
> + * Add a callback function that will be invoked when the nonblocking
> + * pool is initialised.

Same here ("nonblocking pool").

Other than that, looks fine.

Thanks,
	Dominik
