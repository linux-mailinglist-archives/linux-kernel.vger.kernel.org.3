Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7A59BD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiHVJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiHVJ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:57:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199731DC4;
        Mon, 22 Aug 2022 02:56:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5133E2B3;
        Mon, 22 Aug 2022 11:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661162218;
        bh=HItqUbPown0MuVwTPfUbAILw8/+d0rHi9wXNaFSpNjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbRlKX8k5Pg7aVgZ0GrNQACjH1DxMaf1YWnwExaQWkjyXscljXgOV2PsWaI15NyEe
         XHnaZcGkMZd/p9RkunmCGx2S2tQPmWjTK1bsTnkOghrs1e3Fxt/gy1F0YQaehyHh2j
         xCKwBaAa13IALeex34cpG/R2iIrjTsZkrBQttY1k=
Date:   Mon, 22 Aug 2022 12:56:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: dw100: Fix an error handling path in dw100_probe()
Message-ID: <YwNS5jr2+ersua9B@pendragon.ideasonboard.com>
References: <7213b90d0d872be154cff81aec1ad8a4a77116af.1661161223.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7213b90d0d872be154cff81aec1ad8a4a77116af.1661161223.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Mon, Aug 22, 2022 at 11:40:43AM +0200, Christophe JAILLET wrote:
> After a successful call to media_device_init() it is safer to call
> media_device_init().

I assume you meant media_device_cleanup() ? With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Add the missing call in the error handling path of the probe, as already
> done in the remove function.
> 
> Fixes: bd090d4d995a ("media: dw100: Add i.MX8MP dw100 dewarper driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/media/platform/nxp/dw100/dw100.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
> index 94518f0e486b..b3b057798ab6 100644
> --- a/drivers/media/platform/nxp/dw100/dw100.c
> +++ b/drivers/media/platform/nxp/dw100/dw100.c
> @@ -1623,6 +1623,7 @@ static int dw100_probe(struct platform_device *pdev)
>  error_v4l2:
>  	video_unregister_device(vfd);
>  err_m2m:
> +	media_device_cleanup(&dw_dev->mdev);
>  	v4l2_m2m_release(dw_dev->m2m_dev);
>  err_v4l2:
>  	v4l2_device_unregister(&dw_dev->v4l2_dev);

-- 
Regards,

Laurent Pinchart
