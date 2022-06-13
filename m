Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2E54A0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352016AbiFMU6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351535AbiFMUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0161A05D;
        Mon, 13 Jun 2022 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fBWi7QPO/F0ytmVW1WCvq92sKKuPA3DpoLxZ9CDOG/k=; b=P1VppJRSb+oHRmLr0pSpjezyww
        g2/6H9CewlIn9zZRkKrtbcQTPeE8uAqzG/2pPtz8cx+eX9/1EIKU5uu27T/j+zf8PAEq52J1Qf+HD
        qs9bH+cATvW4OI9AbR09GYH7TZFbFh1xn73nTAADt0Mie3mIhQ2Cqu8IDNfjMzcObV1KmTkvvfNsu
        Ji3pKltRIyqjnx3TreMEMhYTSRfuvzSI1OAwFOFnGskM+2YHfWASqe+qHrFBhlz6ArtvGEed2gMEH
        8Yd/bxVP+/1X1BojLJMzjqa/28vDKTpqNsjyo0f9qqR1kUzbpUDJigHN1QWRwVsW+sMXssao+NKH0
        XvAZL72w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0qVC-007fDz-Il; Mon, 13 Jun 2022 20:17:37 +0000
Message-ID: <915871e4-b156-ab19-043f-b719e03a5711@infradead.org>
Date:   Mon, 13 Jun 2022 13:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 11/15] iio: adc: mt6370: Add Mediatek MT6370 support
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
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-12-peterwu.pub@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220613111146.25221-12-peterwu.pub@gmail.com>
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

Hi,

On 6/13/22 04:11, ChiaEn Wu wrote:
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 71ab0a06aa82..09576fb478ad 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -737,6 +737,15 @@ config MEDIATEK_MT6360_ADC
>  	  is used in smartphones and tablets and supports a 11 channel
>  	  general purpose ADC.
>  
> +config MEDIATEK_MT6370_ADC
> +	tristate "Mediatek MT6370 ADC driver"
> +	depends on MFD_MT6370
> +	help
> +	  Say Y here to enable MT6370 ADC support.
> +
> +	  Integrated for System Monitoring includes is used in smartphones

Please try again on the help text. I can't decode that.

> +	  and tablets and supports a 9 channel general purpose ADC.

-- 
~Randy
