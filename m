Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E34FA1AE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiDICgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiDICgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:36:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7592D1CA;
        Fri,  8 Apr 2022 19:34:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q142so9279656pgq.9;
        Fri, 08 Apr 2022 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/4sfvi1I4GkLrH3xXCLL3IJlhgXOJprc6Zo+ZFJfsU=;
        b=Cklb5C/a2OjoWvBYK0FY8Mq9hos7f0y9adz3G74e1YGKpI4dUzl2pqzjbEL3Pmm6a0
         MQX3CKHIVWc6PA1kyxbiIykaGLcFDvDuQRuG65QwKHG4HdvoPcxO+fVtAQg/strJrulM
         XQP6PAHqRuVIlisVYuuNcU8Ta2U7P8lBq4mp/SpPAMmYf/nAmaX9l/XDsrqmyd/2yLav
         b1yOaaLXV3JO0Mxhfo6W2VZNBH4kfuDFgu1Dcg4KxS9ptgOy+XhF+/pdMVlLh4K1EB80
         kwC7V17ee5pHRvFD2e4C440dcNiXbyURfoBVskxZDZTS7pKsHIkVDMtcDv9M5xqbmPOX
         2e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/4sfvi1I4GkLrH3xXCLL3IJlhgXOJprc6Zo+ZFJfsU=;
        b=PLYfeC8VURMC5H16iUzJbj5a2PrgczgmlceMZCltSYChR5DohGL/PGB3zjR+wove9u
         +OAOeT12K+T3++BsUbUiEmo/2BZtARKNtwijcHpovi3nUznMsKILCWz7p/ddYHtcXHPS
         AQ9PHXdjYBeifa2ygyOYWZlP61m/QpINtOUWdnAgMuiyag5IdJnUYheF1QTiYtCJCbXe
         h+OrScimHCF6oISfobsMLojM7N1bfF90xLxx+hL+MuwN1iiDo6qDs75Qs98ftPjb+vah
         veRgq76IN5ALWs6vlEDLdFx0DNWTEfT1PubmgBdk4roQMbBXCofrCH2cL83rgHRGmK7c
         NG1Q==
X-Gm-Message-State: AOAM532AoGj/A8pScNkjg5jAVfT12dSr9ZDouI2hBQR8B9vT1N7iJg2U
        rIiXrbFFPUnyBd5YEFTQhpw=
X-Google-Smtp-Source: ABdhPJz6KJChjKlx8GDpD+WnjJcO+NtxG1L4cgezRKMwc3qcoNT0xmoKYfvSOvrvBgtYPJxxcWCjKQ==
X-Received: by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP id c18-20020a056a000ad200b004f12734a3d9mr22626769pfl.61.1649471653394;
        Fri, 08 Apr 2022 19:34:13 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9186:332c:bcb2:4506])
        by smtp.gmail.com with ESMTPSA id k9-20020a635a49000000b0039cc5dc237fsm6016149pgm.8.2022.04.08.19.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 19:34:12 -0700 (PDT)
Date:   Fri, 8 Apr 2022 19:34:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     y.oudjana@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: cypress-sf: Register a callback to disable the
 regulators
Message-ID: <YlDwoazfX4rcf4ho@google.com>
References: <20220409022629.3493557-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409022629.3493557-1-zheyuma97@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheyu,

On Sat, Apr 09, 2022 at 10:26:29AM +0800, Zheyu Ma wrote:
> When the driver fails to probe, we will get the following splat:
> 
> [   19.311970] ------------[ cut here ]------------
> [   19.312566] WARNING: CPU: 3 PID: 375 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> [   19.317591] RIP: 0010:_regulator_put+0x3ec/0x4e0
> [   19.328831] Call Trace:
> [   19.329112]  <TASK>
> [   19.329369]  regulator_bulk_free+0x82/0xe0
> [   19.329860]  devres_release_group+0x319/0x3d0
> [   19.330357]  i2c_device_probe+0x766/0x940
> 
> Fix this by adding a callback that will deal with the disabling when the
> driver fails to probe.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/input/keyboard/cypress-sf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cypress-sf.c b/drivers/input/keyboard/cypress-sf.c
> index c28996028e80..798611b76de6 100644
> --- a/drivers/input/keyboard/cypress-sf.c
> +++ b/drivers/input/keyboard/cypress-sf.c
> @@ -61,6 +61,13 @@ static irqreturn_t cypress_sf_irq_handler(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>  
> +static void cypress_sf_disable_regulator(void *arg)
> +{
> +	struct cypress_sf_data *data = arg;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> +}
> +
>  static int cypress_sf_probe(struct i2c_client *client)
>  {
>  	struct cypress_sf_data *touchkey;
> @@ -84,6 +91,10 @@ static int cypress_sf_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> +	error = devm_add_action_or_reset(&client->dev, cypress_sf_disable_regulator, touchkey);
> +	if (error)
> +		return error;

This needs to be moved to the spot after we enabled regulators. I
adjusted and applied.

> +
>  	touchkey->num_keys = device_property_read_u32_array(&client->dev,
>  							    "linux,keycodes",
>  							    NULL, 0);
> -- 
> 2.25.1
> 

Thanks.

-- 
Dmitry
