Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9761545D00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbiFJHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiFJHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:16:29 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF02109C1;
        Fri, 10 Jun 2022 00:16:24 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb3f.dynamic.kabel-deutschland.de [95.90.235.63])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D0BA161EA1923;
        Fri, 10 Jun 2022 09:16:20 +0200 (CEST)
Message-ID: <1472eccd-429b-0a18-565c-7de2e5ed44f2@molgen.mpg.de>
Date:   Fri, 10 Jun 2022 09:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Bluetooth: btmtksdio: Add in-band wakeup support
Content-Language: en-US
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
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
References: <742cdffcf110e1601257207fb2b0d3f426d4008c.1654819586.git.objelf@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <742cdffcf110e1601257207fb2b0d3f426d4008c.1654819586.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean,


Thank you for the patch.

Am 10.06.22 um 02:17 schrieb sean.wang@mediatek.com:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> 'ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")'
> have added the waken-on-bluetooth via dedicated GPIO.

Maybe:

Commit ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth") 
adds the wake on bluethooth via a dedicated GPIO.

> The patch extends the function to the waken-on-bluetooth via SDIO DAT1 pin
> (inband wakeup) when the SDIO host driver is able to support.

Maybe:

Extend the wake-on-bluetooth to use the SDIO DAT1 pin (in-band wakeup), 
when supported by the SDIO host driver.

How did you test this? In what datasheet is it documented?

> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   drivers/bluetooth/btmtksdio.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index d6700efcfe8c..9ed3af4ba51a 100644
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
>   	if (may_wakeup && bdev->data->chipid == 0x7921) {
>   		struct sk_buff *skb;
>   
> @@ -1384,6 +1388,10 @@ static int btmtksdio_probe(struct sdio_func *func,
>   	 */
>   	pm_runtime_put_noidle(bdev->dev);
>   
> +	/* Mark if the mmc host can support waken by SDIO */

Maybe:

Mark if MMC host supports wake on bluetooth by SDIO

> +	if (device_can_wakeup(func->card->host->parent))
> +		set_bit(BTMTKSDIO_INBAND_WAKEUP, &bdev->tx_state);
> +
>   	err = device_init_wakeup(bdev->dev, true);
>   	if (err)
>   		bt_dev_err(hdev, "failed to initialize device wakeup");


Kind regards,

Paul
