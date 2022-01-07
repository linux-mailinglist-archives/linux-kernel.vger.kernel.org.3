Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C50487388
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbiAGH0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:26:44 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36908
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344321AbiAGH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:26:34 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2FF9F3F225
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641540383;
        bh=M9bA08m/4+qmYorXwlFuqKIOOS7D4thRY9R5eRYtFbs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=CUnUfjCWP4RYcEeNH73ExObzqwUnzE2qPp6eHblTgAlOBAcJ5FWEKJgWGkeBsaR/C
         4tAJAydfUxdsgq/hHPdFHaBPnyexgrgjdM3pMfXFOVHxcV33AbBdzgUW/Sz06lzwI4
         3h1McXYSgzgD+KoqT9zHSU2gXBPMi9qxJuJ6WBv49+siGp8vuFqPyGJNikXRs4wfC7
         dr/24VWM5VhFdcD5ZX/vcqPkpfaCksIwT63I3NofTbKAEiwbT0k579IlR2XJR9bkQb
         Vze83ueJ4zf16bFgYdseekRB6C9XxX4mqhA1gEG8vIFTDCrt+Ey3sDrpZnzd2SM9zF
         Dn83UFqhdVLSQ==
Received: by mail-ed1-f71.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so3950805edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 23:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M9bA08m/4+qmYorXwlFuqKIOOS7D4thRY9R5eRYtFbs=;
        b=H+Kvqvn36Dm+McL+EV9MNvXsB3lxVX+HdVHe+zF/r/5+GOVtZu5eAkcz7NYMBUVmdM
         u7CoeJc/PQHleqPQUw5GyDf266NnSffPiPrkO0akpXuvRnTuEADZXWdhwe/82/SrSKdB
         5xIMI5ke4/TEmsC5jPjc0WlMFIWUwmdJkR4Jk539EPkJZmRLFJ6qpZ/1GrNcWvL2Rrz2
         4UDZV8AIH5dihcAUKk1vEuIp6/MZ6TWJN4JLQ8R3Pw70k2pHlB37yDIn4a9b6AWe5+nJ
         6GCJXFDC9CRdoY2dJLqOH1HRwOTmaDJUVJWl3aLTgz2ByFYEkCExoL2wEI0q1EdvHBx8
         zREw==
X-Gm-Message-State: AOAM532BqQFxaKyNK7+wvtcQEwa7L2UhQJRV8M+bPW0gEJ0vViuv+46s
        p9fgeGWsmKZJHddHFbwvKghQWJgvfkO6PhTFNnGNnGJ5pw6KiW9pNB8pMh9TFNeFHjVXwPT24xT
        X/wb9PpOWyIKs4QT7GftdbYcWITlIRJBR+EH+YfGYbA==
X-Received: by 2002:a17:906:3e44:: with SMTP id t4mr1013018eji.233.1641540382848;
        Thu, 06 Jan 2022 23:26:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwb017p+Oc5AqO2GTx8LN7DviB/du5sQ9u+BbDoumqR10b5Wls3pJvkYlFJVzjLDs3uNuoJQw==
X-Received: by 2002:a17:906:3e44:: with SMTP id t4mr1013010eji.233.1641540382728;
        Thu, 06 Jan 2022 23:26:22 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f15sm1705500edq.33.2022.01.06.23.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 23:26:22 -0800 (PST)
Message-ID: <950a0cb6-be94-dc60-9878-0c4dd8581f1f@canonical.com>
Date:   Fri, 7 Jan 2022 08:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dt-bindings: power: maxim,max17040: Fix incorrect type
 for 'maxim,rcomp'
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220107030433.2381616-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220107030433.2381616-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 04:04, Rob Herring wrote:
> The 'maxim,rcomp' is defined as a uint32, but the description and users all
> say it is uint8-array with 1 or 2 elements. The tools missed checking this
> case.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17040.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
