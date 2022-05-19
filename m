Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A052E060
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245746AbiESXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbiESXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D31053F2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3235761888
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2B1C36AF5;
        Thu, 19 May 2022 23:12:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DE7K6Whm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653001927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VdrDpD0tLfl85nsklXAWL6SMKzi5GMiDFp0ijEM7df8=;
        b=DE7K6Whmj3mBtJ0YWsVxGXufXavxq55vjTRKit4nDgbWdOVTFZtYOIr+yC7V3jU+ZEJ54/
        oYKkFYQYTT7W4bkWmDhGn+AflydbJCeKZwpNCedylXCEWx6Z7SALPMnaJ6USi5NV39VZE0
        fbvhTGkar+8qHQdsaEBhHUQ5nY/wXyE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3cafe43 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 19 May 2022 23:12:06 +0000 (UTC)
Date:   Fri, 20 May 2022 01:12:04 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] random: convert to using fops->read_iter()
Message-ID: <YobOxLKnRDyYChXS@zx2c4.com>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <20220519193133.194138-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519193133.194138-2-axboe@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, May 19, 2022 at 01:31:32PM -0600, Jens Axboe wrote:
>  	for (;;) {
>  		chacha20_block(chacha_state, output);
>  		if (unlikely(chacha_state[12] == 0))
>  			++chacha_state[13];
>  
>  		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
> -		left = copy_to_user(ubuf, output, block_len);
> -		if (left) {
> -			ret += block_len - left;
> +		block_len = copy_to_iter(output, block_len, to);
> +		if (!block_len)
>  			break;
> -		}
>  
> -		ubuf += block_len;
>  		ret += block_len;
>  		len -= block_len;
> -		if (!len)
> -			break;
>  
>  		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
>  		if (ret % PAGE_SIZE == 0) {
>  			if (signal_pending(current))
>  				break;
>  			cond_resched();
>  		}
>  	}

This isn't quite the same, is it? Before, it would immediately break out
of the loop on any short copy. Now, it will only break out on a zero
copy, which means it's possible that ret % PAGE_SIZE == 0, and there'll
be an unnecessary cond_resched() before copy_to_iter() runs again and
then breaks.

Jason
