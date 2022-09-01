Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165035A8E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiIAGeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIAGeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:34:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678BE396A;
        Wed, 31 Aug 2022 23:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AEE7B81619;
        Thu,  1 Sep 2022 06:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FC5C433C1;
        Thu,  1 Sep 2022 06:34:03 +0000 (UTC)
Message-ID: <95b5a18c-8f31-81d6-c878-17d32ae8d7e6@xs4all.nl>
Date:   Thu, 1 Sep 2022 08:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] media: v4l2-tpg: Use 'unsigned int' instead of just
 'unsigned'.
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, mchehab@kernel.org,
        jacopo@jmondi.org, laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901011151.22735-1-yuanjilin@cdjrlc.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220901011151.22735-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jilin,

On 9/1/22 03:11, Jilin Yuan wrote:
> 'unsigned int' should be clearer than 'unsigned'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/media/common/v4l2-tpg/v4l2-tpg-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

I don't get it, just 8 changes? If I do a 'git grep unsigned drivers/media/common/v4l2-tpg'
I get 128 hits, and include/media/tpg/v4l2-tpg.h has another 52.

What's the point of changing just a few of these instances instead of doing
them all?

In any case, patches like this just create a lot of noise and take away too
much code reviewer bandwidth for very little gain.

Speaking for the media subsystem I will reject patches like this, it's not
worth the effort.

Regards,

	Hans

> 
> diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
> index 9b7bcdce6e44..10ed9e65eecc 100644
> --- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
> +++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
> @@ -86,7 +86,7 @@ void tpg_set_font(const u8 *f)
>  }
>  EXPORT_SYMBOL_GPL(tpg_set_font);
>  
> -void tpg_init(struct tpg_data *tpg, unsigned w, unsigned h)
> +void tpg_init(struct tpg_data *tpg, unsigned int w, unsigned int h)
>  {
>  	memset(tpg, 0, sizeof(*tpg));
>  	tpg->scaled_width = tpg->src_width = w;
> @@ -109,15 +109,15 @@ void tpg_init(struct tpg_data *tpg, unsigned w, unsigned h)
>  }
>  EXPORT_SYMBOL_GPL(tpg_init);
>  
> -int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
> +int tpg_alloc(struct tpg_data *tpg, unsigned int max_w)
>  {
> -	unsigned pat;
> -	unsigned plane;
> +	unsigned int pat;
> +	unsigned int plane;
>  
>  	tpg->max_line_width = max_w;
>  	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++) {
>  		for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
> -			unsigned pixelsz = plane ? 2 : 4;
> +			unsigned int pixelsz = plane ? 2 : 4;
>  
>  			tpg->lines[pat][plane] =
>  				vzalloc(array3_size(max_w, 2, pixelsz));
> @@ -132,7 +132,7 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
>  		}
>  	}
>  	for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
> -		unsigned pixelsz = plane ? 2 : 4;
> +		unsigned int pixelsz = plane ? 2 : 4;
>  
>  		tpg->contrast_line[plane] =
>  			vzalloc(array_size(pixelsz, max_w));
> @@ -153,8 +153,8 @@ EXPORT_SYMBOL_GPL(tpg_alloc);
>  
>  void tpg_free(struct tpg_data *tpg)
>  {
> -	unsigned pat;
> -	unsigned plane;
> +	unsigned int pat;
> +	unsigned int plane;
>  
>  	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++)
>  		for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
