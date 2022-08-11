Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34858FD96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiHKNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiHKNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:42:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDC15A22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:42:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs25so2953121wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5iFjW4mH2SdQj0QDIE0YGEPOh872v8cXsK/Ld6auj0k=;
        b=OVVOzKU2OF2ob9mMAjoIKHK5cTolrX3EI5Yv57arqnAg0Mk/fQiEhu5YOmKUppLcGs
         bSDvg16jFXmkHecF62uKo6ESzrXzmrc0N+M9BzdVLANClfLjIxtcxUHW7+jqN9lFufBr
         cE/GR4DYtqRXC8dIp9zo6xhjHD+6J7sUvD6Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5iFjW4mH2SdQj0QDIE0YGEPOh872v8cXsK/Ld6auj0k=;
        b=T/iLqzA8V2rSj08u0iqdYrk0GsJZ8ukDMGbZPYLPguXCGch047A0mEHkqtNNrON80F
         7Cgbf1mkJ6P+CJoFxsGm95d3Kl6oMRo+SbY0ON4cGLg0vxjRdVtgLbLOhLKk43TOAqed
         BMF13YC4f3b0vj4KV2cxS7ZtXLdq3rGjCD8z4/B/olOpfvcAkThvM+LHlvwEr7JEpPQI
         swttSobvwrQKr6UI2xruTXEKrc0Y2IOcIRzHD1elI51GSDnm+Ta3xNC45U6AAM0Yw01q
         DqmUV6WsC+LqdOZnAoD4fBmod1Au849IvEVGpOwMtgfuNc+oaKVIqy5aBHzL+f4wUQOc
         gixA==
X-Gm-Message-State: ACgBeo2G0g17pND7TQLldFpVqo0LHIuzWnl9mJg0zarE1+88lGmYvtCS
        2Eu7tKupoOAXQCaW8oq4WimCXg==
X-Google-Smtp-Source: AA6agR5uFxpGwgY41pOIGd/cQxEWOqrs8VXvPQXrj9cy/yX384JSAASkZ7n//wNcgMgTisKO6k7Xpw==
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr20668312wrz.371.1660225371492;
        Thu, 11 Aug 2022 06:42:51 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-51-7.cust.vodafonedsl.it. [188.217.51.7])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm5757888wmp.6.2022.08.11.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 06:42:51 -0700 (PDT)
Date:   Thu, 11 Aug 2022 15:42:48 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Oliver Neukum <oneukum@suse.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+bb25f85e5aa482864dc0@syzkaller.appspotmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: airspy: fix memory leak in airspy probe
Message-ID: <20220811134248.GA6390@tom-ThinkPad-T14s-Gen-2i>
References: <20220811045701.31152-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811045701.31152-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

On Thu, Aug 11, 2022 at 12:57:00PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> The commit ca9dc8d06ab6 ("media: airspy: respect the DMA coherency
>  rules") moves variable buf from stack to heap, however, it only frees
> buf in the error handling code, missing deallocation in the success
> path.
> 
> Fix this by freeing buf in the success path since this variable does not
> have any references in other code.
> 
> Fixes: ca9dc8d06ab6 ("media: airspy: respect the DMA coherency rules")
> Reported-by: syzbot+bb25f85e5aa482864dc0@syzkaller.appspotmail.com
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/media/usb/airspy/airspy.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/usb/airspy/airspy.c b/drivers/media/usb/airspy/airspy.c
> index 240a7cc56777..7b1c40132555 100644
> --- a/drivers/media/usb/airspy/airspy.c
> +++ b/drivers/media/usb/airspy/airspy.c
> @@ -1070,6 +1070,10 @@ static int airspy_probe(struct usb_interface *intf,
>  				ret);
>  		goto err_free_controls;
>  	}
> +
> +	/* Free buf if success*/
> +	kfree(buf);
> +

buf var is only used to print the fw version during the probe.
I think you are right we need to free this.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolution.com>

>  	dev_info(s->dev, "Registered as %s\n",
>  			video_device_node_name(&s->vdev));
>  	dev_notice(s->dev, "SDR API is still slightly experimental and functionality changes may follow\n");
> -- 
> 2.35.1
> 

Regards,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
