Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5824D4BD54D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbiBUFWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:22:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbiBUFWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:22:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EFE29
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:21:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10AEC611D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D43C340E9;
        Mon, 21 Feb 2022 05:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645420910;
        bh=tKN5lVyIdydcnMmzW64HD2z0D7NvvLEpCWMv4HHhS28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJWZqcwnKTigFSQ0X3zkh+yU4KUaaNYY6gvjHaoX1gSSBIaIg/ImpEndvQ0sPuQCR
         SCFcfXQSWZWctVg4925sAhZMotxz9dHJMwQEADk7ybd5KXI/0hoI7DGqFKKC6P4Gi1
         BEKHnD7Hz0C80E0cHLkJtZJCL6V8IqSG+ruyu8lzkJKMhV8blIZjiJU6RClSo7M3dF
         KYe3QpJFOpTyTVUyjkslYpQBOPPN/WyxaVWWeAvkOhHoH6dTRHlFAA0x5xXhxWpM61
         suDQDipcc574Tx7uuWTq6Y+h3MfsSSzaeGsHIWj9y8JJb9SNlLzx/ZMxMVxBNLhcL1
         Pn5GatbQFdnew==
Date:   Sun, 20 Feb 2022 21:21:48 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 09/10] random: group sysctl functions
Message-ID: <YhMhbKdIH2wwEDxc@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-10-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-10-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:17PM +0100, Jason A. Donenfeld wrote:
> This pulls all of the sysctl-focused functions into the sixth labeled
> section.
> 
> No functional changes.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index b2af2dc96d20..a32176a46691 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1678,9 +1678,34 @@ const struct file_operations urandom_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> +
>  /********************************************************************
>   *
> - * Sysctl interface
> + * Sysctl interface.
> + *
> + * These are partly unused legacy knobs with dummy values to not break
> + * userspace and partly still useful things. They are usually accessible
> + * in /proc/sys/kernel/random/ and are as follows:
> + *
> + * - boot_id - a UUID representing the current boot.
> + *
> + * - uuid - a random UUID, different each time the file is read.
> + *
> + * - poolsize - the number of bits of entropy that the input pool can
> + *   hold, tied to the POOL_BITS constant.
> + *
> + * - entropy_avail - the number of bits of entropy currently in the
> + *   input pool. Always <= poolsize.
> + *
> + * - write_wakeup_threshold - the amount of entropy in the input pool
> + *   below which write polls to /dev/random will unblock, requesting
> + *   more entropy, tied to the POOL_MIN_BITS constant. It is writable
> + *   to avoid breaking old userspaces, but writing to it does not
> + *   change any behavior of the RNG.
> + *
> + * - urandom_min_reseed_secs - fixed to the meaningless value "60".
> + *   It is writable to avoid breaking old userspaces, but writing
> + *   to it does not change any behavior of the RNG.
>   *

This is a nice explanation, but shouldn't
Documentation/admin-guide/sysctl/kernel.rst be updated instead, and this comment
point to there?

>  device_initcall(random_sysctls_init);
> -#endif	/* CONFIG_SYSCTL */
> +#endif

Nit: I'd prefer leaving the comment for the #endif.

- Eric
