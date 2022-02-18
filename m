Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9464D4BB73F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiBRKuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:50:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiBRKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:50:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A861EC51;
        Fri, 18 Feb 2022 02:49:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03B87B823BB;
        Fri, 18 Feb 2022 10:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8C3C340E9;
        Fri, 18 Feb 2022 10:49:43 +0000 (UTC)
Message-ID: <c78ed114-b838-e030-a235-f4de9c88e71e@xs4all.nl>
Date:   Fri, 18 Feb 2022 11:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] media: dvb-frontends: use div64_u64() instead of do_div()
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1644395896-4036-1-git-send-email-wangqing@vivo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <1644395896-4036-1-git-send-email-wangqing@vivo.com>
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

On 09/02/2022 09:38, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
> 
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/media/dvb-frontends/tda10048.c     | 2 +-
>  drivers/media/dvb-frontends/tda18271c2dd.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
> index d1d206e..1ce2e67
> --- a/drivers/media/dvb-frontends/tda10048.c
> +++ b/drivers/media/dvb-frontends/tda10048.c
> @@ -344,7 +344,7 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
>  	z = 7 * sample_freq_hz;
>  	do_div(t, z);
>  	t += 5;
> -	do_div(t, 10);
> +	div64_u64(t, 10);

This makes no sense, I think you intended to convert the previous do_div(t, z).

>  
>  	tda10048_writereg(state, TDA10048_TIME_WREF_LSB, (u8)t);
>  	tda10048_writereg(state, TDA10048_TIME_WREF_MID1, (u8)(t >> 8));
> diff --git a/drivers/media/dvb-frontends/tda18271c2dd.c b/drivers/media/dvb-frontends/tda18271c2dd.c
> index a3483448..fd92878
> --- a/drivers/media/dvb-frontends/tda18271c2dd.c
> +++ b/drivers/media/dvb-frontends/tda18271c2dd.c
> @@ -328,7 +328,7 @@ static int CalcMainPLL(struct tda_state *state, u32 freq)
>  
>  	OscFreq = (u64) freq * (u64) Div;
>  	OscFreq *= (u64) 16384;
> -	do_div(OscFreq, (u64)16000000);
> +	do_div(OscFreq, 16000000);
>  	MainDiv = OscFreq;
>  
>  	state->m_Regs[MPD] = PostDiv & 0x77;
> @@ -352,7 +352,7 @@ static int CalcCalPLL(struct tda_state *state, u32 freq)
>  	OscFreq = (u64)freq * (u64)Div;
>  	/* CalDiv = u32( OscFreq * 16384 / 16000000 ); */
>  	OscFreq *= (u64)16384;
> -	do_div(OscFreq, (u64)16000000);
> +	do_div(OscFreq, 16000000);
>  	CalDiv = OscFreq;
>  
>  	state->m_Regs[CPD] = PostDiv;

The changes here do not match with the subject line of this patch.
I think it is best to split this into two patches, one for each source.

Regards,

	Hans
