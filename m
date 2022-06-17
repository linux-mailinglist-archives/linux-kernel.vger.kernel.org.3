Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615854FFAA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbiFQWDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiFQWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:02:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464DD6551;
        Fri, 17 Jun 2022 15:02:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i10so3510032wrc.0;
        Fri, 17 Jun 2022 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iACHHJOTxtILwtD0NFxtS+BXQ6VW7TBL7A+QIQz2pXY=;
        b=HNj7zDr2dXc86u2dQaninkTvR1QJJpNTuGDBAGGV+uz23Q2V+KclgGsn/nTpSQ5Ut4
         zGB9IBBVadWFDs08ibIkJ23RU9kf2rvZhDgC8nyQv3PIdHpglN16NWL2VEZDXjNP+yas
         ppaH9OHrZoGRZ7qO0+GZQ+IGav2t4RveDvO07tK9KxvCrqXH26wfp9dDhIUPuiG0JJpg
         A9espWCvJfe6XigBwejHCV3hc5dN8et8yV6oeiiB6uNC0eV8ZOS6rZKXN27ms+rPmnZK
         Vv9qB+yvlYXwak8iR1sfHt2GfQMWRZ7YKerKzRmSHXoeGt8Xd8E+Vz/cCmyvctflAVRB
         KaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iACHHJOTxtILwtD0NFxtS+BXQ6VW7TBL7A+QIQz2pXY=;
        b=5k2n1vaQvMm2iiuzSx0YfT7xryd/S7Cm474Rk15cPL78zJqlD3jcirpfu81GYNmvb2
         eOWo9iVrKYvvr1KVzbzLjYcNP7e5/VPcCkJInnVyp2s2qBc/0woJeO64aFFymI92HjEa
         DIMKG4Jo27DMcyTl2mjSdL0OqHqFbnoeYyRpcdtrP3v02mm1ZJrnTk3AZq+OdTMw955g
         jJGAALF+QmGF2eB6QS8WJbWDeiGALdj4uSNVy7xJgYh3GVV0/Qb7sSCEdsKeTK8QAOD6
         Ckhh59PW3CEe6A4g3ig9uPHQcx6UnsNyWN7sjT0B9OeUWnaupdOvo4NjN8pTkG84W39l
         ZEKA==
X-Gm-Message-State: AJIora+5kFXhZxHqmYwKxq7TCXWghNanXX4vbc6Frnbc3YXXASMm40e4
        aZZhTp2UJjph9Akj14kp4obfl35L42A=
X-Google-Smtp-Source: AGRyM1vKe47NBTiCIGTZ3A2mNS/C9PuKLNUynKpXlPkWjnRGvm1VIeGePR6zGx2kldrH4LxaKZr9uA==
X-Received: by 2002:a5d:6192:0:b0:219:aa98:897b with SMTP id j18-20020a5d6192000000b00219aa98897bmr10855625wru.341.1655503375761;
        Fri, 17 Jun 2022 15:02:55 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0039c5a765388sm6638406wmn.28.2022.06.17.15.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 15:02:55 -0700 (PDT)
Message-ID: <5bdf862c-8aed-5dd4-17c4-b2c7a2961e92@gmail.com>
Date:   Fri, 17 Jun 2022 23:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] media: ov7251: add missing clk_disable_unprepare() on
 error in ov7251_set_power_on()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, andriy.shevchenko@linux.intel.com,
        sakari.ailus@linux.intel.com
References: <20220617013943.851327-1-yangyingliang@huawei.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <20220617013943.851327-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 17/06/2022 02:39, Yang Yingliang wrote:
> Add the missing clk_disable_unprepare() before return
> from ov7251_set_power_on() in the error handling case.
>
> Fixes: 9e1d3012cc10 ("media: i2c: Remove .s_power() from ov7251")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>


Thanks for spotting this - with Andy's comment addressed:


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
>  drivers/media/i2c/ov7251.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
> index 0e7be15bc20a..40c207d1d7af 100644
> --- a/drivers/media/i2c/ov7251.c
> +++ b/drivers/media/i2c/ov7251.c
> @@ -934,6 +934,7 @@ static int ov7251_set_power_on(struct device *dev)
>  					ARRAY_SIZE(ov7251_global_init_setting));
>  	if (ret < 0) {
>  		dev_err(ov7251->dev, "error during global init\n");
> +		clk_disable_unprepare(ov7251->xclk);
>  		ov7251_regulators_disable(ov7251);
>  		return ret;
>  	}
