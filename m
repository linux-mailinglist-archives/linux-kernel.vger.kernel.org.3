Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3D473857
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbhLMXSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243871AbhLMXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:18:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB5C061574;
        Mon, 13 Dec 2021 15:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DE9B816E1;
        Mon, 13 Dec 2021 23:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8922AC34600;
        Mon, 13 Dec 2021 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639437519;
        bh=Z80p1A+c7fVAB/CaA/qq8wArc2yUp77Z05L1Jot+bdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geQ8GJP7yM5QJRI/uDH+qvxlOz23r8gwJeWPPEXDoEUhgQ+FPbejV65NBdsvxsldl
         tGnbSStsG4uxcYm0n8RDalA+r5YjYh+WTpNSffAT60QIiKqHxYPnwUZVAHzgG0ptMk
         eNwN/IGHFd9rh6k0E3BBZOo9/U6O4PaoTC6JmP4mVmO0nwtn/y+CabTv7kS0jsdlCw
         +q0vn2StlpwmkpVGvoVA1KQORDP88fhwdS+ri8jHGQKm6t3uGZfpg+WqlJDZuB8Smk
         sMkEO+seRBnqLyWzvM2tiiBkfIYB0w4sYlNawBNP5b7h1Cg7oR+Jykuq3jiRUFDuT2
         OC1hRArNQlo8g==
Date:   Mon, 13 Dec 2021 17:24:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] media: omap3isp: Use struct_group() for memcpy() region
Message-ID: <20211213232416.GA60133@embeddedor>
References: <20211118184352.1284792-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118184352.1284792-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:43:52AM -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields. Wrap the target region
> in struct_group(). This additionally fixes a theoretical misalignment
> of the copy (since the size of "buf" changes between 64-bit and 32-bit,
> but this is likely never built for 64-bit).
> 
> FWIW, I think this code is totally broken on 64-bit (which appears to
> not be a "real" build configuration): it would either always fail (with
> an uninitialized data->buf_size) or would cause corruption in userspace
> due to the copy_to_user() in the call path against an uninitialized
> data->buf value:
> 
> omap3isp_stat_request_statistics_time32(...)
>     struct omap3isp_stat_data data64;
>     ...
>     omap3isp_stat_request_statistics(stat, &data64);
> 
> int omap3isp_stat_request_statistics(struct ispstat *stat,
>                                      struct omap3isp_stat_data *data)
>     ...
>     buf = isp_stat_buf_get(stat, data);
> 
> static struct ispstat_buffer *isp_stat_buf_get(struct ispstat *stat,
>                                                struct omap3isp_stat_data *data)
> ...
>     if (buf->buf_size > data->buf_size) {
>             ...
>             return ERR_PTR(-EINVAL);
>     }
>     ...
>     rval = copy_to_user(data->buf,
>                         buf->virt_addr,
>                         buf->buf_size);
> 
> Regardless, additionally initialize data64 to be zero-filled to avoid
> undefined behavior.
> 
> Fixes: 378e3f81cb56 ("media: omap3isp: support 64-bit version of omap3isp_stat_data")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/media/platform/omap3isp/ispstat.c |  5 +++--
>  include/uapi/linux/omap3isp.h             | 21 +++++++++++++--------
>  2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
> index 5b9b57f4d9bf..68cf68dbcace 100644
> --- a/drivers/media/platform/omap3isp/ispstat.c
> +++ b/drivers/media/platform/omap3isp/ispstat.c
> @@ -512,7 +512,7 @@ int omap3isp_stat_request_statistics(struct ispstat *stat,
>  int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
>  					struct omap3isp_stat_data_time32 *data)
>  {
> -	struct omap3isp_stat_data data64;
> +	struct omap3isp_stat_data data64 = { };
>  	int ret;
>  
>  	ret = omap3isp_stat_request_statistics(stat, &data64);
> @@ -521,7 +521,8 @@ int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
>  
>  	data->ts.tv_sec = data64.ts.tv_sec;
>  	data->ts.tv_usec = data64.ts.tv_usec;
> -	memcpy(&data->buf, &data64.buf, sizeof(*data) - sizeof(data->ts));
> +	data->buf = (uintptr_t)data64.buf;

Shouldn't this be

	data->buf = (uintptr_t)(void *)data64.buf;

instead?

--
Gustavo

> +	memcpy(&data->frame, &data64.frame, sizeof(data->frame));
>  
>  	return 0;
>  }
> diff --git a/include/uapi/linux/omap3isp.h b/include/uapi/linux/omap3isp.h
> index 87b55755f4ff..9a6b3ed11455 100644
> --- a/include/uapi/linux/omap3isp.h
> +++ b/include/uapi/linux/omap3isp.h
> @@ -162,6 +162,7 @@ struct omap3isp_h3a_aewb_config {
>   * struct omap3isp_stat_data - Statistic data sent to or received from user
>   * @ts: Timestamp of returned framestats.
>   * @buf: Pointer to pass to user.
> + * @buf_size: Size of buffer.
>   * @frame_number: Frame number of requested stats.
>   * @cur_frame: Current frame number being processed.
>   * @config_counter: Number of the configuration associated with the data.
> @@ -176,10 +177,12 @@ struct omap3isp_stat_data {
>  	struct timeval ts;
>  #endif
>  	void __user *buf;
> -	__u32 buf_size;
> -	__u16 frame_number;
> -	__u16 cur_frame;
> -	__u16 config_counter;
> +	__struct_group(/* no type */, frame, /* no attrs */,
> +		__u32 buf_size;
> +		__u16 frame_number;
> +		__u16 cur_frame;
> +		__u16 config_counter;
> +	);
>  };
>  
>  #ifdef __KERNEL__
> @@ -189,10 +192,12 @@ struct omap3isp_stat_data_time32 {
>  		__s32	tv_usec;
>  	} ts;
>  	__u32 buf;
> -	__u32 buf_size;
> -	__u16 frame_number;
> -	__u16 cur_frame;
> -	__u16 config_counter;
> +	__struct_group(/* no type */, frame, /* no attrs */,
> +		__u32 buf_size;
> +		__u16 frame_number;
> +		__u16 cur_frame;
> +		__u16 config_counter;
> +	);
>  };
>  #endif
>  
> -- 
> 2.30.2
> 
> 
> 
> 
