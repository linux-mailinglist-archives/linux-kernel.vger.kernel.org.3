Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC14D10CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbiCHHUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiCHHUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:20:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDC338BF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:19:23 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BABEB3F7EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646723961;
        bh=g+9Wm5oRRjGP5tzhaSlJoZtPqoXXX/87ipaM5ZiCUrk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oOJNBWHqB7z7ggO/jfAuxAfnhpEK9H0QNndfqe365WQOkaBIiaqR4DfUFs/uD4Feb
         SGa+sm75CeADDeR0QjaSWARulbeVzCn5rQ0nGUVXE6kWMHX3bez6qvoLzHANwgI0tY
         3RL/Baho6p0+7xSjj3uPg+ije6lgeMJJ354S1axhHrSPrfbf+wjvVVn3YeVoFQIuP2
         XEiGh8YvlRGG8dyTfY/1PtRMZTHtgpeswLgYmUy0rWLiQXPWnOV/s+Iriy8iPh6MGh
         /2O79XvOqQuprTw17SxSQksY7MnP8xL6kfN2kAnNf+zcjm9DTSVbnPElAfBTseDCJV
         2Zt0jWcfNMp2w==
Received: by mail-ej1-f69.google.com with SMTP id q22-20020a1709064cd600b006db14922f93so2269813ejt.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 23:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g+9Wm5oRRjGP5tzhaSlJoZtPqoXXX/87ipaM5ZiCUrk=;
        b=wbcf/rw9S5Eyh+gJkxOHmuDFVja9MQpVfyV2b2V3NKpK8tunoTfXsQm+QWR2Sb+NiU
         lSe2CMJRlLXDeTFvEyOv5FmGmcgIW4/VF2YiPV+/JuGEoxz4IkQ8dmuhfi0aChHL6nhB
         J0Q1kyNr4lzUEH6PxR0MhB7KEH9Z0L8UrDKinpsTljqG9aD8YIPTvu4ADpplgqsCmWq2
         KlSOLBDdMjqJRr5DpVT1aYB2WfNLKAJMC0xeEKkJ6IeRHf+c6KbGFkJv9OuvrEwqfrmH
         9Ta2S1O2d7UJH9JfdIa4iSJ4vrIWcL8AH35YC2ogS46w9teSMsmnBuq2JYIg5oRCnX2H
         nyBw==
X-Gm-Message-State: AOAM530MfZQlRfDcAschmIzmSNPZ5cvai/tIpk4Lte9jWdyikKMKNVFi
        nITNk2gzLni6U+z7fyUFlKPZ7MVseGNqpRQi9Cb7v2su7ue1ElynVOeiwepz7t/+9mVRs93Yz08
        wiXfrTL86h5tHGP10uQ7UD5s3fPgm/dGesgfznYOnhw==
X-Received: by 2002:a05:6402:239b:b0:415:a36e:99c0 with SMTP id j27-20020a056402239b00b00415a36e99c0mr14642790eda.283.1646723961433;
        Mon, 07 Mar 2022 23:19:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUv5CjFK4sT0ujXvgJ9JrYlSDvoMpSLD55xAvEXQ28a3knkx1LSXXTnQXCyQkWQPQ2iGtZ/w==
X-Received: by 2002:a05:6402:239b:b0:415:a36e:99c0 with SMTP id j27-20020a056402239b00b00415a36e99c0mr14642777eda.283.1646723961273;
        Mon, 07 Mar 2022 23:19:21 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id v5-20020a50c405000000b004161123bf7asm5244507edf.67.2022.03.07.23.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 23:19:20 -0800 (PST)
Message-ID: <58418443-af3a-c799-624d-76fa1decc4a5@canonical.com>
Date:   Tue, 8 Mar 2022 08:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 7/7] tty: serial: samsung: simplify getting OF match
 data
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
 <20220307080925.54131-6-krzysztof.kozlowski@canonical.com>
 <CAHp75VdN3MDDEjEoLAudtRW5pgHvfgP7Zt9Hv8OOhfZbHN9hpA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAHp75VdN3MDDEjEoLAudtRW5pgHvfgP7Zt9Hv8OOhfZbHN9hpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 21:24, Andy Shevchenko wrote:
> On Mon, Mar 7, 2022 at 11:20 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> Simplify the code with of_device_get_match_data().
> 
> You may get rid of ugly ifdeffery as well.
> 
> ...
> 
>>  static inline const struct s3c24xx_serial_drv_data *
>>  s3c24xx_get_driver_data(struct platform_device *pdev)
>>  {
>>  #ifdef CONFIG_OF
>> -       if (pdev->dev.of_node) {
>> -               const struct of_device_id *match;
>> -
>> -               match = of_match_node(s3c24xx_uart_dt_match, pdev->dev.of_node);
>> -               return (struct s3c24xx_serial_drv_data *)match->data;
>> -       }
> 
>> +       if (pdev->dev.of_node)
> 
> I believe it's never true when CONFIG_OF=n,

Right, I can use dev_of_node() helper for that purpose as well. Thanks!


Best regards,
Krzysztof
