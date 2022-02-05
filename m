Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2A4AA859
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiBELfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:35:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44166
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243390AbiBELe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:34:58 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C4E5040031
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644060897;
        bh=8wZjc4AJmUICEN/J47+AHu6zl7TY1OVui5hLAqvkGdQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=vj4XFnlbcInIcHR5RxOkB/aijWrDe/l9eH/srv90HqrqG+PXpsPALNBmHT/WZ9XuL
         imQbz+/kj6GUyLb7496MCBWe1CiEtjKQDG5NJAOX/gY9+P6T5ciXCRKzAkjqJNuOzc
         nUw2i2LWvl0LJmrzlv2DKF1hp8Uy4r6xcbtvxNRz1DZtUP7APBEhhO8kvVXjbFY1Ke
         vQaJxv6L6EskXEIEMANYIc8cUoFWyy+ss3QZiOkyA97xZEk6O5HXmRdeXx6tkM2JXf
         HKu/LOKCoy71zqt8AURDp2arcKCoOQYw6xE6PhvoHI/dDlbY02RvvE80lSm2INum+k
         OLK4jDP4JuX2A==
Received: by mail-ed1-f71.google.com with SMTP id o6-20020a50c906000000b0040efa863337so1730499edh.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 03:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8wZjc4AJmUICEN/J47+AHu6zl7TY1OVui5hLAqvkGdQ=;
        b=jGxhePhFjqRqfTXxQdduShjj23/kkyXmR14ddXNQLG9QInkygyY6yhuKdMhCeRpYRT
         N6VzEVvZZldaKS6JCVW/BBrpnrphj/8QzSeijv+9AVjIUhejv6Hk00YiqDSgeDu3YnS8
         Wart2wDvrO3bB7cAO0Q2J1tYnDeknR746MX9g0HqljDawMGMlmT8BkFypgpTLNq7W7yu
         I5DUGioiU66bHjszPofUowK/z+fdxR46LKkxoozGnZouslOg6RMlGSqBdKRTDS06NC/a
         kXXeLbet1IPtDolE0tN0ea90qYWk3lINm9d+m/yqrFM6dWxNdsyhDgI2Zqs+NN5Zw1oV
         GMjA==
X-Gm-Message-State: AOAM530cFxdAxrLcohiiNr2oNi1c2koEv0B5PULIhbFLz+x2x/yR25lp
        3lYirDp0ekg2YV8NDEQRJSbI0nGjEUlYkvVLP4TZO/OifqNA6xIncvRnjPUxRKu8/7ed11pNcQn
        jy//FbCR1bdKjZrLfs4+5EDuMYwy4WSS4L89qjEJO8A==
X-Received: by 2002:a17:906:9514:: with SMTP id u20mr2771806ejx.227.1644060897137;
        Sat, 05 Feb 2022 03:34:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNClAORm0Is6CvvWa0A5wmi15Ut3l492E6QUKdnkYGlK2vqHYbGFsJvHLoIE4y9hBSj7zuGQ==
X-Received: by 2002:a17:906:9514:: with SMTP id u20mr2771793ejx.227.1644060896994;
        Sat, 05 Feb 2022 03:34:56 -0800 (PST)
Received: from [192.168.0.83] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ec52sm663468edb.24.2022.02.05.03.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 03:34:56 -0800 (PST)
Message-ID: <3dd66b36-5b91-6cb7-cdea-851e780e3d54@canonical.com>
Date:   Sat, 5 Feb 2022 12:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/6] dt-bindings: memory: lpddr2-timings: convert to
 dtschema
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
 <20220201114749.88500-6-krzysztof.kozlowski@canonical.com>
 <23d38615-6b75-8715-0f83-fc93755a708b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <23d38615-6b75-8715-0f83-fc93755a708b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 20:48, Dmitry Osipenko wrote:
> 01.02.2022 14:47, Krzysztof Kozlowski пишет:
>> +  tZQCL:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      SELF REFRESH exit to next valid command delay in pico seconds.
>> +
>> +  tZQCS:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      SELF REFRESH exit to next valid command delay in pico seconds.
>> +
>> +  tZQinit:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      SELF REFRESH exit to next valid command delay in pico seconds.
> 
> Hm.. these look incorrect.
> 
> tZQCL is Long Calibration Time
> 
> tZQCS is Short Calibration Time
> 
> tZQinit is Initialization Calibration Time
> 
> No?

Yes, thanks for spotting these. Copy-paste error.


Best regards,
Krzysztof
