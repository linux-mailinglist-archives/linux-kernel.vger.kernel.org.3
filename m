Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2804CA438
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiCBLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbiCBLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:52:49 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48FDBAB8C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:52:06 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8359E3F5FC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646221925;
        bh=GZ+2gRpwKiQW36vuEeC1R6O1z6W6FXlkVCMt+nuuy1c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VT+rVZNfBj+nKfYmg/tutfP0Nv3y4RtQh/4j7iTWQF0yQLOY1urUfFI/M3Qr6OG/M
         AI+kuPW8MliFePZThcX3JJnJL28GeiW0FTRfVeKZzoQ1XaT22RZ9kF83Hmyfh5TggA
         /0cx8MMLMBmUdGi3dwaj8JUhEdjRjBpUH9+IoFeve9JkFuGCpJc2FwzB2nAVduaIV0
         MWPOBwFtGpwtPxi1XJuygI/SbcZ1Qv/S1ROpdWkoBx10utXiFlRwdu8WDOyH5O6G4x
         7mhsitO56pPUCAgBvf5mRCfkcqoSOxP0eJ19jQkGgwWpscpZSTRON6UlwXP97I4YYF
         Cc//H9guDzCUA==
Received: by mail-ed1-f72.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so845955edh.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GZ+2gRpwKiQW36vuEeC1R6O1z6W6FXlkVCMt+nuuy1c=;
        b=nC9d2LMAva73vYpjjOBx+le0ZZdQUX1jrq44m8q7H0rFW5Jl6S4c9Zluk5baN07d6q
         aLOY+Mw9rSHHeMxbf9HFf9y3p/TLlRpaFBJXfuCMUwE7duFA4pQlnLfoH4Acns9u7GT4
         QtDt42pww3zP44OSvHjn1NVLkhL7ElFQzgsDYz95CJY3c7KonZKdAJawNds9tX3+8vd8
         SVE2vspS60M6hM57FB+4gRxWyQjEo7IwslTYn0YhWjk61C4QFk2uTe70iHIuts2Gutym
         ZsUgpvk+cQGFmohaqz3++TjymegbBTq4+UhkRN5I2aCNfIqsaMzX7L1nC7Wo3ykl+H1M
         AfZQ==
X-Gm-Message-State: AOAM530+hfADbqKOd+wBwTWQQUk+5cJYFmtPXy4Jy844FTHJagrJLNWo
        6H1Fkshr+ARAufGGWBG25xYgtgv3uXtPVu7FhKM3bGYfExOYg3obv6AVXW1OonLOQsgIPhzNq4V
        f7ac6HnMKaUwttWRkWLPODGUtSzrU6ApwiwkgMCdZ5Q==
X-Received: by 2002:a05:6402:372:b0:40a:bbf4:7973 with SMTP id s18-20020a056402037200b0040abbf47973mr28811633edw.399.1646221925299;
        Wed, 02 Mar 2022 03:52:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHlgE9lrc9DIKhd5HEEpVRbPqfpkzxaQ24qbVi00bwUH6CL9gHM16wriclt0C6f0bHFRgaaw==
X-Received: by 2002:a05:6402:372:b0:40a:bbf4:7973 with SMTP id s18-20020a056402037200b0040abbf47973mr28811606edw.399.1646221925129;
        Wed, 02 Mar 2022 03:52:05 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906340400b006d077e850b5sm6286439ejb.23.2022.03.02.03.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 03:52:04 -0800 (PST)
Message-ID: <6f17b476-0bba-5820-5cf2-7c888750ce31@canonical.com>
Date:   Wed, 2 Mar 2022 12:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] serial: samsung: Add samsung_early_read to support
 early kgdboc
Content-Language: en-US
To:     Woody Lin <woodylin@google.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, markcheng@google.com
References: <20220302114923.144523-1-woodylin@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220302114923.144523-1-woodylin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 12:49, Woody Lin wrote:
> The 'kgdboc_earlycon_init' looks for boot console that has both .read
> and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
> console to support kgdboc.
> 
> Signed-off-by: Woody Lin <woodylin@google.com>
> ---
> v2:
> add 'const' to 'struct samsung_early_console_data *data'
> ---
>  drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
