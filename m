Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECC51B4C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiEEApu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiEEApq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:45:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588851D0F0;
        Wed,  4 May 2022 17:42:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 5D6FE1F40A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651711327;
        bh=MyOm9L9WGRdUCHRglVPQ6r+0Az2kPrdmLi4U0cgQB+M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OzGMoesSvl76vDw/rGqLDlidJ30q+2p8JVEemntpZj/HiFybMjDA64LAQlAuBXCDv
         ddHuD/R0AiRd0qGdMOQU3IKMpL6cUYyiB31hXaFcPGYOYx15QobmdbztD8c/AXll9M
         lYER4eSv4WHNv/f/509FCX0O9Ua8VzNlrO6VQRjlHwPvWSWIsgIebs3WMHvGbp8N7o
         0lFvG17/neKrcP9HzEJoUMcWLxIwEsnUcmqyLhU9MLmB+usJiGbxRms1is1I5UqkFm
         jgzYyWq1GtDPthuLF7d3zG6wxigGxTqKdnuXjSx809hL8eBmphREbxwV2r+4VMyHZx
         Q8lrF5JxdXuTw==
Message-ID: <dfda7666-7325-f4a1-69b1-6b3cb9701b62@collabora.com>
Date:   Thu, 5 May 2022 03:42:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 05/24] media: h264: Use v4l2_h264_reference for reflist
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
 <20220426125751.108293-6-nicolas.dufresne@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220426125751.108293-6-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 15:57, Nicolas Dufresne wrote:
>  static int tegra_vde_wait_mbe(struct tegra_vde *vde)
> @@ -768,7 +768,7 @@ static int tegra_vde_h264_setup_frames(struct tegra_ctx *ctx,
>  	struct h264_reflists reflists;
>  	struct vb2_buffer *ref;
>  	unsigned int i;
> -	u8 *dpb_id;
> +	struct v4l2_h264_reference *dpb_id;

nit: will be nice to preserve to reverse Xmas coding style, but only if
you'll need to make v5 with more important changes

>  	int err;
>  
>  	/*
> @@ -811,14 +811,16 @@ static int tegra_vde_h264_setup_frames(struct tegra_ctx *ctx,
>  	}
>  
>  	for (i = 0; i < b.num_valid; i++) {
> -		ref = get_ref_buf(ctx, dst, dpb_id[i]);
> +		int dpb_idx = dpb_id[i].index;
>  
> -		err = tegra_vde_h264_setup_frame(ctx, h264, &b, ref, dpb_id[i],
> +		ref = get_ref_buf(ctx, dst, dpb_idx);
> +
> +		err = tegra_vde_h264_setup_frame(ctx, h264, &b, ref, dpb_idx,
>  						 h264->dpb_frames_nb++);
>  		if (err)
>  			return err;
>  
> -		if (b.refs[dpb_id[i]].pic_order_count < b.cur_pic_order_count)
> +		if (b.refs[dpb_idx].top_field_order_cnt < b.cur_pic_order_count)
>  			h264->dpb_ref_frames_with_earlier_poc_nb++;

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
