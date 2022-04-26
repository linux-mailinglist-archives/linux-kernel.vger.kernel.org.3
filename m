Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3458250F530
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbiDZIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbiDZIek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:34:40 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6281078933;
        Tue, 26 Apr 2022 01:27:31 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e93ff05b23so5549026fac.9;
        Tue, 26 Apr 2022 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JyWiIRUPQ2EQSPq1mXaopILM4bH8C27NOUyoSKH0Kx0=;
        b=GnmfzeNbJetLPcgOVIDW167P97CHVrHZEtM+M2S9wFPQjOUEmoHfTfmzpCm2EjZM0K
         whuvCP9KJpqrXXQUmXikaAC0v8o2lDEi0kjrpgfsFM3y98aKviiAn+MXpe1N3OdOLlRG
         xl2/UNLA28EBEjDv7j1N04M6Lt+6ZzTPZc265ucTjKj83saennVZrRWbCx5e8sLGMeVx
         ygCiGroytXMSHv5y6S0AgYw5vDoXwxPkQA4ow2axQs7VAndznkVgZEmwZpgpfWs6aUQR
         JpArsopYmKPWSPsnzCHLU1XfQePgiqgCJbV3ZMQU1Qw+qjqnQsUghQM+vF4LFb02MSSr
         4QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JyWiIRUPQ2EQSPq1mXaopILM4bH8C27NOUyoSKH0Kx0=;
        b=SN9wRxAJAO89dU1lPsl1tsqJLkGIoBzbtlKR7C1XwD7eTb4SxFbhJUd1ZjJRvqRDZh
         3AxfzV8kcmFqcSZlcVIZJzqFpqYlClPulAPGkF+j36pjRuvEZIDBnRsT4H+Nr7lfZai1
         TvShU8w8+Thwj98I4BYnLsfwFkPZo3wBFCI6PK4ztHNQfgbOx+dPqzMSobF4wQoTuMBr
         GBg3Y460hdmcQ/1t9jjsjdrJlSY0GlYbDmph0GSOruC/sXO9y7NSm/76qb8tfCPo5ggF
         Q1EiWBdMoBELRsDdAWvgTYrFiS/DcTp4ZAgsBXU+m7mFhUQVI0lglItqNmZRkOI/eVzT
         Wqyg==
X-Gm-Message-State: AOAM533Mc7McIkChWqLPZYlWcSm/9k4pux+E+C+ifj4wiVGcxx1lgewD
        cC0ncf2SdwSB7NECy5dZ6EC+lWFrWAQ=
X-Google-Smtp-Source: ABdhPJxI6qYl36Xp+qPV11OmVb8RL5z0QIOZJOtq0tjrrNmAI9DxIvRi55kIn0SC5Jq7y7Xi1v4n/w==
X-Received: by 2002:a05:6870:5a5:b0:e2:896a:80c with SMTP id m37-20020a05687005a500b000e2896a080cmr8381464oap.131.1650961651221;
        Tue, 26 Apr 2022 01:27:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9-20020a056808056900b0032252797ea4sm4718739oig.6.2022.04.26.01.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:27:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aaccd71a-64f7-7d8f-f5a7-41164ad80f1e@roeck-us.net>
Date:   Tue, 26 Apr 2022 01:27:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 4/4] watchdog: iTCO_wdg: Make code more clearly with
 macro definition
Content-Language: en-US
To:     "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>,
        wim <wim@linux-watchdog.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-watchdog <linux-watchdog@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650957029-910-5-git-send-email-liuxp11@chinatelecom.cn>
 <9f991b4d-8f02-6c07-a8b6-2861837a0224@roeck-us.net>
 <2022042616173226700718@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2022042616173226700718@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 01:17, liuxp11@chinatelecom.cn wrote:
>     On 4/26/22 00:10, Liu Xinpeng wrote:
>      > Using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS reduces redundant code.
>      >
>      > Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
>      > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
>      > ---
>      >   drivers/watchdog/iTCO_wdt.c | 12 ++++--------
>      >   1 file changed, 4 insertions(+), 8 deletions(-)
>      >
>      > diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
>      > index 3f2f4343644f..8d24cf4f4ca3 100644
>      > --- a/drivers/watchdog/iTCO_wdt.c
>      > +++ b/drivers/watchdog/iTCO_wdt.c
>      > @@ -635,22 +635,18 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
>      >
>      >   return 0;
>      >   }
>      > +#endif /* CONFIG_PM_SLEEP */
>      >
>      >   static const struct dev_pm_ops iTCO_wdt_pm = {
>      > - .suspend_noirq = iTCO_wdt_suspend_noirq,
>      > - .resume_noirq = iTCO_wdt_resume_noirq,
>      > + SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(iTCO_wdt_suspend_noirq,
>      > +       iTCO_wdt_resume_noirq)
>      >   };
>      >
>      > -#define ITCO_WDT_PM_OPS (&iTCO_wdt_pm)
>      > -#else
>      > -#define ITCO_WDT_PM_OPS NULL
>      > -#endif /* CONFIG_PM_SLEEP */
>      > -
>      >   static struct platform_driver iTCO_wdt_driver = {
>      >   .probe          = iTCO_wdt_probe,
>      >   .driver         = {
>      >   .name   = DRV_NAME,
>      > - .pm     = ITCO_WDT_PM_OPS,
>      > + .pm     = &iTCO_wdt_pm,
>      >   },
>      >   };
>      >
>     Sorry, I fail to see how this is an improvement.
> 
>     Guenter
>     --->
>     #define NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>              .suspend_noirq = pm_sleep_ptr(suspend_fn), \
>              .resume_noirq = pm_sleep_ptr(resume_fn), \
>              .freeze_noirq = pm_sleep_ptr(suspend_fn), \
>              .thaw_noirq = pm_sleep_ptr(resume_fn), \
>              .poweroff_noirq = pm_sleep_ptr(suspend_fn), \
>              .restore_noirq = pm_sleep_ptr(resume_fn),
> 
>     NOIRQ_SYSTEM_SLEEP_PM_OPS, defined for CONFIG_PM_SLEEP, will
>       point ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
>       function. Vice versa happens for ->resume_noirq, ->thaw_noirq and ->restore_noirq.
>       (commit 020af89a41c41fd2c92d0da524968dfaba6269f0)
> 
>     Some power management occasion needs freeze_noirq/thaw_noirq /poweroff_noirq /restore_noirq.
> 

That isn't what the commit description and subject say. Change description
and subject to describe what is actually done, use __maybe_unused instead
of #ifdef as suggested, and do not invent Reviewed-by: tags.

Also, this is an independent change, and should not be sent together
with the other patches.

Guenter
