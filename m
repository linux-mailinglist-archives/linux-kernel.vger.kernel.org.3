Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B755FA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiF2IXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiF2IXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:23:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E529DF50
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:23:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7567966018F6;
        Wed, 29 Jun 2022 09:23:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656490988;
        bh=0t6j94JZZK8bF91PrvfOUNSp6yuyLd27b/J9iVMqEwA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G+M88IanBOnVCTuoqrdwn3cJ/u3N++3aODbXoX27zZi74s7P8Nis420l+UrLEX9tp
         n0LT1X0S8tG0DTwsL+4TARRktUPQWry2XFJ4ySHmxKNqmdWJKQg1EHRTyEkExv0KtV
         1kInSvhWwERZt+s2p88Yc9AvSEWwohajIv+7Y57Ec0uFJzWH4IWL0wZpqhcd0GHUXA
         uNV6nTWW9a7cfIfKEjn7eX3ieoplqUZZNTklloeJKh6NtJQg82PVXg0e66omx62+Fg
         hH4B13tieKuRR4nVs9uYMbHZRPV7LhhhXWbJLI1kViPa0Ph2/hPNUDS5annaBdiLP2
         D8sA/CXHAZamA==
Message-ID: <618f0794-429c-705d-ab4c-84aace6aaaaa@collabora.com>
Date:   Wed, 29 Jun 2022 10:23:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] regulator: mt6370: Use 'fwnode_gpiod_get_index' to
 fix gpio parsing
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
References: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/06/22 03:41, cy_huang ha scritto:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> From the common binding, 'enable-gpio' or 'enable-gpios' are all well
> for external 'enable' gpio.
> 
> 'gpiod_get_from_of_node' only parse the 'enable' property, it need to
> add the gpio suffix. It's more convenient to use fwnode_gpiod_get_index.
> Although fwnode parsing is not preferred, but 'of_parse_cb' already can
> guarantee the callback will only be used by regulator of_node parsing.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>   drivers/regulator/mt6370-regulator.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
> index bc356b4..949b2c7 100644
> --- a/drivers/regulator/mt6370-regulator.c
> +++ b/drivers/regulator/mt6370-regulator.c
> @@ -153,7 +153,8 @@ static int mt6370_of_parse_cb(struct device_node *np,
>   	struct gpio_desc *enable_gpio;
>   	int ret;
>   
> -	enable_gpio = gpiod_get_from_of_node(np, "enable", 0, GPIOD_OUT_HIGH |
> +	enable_gpio = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,

Since this driver is never calling gpiod_put(), you can even fix that in one shot.

Just use devm_fwnode_gpiod_get() here, as it's guaranteed that priv->dev is
initialized at this time.

Cheers,
Angelo


