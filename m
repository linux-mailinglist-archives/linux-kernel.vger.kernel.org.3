Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A045D529DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244590AbiEQJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiEQJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:20:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FCA2AE17;
        Tue, 17 May 2022 02:20:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j4so30201841lfh.8;
        Tue, 17 May 2022 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u1u68XBlOoqhQlGBcvLtqUGc4JmYDMhCSzrjxV3ZoEg=;
        b=U2tyNAjwqBTWVt+uAa1+1l92ZWUT0TikMXMZ4M4/JtVFfdFxf0fV4gYZwRk3ELbi8N
         Wt5mbUHCpbqzF/pmvr4+TicqhkEOhhVGYQM4CpCjRUDu+52esgCjvJtKyHIfWMmUVR3r
         p+hVAE38t1k7bQvgLQZYnlVzoWLnsqOZPS9rJvpAYAOn/mVHKc3YC5kRSHkvfHK11v2m
         QDerHO3Q8OWjq3Sx9eYbtzCm1qZ8DljqDmwnW0SVC+uEMiU93CZvzyXO0RItvUHJfKGy
         Ag593g3SqjjDxOdQjrEwdh3NZ+yV2Ry0JwMjG1CGo3JKtv6TZkzYLtMUdz6PV4t7ycet
         nuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1u68XBlOoqhQlGBcvLtqUGc4JmYDMhCSzrjxV3ZoEg=;
        b=gI8laU0ctJbpoBegK+D01BiorhrpO1Id6+ynXSe3xyCh4bcRhcoP1DprCZRa70jLrZ
         JHkLXV821EcQ6uOEY9zc6GaFJQBcwvrJbPy0R4xm8+J2vlCQQ497Uo/6rMbFY8tPFA1P
         B3I/sQ61UInP49aTCFEaHMDW9Cuq2AxU2CVjb8OIYOFqzVWzbDc7aMG5jHQhohhVdGfD
         m5xpNVlm18n4pWbbbjaUr4xWwph9nsQ6Fu7cuXOJIq0LxJ/H6C1e09jtlKldas26XC64
         rlouJ65GhBt+EOjImG5Nt0OSklMiRi2izHpmG5JN/wFC9sDpPJYWdemcqFuQ3pWr7GJG
         n06w==
X-Gm-Message-State: AOAM530ffu1n2dPkP3J9ph+PQtwamFH8wgtU/B7YhPVOQh9KollVrVN6
        rjazhI1RglhYoyS+KTLbSxpau++8zPg=
X-Google-Smtp-Source: ABdhPJwnsme02W8duFxrEVD9RI1ZPaBP3YaO1auHlKwka+mKyKSpL7rsbHZIt4m2cmMTPkeln8MYRQ==
X-Received: by 2002:a19:a418:0:b0:473:c1af:fc9f with SMTP id q24-20020a19a418000000b00473c1affc9fmr16141770lfc.575.1652779235847;
        Tue, 17 May 2022 02:20:35 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.77.211])
        by smtp.gmail.com with ESMTPSA id w1-20020a05651234c100b0047255d2118fsm1533995lfr.190.2022.05.17.02.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:20:35 -0700 (PDT)
Subject: Re: [PATCH -next] usb: typec: ucsi: fix return value check in
 ucsi_acpi_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
References: <20220516131527.999909-1-yangyingliang@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <da320390-b47f-27a3-06e6-c4f660a41873@gmail.com>
Date:   Tue, 17 May 2022 12:20:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220516131527.999909-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/16/22 4:15 PM, Yang Yingliang wrote:

> If memremap() fails, it never returns NULL. Replace NULL check

   Oh, memremap() does! But devm_memremap() doesn't, indeed. :-)

> with IS_ERR().
> 
> Fixes: cdc3d2abf438 ("usb: typec: ucsi: acpi: Map the mailbox with memremap()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 7455e3aff2be..8873c1644a29 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -133,8 +133,8 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
>  	}
>  
>  	ua->base = devm_memremap(&pdev->dev, res->start, resource_size(res), MEMREMAP_WB);
> -	if (!ua->base)
> -		return -ENOMEM;
> +	if (IS_ERR(ua->base))
> +		return PTR_ERR(ua->base);
>  
>  	ret = guid_parse(UCSI_DSM_UUID, &ua->guid);
>  	if (ret)

MBR, Sergey
