Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521AC595909
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiHPKzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiHPKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:54:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075A356FD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:22:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u1so14306082lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6y2krG3wAEmTknGGh9SWgv5ytZ0gHA2IN3Cns5M9GFw=;
        b=BtvhQgdITP9SVWq42oqxksbehGD1ih5Kbh9JO7DR9OnzuTHyzSYHB6tux+eSg54c8R
         /YYmMWImRp4q7iTHdyI5nHBhTJpLt2la8nLT0azQB5jK/LsSjdUnIQoM/3zv3toE+EpI
         YZ7zs9n4oNjIvf/+FgEx4t1GK4fsgric7tF1bPURpLnWGynjTeaurVY8oNs5Tiv6XpDm
         dAYw7Vm9fDYyInafZtJFjtfbeoUNRvIrPxMODgXeD/01TQWY3KvDwtzV4cE+Iz+LgdQS
         1XGyVCCU8wfLF08ObAyR7JD+vAwdJWREjjtaWjuXC1TkqV7+pMrWWfb/pTcvOdF9m+rn
         knvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6y2krG3wAEmTknGGh9SWgv5ytZ0gHA2IN3Cns5M9GFw=;
        b=ivFPzqCE9pC8jVGUKkQmNBrR187yQcq9BquSVISsh5W8BRW1/SdvPmm1CiogQeI892
         21f466+T6t9aI1ZLGMfiK70dLFQzJYYXBCB+ZXZosx5/1tJcqk51DDIxhF9W4R4TksDQ
         Xj5B2ugX3xZnSZ8bVFmx097wZM9z4mMc5itXtxLKmfWqC10cXsv/5WvVmbHhfr2gHpJd
         eBYzdn5CHeMkT/2GF6NGnLCCS1oEcgoGgyTd8waRkh8g/zTbiYAa9RaNtbttUDJtfpAy
         ErQstNudkTjzEgBpkFDkp94LXs830J1ysdJeRdROY/sTtJHKeokyZK7XSMPrv7I+PKFH
         04fw==
X-Gm-Message-State: ACgBeo0rctGTKhWXAoi5VB81+K06981xMXE15s9nOpUKCxGBXlmwvczv
        cFN69dgnCi1BvpNnMeVx6QtNsQ==
X-Google-Smtp-Source: AA6agR4DMyXo52/nUb1RZwWnixhPJUeaO3FFQ4Es1RNWx1ag+phFlD/ZNuPsKviV0NRpDtSdDjSUeg==
X-Received: by 2002:a05:6512:22c3:b0:48b:882d:15b8 with SMTP id g3-20020a05651222c300b0048b882d15b8mr7147821lfu.459.1660645353651;
        Tue, 16 Aug 2022 03:22:33 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id a24-20020a19ca18000000b0048a7ce3ff84sm1332728lfg.285.2022.08.16.03.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:22:33 -0700 (PDT)
Message-ID: <99d7784e-e59f-b4f7-e275-935836e5d406@linaro.org>
Date:   Tue, 16 Aug 2022 13:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 0/9] Improve MCP3911 driver
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 09:16, Marcus Folkesson wrote:
> v5:
> - Drop remove function
> - Split tx&rx transfers in mcp3911_trigger_handler()
> - Moved Kconfig changes to right patch
> 
> v6:
> - Go for devm_clk_get_enabled()
> - Cosmetic cleanups
> - Clarify the description of microchip,data-ready-hiz
> 

Please include the diffstat (format-patch does it for you, but if you
prefer to use other tools - it's your job).

Best regards,
Krzysztof
