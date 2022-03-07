Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832784CF2BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiCGHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbiCGHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:39:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59C6333;
        Sun,  6 Mar 2022 23:38:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E2060B0F;
        Mon,  7 Mar 2022 07:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EE1C340F4;
        Mon,  7 Mar 2022 07:38:56 +0000 (UTC)
Message-ID: <8e4a35a4-1d8f-5aff-f577-2a2b87646528@xs4all.nl>
Date:   Mon, 7 Mar 2022 08:38:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220105111056.4662-1-linmq006@gmail.com>
 <20220301071859.24285-1-linmq006@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220301071859.24285-1-linmq006@gmail.com>
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



On 3/1/22 08:18, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> 
> Fixes: 0a0e265 ("media: atmel: atmel-isc: split driver into driver base and isc")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - remove unused label.
> ---
>  drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> index 1b2063cce0f7..7f1ebbb25437 100644
> --- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> +++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
> @@ -559,6 +559,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
>  cleanup_subdev:
>  	isc_subdev_cleanup(isc);
>  
> +	pm_runtime_disable(dev);

Same issue as with the st-delta patch: there is one 'goto cleanup_subdev'
that is called before the pm_runtime_enable, so this patch just introduces
another imbalance. You need an additional goto label here and rework it a
little bit to get this right.

Regards,

	Hans

> +
>  unregister_v4l2_device:
>  	v4l2_device_unregister(&isc->v4l2_dev);
>  
