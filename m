Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60E48FD40
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiAPNpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:45:22 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53492 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbiAPNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:45:09 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4B65520000E;
        Sun, 16 Jan 2022 13:45:07 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 421B5803E1; Sun, 16 Jan 2022 14:24:59 +0100 (CET)
Date:   Sun, 16 Jan 2022 14:24:59 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 5/7] random: rather than entropy_store abstraction, use
 global
Message-ID: <YeQcq0akOPjUU5gW@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220113154413.29513-6-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113154413.29513-6-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void __mix_pool_bytes(struct entropy_store *r, const void *in,
> -			     int nbytes)
> +static void __mix_pool_bytes(const void *in, int nbytes)
>  {
> -	trace_mix_pool_bytes_nolock(r->name, nbytes, _RET_IP_);
> -	_mix_pool_bytes(r, in, nbytes);
> +	trace_mix_pool_bytes_nolock(nbytes, _RET_IP_);
> +	_mix_pool_bytes(in, nbytes);

Can the parameters of these tracepoints be modified, or does this break
any part of our API?

I haven't looked at the tracepoint bits in detail; otherwise, the changes
look good:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net> # random.c only

Thanks,
	Dominik
