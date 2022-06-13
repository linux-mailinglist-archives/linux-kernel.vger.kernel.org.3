Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B854A051
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351235AbiFMUy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351157AbiFMUxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17810FD7;
        Mon, 13 Jun 2022 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=b8nNT/xprutxuiBevYoYuq5d2FkteRl+uXtHRkddO1w=; b=Yww0fYQTyEmxuLew3Ionpx8OMF
        +g7pCz3zRQQ2OjT74EOB/aK/dKBfXJ737MYvDCWwla+U3+2mtAsnmAiqEJ+m8MN+Y8xvD/dr8Kk7+
        CTHDzxZHuUbX84iCMrvOenFQ90E0I7QbBDBpbpRcv9DHuB1PBMnj3fkLJuLOL7pAOAjKHnv/fZxcZ
        qBUgYfDwZbaAcDkLi/88MIc3QnzcG8sfkbK8gFuVv69yiLOeqZvVFHbgOvfC464+3bKiyAnRQs1T7
        zAg+DPfZjGpXLgfVKZtkDdrn2AUTr2iAOHaX3ptXEXn0pcM/4bla3HnDKKuUovF0Gd78dX+qMf6AS
        p+bpoqHg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0qTP-007fBI-DS; Mon, 13 Jun 2022 20:15:44 +0000
Message-ID: <31b588e9-2233-3b40-e452-83f0f6bfb744@infradead.org>
Date:   Mon, 13 Jun 2022 13:15:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 10/15] regulator: mt6370: Add mt6370 DisplayBias and
 VibLDO support
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-11-peterwu.pub@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220613111146.25221-11-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 04:11, ChiaEn Wu wrote:
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index cbe0f96ca342..dcb6866dab53 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -804,6 +804,14 @@ config REGULATOR_MT6360
>  	  2-channel buck with Thermal Shutdown and Overload Protection
>  	  6-channel High PSRR and Low Dropout LDO.
>  
> +config REGULATOR_MT6370
> +	tristate "MT6370 SubPMIC Regulator"
> +	depends on MFD_MT6370
> +	help
> +	  Say Y here to enable MT6370 regulator support.
> +	  This driver support the control for DisplayBias voltages and one

	              supports

> +	  general purpose LDO which commonly used to drive the vibrator.

	                      which is commonly used to drive the vibrator.


-- 
~Randy
