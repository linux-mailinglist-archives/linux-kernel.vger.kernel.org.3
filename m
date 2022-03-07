Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906724CF351
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiCGILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiCGILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:11:08 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9753750E1D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:10:09 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F4293F4C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640608;
        bh=rZiSscehpFaw25MYSQrGhTmta6JFYZvBO72KN+MNtGk=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=njbZPdCZJyKHnGR7t61TKG+orPwNIi9aa+VSxvJLqeIhHStKPz09cXEQt2sMIiG7i
         vqXsS4k0DiFggZvoMjv8OErvg8NbUPOVTT/PQc7RbsrOpA7Dg3/nXsCPM8gW+44ylM
         LoYhlU6yDPPr2wnvu+XV0Zw+qLUiLbkvLm7qhhggrSOQt51E7dfI+7Jro8mi/uH+/t
         +pxg0weFjpKxybSs1ISbVS2vvXYdLHnO3veleZjRur0ZMn5RTHdzuNhQgi9tIu8W9l
         bclM7Ky7X+DQZZd29NzLROa3xfBrhTBCTK8kN1pu8LbfNymbq6vlVZF1OwsFa/zf6x
         GeqVIvvBhLcEA==
Received: by mail-ed1-f70.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso7244251edb.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rZiSscehpFaw25MYSQrGhTmta6JFYZvBO72KN+MNtGk=;
        b=UlJY8Gq0ZdwNPFd2KEOgrDQ1NYGJyLe8Z+ggKfDOQVc/RCbUuc1pFmh+OXl0Qyh8nb
         szj7oEiyFyBb1+nKJzjBTZ3HEoojLvsWZfbru3LxHxVf++MAhGaJ/7lHI1kvS4Jq7X8H
         oyAQiDZZmOfq8wdTP6znvgwhwJHMbFelx+G5UpTWbl7gErL9McCdy1rXfo0ozc1NWFjY
         HNdmwGPnl+wFm+9p+/Sqyimt9zW7vE+CY9InAyKp0ygDo9FzKYKRIkcmoRrLjdmijdxe
         6AyXlf8Dsv6YvfZneeRgV7vxrzSwjBpw08hYGYxTL5Bj5yAdwHyojErs4/bIr4qEZBBM
         Xe7Q==
X-Gm-Message-State: AOAM533lz2A9ap2cih6OqEsyTS5NWQ4CqDtamRux5n+Ivas8VkDCZTEM
        TgrdU0yM3yxsCFuu0qs0DuIBfUVfSLDkwXPUJWfTi0gq/pzmqlpDrxxVijavuLznV38tpGN6pYI
        3KDRVBr86cd1xTD15Le6p7z2yfwLtYx/4OfLYHzHtPA==
X-Received: by 2002:a17:906:b6c7:b0:6db:2e14:875 with SMTP id ec7-20020a170906b6c700b006db2e140875mr2778342ejb.737.1646640608127;
        Mon, 07 Mar 2022 00:10:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyd6HS0bvQ2SwL7iCHkBfje+k5g6sDwg1lh8KmBe4nqnJ4FmOFFYvoqWBiy8wC//2osRBIahw==
X-Received: by 2002:a17:906:b6c7:b0:6db:2e14:875 with SMTP id ec7-20020a170906b6c700b006db2e140875mr2778324ejb.737.1646640607971;
        Mon, 07 Mar 2022 00:10:07 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906780400b006ce69ff6050sm4482993ejm.69.2022.03.07.00.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:10:07 -0800 (PST)
Message-ID: <9e4bd211-89e2-f7ef-735e-1d6bc9b795cd@canonical.com>
Date:   Mon, 7 Mar 2022 09:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/7] tty: serial: samsung: embed s3c24xx_uart_info in
 parent structure
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
 <20220307080852.53992-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307080852.53992-1-krzysztof.kozlowski@canonical.com>
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

On 07/03/2022 09:08, Krzysztof Kozlowski wrote:
> Embed "struct s3c24xx_uart_info" directly as a member of "struct
> s3c24xx_serial_drv_data" instead of keeping it as a pointer.  This makes
> the code clearer (obvious ownership of "struct s3c24xx_serial_drv_data")
> and saves one pointer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> ---

I had SMTP troubles when sending so this one duplicated itself. Sorry
for the noise.


Best regards,
Krzysztof
