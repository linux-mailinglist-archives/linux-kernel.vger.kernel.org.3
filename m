Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2C4BD5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiBUFvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:51:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344759AbiBUFvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:51:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4048F50E3B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:50:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE5860ACA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D90C340E9;
        Mon, 21 Feb 2022 05:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645422639;
        bh=P6LWB/6wJ3LWwY/7PjOI8cGej0WPooK3P5KRVug1JEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i94N58+xO6xCt9iL5ZioHY/6CarlvPruoFJeTkZv5tBXNpCOXJKfqu7Vdln0u5fU9
         uRH+xDoNj2j0mzWNsxlVR7Kxp4DdyTO142IWZmGnYlq1rP9qh9lRgColmufNBDVW9M
         pWPNtUauYXk9PdjKj5RRZPV5eAPppD8s4hA5XURo0LMYhUe3KbtHXmnvZRNT7XPhDt
         k9mlOwGV3AolO4ML3euylrPqHR5B260PC/2NtuXWdxNSlW9MMPPM2QgYL75pKL9lOk
         oQXAVZBJg3gSp36bRezM6UxrIZQP5/1OFc3SqBZTbTdI9V50VsnhXAlBIWsWw2L0PO
         +3mfPcpX1tjzA==
Date:   Sun, 20 Feb 2022 21:50:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/3] random: unify early init crng load accounting
Message-ID: <YhMoLad2U2zJVTyo@sol.localdomain>
References: <20220212231022.679926-1-Jason@zx2c4.com>
 <20220212231022.679926-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212231022.679926-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 12:10:20AM +0100, Jason A. Donenfeld wrote:
> -static size_t crng_fast_load(const void *cp, size_t len)
> +static size_t crng_pre_init_inject(const void *cp, size_t len,
> +				   bool fast, bool account)

This would be a good chance to rename 'cp' to something more usual, like 'in'.

Also, there's still a mention of "crng_{fast,slow}_load" in crng_make_state().

> +	const u8 *src = cp;
> +
> +	if (fast) {
> +		if (!spin_trylock_irqsave(&base_crng.lock, flags))
> +			return 0;
> +	} else
> +		spin_lock_irqsave(&base_crng.lock, flags);

Nit: the kernel coding style requires braces around the else clause here.

- Eric
