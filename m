Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99AB50D395
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiDXQnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiDXQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:43:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D42E008;
        Sun, 24 Apr 2022 09:40:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43DC630B;
        Sun, 24 Apr 2022 18:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650818437;
        bh=f67DrpMM3WqfmwBxGxHfSZkKGZr/pZm0y+ajUHoXOZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqk3EraTPIM1iGwsaGpmOnGv4XTKyalRg2PmRTMDr3pQ5fpDEixYEmxnsOrav825C
         Sg6wQS3oQm6Fp89FGS8elNIjnihXdfg+9jzgyVk8LQPGQ1mm5+jByTp5RsR7VbjBOg
         DKvfdXZP3XX9hwZWTyaykbqFz/vkNbT+Z4utlLuU=
Date:   Sun, 24 Apr 2022 19:40:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov7670: remove ov7670_power_off from ov7670_remove
Message-ID: <YmV9heuEM+zpaE+x@pendragon.ideasonboard.com>
References: <20220422085408.634616-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422085408.634616-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

Thank you for the patch.

On Fri, Apr 22, 2022 at 04:54:05PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> In ov7670_probe, it always invokes ov7670_power_off() no matter
> the execution is successful or failed. So we cannot invoke it
> agiain in ov7670_remove().
> 
> Fix this by removing ov7670_power_off from ov7670_remove.
> 
> Fixes: 030f9f682e66 ("media: ov7670: control clock along with power")

ov7670_power_off() is a no-op if power is already off. What does this
fix ?

> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/media/i2c/ov7670.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
> index 196746423116..1be2c0e5bdc1 100644
> --- a/drivers/media/i2c/ov7670.c
> +++ b/drivers/media/i2c/ov7670.c
> @@ -2017,7 +2017,6 @@ static int ov7670_remove(struct i2c_client *client)
>  	v4l2_async_unregister_subdev(sd);
>  	v4l2_ctrl_handler_free(&info->hdl);
>  	media_entity_cleanup(&info->sd.entity);
> -	ov7670_power_off(sd);
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
