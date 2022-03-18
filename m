Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D654DD9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiCRMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiCRMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:55:01 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79131DF8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:53:42 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id u3so11260574ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4mu2OuGaPzAlSckILaZwyPu3lEiEzcu9CZya493fP8E=;
        b=saaQzXzI8UZ8u3oHra1CyTZxJexrxjlIHuyPiJtMquAD2IkiBiDVh0KPi+dAwg4AHl
         khBC1TmwAkGNDajrpUC4kuCLTvbcrROVQqMyrBfjPT5YqDxqXDZGKLejmeZ/EHaReuNx
         SyubnqRsp4fB4tWdml/3kP9T3xzG2yHK9msCynJo2xopijVga8h1lDGFgW78pxOGvkHf
         3tiCEcJ+3swyJjoP3huJz7oZWtbG4IlkzbzyzFRH0X1mtYzykUn9Y+wa/AoU/aWk/D0m
         wvaefjbRhlOxrjT7SvSRBeDy9TABNesmU9otDxW0mV/BtHB69KkahbuziaGZbQaJSLKU
         ozWw==
X-Gm-Message-State: AOAM533bcbjOGEqwbUNmUTf6UDA+NH65spKqf07yHd7r43CwNQ5Htxe/
        nk2pl/C5+IGCE5vxxGCYKq4=
X-Google-Smtp-Source: ABdhPJxQ9uko5et6u+LegwREFDr5bEBIZhwzLZ4c47FNelbGTzZYJD439JkB+S5faUXXtgm0Yi7G1A==
X-Received: by 2002:a05:651c:1209:b0:244:b99d:8902 with SMTP id i9-20020a05651c120900b00244b99d8902mr5872302lja.185.1647608020684;
        Fri, 18 Mar 2022 05:53:40 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id c7-20020a2e9d87000000b00247ebe11990sm954625ljj.10.2022.03.18.05.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 05:53:40 -0700 (PDT)
Message-ID: <5bc9ebe3-5c0b-2d72-4574-1630056c883e@kernel.org>
Date:   Fri, 18 Mar 2022 13:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] memory: atmel-ebi: Fix missing of_node_put in
 atmel_ebi_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220309110144.22412-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220309110144.22412-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 12:01, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle() with refcount
> incremented. We should use of_node_put() on it when done.
> 
> Fixes: 87108dc78eb8 ("memory: atmel-ebi: Enable the SMC clock if specified")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/memory/atmel-ebi.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 

It's too late for upcoming cycle, so I will pick it up after the merge
window.


Best regards,
Krzysztof
