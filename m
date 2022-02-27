Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA314C5A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiB0K7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiB0K7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:59:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F84DF46
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:58:39 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61F2A3F1B7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645959518;
        bh=2bOCiusGq2ul/MWsE8cSC2kGM7wquiIO9nYKtCZH63I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bATA61xMq9rLGkt6t5BC9H4jpR6EW41nnCA5E1ZX4+Tck4E70nDedfeDVvq6Izoiq
         kc/Wl7VbUNH6FpGc24aO4SUfNaKVYRAsGwwhIAIPwsg1hV5nc33lAIKDD0ZOnd4Vc6
         c14Bp0VE5/wPE5lvRX/EWTBqynxB0ntgN1gMgOmb8eGyXCF1Yuijms4M64o9Dni8MB
         pNdkb2MdJwhjPMa+1DMNtOelJIjPpP5foMh5Otwg4GhxxwQ+rdw7b5e9pnm00Jv2ch
         tkjSMXQtUrBnopJbUfbVyytzVmyWMsMP91DgTxdAPDPMPNhG4pp4JubUSr+nEPQI2G
         t2AhGb9NRCeIA==
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso4078235edt.20
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2bOCiusGq2ul/MWsE8cSC2kGM7wquiIO9nYKtCZH63I=;
        b=ixfYLr6JDdT0a2lCx1wBoc7rDFUfE+0qd51WVmL/Ms+JnXE3zHhDR4ZotSA4E6MVbl
         UQ5IfaubXRVfieThxLWRpO5YRRuVrOwLdU6zr6Hq1MMUpRFgtJojapjRTYlQCkQAmWUF
         pUjnGMi1i8+wr62KZpJ4afBn5aFY6LzMR8ulFsnuWJp1hXGWTy+G9yiRjUogriOv7eMk
         0uNyeWbLGso/op8wBZDKTFc9yAbfOjdTmXLu3esEpdLaSZfI7odFhASMimGDnXQ+keYE
         IyNlDm0v5O0walgaBnfmg95IK3ONR9vhOYbNzZ0mbTCE4yWaeJbMdiUeMCXNTSmwRIW+
         /gFQ==
X-Gm-Message-State: AOAM533MkhQtEIO8zi3fKYmh3+tD8p7iipl8sPuDZpQFMq+9YavSvlT2
        JQuHeOf3zfXTI4PApGMTrKf2j52SVupIPAaV8Oo9Tue3QcQUFxnDjV7CEWLwBojkJQm2q4Jh6nw
        qK1kpgPX0FBBPrEri4dDH0YsCwXbjW287gi4dQJ0rtQ==
X-Received: by 2002:a05:6402:350d:b0:410:b608:ff4f with SMTP id b13-20020a056402350d00b00410b608ff4fmr14922910edd.89.1645959518000;
        Sun, 27 Feb 2022 02:58:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoFbq1X2KP1qKbtNx82/SCmsEevJmYxZ2Bf2LLbkURS/vDpov5C3QYi0mxgeV/lId9Uap8Sg==
X-Received: by 2002:a05:6402:350d:b0:410:b608:ff4f with SMTP id b13-20020a056402350d00b00410b608ff4fmr14922898edd.89.1645959517865;
        Sun, 27 Feb 2022 02:58:37 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id t2-20020aa7db02000000b00412cd5d5148sm4403973eds.47.2022.02.27.02.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 02:58:37 -0800 (PST)
Message-ID: <e6f3ceb8-7b02-020a-7b2c-07520f6d9661@canonical.com>
Date:   Sun, 27 Feb 2022 11:58:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] dt-bindings: hwmon: Add nuvoton,nct6775
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Renze Nicolai <renze@rnplus.nl>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20220226133047.6226-1-zev@bewilderbeest.net>
 <20220226133047.6226-5-zev@bewilderbeest.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220226133047.6226-5-zev@bewilderbeest.net>
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

On 26/02/2022 14:30, Zev Weiss wrote:
> These Super I/O chips have an i2c interface that some systems expose
> to a BMC; the BMC's device tree can now describe that via this
> binding.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/hwmon/nuvoton,nct6775.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
> 

Bindings should be the first patch in a series.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
