Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8C592F52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiHONDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiHONDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D048313F14
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660568628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9looORc2B9jMHH3VzUUV0AiKpljw9fLhRn4KnsP/uTk=;
        b=HNLZDXW6Iucj8uS7/F3Pf/+u20Fh4D4hU9XaS/hhmP/d+OskMpGvZrlV1f3lvixzNcg+Vb
        GNvNOwO/cmZ0QbGc3TJDl3bUSoNpyYZvPH2mstUflZsIHIGS6zAfrlCFI52J8NHmQAeoyW
        esokOEyU6lsveGER3OEaWsr5dk40IE8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-272-oXMugPedOneRX22GxfrOrw-1; Mon, 15 Aug 2022 09:03:44 -0400
X-MC-Unique: oXMugPedOneRX22GxfrOrw-1
Received: by mail-ed1-f71.google.com with SMTP id z20-20020a05640235d400b0043e1e74a495so4752592edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9looORc2B9jMHH3VzUUV0AiKpljw9fLhRn4KnsP/uTk=;
        b=l+C8mYDpz3NLcdQjnvlGK4HT4M4iHdQ7V/Vjk47QsVjK0LSMjQwtrC3DQNIz3064qu
         q39YLCfTMxiu4fBS5yQPZjrIm8ZW57C9a6cuwfQXC/AE/XHvSgrHlU8hBpJVkBAfZ/d+
         0TocJRGYSw+++2R3pS+1AZKBxAyQRihYV5yBRsN+Nikm4RSRo6tZg0OcWSF1MnbQCe6r
         S56vQ4PAaviGdoQvKgJeQQq5GWC1Ji8cDAQxh4cF/9F4wKyfPDe8Svq/5vjHePTkyYQ6
         9BBuErpWzHItRSnVHqw/nnhPK8cgDV11R6Ux2Tyfqs9Iy2phktdnjtYg94IZ+Jo4L0ct
         4jWA==
X-Gm-Message-State: ACgBeo1XO8Z2FmfsAqpFRm6nIGczQ0A/D0SaXhrPVzxMrbqHL4hpgYtE
        Otr09TnxnEbpvvKQRLoeMxxMbHrZ2COw+HBQa7AgeVwxqcgBS+9qfBnlj5ghIdnY2gtGs7ws6BP
        pnFhOyehZ96GMkAFKdCtuugg/
X-Received: by 2002:a17:907:72d0:b0:734:b451:c8d9 with SMTP id du16-20020a17090772d000b00734b451c8d9mr10212913ejc.272.1660568623395;
        Mon, 15 Aug 2022 06:03:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7SDKIwXTY8qn3QWNAK4WGFrAoJ7ewW8hNElK4OlyhW26psKDdMWu1raCkCKzrAeCtTLZCjqA==
X-Received: by 2002:a17:907:72d0:b0:734:b451:c8d9 with SMTP id du16-20020a17090772d000b00734b451c8d9mr10212901ejc.272.1660568623216;
        Mon, 15 Aug 2022 06:03:43 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id m21-20020a170906849500b0072b6d91b056sm4084346ejx.142.2022.08.15.06.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:03:42 -0700 (PDT)
Message-ID: <7f616e90-f38d-64b7-a2f2-b847b237edd1@redhat.com>
Date:   Mon, 15 Aug 2022 15:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] platform/surface: aggregator_registry: Rename and add
 more HID device nodes
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220810144117.493710-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220810144117.493710-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/10/22 16:41, Maximilian Luz wrote:
> This series is twofold:
> 
> Patch 1 and 2 rename existing HID firmware nodes to better reflect the
> devices they represent and the hierarchy they are placed under. In
> particular, the three previously unknown nodes are for sensors, firmware
> updates via the CFU mechanism, and for a USB Type-C Connector System
> Software Interface (UCSI) HID client.
> 
> Patch 3 adds support for sensors and the UCSI client to the Surface Pro
> 8 by adding the missing SAM-connected HID nodes.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> 
> Regards,
> Max
> 
> Maximilian Luz (3):
>   platform/surface: aggregator_registry: Rename HID device nodes based
>     on their function
>   platform/surface: aggregator_registry: Rename HID device nodes based
>     on new findings
>   platform/surface: aggregator_registry: Add HID devices for sensors and
>     UCSI client to SP8
> 
>  .../surface/surface_aggregator_registry.c     | 44 ++++++++++---------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 

