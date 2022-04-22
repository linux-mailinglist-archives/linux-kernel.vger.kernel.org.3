Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E033850B1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444891AbiDVHgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444876AbiDVHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:36:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5741515BB;
        Fri, 22 Apr 2022 00:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 035EACE279A;
        Fri, 22 Apr 2022 07:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD0CC385A4;
        Fri, 22 Apr 2022 07:33:10 +0000 (UTC)
Message-ID: <4f4c3348-4eae-f881-74e4-d39aeebf5356@xs4all.nl>
Date:   Fri, 22 Apr 2022 09:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 12/24] media: rkvdec: Stop overclocking the decoder
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-13-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220405204426.259074-13-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 22:44, Nicolas Dufresne wrote:
> While this overclock hack seems to work on some implementations
> (some ChromeBooks, RockPi4) it also causes instability on other
> implementations (notably LibreComputer Renegade, but there were more
> reports in the LibreELEC project, where this has been removed). While
> performance is indeed affected (tested with GStreamer), 4K playback
> still works as long as you don't operate in lock step and keep at
> least 1 frame ahead of time in the decode queue.
> 
> After discussion with ChromeOS members, it would seem that their
> implementation indeed used to synchronously decode each frames, so

frames -> frame

Regards,

	Hans

> this hack was simply compensating for their code being less
> efficient. In my opinion, this hack should not have been included
> upstream.
> 
> Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index c0cf3488f970..2df8cf4883e2 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -1027,12 +1027,6 @@ static int rkvdec_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Bump ACLK to max. possible freq. (500 MHz) to improve performance
> -	 * When 4k video playback.
> -	 */
> -	clk_set_rate(rkvdec->clocks[0].clk, 500 * 1000 * 1000);
> -
>  	rkvdec->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(rkvdec->regs))
>  		return PTR_ERR(rkvdec->regs);

