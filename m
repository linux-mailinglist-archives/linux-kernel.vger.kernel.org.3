Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD952A87A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351055AbiEQQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiEQQqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:46:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE9FD4D27B;
        Tue, 17 May 2022 09:46:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E1001042;
        Tue, 17 May 2022 09:46:42 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFD8E3F718;
        Tue, 17 May 2022 09:46:40 -0700 (PDT)
Message-ID: <0da188fa-efd8-62d0-2ea6-5a8e0c286cb5@arm.com>
Date:   Tue, 17 May 2022 17:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] media: hantro: fix compatible string deprecation warning
Content-Language: en-GB
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220517143521.1670663-1-martin.kepplinger@puri.sm>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220517143521.1670663-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-17 15:35, Martin Kepplinger wrote:
> of_device_is_compatible() in the end uses strlen of the string
> for comparison, so in this case, the condition is true even if
> the requested string "nxp,imx8mq-vpu-g1" is being used. The first
> chars containing "nxp,imx8mq-vpu" are the same.

Have you seen this go wrong in practice? AFAICS, unless you're on SPARC, 
which seems somewhat unlikely for an i.MX8 peripheral, of_compat_cmp() 
should map to strcasecmp(), which should do the right thing :/

Robin.

> Fix this by encoding what the comment says.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> This is more of a bugreport as the solution doesn't look very elegant
> to me. I'm happy for advice.
> 
> thanks,
>                             martin
> 
> 
>   drivers/staging/media/hantro/hantro_drv.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index ac232b5f7825..014fab637df0 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -923,10 +923,11 @@ static int hantro_probe(struct platform_device *pdev)
>   
>   	/*
>   	 * Support for nxp,imx8mq-vpu is kept for backwards compatibility
> -	 * but it's deprecated. Please update your DTS file to use
> -	 * nxp,imx8mq-vpu-g1 or nxp,imx8mq-vpu-g2 instead.
> +	 * but it's deprecated.
>   	 */
> -	if (of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu"))
> +	if ((of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu")) &&
> +	    (!of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu-g1")) &&
> +	    (!of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu-g2")))
>   		dev_warn(&pdev->dev, "%s compatible is deprecated\n",
>   			 match->compatible);
>   
