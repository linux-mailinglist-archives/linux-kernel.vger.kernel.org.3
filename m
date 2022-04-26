Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAC0510A39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354855AbiDZUT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354853AbiDZUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:18:55 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140F2729;
        Tue, 26 Apr 2022 13:15:44 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso13828690otj.5;
        Tue, 26 Apr 2022 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1nZK4LL1ygLY1Nj0F4n58Fq2vqu0dCliNETQaPqLm+c=;
        b=JaIR2Rvou6MXvUbQKIrUi5yzrY7zLCiDR9R2PUNcMoMi7y/t4eFN6OHhJP7JkiC+q8
         jucncSgW1oFuNuxjmzbZ76s6YlqHQdvpS/IQ7IrSgLaPJlAaCTHm4pckhL1HEj2tkwMV
         nzTVRg3xJH1UwumLaY48pvUHv5VkoknqfV/dJxBZDeiGUSpENbfcLYJ5cjh5hH5Rvbnt
         Xvz5Eps7RKqEVxj9CfJ1WrHbwKlyegQUQHvGIBceymC64lPhV3c8H+0PgzwmiH7D6pc4
         F7RKD9P+IXghyu47vG66JIM6cA26kS07MuzrcgvBLfLA1efTHJmD5dOmmez2QtKmISFM
         w51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1nZK4LL1ygLY1Nj0F4n58Fq2vqu0dCliNETQaPqLm+c=;
        b=QeCkQEBpM0GUBIFQWakvdeTpKUlJEUWtlk30p3d7Eggh+gZwSN+Cem3uwRv9Ld1+eu
         f8IXPn1RQeeSkJD6fOgix8AXKhED1xjh7RDtvJxSP1DRsYDAVmWM91LPWbfkyCC1qwP5
         nqn/Xe+k+ztkTvEFBkXzHjrdkJuHaRV/WOO+jlPhR1RjVdPnuPwsmqbF5gdYza//UKZC
         EwUH+SoZVIrosN6UU0eLec8PCGEz67Rw0YGTm2W4vP58K47hPlOOuuYjspjnN1c+77JQ
         s+KRLLPcjZYVpEOTlWXvrF8Dkx/Ka4Vofm+ADBCvmY61LBiqCQCmjeNL+AC5hlVieEJ7
         joHQ==
X-Gm-Message-State: AOAM531HRmPaqh3IXvLJU5qRAF21nOwDTsZhfPL4QSRs0PYeFqXmHf45
        Sfd2wXXapgE+6eAuDIMsxzM=
X-Google-Smtp-Source: ABdhPJwYSuHy435B9Z5a5PcfNeVmW0J3NH61zH/JkhPcaTpP4mFb21PM1DgwH6aGr7locf/VelqCJA==
X-Received: by 2002:a9d:4796:0:b0:601:94e2:ce0b with SMTP id b22-20020a9d4796000000b0060194e2ce0bmr8834819otf.197.1651004143906;
        Tue, 26 Apr 2022 13:15:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6-20020a4a84c6000000b0035e5906bcc4sm4190958oog.4.2022.04.26.13.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:15:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:15:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, tzungbi@kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] watchdog: wdat_wdt: Stop watchdog when
 uninstalling module
Message-ID: <20220426201541.GM4093517@roeck-us.net>
References: <1650984810-6247-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650984810-6247-4-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650984810-6247-4-git-send-email-liuxp11@chinatelecom.cn>
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

On Tue, Apr 26, 2022 at 10:53:30PM +0800, Liu Xinpeng wrote:
> Test shows that wachdog still reboots machine after the module
> is removed. Use watchdog_stop_on_unregister to stop the watchdog
> on removing.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdat_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 6f36a653767b..e6f95e99156d 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -463,6 +463,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  
>  	watchdog_set_nowayout(&wdat->wdd, nowayout);
>  	watchdog_stop_on_reboot(&wdat->wdd);
> +	watchdog_stop_on_unregister(&wdat->wdd);
>  	return devm_watchdog_register_device(dev, &wdat->wdd);
>  }
>  
> -- 
> 2.23.0
> 
