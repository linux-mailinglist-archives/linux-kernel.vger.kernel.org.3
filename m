Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955024E1B90
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbiCTMSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiCTMST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:18:19 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E3D40A0D;
        Sun, 20 Mar 2022 05:16:56 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id r22so4958908ejs.11;
        Sun, 20 Mar 2022 05:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0m+DD8jcICWmSL15nXNS8VPv5AmHQkrE/XIE2Q+G2GE=;
        b=rjU7Mt2sfeaVa6ld32t3QpGQxMsT/6pnsdUPcIfeygGhnAotB/S5kQ/Vvn3kH/88FS
         XXoIDChtGEvWGbpomF+bQFI1z/IHJQST6D+dnaJKxWhsdf33wMPtnM95JdsGdK2W4P18
         wyOqe6e1JelHl4VQovCmFtU06Aum2al+h5yTU3ioiV9a76/YG8fdINN2u6XHy8ScGt+L
         ltfuexe3ext2STap6lSTwEFD1MqygbpJd0VQ5PeYyJ8Dm0CiJQkAxLvNTVGuGsoORJPe
         lCZgel/PSju56dRhTfMDVnovzI2vZY42V0UdDdk9U6fliTpz8KqjdJYdKLBie3pgpeDE
         8TGA==
X-Gm-Message-State: AOAM5325AxbFjAT6jilzC5aabBJb0pyAnMV+a/cHgQQDIZuDTTaxto26
        8ZUkHTNP/OSj0pMNT3/AJMo=
X-Google-Smtp-Source: ABdhPJxT5vk1JEx9+TNT5+JbcYdHzOLhGcIkH/AVyoEc/atVyPY2CknAwBKJ25W/gAZfMZtie3BKwA==
X-Received: by 2002:a17:907:3f9e:b0:6da:842e:873e with SMTP id hr30-20020a1709073f9e00b006da842e873emr16743467ejc.383.1647778615069;
        Sun, 20 Mar 2022 05:16:55 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id u24-20020a1709064ad800b006d70e40bd9esm5846284ejt.15.2022.03.20.05.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:16:54 -0700 (PDT)
Message-ID: <56dabe01-d44a-9c6d-aee5-da606f557b93@kernel.org>
Date:   Sun, 20 Mar 2022 13:16:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Avoid some over memory
 allocation
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <69d7e69346986e2fdb994d4382954c932f9f0993.1647760213.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <69d7e69346986e2fdb994d4382954c932f9f0993.1647760213.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2022 08:10, Christophe JAILLET wrote:
> 'dmc->counter' is a 'struct devfreq_event_dev **', so there is some
> over memory allocation. 'counters_size' should be computed with
> 'sizeof(struct devfreq_event_dev *)'.
> 
> Use 'sizeof(*dmc->counter)' instead to fix it.
> 
> While at it, use devm_kcalloc() instead of devm_kzalloc()+open coded
> multiplication.
> 
> Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> devm_kmalloc_array() could also be used to save a few cycles because the
> array is fully initialized a few lines below.
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Thanks, looks good. I'll take it after merge window.


Best regards,
Krzysztof
