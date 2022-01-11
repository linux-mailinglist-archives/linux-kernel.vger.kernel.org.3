Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF148B2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbiAKRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:06:19 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59284
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241667AbiAKRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:06:18 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 859B53F31F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641920777;
        bh=yHM2E3K7PraAAJZW6vk3OPqoH3vFzda1D3jFgKg0Kxo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EVyFf34v1Hhf/iam5SnOpiYtNuQ2u7NkGLT3rKuYZcBvpyb9V+XHwn1PHJ8dZQpzF
         a5SQ6AwWFH4TjaG/NyH+Zkgv8EWG1iKOefU4quzSRTXkxyptsCUMdrUvg4vTibv9B9
         DXlL2ROC0YykFm8d8WCabrZsLGvtDLvDPy9HMS1/aenUPhdtqRYTiDgiWqXjLkXpkY
         KKB/sn3h2E5QSjRQdpdBtNFZr9igNWtEV+/zI03e7Wz6EgmQwQjHb/aFXgV7NEZnEl
         FtY65v0qATDfEvJ23uCjW/GAame3mZEGcOw705TMCNbG1VGat2U3FifZhT4qcjMUIX
         LchifHI/0lEIA==
Received: by mail-ed1-f69.google.com with SMTP id m8-20020a056402510800b003f9d22c4d48so13873083edd.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yHM2E3K7PraAAJZW6vk3OPqoH3vFzda1D3jFgKg0Kxo=;
        b=JfTVT420lH5V1uXTpa7pJaannOEd7BFK9PJGA5pTHYUfDWRuu5RXKwqts78FfdSyKm
         RwuX5VxDjOAdK59NNMDc0egrqWd51AomUMmiKeJtTXB6Pv6FY2XUN3QC5BDUyRGfvJKT
         uBI6+V9argNbFcbg6wMWmDys+KvrDyNCCbT+6dNUKKMRWFdUfCtimvZ1jc99jPl5cw/S
         P7OfX+DDRmF4B+OraZnmMFhN5SRDK5kTRq1ksapAO+Ry89LAQ38Sc5Rw+Gj5OAVES3y1
         NHiu5jz87eZxmxbEwd33OUKKb258UtIN8CHNNp2Fli6TkWJmhFEEVQ/9ifhrd54WPpMq
         z/oA==
X-Gm-Message-State: AOAM531aACpfFAyhRXmLywBe0LlTm55+sw3Ac2zrvAYsMf2J65HJQD6N
        arYzwOxJ+OuHU2G8ztJSOSTVbZy0GHxfSlNvbZX/6AS5G1LQPR7lOMm/Ol1pHEu+z5hoFXoJZjF
        bKCbHqde1dEuas7v0M0Qt8RUwH5BwYvAq0PGHRC62eA==
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr4233121ejc.247.1641920777182;
        Tue, 11 Jan 2022 09:06:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNQAYRkR8aH2kKGfF5rTf5NkddVy3w5dhxChqjTNsjXzjMNArOAj98x/iMiCtdSBgXLqHPyg==
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr4233101ejc.247.1641920777033;
        Tue, 11 Jan 2022 09:06:17 -0800 (PST)
Received: from [192.168.0.25] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ky5sm3688615ejc.204.2022.01.11.09.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 09:06:16 -0800 (PST)
Message-ID: <dd6caaeb-f395-2109-b1a3-6076f8c41ad0@canonical.com>
Date:   Tue, 11 Jan 2022 18:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/5] regulator: dt-bindings: maxim,max77843: add MAX77843
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
 <20211229124631.21576-4-krzysztof.kozlowski@canonical.com>
 <YdRrWGry08M+h2IZ@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YdRrWGry08M+h2IZ@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2022 16:44, Rob Herring wrote:
> On Wed, Dec 29, 2021 at 01:46:29PM +0100, Krzysztof Kozlowski wrote:
>> Document the bindings for MAX77843 regulator driver.  The bindings are
>> almost identical to MAX77693 bindings, except the actual names of
>> regulators.
> 
> Same issues here as your other Maxim regulator conversions.
> 

Thanks, all comments (also from extcon and mfd) applied.


Best regards,
Krzysztof
