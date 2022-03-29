Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B354EB3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiC2St3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbiC2St1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:49:27 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0051BA476
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:47:44 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id ZGsVnTTcWuCn2ZGsVnMSTo; Tue, 29 Mar 2022 20:47:41 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 29 Mar 2022 20:47:41 +0200
X-ME-IP: 90.126.236.122
Message-ID: <63e05f0a-6fb0-c7dc-0c3a-467a5c4e11da@wanadoo.fr>
Date:   Tue, 29 Mar 2022 20:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] usb: gadget: udc: add NULL pointer check
Content-Language: fr
To:     cgel.zte@gmail.com, balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, peter.chen@kernel.org,
        skhan@linuxfoundation.org, lv.ruyi@zte.com.cn, johan@kernel.org,
        jakobkoschel@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20220329055407.2375626-1-lv.ruyi@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220329055407.2375626-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 29/03/2022 à 07:54, cgel.zte@gmail.com a écrit :
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> kzalloc() is a memory allocation function which can return NULL when some
> internal memory errors happen. It is safer to check NULL pointer.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>   drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> index fdb17d86cd65..f52eb3f2420a 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -2231,6 +2231,10 @@ static int mv_udc_probe(struct platform_device *pdev)
>   
>   	/* allocate a small amount of memory to get valid address */
>   	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
> +	if (!udc->status_req->req.buf) {
> +		retval = -ENOMEM;
> +		goto err_destroy_dma;
> +	}

Hi,

not directly related to this patch, but I wonder if this kzalloc should 
be freed in the error handling path, and maybe also in the .remove 
function. It seems to be leaking.

CJ

>   	udc->status_req->req.dma = DMA_ADDR_INVALID;
>   
>   	udc->resume_state = USB_STATE_NOTATTACHED;
