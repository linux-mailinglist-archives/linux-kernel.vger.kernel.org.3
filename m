Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EABE5912D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiHLPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiHLPTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:19:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57556ABF3D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:19:40 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z187so1194808pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=AFUOARZXq1xWqbjN64AF0sbE84lot9hyotvLNNmb9xo=;
        b=lbfmZHxwT4t3Yg5iuKcXAmksiLh2khCTE6SCy9nbrfz7thwsCx4jqmx1dA0pt8NM+0
         hkV/NZSiUwmo3uIDEzzFEwnZfkn6sm8zaPTgDv+/YJL1yIVldDCVOkUShJGkvME6817e
         M8AdGomQ1Rsv29+xVkBNKFPtDhEqYGvVMWTkNJRs3htsvxdN7PcufjI2R5DY6nB+4QyX
         vZBvFqWshwKdNy70WHcBVRO8e3gE/NtzpBtpOIcks5tk3tII3Up7K+6Zrf2RiVf/XIYY
         Qy6pYPpxrCsoaDJ4ZS1B6EazViNOElpOcdOmsGSRv5097Mk/l7e0In0lwf+2UDgzCn58
         awbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=AFUOARZXq1xWqbjN64AF0sbE84lot9hyotvLNNmb9xo=;
        b=7w/G2w1Xgxtc6f8hsqHm7cnkdgK8jVVBU8SejjxUIGNrWk3PXihq+4yjJZ7YwpNjWo
         8LkawLXDrx1kqS+liD9hBn0teadtyDM8TXv1F1G4bKj9vVNFThc6iMEezEbddSAj8O+5
         KDpPgj5eR7PkVCAZNMaL0lPMOaYeBpAKYr717K3tTK0+E7zGBiNkSwsKZeOVppgSc+MS
         g65mB4sCDDWmcIDVysY23B6Q32txhFtnzi4yirQSsbZUg8+ia6dj+e/uJukg+suxyflY
         cBbhWyJyhnckuCucg8DWzvCeAbILblTtuSW6Z+WlgBLK1qfiinHZ8rwEfg8RahgwDvfz
         CViA==
X-Gm-Message-State: ACgBeo01e5m4kwn62r3LdBY4+bHBDQ7/W4ZYtJ0RI7mSBdDQdRSKt8BO
        QcjZ0SSwnA7yRgVTmanc/O4=
X-Google-Smtp-Source: AA6agR4fx9z1Dt/jeLstctGLZVxbkMNmRJB3bcHfON55/30Qgmma3WWiyip1M9Vg/50p6CJBc9YRIg==
X-Received: by 2002:a63:e102:0:b0:41b:3901:990e with SMTP id z2-20020a63e102000000b0041b3901990emr3433200pgh.107.1660317579709;
        Fri, 12 Aug 2022 08:19:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a7f9100b001f8c532b93dsm1323151pjl.15.2022.08.12.08.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 08:19:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <adf3818b-1f40-ec59-e227-f474773b0033@roeck-us.net>
Date:   Fri, 12 Aug 2022 08:19:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Content-Language: en-US
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
 <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
 <YvQnbq2RhMOElQE3@google.com>
 <225747de-4348-58b3-19be-8b14356ab3a0@roeck-us.net>
 <CAGETcx895=9wPF+jnUfiycJ0k8d1S3BA0HLz42nCegtMBeo3LQ@mail.gmail.com>
 <971799be-8c15-fc81-ec71-bbca6483207d@roeck-us.net>
 <YvUzpSAQDktDPRbR@google.com> <YvVWEIn8veGL9Psa@google.com>
 <20220811195234.GA4018948@roeck-us.net> <YvXhJRlHN9OAIA5l@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YvXhJRlHN9OAIA5l@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 22:12, Isaac Manjarres wrote:
> On Thu, Aug 11, 2022 at 12:55:08PM -0700, Guenter Roeck wrote:
>>
>> Ah, it must be triggered by one of the configuration options I have enabled
>> on top of versatile_defconfig. Sorry, I should have checked. Please try
>> with the configuration below.
>>
>> Guenter
> 
> Thanks for sharing your config options; I was able to reproduce the
> crash after copying your config options to my repository :) The
> following changes fixed the problem for me. Can you please give them a
> try on your end to see if they work for you too?
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 90b31fb141a5..0315bc2853ef 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1117,7 +1117,9 @@ static int __driver_attach(struct device *dev, void *data)
>           * is an error.
>           */
> 
> +       device_lock(dev);
>          ret = driver_match_device(drv, dev);
> +       device_unlock(dev);
>          if (ret == 0) {
>                  /* no match */
>                  return 0;
> 
> 
> Thanks,
> Isaac

The original test passes, but I now see other boot failures with other emulations.
I don't know yet if it is due to your changes or due to something else. I'll do
more testing and let you know.

Guenter
