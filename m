Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ED94AD2A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348669AbiBHIAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346016AbiBHIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:00:36 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E7C0401F1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:00:35 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF66B3F203
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644307234;
        bh=3QvcFVTPDJZuAhUiGWl4CyyIsrf8BQ7SHGDfPoIz7Z4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Azy9ELIyehutrr9dPti3umgNbLnPJo2+jOTBPiBEVt1P0pi6u8bKByc4y5wiRGmEu
         xejb8Kp+bmuPXB7/rMjHmVrECZX3KDCN+hIdyU0MZMV9z6BwOAxFKzTb1tWiZMrjoN
         gQnkwtZbHisfVmbfywesbY1ak41ZkDqs/YJfJ7Cq/Xwdsbc6Kw6bH7+lS4yndoBx5I
         EaG24HvZHn3fd9Fi3Gq99csWh2HavzRTD6A/FAt++FkWS1eKZxfbRzD+XekBkZyUsP
         v/wxS7XEXad9EggXURkn5z0v9oeEoxYo1WOed7UyLlnhcrZ6Tttxuaw1whNb1AGWy7
         4NoJmAabzgSaQ==
Received: by mail-ed1-f71.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so4061116edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3QvcFVTPDJZuAhUiGWl4CyyIsrf8BQ7SHGDfPoIz7Z4=;
        b=BqlW/D9gp36gqyNd9AbP8OKGI2DPGn2NqAKXc64zoKevKD1DTQ5oY7wKYMSG/tr8Z9
         l3JfZxt9TYfoQlZMve81ljW4N9SyauFuYD4EbPTTUrnOS7HeG6XFkbvgdtO8WtK0pq3H
         /grbGN2X8E/kv+VGoebcxVV73y1YLxxaXmTX0qnIhCVXCkp2SzS4aQE4Lbs5rVFAfDaC
         GHAf2YyXgynWsqDGMwL2tOeszb7jX3hmab0QuRU0nI53Vi/AJFcc7xVF7asAmxhf9GDJ
         3A7cydMPyYnTiGAt4mYo4TJOVWm6gkcgOYsg2nxAkmDkkuUVibwZd0ZY73IUmCXnceAf
         3R+w==
X-Gm-Message-State: AOAM532YRxhb7aGi/1yr2/U46D2sl9Lpa8Hznn0WW5d99iVgQiiG5FAL
        6Q4lh9ne8ThyUHI/TPip9iaUIQ/kecMdjWY5udGNQ8LG/cvAXxHgAUhaaKYpN0Hg0r/vDcmSyF1
        faWFu9fiTwayOqYUQ+U6/TH5GzDlqEyp2La42TQtY1g==
X-Received: by 2002:a17:907:2ce4:: with SMTP id hz4mr2635479ejc.261.1644307234083;
        Tue, 08 Feb 2022 00:00:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxf1u/l/6M5t0K3oKwiJAkWQBQCgEYcJYoIE/hf+efk9h1PxETkbhkx7zZ3KnpZ12Hq/I262w==
X-Received: by 2002:a17:907:2ce4:: with SMTP id hz4mr2635471ejc.261.1644307233936;
        Tue, 08 Feb 2022 00:00:33 -0800 (PST)
Received: from [192.168.0.92] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g11sm2486577ejs.14.2022.02.08.00.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 00:00:33 -0800 (PST)
Message-ID: <2766539e-984b-07f2-000f-051d6688c726@canonical.com>
Date:   Tue, 8 Feb 2022 09:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: arm: Trivial typo fixes in cpu-capacity.txt
Content-Language: en-US
To:     Zenghui Yu <yuzenghui@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Cc:     kernel.yuz@gmail.com, wanghaibin.wang@huawei.com,
        wangjingyi11@huawei.com
References: <20220208070300.1610-1-yuzenghui@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208070300.1610-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 08:03, Zenghui Yu wrote:
> Correct the spelling of 'cluster1@max-freq' and fix the wrong
> capacity-dmips-mhz value 576 (which should be 578 instead).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Fix is correct but instead entire bindings should be converted to DT schema.


Best regards,
Krzysztof
