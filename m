Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB72548411F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiADLpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:45:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46890 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:44:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5590B811B9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0152FC36AEB;
        Tue,  4 Jan 2022 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641296696;
        bh=rt7HXTxnuZT1rpjkZhIX8/hMCh79mc/hiWSjY0oxjFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTt/+iMWHRSeMa0noAy/M9rcXenzs/mLZPHbMDTfDVlWUc2PcB0VcfgSFDCxe8e8D
         Gc/lMtRQsdV6NbPpotGya3nnbCqwc3MB0aKeDDrnr9Q8SoVyW4y9SCNyBtWi0fg87f
         n/o/7MX3zr1bSSSBXlfR3jvB1sr30ysbOXgTESp8=
Date:   Tue, 4 Jan 2022 12:44:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers/android: remove redundant ret variable
Message-ID: <YdQzNX77nT2OIh7W@kroah.com>
References: <20220104113500.602158-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104113500.602158-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 11:35:00AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from list_lru_count() directly instead
> of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/android/binder_alloc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 340515f54498..4f221d1839f4 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1049,18 +1049,14 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  static unsigned long
>  binder_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> -	unsigned long ret = list_lru_count(&binder_alloc_lru);
> -	return ret;
> +	return list_lru_count(&binder_alloc_lru);
>  }
>  
>  static unsigned long
>  binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  {
> -	unsigned long ret;
> -
> -	ret = list_lru_walk(&binder_alloc_lru, binder_alloc_free_page,
> +	return list_lru_walk(&binder_alloc_lru, binder_alloc_free_page,
>  			    NULL, sc->nr_to_scan);
> -	return ret;

Is the compiler output any different?

If not, why make this change?

What did you use to test this change is equivalent?

thanks,

greg k-h
