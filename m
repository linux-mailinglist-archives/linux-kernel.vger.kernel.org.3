Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7271D5A21B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbiHZHXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbiHZHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:23:02 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E09D25FD;
        Fri, 26 Aug 2022 00:23:00 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 45B7E24000B;
        Fri, 26 Aug 2022 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661498578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JK9COduMorPgKCAsggz5pvTrJ2MnP3XJ9ZS9Yi4YLmo=;
        b=k2jQNZTSqbhsDjWsVNPZdeykaB3Jq0J7Z1Bcvt1Vtghj2eeiqZPpEXhoIs4iCFNOST5jQ4
        tuLiCOCyRU5aD6v3FqfjRu0OztAyIy64lqBQn/GXBu7XUB3+cn7BpxkGs/csa6ngYjvw4F
        q6QPYxWz8hkcD0inkcTDLHq+jLYeEyA2/zYqITcRDDWGiyFWRGyNjziOQ2Ay1uAjUwJJKP
        +NCKhoEeOh53Mi0y+JCD6/bP+1a9mL7j2ms0yxd8YrQHZVQW/lm5OdOPzTpReqNWtL9KP+
        3N9vGd5PbATIxEjEv74YUZvNdFwqZK3pAoq/pAHOPnmzD+5ZfYnwoh7PlZ3x/w==
Date:   Fri, 26 Aug 2022 09:22:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: fsl-ftm-alarm: Use module_init and add module_exit
Message-ID: <Ywh00crgSilSfZnC@mail.local>
References: <20220826070017.2340617-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826070017.2340617-1-chris.zjh@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 15:00:17+0800, Zhang Jianhua wrote:
> - Use module_init instead of device_initcall.
> - Add a function for module_exit to unregister driver.
> 

I can see what you are doing but this doesn't explain why. Also, was
this tested on any actual hardware?

> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> ---
>  drivers/rtc/rtc-fsl-ftm-alarm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
> index c0df49fb978c..28bdc6c97b64 100644
> --- a/drivers/rtc/rtc-fsl-ftm-alarm.c
> +++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
> @@ -332,7 +332,13 @@ static int __init ftm_alarm_init(void)
>  	return platform_driver_register(&ftm_rtc_driver);
>  }
>  
> -device_initcall(ftm_alarm_init);
> +static void __exit ftm_alarm_exit(void)
> +{
> +	platform_driver_unregister(&ftm_rtc_driver);
> +}
> +
> +module_init(ftm_alarm_init)
> +module_exit(ftm_alarm_exit)
>  
>  MODULE_DESCRIPTION("NXP/Freescale FlexTimer alarm driver");
>  MODULE_AUTHOR("Biwen Li <biwen.li@nxp.com>");
> -- 
> 2.31.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
