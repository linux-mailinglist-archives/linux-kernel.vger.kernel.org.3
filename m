Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693765575B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiFWIme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiFWImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:42:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D9248E74;
        Thu, 23 Jun 2022 01:42:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 968FB6601792;
        Thu, 23 Jun 2022 09:42:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655973749;
        bh=a3qg+o/OwgqXslU/4j4RlR9cUNoRYrfj19YE44y2v3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XKQK0beGg3vTWSmevrEBFXfg7Q50EHWuJlc9pwCXzaWUO+VBLRPh9p4Oy3qQRBUsS
         2W7qVoYtzbfrOv/1RrewUg21ryne4VDHhJZdOO+WEWkFcAQl8p6YG9Y+YzRVi4CRh7
         77J6K81IQ+QSFtfhS/4wVHmTXZUfaz5CxrZSyP/VVqdmpOArk9s+lvIvrNdEEYSOfr
         CBDGOw97CVusucf5EYiBq65amZ8Ldr1FtzeutiCuujc2zWnCK1610hxEMZth5xs6pP
         VkcNlnAigF0gFT5diFw0gsC73kN0Q+5Xn4BKM5vlj5aMhsn+c4uYuAv4ZZxidv0ULF
         dzHKBOcezZn1w==
Message-ID: <c379dca6-88a7-8ed6-c585-714ea411bd02@collabora.com>
Date:   Thu, 23 Jun 2022 10:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] Bluetooth: btmtksdio: Add in-band wakeup support
Content-Language: en-US
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yake Yang <yake.yang@mediatek.com>
References: <52b63a1be094a1ccbb20f2c89472580d95f0652a.1655934689.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <52b63a1be094a1ccbb20f2c89472580d95f0652a.1655934689.git.objelf@gmail.com>
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

Il 22/06/22 23:56, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Commit ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")
> adds the wake on bluethooth via a dedicated GPIO.
> 
> Extend the wake-on-bluetooth to use the SDIO DAT1 pin (in-band wakeup),
> when supported by the SDIO host driver.
> 
> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2: enhance the patch description and comments
> ---
>   drivers/bluetooth/btmtksdio.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index d6700efcfe8c..9d79c9107b3a 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -118,6 +118,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
>   #define BTMTKSDIO_FUNC_ENABLED		3
>   #define BTMTKSDIO_PATCH_ENABLED		4
>   #define BTMTKSDIO_HW_RESET_ACTIVE	5
> +#define BTMTKSDIO_INBAND_WAKEUP		6
>   
>   struct mtkbtsdio_hdr {
>   	__le16	len;
> @@ -1294,6 +1295,9 @@ static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
>   		.wakeup_delay = cpu_to_le16(0x20),
>   	};
>   
> +	if (test_bit(BTMTKSDIO_INBAND_WAKEUP, &bdev->tx_state))
> +		return may_wakeup;
> +

Uhm... this flag is either *always* set, or *always not set*... and we decide that
during probe time... and we use it in just one function as well.

At this point, I would just avoid the addition of the BTMTKSDIO_INBAND_WAKEUP flag
and add a new function for handling the .wakeup() callback - something like:

static bool btmtksdio_sdio_inband_wakeup(struct hci_dev *hdev)
{
	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);

	return device_may_wakeup(bdev->dev);
}

static int btmtksdio_probe(...)
{
	.... code ....

	/*
	 * If SDIO controller supports wake on Bluetooth, sending a wakeon
	 * command is not necessary.
	 */
	if (device_can_wakeup(func->card->host->parent))
		hdev->wakeup = btmtksdio_sdio_inband_wakeup;
	else
		hdev->wakeup = btmtksdio_sdio_wakeup;

	.... etc ....
}

Regards,
Angelo
