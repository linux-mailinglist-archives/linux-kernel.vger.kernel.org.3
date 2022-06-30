Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C818562044
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiF3Q1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiF3Q1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:27:20 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F232051;
        Thu, 30 Jun 2022 09:27:19 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id r133so19656072iod.3;
        Thu, 30 Jun 2022 09:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/eRRfsESn3hEDvJuznxEqjr9DgXsw8PFQnlAfRwQgZk=;
        b=mBoltm3F0etQmf013b40NcCJ/JNp9fQUBSde/d32Rz0VFRV9aOwQOJkdKAgUTCKvQF
         zuF/R3tYqrwfnhCADFeBAeT7/zC/QryN4gFt4gynrZqdviooCps/A3o5nyy/SonK+tzZ
         K2+qBDCje0MnMYXR0kT/2hDM4GYiA8DKHSECgJJXsEKk7uX32BolW0cRlySKZe3DOe2u
         vMLbfBhOVPnddlYZRFcjyFYHGjsJoYXbPcz/ef4Xcj1pUFKCigfgQUj1Rx0BqudBJkdb
         Xxrn3GmgPIC/qjLAgGXYnRqTAeKdVUSR6kPzxL/JJInj7937XPOS+XcgjA7e7TbKoDZq
         GoJw==
X-Gm-Message-State: AJIora/PKZsQG2hdH2nos4CLVGDibRHhAXObZLCBuODIB4yiSIiV3zwR
        rr5HV3yA+0k2VVD3YzKO1A==
X-Google-Smtp-Source: AGRyM1sy1XL71KJZdOUdcctIv/vE0kNsrL6qK3olqJ8/Cw4Ku5F+To33COo/FDEmMDkh6MX+4BGKLA==
X-Received: by 2002:a05:6602:2c4e:b0:657:4115:d9e4 with SMTP id x14-20020a0566022c4e00b006574115d9e4mr4838969iov.91.1656606438489;
        Thu, 30 Jun 2022 09:27:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d5-20020a026045000000b0033c836fe144sm6629285jaf.85.2022.06.30.09.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:27:18 -0700 (PDT)
Received: (nullmailer pid 2846747 invoked by uid 1000);
        Thu, 30 Jun 2022 16:27:16 -0000
Date:   Thu, 30 Jun 2022 10:27:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Frank Rowand <frank.rowand@sony.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 1/2] of: unittest: Switch to use fwnode instead of
 of_node
Message-ID: <20220630162716.GA2842206-robh@kernel.org>
References: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:50:09PM +0300, Andy Shevchenko wrote:
> GPIO library now accepts fwnode as a firmware node, so
> switch the module to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: no changes
>  drivers/of/unittest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 7f6bba18c515..5a842dfc27e8 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1602,7 +1602,7 @@ static int unittest_gpio_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, devptr);
>  
> -	devptr->chip.of_node = pdev->dev.of_node;
> +	devptr->chip.fwnode = dev_fwnode(&pdev->dev);

Perhaps I want the DT test code to test using the of_node pointer. We do 
want that to work, right?

I'm really not a fan of fwnode'ifying things that are DT only. It's 
really pointless churn.

Rob
