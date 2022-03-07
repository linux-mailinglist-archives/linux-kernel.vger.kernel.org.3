Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B14CF3CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiCGIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiCGIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:41:23 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C92559A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:40:29 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 823BE3F5F1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646642428;
        bh=rO2I99jv/62SugdeMBeIu0gQLuVDL/KgowlHEXSt9XY=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=RnZRDYSOk6rS4+1PtoMtgc6GXoXaCKThFJpXB1z+I7ScPeeZdPRZBKJEhlf+4Ta99
         0kbCyBPH9sZxUQv066NHzmEW2vUrE82H/VEq6Z8wDe6snWdOu/p3h5kvmPC7q4eu4U
         ZFzELyG2ve0EnT1Xp6KV3kirWS7ymG+nlSyrGaJHWp0pAO8h1YksHeQkOF3pX0fMCN
         oT5VaN3Ersvg9286GWDhnOPBmFiFfRfT+ZZ0UQHBZbn5R7CYpumtJ7h3Pkn46ygBn3
         AOUNoVVAzarKX+MDUaYcN/U7RnztmqMtrnFdkRBCjFQQAmdaq+d6/Y/SYqSSHtSZ0x
         0XKbR8kDmE6lQ==
Received: by mail-ed1-f71.google.com with SMTP id i5-20020a056402054500b00415ce7443f4so7264643edx.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rO2I99jv/62SugdeMBeIu0gQLuVDL/KgowlHEXSt9XY=;
        b=geielPHchq9cZFnNvp3Q3TeU1AOi4A3Z53cHJucy66s7HTbkzWAHiamibz08Wlxp7C
         63omI4vT3XFXveoUI2UtFbnBFiPYX7iRJg+ccFbpEn/s7f/vgSFBWixmejBNbmSnzo8K
         HAf0tqEEwIzAOV6PP6Dfk7NiWldlmGlWOTlQ5Xheoh4IXjmUGQPcmd54HdQpSUIFYrhi
         0oA298DstE2x4rUa7e/50jyFd/U5XKLHmrfvyWFjtEKTK/6uOlQsrcv1T7E40/h9C1TJ
         OwWQx+TfQ9+Vc6Jm1N0yVz2OHERR8ajobJFm756KHPyDTWn47sizmP36e7D78frX2hbb
         GLSg==
X-Gm-Message-State: AOAM530F6/J8iBRhwxkGMZnizP4aZehT2/cujZHNuNgZdlzMLt/YCGTO
        2gKbTWi76awihgDU1UEU3+SknMqg3HPzsGbK197gsoUoBJ7rtwpbQlHO/XHAyqDG+5BGLReXqIJ
        IrTZko8NeHUQb8iGhaILwVSDRx/9M0/xXLRSR5yP2nA==
X-Received: by 2002:a50:9d47:0:b0:40f:9d3d:97b6 with SMTP id j7-20020a509d47000000b0040f9d3d97b6mr9926770edk.392.1646642427974;
        Mon, 07 Mar 2022 00:40:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL6fmdV5iKJnJB72/p5jFwG1rLkPoi95bQHxRu8Lb8Q0NaduvA8lt+bMJzhT3Gi1R4kBrBjw==
X-Received: by 2002:a50:9d47:0:b0:40f:9d3d:97b6 with SMTP id j7-20020a509d47000000b0040f9d3d97b6mr9926760edk.392.1646642427802;
        Mon, 07 Mar 2022 00:40:27 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id ka6-20020a170907990600b006ce54c95e3csm4515902ejc.161.2022.03.07.00.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:40:27 -0800 (PST)
Message-ID: <cf34d431-22ba-ccaa-3622-a098b09a8bfe@canonical.com>
Date:   Mon, 7 Mar 2022 09:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
 <20220307080925.54131-2-krzysztof.kozlowski@canonical.com>
 <3eecfcea-8eeb-3ea2-566b-704c314af718@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <3eecfcea-8eeb-3ea2-566b-704c314af718@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 09:33, Jiri Slaby wrote:
> On 07. 03. 22, 9:09, Krzysztof Kozlowski wrote:
>> The driver data (struct s3c24xx_serial_drv_data) is only used to
>> initialize the driver properly and is not modified.  Make it const.
> ...
>> @@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>>   	},
>>   	.fifosize = { 256, 64, 16, 16 },
>>   };
>> -#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
>> +#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
>>   #else
>> -#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
>> +#define S5PV210_SERIAL_DRV_DATA	NULL
> 
> Yet, I still don't see why the switch from ulong->ptr happens in this 
> "constify it" patch?

All these defines S5PV210_SERIAL_DRV_DATA and so on are now const and
are assigned to of_device_id.data (s3c24xx_uart_dt_match). Before, these
were assigned with a cast:

static const struct of_device_id s3c24xx_uart_dt_match[] = {
	{ .compatible = "samsung,s5pv210-uart",

	.data = (void *)S5PV210_SERIAL_DRV_DATA }

but since the actual data structure is const, I want to drop the cast.
Casting const via (void *) might hide some possible issues, e.g. if
of_device_id.data becomes actually non-const. There is no particular
issue here, because of_device_id.data and S5PV210_SERIAL_DRV_DATA are
const. But also because they are both const now, I want to drop the cast
via void *.

When (void *) is dropped, the S5PV210_SERIAL_DRV_DATA cannot be
kernel_ulong_t:

../drivers/tty/serial/samsung_tty.c:2753:33: warning: initialization of
‘const void *’ from ‘long unsigned int’ makes pointer from integer
without a cast [-Wint-conversion]

 2753 | #define S5PV210_SERIAL_DRV_DATA (kernel_ulong_t)NULL



Best regards,
Krzysztof
