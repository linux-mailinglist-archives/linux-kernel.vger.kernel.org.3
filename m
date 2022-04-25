Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C950E7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbiDYSWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiDYSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:22:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B511E762BB;
        Mon, 25 Apr 2022 11:19:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k29-20020a056830243d00b006040caa0988so11356390ots.6;
        Mon, 25 Apr 2022 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uvc5bXo42oHV87Iw9NQ/VTqufRs0I0hy2e2+bdje3+g=;
        b=VUxb4hFjZXiyUmglDD5gpJqRXkW4D39teQmSSqugFTQHRlNDVeiy0RgmlforeYQNn9
         FPKS98aqWUrOebLtGt+ud/nycq+dyLhGbVJFFsDA8XrRLaKGlkYP1hceFtR8IcMU1XJs
         x2ngq188gNkg02jCIZBuoYtBPlAokEie23BWlGa8iNgAZ1OAkMQ9iL4cXRmEbw/f9sWy
         n5UXoUp3st7UxkRQbLl4b2c8EQ2fsE7azOCUIv8RkQt47JWJ9SaBrdoZagQEBDysk+x0
         Gq6a20E96ap7BRniFuem8Qkr+HSVfE2ItyBkp51oUoAbfsHy0gSeQdce2cR3S1ZrufKY
         1ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uvc5bXo42oHV87Iw9NQ/VTqufRs0I0hy2e2+bdje3+g=;
        b=vEjZjDwMPGf+bJJk6o2W6oQONMybiiodO48eL6uYFWj2teD5F5TP6nhr5so5j09iDY
         rq3dSnDCIEX/e9jxS1v+Y6juD1SZkk81ncHZtGlFUnNZI/Bykv9NtP+7PSE+aqIDPpFH
         CSMDbUOH1dADptlzA8eddjKe8+wpBi8jvWg7pYVO273CqCasuj/gu/D/WhdgDQTB7s1n
         +mNXGbvEX1vxs+EkYu6lj38wiK1Habe1FN1PP8PhohwFCTIVEjrM3G7LQ00zYsZNCkQG
         2Do4jL7shAQDpvenBq6H+GLlb7NHDm71RrGp/wJLIFDdwcCiPlEliv1yP7qb8qfmS/nw
         /oog==
X-Gm-Message-State: AOAM5314RZxa5ZjA/gtW+5l+A9Fvi0Y9zTb6gui6TPDmbsOqiOQCzLC6
        sP5V2pSzg12TMnlsBK0Cnbw=
X-Google-Smtp-Source: ABdhPJzc0+Nh5njthZAYBYW8ruRLx2H8O0qHhlQJFMBkpAlDlpy9erArbqSgW3chxUCdDMPo79oiqQ==
X-Received: by 2002:a9d:5f14:0:b0:5e6:c009:213f with SMTP id f20-20020a9d5f14000000b005e6c009213fmr7163684oti.35.1650910757973;
        Mon, 25 Apr 2022 11:19:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a05687036c700b000da4bcdae42sm3475587oak.13.2022.04.25.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:19:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Apr 2022 11:19:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Camel Guo <camel.guo@axis.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] hwmon: (tmp401) Fix incorrect return value of
 tmp401_init_client
Message-ID: <20220425181915.GA4175249@roeck-us.net>
References: <20220425100019.562781-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425100019.562781-1-camel.guo@axis.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:00:19PM +0200, Camel Guo wrote:
> When ti,n-factor, ti,beta-compentation are not defined in devicetree,
> of_property_read_u32|s32 returns -EINVAL. In this case,
> tmp401_init_client should return 0 instead of simply pass ret to its
> caller.
> 
> Fixes: c825ca044988 ("hwmon: (tmp401) Add support of three advanced features")
> Signed-off-by: Camel Guo <camel.guo@axis.com>

Good catch. Thanks, applied.

Guenter

> ---
>  drivers/hwmon/tmp401.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index 8f49da997367..a58a2f31a07e 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -604,7 +604,7 @@ static int tmp401_init_client(struct tmp401_data *data)
>  			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int tmp401_detect(struct i2c_client *client,
