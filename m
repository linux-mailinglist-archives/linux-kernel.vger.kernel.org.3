Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382C24EAB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiC2Kfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiC2Kfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:35:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06752CE2C;
        Tue, 29 Mar 2022 03:33:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1F4E21F4107C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648550038;
        bh=kPA++nT55REBlchYsmQAKCVDO+2FGIFaT9+6SOaLk3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gQj1CxjzhqGt0pUEPgcYIaxrs4EYIQarFlqUZ4Is689TDVOvVTj2gAMzgAzKp59O/
         UZSgoLqUDCH4KZ6oohX7H/E9+vcCbAbtE62z5s7Fbqr3a5vnPh/uRdqltiEDUXwj8f
         mOJW9uxFkxyydkosxFVmOk0KqnmlxG1kNjlXKsEIOiQW85PLIT2HA+1cN7ro0AvK9W
         kDdzu++ORpOke56KdtkIm4P37NXpUyPYqp+2mzcBglbQEK4Pgfn3kpnnwmst+td8q2
         TnPUyy/rnQEp1G1hh2kf2nlPK8qUgMUEoAg1VJOrZSqXqh3Hvp2JKawy8IR7DO55EM
         O5Cs1E24l5h4A==
Message-ID: <e9daf657-2a29-a4b1-158a-86f2a98a8900@collabora.com>
Date:   Tue, 29 Mar 2022 12:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 2/3] mmc: core: Add support for SDIO wakeup interrupt
Content-Language: en-US
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220329032913.8750-1-axe.yang@mediatek.com>
 <20220329032913.8750-3-axe.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220329032913.8750-3-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/22 05:29, Axe Yang ha scritto:
> If wakeup-source flag is set in host dts node, parse EAI information
> from SDIO CCCR interrupt externsion segment for in-band wakeup. If
> async interrupt is supported by SDIO card then enable it and set
> enable_async_irq flag in sdio_cccr structure to 1. The parse flow is
> implemented in sdio_read_cccr().
> 
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

Hello Axe,
there was a mistake about my tag (my fault, sorry), can you please change it from
Acked-by to Reviewed-by?

Thanks,
Angelo
