Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B074B207A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbiBKIqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:46:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbiBKIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6C6CE67
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644569157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhiejNdZNc9V7Q57Z4FGfEE9W4EtgIkRByXMCdx4jhQ=;
        b=jMniQzghdCSnuvlxHcu49FP/Obyx5NWFaPwcyzzfZdjxyooE8BajYvjCf1xUbnQO8F8ju5
        pcksNg21DA5dsfClrrEk6z6jgEmqdInXVwNh66SXER1+m99CNDJ/6SfYrSzCW5EaaIe6L4
        OpEEFD18jFoE4lIPWJk3cvN/ondEI+Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-A-twu_aGMGmlRNfqQ4uQLQ-1; Fri, 11 Feb 2022 03:45:55 -0500
X-MC-Unique: A-twu_aGMGmlRNfqQ4uQLQ-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso2250625wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=yhiejNdZNc9V7Q57Z4FGfEE9W4EtgIkRByXMCdx4jhQ=;
        b=Eth+WDPVKG+eAoWqO5QDMQmlYHvq1obhtLsiWle8B3ZmCVvTLPc204p7tuAXZgrNev
         PWhei6TnMs4VoKw4gbqphZntuRR99Ijzmbz+caOllOBWG8lylYS7c5Ew7d+tAujh/jfM
         uupYOwim5aS0SwIJMFZ9qi/t027Afvf0xYxO2ZeFBlUfHzWevczp9cExaY4C7M/NScfh
         JK7QzzDjbsEzaxCfbg1hdYNdRP+YqzLCzIIcnGgaKkGSLWKrj0gwna5Zjoe19gY5oa2A
         MouI3WK7FrRmUIIhmcC2BcIYo8vxHmZ8qmiW7jNxjeORo1w4aEYLFzM1wCA6k+irthY3
         mxmg==
X-Gm-Message-State: AOAM533UeBn89s4HxTmWZ/yxs5LxIV/bR+HcJd5Y7HwRwMRsA8lV2+sT
        TK9IWM0BvErN/wOZhpRKKAZmcutD7ZYbObZArGJ+RZuYhazhQomiSXYMH6LpPsj/vlf1vt0VzPH
        oHPI5fV7Yf4wUvvvGqj1DZtg3
X-Received: by 2002:adf:edc9:: with SMTP id v9mr470924wro.135.1644569154550;
        Fri, 11 Feb 2022 00:45:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydD7roXdtXZjQWp72Wo5fcJQ6eNKNYHlSPNx2dupK8zLBlB9eyylPxhSvKDBOJgfjPqx/X3w==
X-Received: by 2002:adf:edc9:: with SMTP id v9mr470898wro.135.1644569154333;
        Fri, 11 Feb 2022 00:45:54 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id az21sm3460772wmb.11.2022.02.11.00.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 00:45:53 -0800 (PST)
Message-ID: <9ee28446-2dda-7015-1a0a-44dc8385002e@redhat.com>
Date:   Fri, 11 Feb 2022 09:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
 <58ebacd2-d44d-c7e9-e752-de7815dd4cc1@redhat.com>
In-Reply-To: <58ebacd2-d44d-c7e9-e752-de7815dd4cc1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 13:37, Javier Martinez Canillas wrote:

[snip]

> 
>> There is still an issue with the cursor, though.
>> After doing "echo hello > /dev/tty0", the text appears, but the cursor
>> is gone. "clear > /dev/tty0" brings it back.
>>
> 
> Hmm, I was able to reproduce this too. Thanks for pointing it out,
> I'll investigate what the problem is.
>

I still didn't have time to dig on this for v4. But I think that the
driver works well enough to be merged and we can then fix the issues
that are still present in the fbdev emulation and fbcon interaction
as a follow-up.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

