Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B64D1199
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbiCHIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344794AbiCHIHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:07:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C63EB85
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:06:59 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C69C3F605
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726818;
        bh=J/J3P1Rwx3zVYwDz0ov2BEZ66L38jQkTdS1TVg1pvPk=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:References:
         In-Reply-To:Content-Type;
        b=Zbw6e3ZSkd1Tya/8U6oQkawzHENhy2JijLLz/8wWG8XpdoCWvf4rOQmgZqJwUfGnc
         oak77kJMbcF+jybfUcw3GIJqOL7GvPrWGkDdPFKv9rFUxcGk1HFDdQQ/ivcgQE9KTG
         n+Z1kYnmKtwQO2kTSFLA+9VgzqvcQI0u4KpwDPpfWAsvIxK21f3DxbKjjgIHO+uSoo
         cTGxvT8TFisX2ZACPGLfYM0lVW5Rb87Ux94s9AdSbK+3SjTb/vui/6jyAtNmCDLECM
         a9Hx9k8fyDy9GewZXcPCjbDCOuf+o9e3Wo/Pq8662vZmIE/pqsOBCfPnZUfLvON8H5
         hWMCEzISU+udA==
Received: by mail-ed1-f69.google.com with SMTP id co2-20020a0564020c0200b00415f9fa6ca8so6660481edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=J/J3P1Rwx3zVYwDz0ov2BEZ66L38jQkTdS1TVg1pvPk=;
        b=v5yr705Sl8VpfUWEOyKTUDZvqsVGSgwzwY2WJxdV30XffNfLV9bMf+chSDOGXQm8XS
         LJYt8g6wHT+qxEBRG8/A+HzYQSwiXvwwSauYgIV1RxN14dAcf8BhQW53dLyIORZbDhST
         ijvjM6NRcuRNOMKmo6seiViinEoWl3O9IQNGbYuku+op6aFRDXa3s5VVH1ZNCnwPeFjX
         I3EUhbmuuONltEE4XSkErzMU0ilUejzxxJRlO+J0PnSfBe9kryCaBPGCjzMjcSPBCs1A
         kibz5+f1QGKzEsJHkSEKUmXg9C/YAL2G2eQNbgS4QvAnlFo80mMybLmWXeeE3sXQNdhi
         8ziA==
X-Gm-Message-State: AOAM533LdOcgR3erU60JrffhJq1HbbQAOMQS56e5cVWk/ACiErgtH++4
        CXh51mk1Sw99lVW23zy3xRsfhklGQiZQ7MsZqo/f0kNMP15A8WtSCy//AtulnUKYJPjebv+XUPu
        EBXk2+11rVV6H6r6THNER2s/QhnncsNrVOz2fjtmPSA==
X-Received: by 2002:a17:907:1611:b0:6da:81d0:89d3 with SMTP id hb17-20020a170907161100b006da81d089d3mr12231604ejc.306.1646726817583;
        Tue, 08 Mar 2022 00:06:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJVJ4uGvVXNIf5NiHNb7QI8hmdvsItXsGAUU9dQZV9iYIVWIdyluw+ECgstG2XC7Tc1HjDNQ==
X-Received: by 2002:a17:907:1611:b0:6da:81d0:89d3 with SMTP id hb17-20020a170907161100b006da81d089d3mr12231586ejc.306.1646726817311;
        Tue, 08 Mar 2022 00:06:57 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906644500b006ce6b73ffd2sm5559069ejn.84.2022.03.08.00.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:06:56 -0800 (PST)
Message-ID: <25caed0d-ec42-54f5-5b62-8159979dadb9@canonical.com>
Date:   Tue, 8 Mar 2022 09:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
 <20220307080925.54131-2-krzysztof.kozlowski@canonical.com>
 <3eecfcea-8eeb-3ea2-566b-704c314af718@kernel.org>
 <cf34d431-22ba-ccaa-3622-a098b09a8bfe@canonical.com>
In-Reply-To: <cf34d431-22ba-ccaa-3622-a098b09a8bfe@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 09:40, Krzysztof Kozlowski wrote:
> On 07/03/2022 09:33, Jiri Slaby wrote:
>> On 07. 03. 22, 9:09, Krzysztof Kozlowski wrote:
>>> The driver data (struct s3c24xx_serial_drv_data) is only used to
>>> initialize the driver properly and is not modified.  Make it const.
>> ...
>>> @@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>>>   	},
>>>   	.fifosize = { 256, 64, 16, 16 },
>>>   };
>>> -#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
>>> +#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
>>>   #else
>>> -#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
>>> +#define S5PV210_SERIAL_DRV_DATA	NULL
>>
>> Yet, I still don't see why the switch from ulong->ptr happens in this 
>> "constify it" patch?
> 
> All these defines S5PV210_SERIAL_DRV_DATA and so on are now const and
> are assigned to of_device_id.data (s3c24xx_uart_dt_match). Before, these
> were assigned with a cast:
> 
> static const struct of_device_id s3c24xx_uart_dt_match[] = {
> 	{ .compatible = "samsung,s5pv210-uart",
> 
> 	.data = (void *)S5PV210_SERIAL_DRV_DATA }
> 
> but since the actual data structure is const, I want to drop the cast.
> Casting const via (void *) might hide some possible issues, e.g. if
> of_device_id.data becomes actually non-const. There is no particular
> issue here, because of_device_id.data and S5PV210_SERIAL_DRV_DATA are
> const. But also because they are both const now, I want to drop the cast
> via void *.
> 
> When (void *) is dropped, the S5PV210_SERIAL_DRV_DATA cannot be
> kernel_ulong_t:
> 
> ../drivers/tty/serial/samsung_tty.c:2753:33: warning: initialization of
> ‘const void *’ from ‘long unsigned int’ makes pointer from integer
> without a cast [-Wint-conversion]
> 
>  2753 | #define S5PV210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
> 

I will split the casts removal to separate patch. I hope this clarifies
a bit.


Best regards,
Krzysztof
