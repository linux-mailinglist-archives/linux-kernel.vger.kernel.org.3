Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4CA4AF0EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiBIMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiBIMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:15 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95FDC076859;
        Wed,  9 Feb 2022 03:16:32 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 74A4D201431;
        Wed,  9 Feb 2022 08:31:16 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 5B8518065D; Wed,  9 Feb 2022 09:28:40 +0100 (CET)
Date:   Wed, 9 Feb 2022 09:28:40 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, ebiggers@kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 5/9] random: do not xor RDRAND when writing into
 /dev/random
Message-ID: <YgN7OKSJRNZNxuGm@owl.dominikbrodowski.net>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-6-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-6-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Feb 09, 2022 at 02:19:15AM +0100 schrieb Jason A. Donenfeld:
> Continuing the reasoning of "random: ensure early RDSEED goes through
> mixer on init", we don't want RDRAND interacting with anything without
> going through the mixer function, as a backdoored CPU could presumably
> cancel out data during an xor, which it'd have a harder time doing when
> being forced through a cryptographic hash function. There's actually no
> need at all to be calling RDRAND in write_pool(), because before we
> extract from the pool, we always do so with 32 bytes of RDSEED hashed in
> at that stage. Xoring at this stage is needless and introduces a minor
> liability.

Looks good generally, just one unrelated change slipped in:

>  		bytes = min(count, sizeof(buf));
> -		if (copy_from_user(&buf, p, bytes))
> +		if (copy_from_user(buf, p, bytes))
>  			return -EFAULT;

Otherwise:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
