Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0C4B7877
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiBORB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:01:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbiBORB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:01:56 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC51111BC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:01:45 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B64853F1D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644944504;
        bh=6A/iTuzJN7RYXq4i8TAWxW9tcqq87v/WRpExFN3KMZw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Z/bI4jRVp0iV8LjMy2nKanT4TQmlrU9FZfOisWCupNJvsIMFLBJ2f8Mdj8PGfpbKb
         QWooHcXbmpr2stcSun4CqAWxA9lwY6b4p6kGKnZEpExtfibRJ5t40FDFL1teO5j8rl
         cfh3yhYzGo1BMVLYosnQhtkvqazJS6fWW00tFSu/5tg8cMRshESremzk7WFWmJbeF/
         DdMcmcKqCnNiXyWXMhfRSLgFfSZkuuAWwf8tzH4zCB5tcjUqUD+RELvzeIyiJ6Typl
         puXqGoNms38lqM4kgvWHSa7srI9zPwN70D62CG91D1SRWZzuWFY5xhLI+SYkC21oe8
         at1and6+Coq7Q==
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so150592edw.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6A/iTuzJN7RYXq4i8TAWxW9tcqq87v/WRpExFN3KMZw=;
        b=D6j/CAKVapSPbB0/YykqE4oqVhlFuhRs9YXR4RjAzOtkXqkMyyZKVC23H5SI+7rC65
         vzU0FRDICObG/Wp3LSVsp/4eVonpoDxzsLGxdKeZNJAGyFlptbGcD8LJwFQZtXONjO85
         rAYcF5mmqdMa8lucdRQqnPhOXKg/v1tWIFscoy6Fd0AghqAioiVbGWZacga3ncHMNyNB
         TJAdigqQghG3g1nb7t7pHjPat/VtNmcyN2GT8QbKRO2W/4GI2ukmXsZX/jfJKte/1UHi
         Lhsq82A93VBpQ6cpH6hgBOie4YWp6gRrH2YQJRVk05rAyRrqX9S3icSMLPTWDvYBWsie
         sUQw==
X-Gm-Message-State: AOAM532y6EvO3+p/jS0g74xM/byD6aGBinWKpH4Ln+4rwJ757AQN0yoc
        dQhRsfny0Hjbg+gWFOkAY1Pql4gegPpjxy4QRi/T6Lf5CKohxQyVDj1NQgP86Y9khaRj7tGvn9t
        oIylvvCv3EpXbwm7ap0jJOj0mte1gdi1OTWipFp1uFQ==
X-Received: by 2002:a17:906:dc92:: with SMTP id cs18mr7306ejc.656.1644944504434;
        Tue, 15 Feb 2022 09:01:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMfu8uzDlw79VM9qAXnSGrPIDJXnTQ1CzhlI1Ng6oF7bX2eWB0r/zeyGYCkcHmpFYe06/6Vg==
X-Received: by 2002:a17:906:dc92:: with SMTP id cs18mr7284ejc.656.1644944504213;
        Tue, 15 Feb 2022 09:01:44 -0800 (PST)
Received: from [192.168.0.109] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y16sm208777edd.0.2022.02.15.09.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:01:43 -0800 (PST)
Message-ID: <33c226ca-334c-7458-62d5-5480d6657ebc@canonical.com>
Date:   Tue, 15 Feb 2022 18:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] dt-bindings: ps2-gpio: document bus signals open
 drain
Content-Language: en-US
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
References: <20220215165113.52659-1-danilokrummrich@dk-develop.de>
 <20220215165113.52659-3-danilokrummrich@dk-develop.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215165113.52659-3-danilokrummrich@dk-develop.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 17:51, Danilo Krummrich wrote:
> The PS/2 bus defines data and clock line to be open drain, this should
> be reflected in the gpio flags set in the binding.
> 
> Especially, this is important since the clock line sometimes is driven
> by the host while being used as interrupt source.
> 
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
