Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400BD53E8CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiFFPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiFFPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:04:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708E197F48
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jP13loBMm9TuZeQCLuO/dhLEWjTmgt4fvmdoZbkBnUg=; b=mNPm8PVf0LJAUO8+dLPyo8Heif
        BPPekofjKKXrVOj8+hjnImZI2eJSH40/07TXC/osNgbHV7z181Qee0BPXqs5hCLLlpeHfZdEmtxSw
        /qczAn9exadqE8jsE5sUEjCAZUNu6yGbspOwvxRZxuDWOez5ID5tIeW5Fh+pujbzitxauOCttB7es
        VC5agdM4yhnnzjsR1qFMwX0ZR5pAooNptP55Ixf2vxNuTZUPnAK7Ueq1EMu0hC+8hVgEmHJWco9xC
        vJKkK4yytJHrfeDckEKZsbk9eITgD6G5x9IAf8cJzXzL7k2RXalc0O1CvyntgnofthVpjh+vK98Al
        cr+imy5Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyEHE-005Tee-Mf; Mon, 06 Jun 2022 15:04:21 +0000
Message-ID: <007d3d1b-8ced-f7f3-7825-d0c67c7961ee@infradead.org>
Date:   Mon, 6 Jun 2022 08:04:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/7] firmware: arm_scmi: Make use of FastChannels
 configurable
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com
References: <20220606100230.3465828-1-cristian.marussi@arm.com>
 <20220606100230.3465828-6-cristian.marussi@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220606100230.3465828-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/6/22 03:02, Cristian Marussi wrote:
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 1e7b7fec97d9..624f32b61825 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -42,6 +42,19 @@ config ARM_SCMI_HAVE_MSG
>  	  This declares whether a message passing based transport for SCMI is
>  	  available.
>  
> +config ARM_SCMI_USE_FASTCHANNELS
> +	bool "Use SCMI FastChannels when available"
> +	default y
> +	help
> +	  Use SCMI FastChannels when advertised as available by the platform.
> +
> +	  On systems where the SCMI platform advertises the availability of
> +	  FastChannels, supported SCMI commands can be issued triggering a
> +	  one-way FastChannel request, much more quicker than using a

Either                                 much more quickly
or                                     much quicker

> +	  regular SCMI message transfer.
> +	  When set to N forces the OSPM to use instead regular SCMI message
> +	  transfers even if FastChannels are available. If unsure say Y.

thanks.
-- 
~Randy
