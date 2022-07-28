Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B7583CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiG1LPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiG1LPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:15:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF22A43F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:15:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D93A56601B43;
        Thu, 28 Jul 2022 12:15:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659006917;
        bh=0gnnEk0TG5O1vi5/Vm6gds5OMe6ylZ4Rer3EJsmYcoU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ye6q2lA5BgXCgHk9eToRCt4M7AqeV1MuUi/od7Zy/EQY00QXeuaD3kymlgnox+gTb
         QsOoV4EGCLKh5N9Uyr18G+AZZXgvLBLMZ+jShh7FLPLTG/PGZ+SzvzPLezgdlJhvb+
         hFsrnavXWQXsJOHz1eY4YyGy30i84TH4zKDVjFZwQTbUEYI4VtRT9YszA9MLQ96RBz
         tyMpA1KomVlbITyGOuZ71Cb9lU7XDHMbLzxiKZ7ovJ1Cgcoe0torqjO2HKIhA//Em0
         JxMpdKEZBS6xeoyPZWy0KL1H/osgLmU57KZO3Jft20v218FEip4wABFExuRjmyo8HE
         MbZ6NJlzmXMBw==
Message-ID: <decb7338-eeb8-3c0c-88f2-c0b00fb8b0e7@collabora.com>
Date:   Thu, 28 Jul 2022 13:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] regulator: mt6380: Fix unused array warning
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
References: <20220727132637.76d6073f@endymion.delvare>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220727132637.76d6073f@endymion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/07/22 13:26, Jean Delvare ha scritto:
> With the following configuration options:
> CONFIG_OF is not set
> CONFIG_REGULATOR_MT6380=y
> we get the following build warning:
> 
>    CC      drivers/regulator/mt6380-regulator.o
> drivers/regulator/mt6380-regulator.c:322:34: warning: ‘mt6380_of_match’ defined but not used [-Wunused-const-variable=]
> 
> Fix this by annotating that array with __maybe_unused, as done in
> various regulator drivers.

I know I'm late to the party, but I would've preferred to see the
of_match_ptr() dropped instead of adding a __maybe_unused.

Cheers,
Angelo

> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202207240252.ZY5hSCNB-lkp@intel.com/
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chenglin Xu <chenglin.xu@mediatek.com>
> ---
> This assumes that the mt6380 driver can be used without OF support.
> However, I can't find any in-tree piece of code instantiating the
> "mt6380-regulator" platform device by name. So unless there's an
> out-of-tree user, a better fix would be to remove mt6380_platform_ids
> and make the driver depend on OF. Chenglin, would that be OK with
> you?
> 
>   drivers/regulator/mt6380-regulator.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-5.18.orig/drivers/regulator/mt6380-regulator.c	2022-07-27 11:55:21.672421481 +0200
> +++ linux-5.18/drivers/regulator/mt6380-regulator.c	2022-07-27 12:01:53.151833378 +0200
> @@ -319,7 +319,7 @@ static const struct platform_device_id m
>   };
>   MODULE_DEVICE_TABLE(platform, mt6380_platform_ids);
>   
> -static const struct of_device_id mt6380_of_match[] = {
> +static const struct of_device_id  __maybe_unused mt6380_of_match[] = {
>   	{ .compatible = "mediatek,mt6380-regulator", },
>   	{ /* sentinel */ },
>   };
> 
