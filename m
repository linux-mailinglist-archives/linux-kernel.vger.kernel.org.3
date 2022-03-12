Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7E4D70AF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiCLUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiCLUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:10:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3728E5A0B2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:09:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0F8FB80184
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 20:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F2AC340EB;
        Sat, 12 Mar 2022 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647115765;
        bh=b9jb1rCoyEDj7gVWncPzm9o0K4cPIjdFW4hxASp/f/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LV+eMpVbBgkx71pC8YbN5jrQ0l7YavOJpdTOYsY+IidDAIyJXesntz8G/a/1kVWWn
         OM+l4ews+7y5WKrawwQyBowlCzT8Kr2WL0uxy2rptN8mtShVDI+xpc3qvRkBnpXtdR
         nX5HziFIrm0avu20hiMUavblnTADE68PTmYPS9/mJPJUhKWc9vu2a7FsshyQfSZDG1
         wngTdlZy9zL5zeSnUjQbK3+7fLGd/qjENlXMcq+jrTqlYosdsaA6FK9p3cm41hueZK
         EDZStG7Ag65yD5G/PzBt/txoHbiVrXodd7I+TFISZDFTY3XP6C1mPKAVakTxFJqWmY
         3Wxc8b6rY271Q==
Date:   Sat, 12 Mar 2022 12:09:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: make consistent usage of crng_ready()
Message-ID: <Yiz98wP1hiPR5Azm@sol.localdomain>
References: <20220308182517.273662-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308182517.273662-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:25:17AM -0700, Jason A. Donenfeld wrote:
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 69591d599338..e37ae7ef039c 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -123,7 +123,7 @@ static void try_to_generate_entropy(void);
>   */
>  int wait_for_random_bytes(void)
>  {
> -	if (likely(crng_ready()))
> +	if (crng_ready())
>  		return 0;
>  
>  	do {
...
>  	} while (!crng_ready());

I guess the reason why the above doesn't simply use a 'while' loop is because
someone wanted 'likely()' on the first crng_ready()?  That doesn't actually
apply, since crng_ready() has likely() itself, it should just be a 'while' loop.

- Eric
