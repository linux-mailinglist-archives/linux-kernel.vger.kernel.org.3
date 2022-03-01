Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F244C82E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiCAFUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCAFUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:20:46 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DFC580D5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 21:20:05 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1BA9E201342;
        Tue,  1 Mar 2022 05:20:03 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D4A0780858; Tue,  1 Mar 2022 06:16:38 +0100 (CET)
Date:   Tue, 1 Mar 2022 06:16:38 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/2] random: don't let 644 read-only sysctls be written to
Message-ID: <Yh2sNtnBLt6HL/mw@owl.dominikbrodowski.net>
References: <20220228133743.2243-1-Jason@zx2c4.com>
 <20220228133743.2243-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228133743.2243-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Feb 28, 2022 at 02:37:43PM +0100 schrieb Jason A. Donenfeld:
> We leave around these old sysctls for compatibility, and we keep them
> "writable" for compatibility, but even after writing, we should keep
> reporting the same value. This is consistent with how userspaces tend to
> use sysctl_random_write_wakeup_bits, writing to it, and then later
> reading from it and using the value.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 116ebf50d791..06c6e15b5f3d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1669,6 +1669,13 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buffer,
>  	return proc_dostring(&fake_table, 0, buffer, lenp, ppos);
>  }
>  
> +/* The same as proc_dointvec, but writes don't change anything. */
> +static int proc_do_rointvec(struct ctl_table *table, int write, void *buffer,
> +			    size_t *lenp, loff_t *ppos)
> +{
> +	return write ? 0 : proc_dointvec(table, write, buffer, lenp, ppos);
> +}

While it would be better if we could return -EINVAL or something like that,
I see the point of this patch:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
