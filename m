Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D582C51B545
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiEEBdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEBdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:33:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4F4A90B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:29:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so3032409plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 18:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=axmZLYy89B3XsolG0763PYww9N2YXIvHmGNfehtY9bU=;
        b=cdCo8Q+RrEP+/j/j1NMrf5VnG+nCqXx/wR6uxeJ4EL0CasKAs3hhxdG3sPLWTaRnJ5
         mskeeCwDpCtFm8a20V32z20Fg73iOFzc3pkB3a4ukjrv0NOfd41zBYVokdKZYyRqV455
         c/q8uTjRf3tzLB5YC4d/Ec0qVQ1XPLzpTDNlWOGS5NfnXwjDxiBOmcGGqsLkDCdoH3/A
         xBfK97HYnrCgq4dFjBY9FcmkyY6Z7V2BMOsJ8b8zt5aABZQ+Icm+DArfGzVr+ELmtXHz
         b11LNCvq6bOtMm+2dlTLYfGX1Bs/rCthXtITHDhS6f/qK14wXffdTmnE+OprS5cEfKh9
         xuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=axmZLYy89B3XsolG0763PYww9N2YXIvHmGNfehtY9bU=;
        b=X/iiAdfW7fKoqj3NLawDaFWg+hpOO9yDaIrnpHP+e5K0gIZRz8+Sc0v/FVafyjGUdI
         icfqF1X0GtFNBkjoY0WkIoen/jFgckUD1vGqXLlHIwV5L6biY/5uBTd2f/KWs3o38tig
         +V2o9RygDdiAQfA9uTXYkI13rvt3EXRT2p+Dpl2ExDSwOuXAPTKBTEuoX/amqPOuNImb
         yI+WxHfLmwpy2kpYqKvxOY3VxSg+azoQvUoe1IoqTqzLaXpnmj/9/XvOJHEIt15TvF+o
         clVx+1i59xkbUgyGoSVERqG8ik8h9ZOkwhZWSZz875dDA4L034DZfCRUe7suBbLPwrCt
         7OPQ==
X-Gm-Message-State: AOAM5331xAtFBLIrEV0NmBoHfKTst1weWN2TMfrNzlqIEXE2CB176aEC
        H9EE+MWsC5amgpcew64zu6w=
X-Google-Smtp-Source: ABdhPJyoSuEoqs49Mg1qwZdYE3bbRPnsDNIoBDGM4MqV+4CWc+1FfvWMI5m2H+yeZ875spqYgJf3Ww==
X-Received: by 2002:a17:902:ef49:b0:15e:b6ed:4832 with SMTP id e9-20020a170902ef4900b0015eb6ed4832mr10897989plx.173.1651714163285;
        Wed, 04 May 2022 18:29:23 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b0015e8d4eb24asm136572plg.148.2022.05.04.18.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 18:29:22 -0700 (PDT)
Message-ID: <3e01d35c-e748-3e03-4417-8b7dea09075e@gmail.com>
Date:   Thu, 5 May 2022 09:29:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] hwtracing: stm: fix possible double free in
 stm_register_device()
Content-Language: en-US
To:     alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220418081632.35121-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220418081632.35121-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

On 2022/4/18 16:16, Hangyu Hua wrote:
> put_device() will call stm_device_release() to free stm when
> stm_register_device() fails. So there is no need to call vfree() again.
> 
> Fix this by adding a return after put_device().
> 
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/hwtracing/stm/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index 2712e699ba08..403b4f41bb1b 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -915,6 +915,7 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
>   
>   	/* matches device_initialize() above */
>   	put_device(&stm->dev);
> +	return err;
>   err_free:
>   	vfree(stm);
>   
