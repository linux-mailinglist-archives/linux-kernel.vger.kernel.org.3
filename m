Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987AB4C49A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiBYPxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiBYPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:52:56 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CC61D3AFB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:52:23 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 607883F1B7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645804342;
        bh=yZ9EwwP+e1ZUj0BFBjKUsMj+i0Q0nH6bGL/C/aUYsK4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vadVt/brUoVCjW7K/a44qASR/7JAZVqiOgaGEefFdRvxMQxQhprzWOe5EKYVlfl9U
         Lsf1dzCG4E4lW+PYanBQz+glsVz02wY901jd5cdBewOIkGLLsg9Fj81dyLowtXFmDI
         nWeXiEbZ7d4R9Gjl7eNzxrpPrpa0DR0j2Djvh7udRC5AYn6Atx5Qqfa9WlM1v6J18D
         fyfI1rl1Rr4PmHvQjk8sUuBadD9UAJKm5ZZfbDH8KhCILG0cBjdVZgQtgq4wzNgNPl
         el2l1Wtk3NsUi1zA1q2lqwwsPEurKLxwASaY5fkqlrTRbtZ0pF7uAwFkTHqGCdg/eW
         qb3ImNNRF1hMA==
Received: by mail-wr1-f71.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so1026537wrh.14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yZ9EwwP+e1ZUj0BFBjKUsMj+i0Q0nH6bGL/C/aUYsK4=;
        b=ra3XLfPkOsKiY2Loow/Urk/Q4D9TqBe89CM/BWpDthd55omu0vgN8UJDTyEiIYMqLN
         OSvZ3zqC1SxLjJgAAyeVYH7HrUcpr3DMd1DvCiRxX/4Z+haNGJ5044lGP+pcNAad7uaH
         r44IDX2jj0IKsPon9FZa7amqPBjFRMgoE8AZUiRUyHT0ZUsc05IsVox44LgO7U6NRwAL
         0HlSrYAfp0rZpEROg6gpF62m2A8pI43FzCkpxeWsCUUcZ+odWwFn0956UNPr3p4gYg2u
         XKF1zmmUQ4osmFQwFNulD3wA2rkhGzVES2upeZzISR15ZcfkWTyZQyFQ8rohXflxdDiy
         F/Ew==
X-Gm-Message-State: AOAM530+M05TTTO79MTJh3qhe4xQQ+v3VKp9FDatway83KJXD7a39I3a
        nAZpHfdxYnxqojWwJ1E8ALGaBQ84TQmTsKJW4j80FkLea6TAlxp0H08doukkV6p7w8sDa2lSqDf
        XfsY2kHkM3czAxGU8/6V1O7zLYliPVSAnO12MgqNgfg==
X-Received: by 2002:a1c:a584:0:b0:380:e357:700e with SMTP id o126-20020a1ca584000000b00380e357700emr3262553wme.79.1645804342111;
        Fri, 25 Feb 2022 07:52:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXyw01AusV2GhnVsCntKIZK4Hm/VHKopuVPbiNlfyN1OZnR5L6onnpqilHATEpOm0P2eTsDw==
X-Received: by 2002:a1c:a584:0:b0:380:e357:700e with SMTP id o126-20020a1ca584000000b00380e357700emr3262529wme.79.1645804341891;
        Fri, 25 Feb 2022 07:52:21 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b0037c2c6d2a91sm2812638wms.2.2022.02.25.07.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 07:52:21 -0800 (PST)
Message-ID: <f4225139-502e-f65c-0ea5-58235fdea92d@canonical.com>
Date:   Fri, 25 Feb 2022 16:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: arm: qcom: Document sa8540p, sc8180x and
 sc8280xp
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220225035415.2294821-1-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220225035415.2294821-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 04:54, Bjorn Andersson wrote:
> Add compatibles for the sa8540p automotive, as well as sc8180x and
> sc8280xp compute platforms. Also add compatibles for the ADP devboard,
> the Lenovo Flex 5G, Microsoft Surface Pro X and the sc8280xp QRD.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - 'q' comes after 'm' in the alphabet
> 
>  .../devicetree/bindings/arm/qcom.yaml         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
