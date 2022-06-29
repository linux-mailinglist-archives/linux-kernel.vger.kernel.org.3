Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FBB560AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiF2Tym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiF2Tyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:54:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2225588
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:54:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d14so16639876pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Tkvi5htth/fHrNPxduGdZkhoZcpp5tPBcOeF/qdELYA=;
        b=ixeR6OzeXyTBYLX/0Ck2lAU+zZ5EiZerWlx+tQt09FFdWg3J9geD8DpcOnlTXqyjzN
         QhbwdqG8T5mRRKAoyroU+CbKR23u4BasC5vJOaJetNJqq7TPHjk3sI84TAfuN4o2NvJU
         nJNoOJTD+gR+GHAwFJugGlK2HiV1XsS2rDNWYPas1uqjTlPwSxVUsSkj7ASdp2wAwwIe
         P5zzvv/0lrtAWT6cUtUpKWyk5N56BUCDVGUfbWBJzzCQ3C74eZd2UgVfMCKYW456fAIk
         p9OKL7N9I4vabk1VSBVlkd43HgpHluYuAbVbjNWHJN0HLqJdyMv9+nwJsBle0lFsTczF
         aEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Tkvi5htth/fHrNPxduGdZkhoZcpp5tPBcOeF/qdELYA=;
        b=zKBgWQeYNJCa2oFbvjeBa834Fs3AQqy5CZW6F/6FVSVrgju9PSgvJY7zEI0kL6SJsu
         kZojCFRA506GXat91qCa9tpXIYUUNfCtm970VpPcTML2BVUe7++RKWKKeef2jMKaCKI4
         DqVwYNnsuBgUtuQN0TY/p+12w5Jldk/9W9R5gDKeQ7K07Ke7ADd5ZKHMdqwagX3QHrRh
         XN/DHQymPf5rE0vxe+a+GbVBoXWyp3NXfDcMcBABLgBj+V5SOM1pGa2PQ46PoYNasUFV
         FrIC8rfnxD4JYCeeYnN0lHtAKbOe4fcjZR/wNuRJ/d97BelziuMubkv0DNzpmqqc4fMQ
         ZaNg==
X-Gm-Message-State: AJIora8JdT9ifjsVBGerIGE1ZKHekjJf4+vIblTljungKfSKBxIfGSO/
        aMsLk7N3FfREYBLOKCdpWWk=
X-Google-Smtp-Source: AGRyM1trenFjQcLrckHS49ijQ3CaQCjPIKh8pAZLcPd4FjGzJ3T6XcVgZZ3lIWrUXeMYQs0NTdPsqw==
X-Received: by 2002:a17:903:25c5:b0:16a:510e:4459 with SMTP id jc5-20020a17090325c500b0016a510e4459mr12017591plb.93.1656532477539;
        Wed, 29 Jun 2022 12:54:37 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001678e9670d8sm11870739plv.2.2022.06.29.12.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:54:37 -0700 (PDT)
Message-ID: <c6d43dab-57bf-7041-9a5a-345fa35ca0c7@gmail.com>
Date:   Thu, 30 Jun 2022 04:54:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] extcon: usbc-tusb320: make sure the state is initialized
 on probe
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Auchter <michael.auchter@ni.com>
References: <ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 23. 20:21, Peter Rosin wrote:
> When the port is connected at boot, there is not necessarily
> an interrupt flagged in the interrupt status register, causing
> the IRQ handler to bail out early without reading the state when
> it is invoked directly from probe.
> 
> Add a flag that overrides the interrupt status register and reads
> the state regardless during probe.
> 
> Fixes: 06bc4ca115cd ("extcon: Add driver for TI TUSB320")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 6ba3d89b106d..bd3645ae0d52 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -55,6 +55,7 @@ struct tusb320_priv {
>  	struct extcon_dev *edev;
>  	struct tusb320_ops *ops;
>  	enum tusb320_attached_state state;
> +	bool initialized;
>  };
>  
>  static const char * const tusb_attached_states[] = {
> @@ -195,7 +196,7 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  		return IRQ_NONE;
>  	}
>  
> -	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
> +	if (priv->initialized && !(reg & TUSB320_REG9_INTERRUPT_STATUS))
>  		return IRQ_NONE;
>  
>  	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
> @@ -297,6 +298,8 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>  		 */
>  		tusb320_irq_handler(client->irq, priv);
>  
> +	priv->initialized = true;
> +

After initializing as 'priv->initialized = true', 
tusb320_irq_handler() is not anymore detecting the external connector changes.

If external connector is detached after finished kernel boot,
how to change the state of external connector by using extcon_set_state()?

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
