Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB224D2B70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiCIJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiCIJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:10:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43214F9A4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:09:03 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2DB713F1AF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646816941;
        bh=WzHkSBUQpjp6lbzAQCdNWpRnWZNKxL9bPgaE1U5jbzc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iTMWEx5kqBub5kJk/mV3kyM3geHDAgrzoNcdYEak3SoCnDTQ7lHFRgjAmjBFTsSg2
         Dux6BtpJmqELIWrRMpmKxnq79C9qqmfCGn9AjU/mZjwgdMXy8FB5AM7eo5VG350mCO
         k93aSHfKHGMvY6kGN9yzM1tWdHRTk7zO1iPVQ+fVneVT+aF/TazfH/kSmD9Ni55r4t
         9XxeG7imH8nvyZ9sWob3kLooBpkw33Dlc6QNg61qoZpM7bafu5no5GNMgxFpo5mK2l
         /w8SGb1T+LzyCeMQYGw9JDi0KYhQrGOrimMOC9rG11JONAGo5LDoDQHApLpJmtPU9E
         rXFrzqPbumo5A==
Received: by mail-ej1-f70.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so941310ejk.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WzHkSBUQpjp6lbzAQCdNWpRnWZNKxL9bPgaE1U5jbzc=;
        b=t7gksT0/xI38kg7hZhKu98maJTg19ILExWSKI6wCrcRHQPf21BkKagOG1qEbfJIan8
         vS1XfLXgttXEl8jQpILqt5kCKOBfc88+hxpWujW8lPt1f0POPOBmkiCO0t+zjyS82kHR
         1iEjhjBoIIoWzBdq3UFfj+CcEeRnEqGFCnQ85PWsKp6U+IfBtcONBjjVoS0ULuuNS+8S
         wZ7H9MdDbONHcHAx7u7Ho9LC6tFbOI4AtebmrK1QitJJxOok+ZzWGrYYbR1sYdyNMqSa
         k6nXT23YcYOod4bO94hcvQ9k2xogpPzB+0j9WyrYkfClH2jwai9EsBY2dHIGyyqal2/2
         7yug==
X-Gm-Message-State: AOAM533zGLvolhUfJgMEBw7cQp+yNdbW0d7f+Mqm/GEEVi9JI6UlhSlh
        JKLJyGUxIodO1eaPRkJA2DcjilY7CEKgKY5DwLQR1ASRHCg6FkZg9fBd4j3ox5AofCo9lE6yWEk
        ABpyLz4e7LZb8UYXJZqQuLpGaDl6RpulHdV+yv/lfoQ==
X-Received: by 2002:a17:906:31c1:b0:6c9:cfb3:4dd3 with SMTP id f1-20020a17090631c100b006c9cfb34dd3mr16530541ejf.392.1646816940895;
        Wed, 09 Mar 2022 01:09:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyokg1UCn/6f42J+LUZN2KQU+wzLO/g3QE5jQNu/CJVwGdXXaVXsl0iCLmJT1kJ7fjTkbU2tQ==
X-Received: by 2002:a17:906:31c1:b0:6c9:cfb3:4dd3 with SMTP id f1-20020a17090631c100b006c9cfb34dd3mr16530530ejf.392.1646816940747;
        Wed, 09 Mar 2022 01:09:00 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id dz10-20020a0564021d4a00b0041665989a9csm533969edb.41.2022.03.09.01.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 01:08:59 -0800 (PST)
Message-ID: <730c8fd2-111e-e028-43d0-0942df2ce188@canonical.com>
Date:   Wed, 9 Mar 2022 10:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5190A PMIC
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1646812903-32496-1-git-send-email-u0084500@gmail.com>
 <1646812903-32496-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646812903-32496-2-git-send-email-u0084500@gmail.com>
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

On 09/03/2022 09:01, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for Richtek RT5190A PMIC.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt5190a-regulator.yaml       | 141 +++++++++++++++++++++
>  .../regulator/richtek,rt5190a-regulator.h          |  15 +++
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
>  create mode 100644 include/dt-bindings/regulator/richtek,rt5190a-regulator.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
