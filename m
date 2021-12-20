Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA747B639
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhLTXkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:40:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLTXkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:40:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A88876133B;
        Mon, 20 Dec 2021 23:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18866C36AE8;
        Mon, 20 Dec 2021 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640043631;
        bh=4O3guiBHX3KqjqKfpW4bNoYSnEh6sqzg0PvP+9IXRkI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D7XG9BEWiIvcnpi7P+RJE/trXvfVEqKMTtZaVChXycVYylna5OVQ21DqwlKl0wf7Y
         /D3JlxDuhWKQ51eVU/jE/w8VlzSx7SxcS168I0y0lRkipjAIJ5vmB7EX8qJwQQ7pYO
         9MjhFN12pOX7b8RKQswiWzP6DK/tHmstJFJiajg0OhuyGWTh+AevNoC4Tfd6VSSS2H
         7WY+DpmyMnoMPP9zEcqs+ebZIT03mi86hg0lp7pmyLH49I22prCpQqJbijxMYewWwP
         WNfGm+UMqdIvDSJB6S419CdXVUpBig1pv6XvVmqGcxvBVa8QwBZ9wPm7wMm3a+7aAO
         YBpXb62jBw1LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D56F75C0527; Mon, 20 Dec 2021 15:40:30 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:40:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 0/2] random: fix some data races
Message-ID: <20211220234030.GH641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211220224157.111959-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220224157.111959-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:41:55PM -0600, Eric Biggers wrote:
> This series fixes some data races in random.c.
> 
> Changed v1 => v2:
>    - Remove unneeded 'inline' keywords
>    - Use READ_ONCE() instead of smp_load_acquire()
>    - Updated commit message
>    - Added patch to fix data race on crng init time
> 
> Eric Biggers (2):
>   random: fix data race on crng_node_pool
>   random: fix data race on crng init time

From a memory-ordering viewpoint:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

>  drivers/char/random.c | 61 +++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> -- 
> 2.34.1
> 
