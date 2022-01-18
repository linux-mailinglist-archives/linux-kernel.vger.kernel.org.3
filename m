Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB4492D90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348171AbiARSkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:40:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44126
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348183AbiARSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:40:05 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1BA7740050
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642531204;
        bh=f+2umpBovoEMQQYdKSu7Hsi6nUQIgy6EPRX6r+n6WEs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=p2Wd8bZ2eJmodZN6kCGhZGmz4DLHboQh/xn3U5d3hUveIHs7OjRjF1RYIhzFEjONB
         pY3rINGFLYOcxoWtOzrdMzZEcIAcwmC10R+xCq4461s2n4kC4v/bzu66fJigmecDZS
         3ZVJFC6Obw4HXI4v8GjHRqrtor3c+E45vKXjPuC6qWikp6KJSdQQBJ9CrlUSY7uvYO
         fyrqRnvvrwDIN/Z/FgArWmhK8Y4zv/vX9YldeFe+FPJbsO4bo3clp7mgVlnPqMm60q
         1d8eZaZQNF2N9QLmGYQyu/Alm15+y52Ust5sXXTdCHwIJq5/r+cCb7nRhS4QNcz6jx
         vGYAC904Q245w==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso17802874edt.20
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f+2umpBovoEMQQYdKSu7Hsi6nUQIgy6EPRX6r+n6WEs=;
        b=ILuB6ErBla8u6oc594O687Nq+QQfVXFs/Z2LFusJ6bBpfn3SmFTp/Pb8SVQwEycSbp
         YC5ksemvUNq5e/R6sCBmfnnQe0rWE5GowTcmtLTd3+aQLbwX+rYKT3kH+kRzw/rjV5Mn
         tUl/FxE4nKeMBBowPtTKWHe95K3adna3MSlwov9CSeOqZayLAqsXoAUzvXJJAnUdg114
         6/8lfYDnKGSKcXJt258cON1WxRnknQh0vy7k/3hzuBgYQyuFmZpgqBv123foJGX1SWze
         02XEQWxPClFQAJB6MwPI421VB7bufya9nFIiFRAaZJoiUXfKky5y9/QtTdvhK0rG6bn7
         1aKA==
X-Gm-Message-State: AOAM5329rTDLtI0ozA+C7K/D1tEsgCl/CPXWskYoVA5jKbk88JLK/JtP
        Wxu+r7h5G6pG1AAJkaHPzCatrF+fejt1ZI4vVRL6GqMtVqbB5tx8AgHPpD7DAHEg/2FA8bbsFtu
        7bKnLeOh9jlzCBPLM72NMp/08K1OhzwqUNxczAkkzwg==
X-Received: by 2002:aa7:d617:: with SMTP id c23mr23862865edr.138.1642531202671;
        Tue, 18 Jan 2022 10:40:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyu5aW0XJhnNwSWHFutY369qOWBZxrMpbOix0c2l2pCMT1g//7aoxN//m/dPRbAWK/k8U04RQ==
X-Received: by 2002:aa7:d617:: with SMTP id c23mr23862850edr.138.1642531202508;
        Tue, 18 Jan 2022 10:40:02 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id qw28sm5582890ejc.154.2022.01.18.10.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:40:02 -0800 (PST)
Message-ID: <b1bf4b43-639d-c09c-2fb2-0ac58a6eb858@canonical.com>
Date:   Tue, 18 Jan 2022 19:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 13/16] dt-bindings: arm: add Tesla FSD ARM SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150104epcas5p4ac6fdc739d21c7d7eb2e53e469466487@epcas5p4.samsung.com>
 <20220118144851.69537-14-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-14-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Add device tree bindings for the Tesla FSD ARM SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  .../devicetree/bindings/arm/tesla.yaml        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tesla.yaml
> 

Looks good to me. I'll take it via Samsung-SoC after the merge window
unless there are some comments/discussion.


Best regards,
Krzysztof
