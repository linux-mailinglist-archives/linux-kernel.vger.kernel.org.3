Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942BA4BD4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiBUFBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:01:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBUFBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:01:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97301443E1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:00:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F3B611C1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AB2C340E9;
        Mon, 21 Feb 2022 05:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645419648;
        bh=/qAyC0tU1D8M/i6ApYcHygtrtCpo+lWb1lQXeoSP/zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McSO/3xGqzaewex3EegJpxO0UPYD/nZVnMj1EITQLRnLkpkmr0l1sCPfB8QM+vNMc
         wgOQJwQ8SStyBhtYlvCDNUDM3l67Eu05GAXjm5M4lq3adUznXEpvh/LGVuVAjJlHIk
         p/6Lg6vXYUrfJlp/NbkRGqRy1I7PUJVgeZsksif4X5NsALmlTBeGfLC7ZvGpYtuc9K
         4fyCY4M72P2ARNSD6tq7J6djP0cnlKTKZRkM9Q4FrmJs/6smryr7+iF3y+ljs5o+LU
         /1mRFwnvR5ipL2v+28vwFUSWi09u0csy//FoxvaXPdBolPIapVUlv2F/QV6VJUixUx
         dzvm1yd85zQaA==
Date:   Sun, 20 Feb 2022 21:00:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 05/10] random: group crng functions
Message-ID: <YhMcf2/xCdcgVjzK@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-6-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-6-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:13PM +0100, Jason A. Donenfeld wrote:
> -	/* We copy the new key into the base_crng, overwriting the old one,
> +	/*
> +	 * We copy the new key into the base_crng, overwriting the old one,
>  	 * and update the generation counter. We avoid hitting ULONG_MAX,
>  	 * because the per-cpu crngs are initialized to ULONG_MAX, so this
>  	 * forces new CPUs that come online to always initialize.
> @@ -635,13 +472,11 @@ static void crng_reseed(void)

Overall looks good, but it's not ideal seeing comments reformatted like this
rather than doing them the right way from the beginning.

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
