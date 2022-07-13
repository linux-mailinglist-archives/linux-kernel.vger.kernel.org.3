Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B9572CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiGME7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiGME6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:58:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A73959F;
        Tue, 12 Jul 2022 21:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=79/v8d1oKbFOQQVh6pxwjkv3SRoNAmhseZcpDSRw8ts=; b=0sBThanHj4Uq4+WJyV2RWOG4UR
        UyVwu1cJgsv7IYruVoAIQ1O4KOSnGwtYbhUsDurvOX/SiRnUZjBhQbZy470yPJkG7UXY/ZoS6ePng
        eH3STODG7bM1Ay0aPZESpzEI+GLWtqGXbl0H+rE5b7mP3oGY4gKYT/qsTL8FmzqgTWqHVYC7qv90u
        2/CeQJsEdDeeBJej1ferLQRlzBXPE/cQTlw2V6GVZmXqIpiVEvdWPblcIL40QdcuAPna1umDPvd/q
        Wohi37T6ah42VMS99kBPMXhpzCs/voy2UF/Fki4WDeFULL2FPnluA0wVv7913aXglC5kZaQmqx8FP
        66CH1oZQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBUSH-000AqY-Nh; Wed, 13 Jul 2022 04:58:33 +0000
Message-ID: <f4585789-cec9-0787-cd80-57afed424ee4@infradead.org>
Date:   Tue, 12 Jul 2022 21:58:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] firmware: Samsung: Add secure monitor driver
Content-Language: en-US
To:     dj76.yang@samsung.com,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <CGME20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
 <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/12/22 21:55, Dongjin Yang wrote:
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index e5cfb01353d8..4b0f2d033f58 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -217,6 +217,17 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>  
>  	  Say Y here to enable "download mode" by default.
>  
> +config SAMSUNG_SECURE_SERVICE
> +	bool "Samsung Foundry Secure Service Layer"
> +	depends on HAVE_ARM_SMCCC
> +	default n

Drop that line, it's the default anyway.

> +	help
> +	  Support secure service layer for SoCs which is manufactured by

	                                        which are

> +	  Samsung Foundry.
> +
> +	  This option provide support of secure monitor service call using
> +	  Trusted Foundations.

-- 
~Randy
