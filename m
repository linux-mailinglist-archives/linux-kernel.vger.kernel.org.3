Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25F4BD3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbiBUCd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:33:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343766AbiBUCd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:33:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501D443E4;
        Sun, 20 Feb 2022 18:33:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92D16B80E49;
        Mon, 21 Feb 2022 02:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39195C340E8;
        Mon, 21 Feb 2022 02:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645410781;
        bh=bvqZ+cJu3gckOWW9wZ9LaHx00GsHlZJ8l045euQ7+n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSktZQ0kmYWeyhc5AyXYasTpRJpIY6H8hM+zQQm6w0sOceWDT75KA1Kyjs/lIR3U7
         y7BDOHFDR9hqsbO3rAmQNskda4KxuUT+d8QGSk8dVj7/gQORqZac8fee4kt7bIXZPa
         A9KueAWQ8TXWOSI84QJia8b0cEV51IMAuGwcYJDAwClA0ydd1DAuh0Nig334XhLfV5
         N0qeQeCzxlEZ7h2sg41ZrltWgfmFoz4WGhil/ZVZD/OddgeKbHsWjhbQbFZ1oobJ+X
         gPagTcDGoOL2t17MPunVZ2b4nD/4qcl87QmQsazscEmhBoGq2s8EITcyvlBoAtafE5
         TYGUikfViAC5g==
Date:   Sun, 20 Feb 2022 18:32:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] random: fix locking in crng_fast_load()
Message-ID: <YhL527P1sEjpu3R2@sol.localdomain>
References: <20220205103458.133386-1-linux@dominikbrodowski.net>
 <20220205103458.133386-2-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205103458.133386-2-linux@dominikbrodowski.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 11:34:57AM +0100, Dominik Brodowski wrote:
> crng_init is protected by primary_crng->lock, so keep holding that lock
> when incrementing crng_init from 0 to 1 in crng_fast_load(). The call to
> pr_notice() can wait until the lock is released; this code path cannot
> be reached twice, as crng_fast_load() aborts early if crng_init > 0.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  drivers/char/random.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
