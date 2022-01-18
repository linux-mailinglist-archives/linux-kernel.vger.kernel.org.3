Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0A492ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiART7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:59:36 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.109]:14202 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348986AbiART7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:59:35 -0500
X-Greylist: delayed 1498 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 14:59:35 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 026D51A6F4D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:11:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9tnVndUiQRnrr9tnVn1CpC; Tue, 18 Jan 2022 13:05:37 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=62lwA313ylYvMl776J0nmotREsLRnHNHGefb4h0dvoo=; b=PyiVKsPlAhwkbLzznyg+KBOywd
        sR3mIPwqE3E0G8CInbrV9M3G8iCwH7MqbVJGhkNV18tD8re3JjQ35Yw5iT63N8odXWGXNt4w2E7Qp
        R12bj3nDKnKpeUy6nnpQEv72BYa4D2F0GXLwSs/jytZy6I1cdm55pDlIN6bh7y0t2P9ZTFSYAXAjY
        QgLeAfhlb5TVG6fv+A+JHfKuJslOWE0B0sqm/ZVJi5LQzt6krt9sHb1aHrwMJ22IyotWi6ryzadzD
        WoRUs4BQGpRp038/cCAQKZC6sLgtAMbEFHpR3CgG71r4m3yhYcip64XkEkz60EMir+GyJFXu2QEQ4
        f/FC+yGw==;
Received: from [187.184.156.46] (port=26621 helo=[192.168.0.21])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1n9tnV-001SJO-46; Tue, 18 Jan 2022 13:05:37 -0600
Subject: Re: [PATCH] drm/dp: Remove common Post Cursor2 register handling
To:     Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220105173507.2420910-1-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <cae904f1-21f4-426f-8831-e122d965b131@embeddedor.com>
Date:   Tue, 18 Jan 2022 13:11:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105173507.2420910-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.156.46
X-Source-L: No
X-Exim-ID: 1n9tnV-001SJO-46
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [187.184.156.46]:26621
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/22 11:35, Kees Cook wrote:
> The link_status array was not large enough to read the Adjust Request
> Post Cursor2 register, so remove the common helper function to avoid
> an OOB read, found with a -Warray-bounds build:
> 
> drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
> drivers/gpu/drm/drm_dp_helper.c:59:27: error: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Werror=array-bounds]
>    59 |         return link_status[r - DP_LANE0_1_STATUS];
>       |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/drm_dp_helper.c:147:51: note: while referencing 'link_status'
>   147 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
>       |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Replace the only user of the helper with an open-coded fetch and decode,
> similar to drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c.
> 
> Fixes: 79465e0ffeb9 ("drm/dp: Add helper to get post-cursor adjustments")

This should be tagged for -stable:

Cc: stable@vger.kernel.org

> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> This is the alternative to:
> https://lore.kernel.org/lkml/20211203084354.3105253-1-keescook@chromium.org/
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 10 ----------
>  drivers/gpu/drm/tegra/dp.c      | 11 ++++++++++-
>  include/drm/drm_dp_helper.h     |  2 --
>  3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 23f9073bc473..c9528aa62c9c 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -144,16 +144,6 @@ u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
>  }
>  EXPORT_SYMBOL(drm_dp_get_adjust_tx_ffe_preset);
>  
> -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> -					 unsigned int lane)
> -{
> -	unsigned int offset = DP_ADJUST_REQUEST_POST_CURSOR2;
> -	u8 value = dp_link_status(link_status, offset);
> -
> -	return (value >> (lane << 1)) & 0x3;
> -}
> -EXPORT_SYMBOL(drm_dp_get_adjust_request_post_cursor);
> -
>  static int __8b10b_clock_recovery_delay_us(const struct drm_dp_aux *aux, u8 rd_interval)
>  {
>  	if (rd_interval > 4)
> diff --git a/drivers/gpu/drm/tegra/dp.c b/drivers/gpu/drm/tegra/dp.c
> index 70dfb7d1dec5..f5535eb04c6b 100644
> --- a/drivers/gpu/drm/tegra/dp.c
> +++ b/drivers/gpu/drm/tegra/dp.c
> @@ -549,6 +549,15 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
>  {
>  	struct drm_dp_link_train_set *adjust = &link->train.adjust;
>  	unsigned int i;
> +	u8 post_cursor;
> +	int err;
> +
> +	err = drm_dp_dpcd_read(link->aux, DP_ADJUST_REQUEST_POST_CURSOR2,
> +			       &post_cursor, sizeof(post_cursor));
> +	if (err < 0) {
> +		DRM_ERROR("failed to read post_cursor2: %d\n", err);
> +		post_cursor = 0;
> +	}
>  
>  	for (i = 0; i < link->lanes; i++) {
>  		adjust->voltage_swing[i] =
> @@ -560,7 +569,7 @@ static void drm_dp_link_get_adjustments(struct drm_dp_link *link,
>  				DP_TRAIN_PRE_EMPHASIS_SHIFT;
>  
>  		adjust->post_cursor[i] =
> -			drm_dp_get_adjust_request_post_cursor(status, i);
> +			(post_cursor >> (i << 1)) & 0x3;
>  	}
>  }
>  
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 472dac376284..fdf3cf6ccc02 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1528,8 +1528,6 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
>  					  int lane);
>  u8 drm_dp_get_adjust_tx_ffe_preset(const u8 link_status[DP_LINK_STATUS_SIZE],
>  				   int lane);
> -u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
> -					 unsigned int lane);
>  
>  #define DP_BRANCH_OUI_HEADER_SIZE	0xc
>  #define DP_RECEIVER_CAP_SIZE		0xf
> 
