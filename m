Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7925552BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377416AbiFVRqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358743AbiFVRqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:46:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754E3467E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:46:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f65so16730026pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpgE2jvIQSFQgAN8WwXX/5vPgLEXVBbuCYjMWpqhCMs=;
        b=QBt8d0UvvlahctWqyz9WVkxT0d4SOTK0NzVBYWVTJPxbLp5UNpIslqwUBSx8/KBBsq
         A+Zw0xj6Cb/ehzhESIgmA9cwUHsw3Lf8BxRs09qsgbPtGdNYaUcbLW8l5EWPwkZ0AQ5g
         iGESoRZXgqDD1vdCkXNbLWk/HCn9nRHSub86qFFPaZYSu/vy+4VR5E0vXlQHak7s1i8O
         a5FQABvTZhyh9Uyq1WBQj3JvkensqX0mcupgMm8ueALkWiZdB97G75hdreUpxIhT5uA0
         TA6dzh2C6/mSYctThb5VLyOmgIq2lFVNGbkMhROrYhHZTzQbRWLNXQ1rFhthz1aNZEQ+
         Lsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpgE2jvIQSFQgAN8WwXX/5vPgLEXVBbuCYjMWpqhCMs=;
        b=sb+v50jpqQ+M7Q2WeKN/KZpyp5AWArd5ne7Pg5SFbfCi9GUxPMsACDXPbNWxMYGFQY
         X9vOarqGeCOL9nFoTz202C+EE9vSkXek5a7yfmDVLIJfdBlaCMQ42ECQRHEH9QP4Eubl
         bjTLsDnUcCc1aGQuu9kwNcWhi397SUQWv5SdjIdLXdtnodDI3zbuk1DteZ2e9uEaO7rX
         oai8+T/VmJcglo4XMFo0K1l8QOP66F2WYMnY1sv84jBYScfckGB/dacQQhIPRIp2D0AR
         9IZr4gkh6iCcLWAszrWd8A0QwO+oevVdhyLquXcxrpYSuPJoIo5/bJC/ss4gm/Hlrwtu
         /EIw==
X-Gm-Message-State: AJIora/kSKEsyiOi4jXGPAB5CogcDcPbjrGMYwY89oEQE7JzJHp238+S
        St0vuaU1422vNlBc6IklTMneIg==
X-Google-Smtp-Source: AGRyM1vvmEv/0t0GsVemfxrvCV9s3hxYmKfiYakDddtSica5aCNDyttDzA/GvdXDpYo1Yp0jqBBf6w==
X-Received: by 2002:a05:6a00:15c1:b0:525:2db4:2a2c with SMTP id o1-20020a056a0015c100b005252db42a2cmr13485017pfu.30.1655919979228;
        Wed, 22 Jun 2022 10:46:19 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm29034pjl.55.2022.06.22.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:46:18 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:46:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Saud Farooqui <farooqui_saud@hotmail.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: strcpy is not safe, use strncpy
Message-ID: <20220622174616.GD1606016@p14s>
References: <PA4P189MB1421005C22E46EBD708EBA798BA49@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4P189MB1421005C22E46EBD708EBA798BA49@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saud,

On Wed, Jun 08, 2022 at 11:43:30PM +0500, Saud Farooqui wrote:
> Replace strcpy with strncpy for copying the rpmsg
> device name in rpmsg_register_device_override
> 
> Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
> ---
>  drivers/rpmsg/rpmsg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 290c1f02da10..d3b29c19715d 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -604,7 +604,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>  	int ret;
>  
>  	if (driver_override)
> -		strcpy(rpdev->id.name, driver_override);
> +		strncpy(rpdev->id.name, driver_override, sizeof(rpdev->id.name));

Please use strscpy_pad() instead of strncpy().

Thanks,
Mathieu

>  
>  	dev_set_name(dev, "%s.%s.%d.%d", dev_name(dev->parent),
>  		     rpdev->id.name, rpdev->src, rpdev->dst);
> -- 
> 2.25.1
> 
