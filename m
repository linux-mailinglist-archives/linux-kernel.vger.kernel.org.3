Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214F6510A22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354433AbiDZUTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbiDZUSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:18:49 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295920F65;
        Tue, 26 Apr 2022 13:15:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v65so17240439oig.10;
        Tue, 26 Apr 2022 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WxppPzWLYNA+81VUjAnYWO9LgxHOLhASEpeHW0n+B1E=;
        b=am0tRX8zv7sbt0cJT98VnkmSxAR2HSuYLlJyKm7/FwlRgdy9pMui6CIr5XcTVQjTU1
         tLvNr4m26L201zwPArojxr+quk6vSF0rcRNLSieec8yQ3F6mMVJL9gmVea1xP9mvghgx
         IVCspx8T8hfE5bmt6gFcyArX4xalgiBezKSGVr7FBr3v5gJ5VZl4Hk3sIa7g0KDh2siD
         Cgnqfa9CSMondi292nzbLTXVflMsMFX7HTVpoiB4qV4CGgRU96/aLXmcibDA7THcZmIH
         u9QBK7kcrRt48vXfT5hfhHHWKUpRdpCGm77nMzH4ra3pj+SB+KLqmXcjtf+uv+y/mOav
         yFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WxppPzWLYNA+81VUjAnYWO9LgxHOLhASEpeHW0n+B1E=;
        b=2YZ0YOPVdu9g8pUBmiwowhd7P+2vgwF1ZpfJoKPVjt9MidI2KKCES9PrU+eUOTH1/I
         1kutdiqPbU6D+nMz+d9WPlL+ZTKrA+UBcXWVyNEpgvvx9PUywKPXeLCAjIpcAAbPEcs5
         iAdjQkoud1AscePZ2hLn3ORL4ZDzmjr+Zla6ujpskP5IMvfd1me5Y6j4IqumK1XEh8Ip
         0tYS2QR3QjrqOF8Yg3aKBpoYsUaaRImMcc3Wh/U4UXSvK6aKy4MiKcTX31sy8Lp9cezr
         40NCtMv4ABoH9f4b1toTBd/F6tU5pugQwYl4nlRCb33tA7FNe/IVXA6ep4To9bHL8Rv3
         Xthw==
X-Gm-Message-State: AOAM530BGj8P6+kZbEFHTyiioG7JnAfxJG+GlpsR3yijgXPRVZCGx9oj
        5Z0Ay+MRfHRA9EhjdkNM6i0=
X-Google-Smtp-Source: ABdhPJxpxGL+eWpPlmKdNL9LiJxmuhemz/rq18UeA7KYeFJvnX6YyOnTTf4K9gKNmRdzXpPcNxmJPA==
X-Received: by 2002:a05:6808:1201:b0:325:75e1:25a8 with SMTP id a1-20020a056808120100b0032575e125a8mr418635oil.18.1651004129790;
        Tue, 26 Apr 2022 13:15:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bq4-20020a05680823c400b0032304581da9sm5396968oib.13.2022.04.26.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:15:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:15:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, tzungbi@kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] watchdog: wdat_wdt: Stop watchdog when rebooting
 the system
Message-ID: <20220426201527.GL4093517@roeck-us.net>
References: <1650984810-6247-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650984810-6247-3-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650984810-6247-3-git-send-email-liuxp11@chinatelecom.cn>
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

On Tue, Apr 26, 2022 at 10:53:29PM +0800, Liu Xinpeng wrote:
> Executing reboot command several times on the machine "Dell
> PowerEdge R740", UEFI security detection stopped machine
> with the following prompt:
> 
> UEFI0082: The system was reset due to a timeout from the watchdog
> timer. Check the System Event Log (SEL) or crash dumps from
> Operating Sysstem to identify the source that triggered the
> watchdog timer reset. Update the firmware or driver for the
> identified device.
> 
> iDRAC has warning event: "The watchdog timer reset the system".
> 
> This patch fixes this issue by adding the reboot notifier.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdat_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index df0865a61a70..6f36a653767b 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -462,6 +462,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	watchdog_set_nowayout(&wdat->wdd, nowayout);
> +	watchdog_stop_on_reboot(&wdat->wdd);
>  	return devm_watchdog_register_device(dev, &wdat->wdd);
>  }
>  
> -- 
> 2.23.0
> 
