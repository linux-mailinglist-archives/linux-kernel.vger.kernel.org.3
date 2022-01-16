Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0F48FD3E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiAPNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:45:18 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53490 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiAPNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:45:09 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5A81C200278;
        Sun, 16 Jan 2022 13:45:07 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DD94A80354; Sun, 16 Jan 2022 14:24:55 +0100 (CET)
Date:   Sun, 16 Jan 2022 14:24:55 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 4/7] random: remove unused reserved argument
Message-ID: <YeQcpzxKWLuJ9Kcz@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220113154413.29513-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113154413.29513-5-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Jan 13, 2022 at 04:44:10PM +0100 schrieb Jason A. Donenfeld:
> This argument is always set to zero, as a result of us not caring about
> keeping a certain amount reserved in the pool these days. So just remove
> it and cleanup the function signatures.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I'd suggest noting in the patch title and commit message that this relates
to the extract_entropy() function. 


> @@ -1342,7 +1341,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
>  	/* never pull more than available */
>  	have_bytes = entropy_count >> (ENTROPY_SHIFT + 3);
>  
> -	if ((have_bytes -= reserved) < 0)
> +	if (have_bytes < 0)
>  		have_bytes = 0;
>  	ibytes = min_t(size_t, ibytes, have_bytes);

Hmm. We already WARN_ON(entropy_count < 0) a few lines below. Maybe move
that assertion before the assignement of have_bytes? Then, have_bytes can
never be lower than zero, and the code becomes even simpler. What do you
think?


	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
