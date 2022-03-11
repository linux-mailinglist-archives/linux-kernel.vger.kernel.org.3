Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8F4D5FED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiCKKn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiCKKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:43:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894866929C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:42:52 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 39B143F30F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646995371;
        bh=x4TvzHF8QuKQ3/zOGOuqHkYTzalnGKY2B97/GSUfpsM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wKY4ijq178WgQSNw1eeE0nkeDM3zj7C5WU4Z4yRwb0qCIaD1FVcGcjC18vwATPhw+
         VN+tNKKNjslf6OZ1LqfEXQ25w85F4M2T9RprutHcmXZ+44gzJpgxcRPTREHgpNTkL3
         EHOpAGr0mNAQwQEqClu5Y73hztZZLq/sl2UdrDAKjHfyydiA6/sf+ZznUkbWCaOADh
         3Bdamcmx5yujKhoUaY3YpghflcahiFeFDofFlMHNC4sNtktKwKbkyIrphn/Yrra5LB
         yhUo/hbvwd4ZGUn/YUG8o4bkEeiiG6Z3YzqaMQ4OR5c1e4dRfUub+016lLi/6dH+/A
         O88Z6tkjMSpbg==
Received: by mail-ed1-f69.google.com with SMTP id n11-20020aa7c68b000000b0041641550e11so4678583edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4TvzHF8QuKQ3/zOGOuqHkYTzalnGKY2B97/GSUfpsM=;
        b=2jbCo/7wf/GUnrLM8gh9UdYOoG+0QnAxbGZN7+pwrz190NpsXVileHEDBfHDYtA1Li
         ErtUAwAqqtZ5k3Ij16bjg3I7hHdVi2tUKgmF2DebHernbT4/Ly12fMsyZCjuTs6cLrh8
         DswM0gZPiYEg2KLlemgsIRqIlTxLT1h6gJELmckfVKFhFMTSn8357VSuC84/9V01kp/C
         ijNDdtxZBqgNCt4aysagP3kgCqgZktg45GnBm+a2M1pePUXaYGWr7Czbm3CzJ7VHoxoX
         oi0+n7aD6xCmHxjGv5cxP5Mn50ICPktqEkM8ESATO4dBw/9FyHJ2pYGPYqG6PP0bOnPG
         bqHQ==
X-Gm-Message-State: AOAM531CxfhCPks2/+01H4Ic0E1CUXX6un0pBCVU0lP+JanOSTvGMLmD
        pluCmFQibZGLTUkRY+72AP3DOHsYiPaFisAAGJkyA2C3s0b2XYDwiZ/9DzL1+d1vnEszF1b23wF
        Xv9RlJOTdF7hWpvonwkvahldcLIHqyvYAG2kMsD5xew==
X-Received: by 2002:a05:6402:4301:b0:415:b73f:1b48 with SMTP id m1-20020a056402430100b00415b73f1b48mr8164298edc.39.1646995370723;
        Fri, 11 Mar 2022 02:42:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5gHHbbJP79tXVqgVSmziJdzb2BPwQmpwOBIR/Tn9dJGGxL7wDFb7JWGH8AKhMGqStoPQB7g==
X-Received: by 2002:a05:6402:4301:b0:415:b73f:1b48 with SMTP id m1-20020a056402430100b00415b73f1b48mr8164284edc.39.1646995370567;
        Fri, 11 Mar 2022 02:42:50 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402278a00b00415b20902a6sm3272872ede.27.2022.03.11.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 02:42:49 -0800 (PST)
Message-ID: <ad94136d-f651-7e6e-b3ec-94553c4c6d3b@canonical.com>
Date:   Fri, 11 Mar 2022 11:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] tty: serial: samsung: Add ARTPEC-8 support
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
 <20220311094515.3223023-3-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311094515.3223023-3-vincent.whitchurch@axis.com>
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

On 11/03/2022 10:45, Vincent Whitchurch wrote:
> Add support for the UART block on the ARTPEC-8 SoC.  This is closely
> related to the variants used on the Exynos chips.  The register layout
> is identical to Exynos850 et al but the fifo size is different (64 bytes
> in each direction for all instances).
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v2:
>     - Added Krzysztof's Reviewed-by.
>     - Expanded commit message
>     - Fixed fifo size
>     - Rebased on top of Krzysztof's "minor fixes/cleanups" series.  This needed a
>       couple of fixes for build errors.
>     
>     (I'm always unsure if Reviewed-by should be carried over or not if the fixes
>     are minor.  I apologize in advance if carring it over was the wrong thing to do
>     in this case.)

For minor fixes, usually we carry Rb tag over. It's fine.

LGTM

Best regards,
Krzysztof
