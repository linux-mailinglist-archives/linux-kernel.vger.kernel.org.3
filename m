Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099C559FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiFXRj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiFXRiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:38:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6A38D84
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:38:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k14so2702111plh.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMGl2uGFo9WP1IR3TTIhsHP9uWyzq0KMX5Ki6ojzI4k=;
        b=Z1gOC9MsNTnTOKdW6JLQOA6GStPqHNdMDGNQ276jBGI4DzN2LiUlL7R0CUUAxOeO5l
         TbABOthK1gLVn+F+B1T+KWRK93ogMkNVrAtbVQqOPm+aGLN8+IjtKKWgw8xWU1qItG32
         jwMxPswhDw1TyYKjbmaR4AxWdeJAaW/BIozkvOJ82HDAmO7E/3vytffty+BtamlS87ds
         9SnOHyO4Du3UNhYj9AVaaTN54ubMSjJmtZG4g5oLAz/sJBhht2057ltozkRBGeGL5HLl
         ZTKC3e4DWVYxZXGt6zM2/yj5vSOqOSbqZJr+84U4/1C8wsDqxbwA/HcpBVlZsufjJVX6
         7nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMGl2uGFo9WP1IR3TTIhsHP9uWyzq0KMX5Ki6ojzI4k=;
        b=ujrTU6ZNNSLOLaqha1lSoZO30i9yGgQsstR1cQo+iaiAM0FFcJyrEzIM3lQDA7YzE2
         NdDlAnIpxdOR1uvcMxPOr/ikK38TLGJ+WUOlSvgqkTt8REIehMm2isNtlLzsHS8R6ArP
         mwxi5f4YXMAiSYbcnRkfvzDVkQUxnlj1WY3HkASzhsiCYJmCfGDVqq880wH7amS7a3X6
         LdplCHi+iD7mTaiZylQklxHCeO1RvoTx9K3aAPUwtckXSontpeB2rFCHo/zCSOGJEPqs
         8c1vYY4jLXYmgMbkLUS7F9WI1kOsO8ScMi/+NzX0wyq8wXLdbM7Y38pU+ZnUAOXjyeBc
         nnXg==
X-Gm-Message-State: AJIora9Vsqdw20BYEm4tMO3n+uYjc/lDQLu+52o0gUVN+0dVvkVzVrmG
        mHHABoosgdiAMIwx3AxGCXarllWKTdspkQ==
X-Google-Smtp-Source: AGRyM1vR6RMJJ8QP6V4B/JeC/lrCUXi3L3lfDEB1qkp6dXgvBtxa6BeUp82g0XjBzuUEbBwVpAaH6A==
X-Received: by 2002:a17:902:860c:b0:16a:20a0:f6e4 with SMTP id f12-20020a170902860c00b0016a20a0f6e4mr181332plo.164.1656092293946;
        Fri, 24 Jun 2022 10:38:13 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w185-20020a6262c2000000b0052523f7050bsm2002295pfb.118.2022.06.24.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:38:12 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:38:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Saud Farooqui <farooqui_saud@hotmail.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v1] rpmsg: strcpy is not safe, use strscpy_pad() instead
Message-ID: <20220624173810.GD1736477@p14s>
References: <20220622174616.GD1606016@p14s>
 <PA4P189MB14210AA95DCA3715AFA7F4A68BB59@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4P189MB14210AA95DCA3715AFA7F4A68BB59@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:20:47PM +0500, Saud Farooqui wrote:
> Replace strcpy() with strscpy_pad() for copying the rpmsg
> device name in rpmsg_register_device_override().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
> ---
>  drivers/rpmsg/rpmsg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 290c1f02da10..a4bad4b00414 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -604,7 +604,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>  	int ret;
>  
>  	if (driver_override)
> -		strcpy(rpdev->id.name, driver_override);
> +		strscpy_pad(rpdev->id.name, driver_override, RPMSG_NAME_SIZE);

Applied.

Thanks,
Mathieu

>  
>  	dev_set_name(dev, "%s.%s.%d.%d", dev_name(dev->parent),
>  		     rpdev->id.name, rpdev->src, rpdev->dst);
> -- 
> 2.25.1
> 
