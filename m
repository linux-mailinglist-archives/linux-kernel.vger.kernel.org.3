Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A52A53EC49
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiFFPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiFFPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:32:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501FB38D9F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:31:44 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q1so16167551ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3IQLw4WbkQa+wAa1iZfTyCfXyto7YbC3Q6qJuX9XAw4=;
        b=KVkA9gDhvveDE1vPCfgz3edIeZnoMisziwBIyCmOYpWcIFfZ37JxrOU8HXoowc+9PS
         5pUblh6GZaG9HaZlAoHag7HGh/jzoNjEHW008/7U/wF5dFRC3emk4Irr5vXqCSeJ1Win
         yslw2RMt43ryN02KpZINsj/U44Hj2TA9esyiW2Uk9Fo+UEjZ6cXdEbryTs3BMtnInDW3
         ojIhWBFuonM/AlC6B0u/cfU48ax9Vm7QAcX0mUfDQUMba9zrEYfYhhzJlgby5gPl2k1y
         a1GxqSAxDHbWJAm2Elkz02s6sT/nxkBTc5LNRQ5nv7uKucfs8PN8dFePx/ZHn3f19QAv
         M75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3IQLw4WbkQa+wAa1iZfTyCfXyto7YbC3Q6qJuX9XAw4=;
        b=dWEaq+2uvRebVS7soP/5k4kQufC9BL+YkI93LxuNZg0Kbhnkh/+LcyMqRL6xZksjxl
         KUF4Sze+KBgJ9OMMMdTt3ew6wneV97naU+Hb+ME4mxNnabTmGD9wrCcwogkhfN0RfuHj
         TxLuWFj+hJLBBL7OYmP490i1nkt+rpcmnwbHDa34yKXIeSRyEw+W39+dtWQ9Dy3Q/iWh
         NToBqF5Kspa70/NtIn8sjEJziLfOJ57FHhk9GfzEmLwngkX0f3bdk7l2ujaq0j62vdJJ
         RyvuQCX7AtipE5wCi4PZ7xAmGxstZHHVY2zcournR0hhaUuiOb668zpDCDqGPsruN7KD
         SWWQ==
X-Gm-Message-State: AOAM530vkgDTb6meJXxGaivz9o3Pgnbqj/hgWj+MOrNZFk5w8CoXI4o+
        6sfvc084wVvp6F8Bxb6qeNsrcg==
X-Google-Smtp-Source: ABdhPJy81rfaB5ZlTyXicVEikJfpMvAMZJ+wwX6R9AiMRfktS2Ph0EYB94+vQ+qThhu86eTa4tPHxA==
X-Received: by 2002:a2e:8044:0:b0:255:a587:3f7e with SMTP id p4-20020a2e8044000000b00255a5873f7emr989325ljg.43.1654529499708;
        Mon, 06 Jun 2022 08:31:39 -0700 (PDT)
Received: from [192.168.16.142] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id h40-20020a0565123ca800b004785b66a9a4sm2899397lfv.126.2022.06.06.08.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 08:31:39 -0700 (PDT)
Message-ID: <a29d5945-0344-4721-553d-e710a3afc61a@kvaser.com>
Date:   Mon, 6 Jun 2022 17:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 07/12] can: kvaser_usb_leaf: Fix CAN state after restart
Content-Language: en-US
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-8-anssi.hannula@bitwise.fi>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20220516134748.3724796-8-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> can_restart() expects CMD_START_CHIP to set the error state to
> ERROR_ACTIVE as it calls netif_carrier_on() immediately afterwards.
> 
> Otherwise the user may immediately trigger restart again and hit a
> BUG_ON() in can_restart().
> 
> Fix kvaser_usb_leaf set_mode(CMD_START_CHIP) to set the expected state.
> 
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>


Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>

> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 2d30a662edb5..5f27c00179c1 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -1411,6 +1411,8 @@ static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
>   		err = kvaser_usb_leaf_simple_cmd_async(priv, CMD_START_CHIP);
>   		if (err)
>   			return err;
> +
> +		priv->can.state = CAN_STATE_ERROR_ACTIVE;
>   		break;
>   	default:
>   		return -EOPNOTSUPP;
