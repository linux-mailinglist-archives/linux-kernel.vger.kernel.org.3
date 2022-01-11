Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC4748B8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiAKUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:32:41 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60938
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235522AbiAKUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:32:40 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4CDCC4076E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641933159;
        bh=H5ZakS3zp5yKL3f7hqWLVBf3SwwkRAJ+CXCwTVqLnWY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iFh1KQmQoxVb4CT/d1HpMimEYQzR/bcIPFSWJEKDCACjgAR9NIixb8GuPfTaZ3qq4
         DzPKEc8xWB71IB6nXwKTD7tWzmW22hpztdLB5aU4EwfvxiCVZ8n15WkQIhkKNjpfCK
         QRn/GzDUkt4yj2Yi3XT4e8F+i1npnbuDvcpTaPQMJ2c61lpIMv2H7yFd3oSG/tL4Ey
         gEFz/Xlxiz2wCMqL89QNo1nYG5MxIJWjYjha9Mu4BZhMZHs6LVZ1Q8mTu8qP/emwiS
         Hk8M/XQl0fWs0CmIWvMRIzkAtTfVINb6NKXSaf2gpXXqef3WfRxTEU8AJ3V7mAxFYw
         fPuUy2BmxJCow==
Received: by mail-ed1-f69.google.com with SMTP id m8-20020a056402510800b003f9d22c4d48so180466edd.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H5ZakS3zp5yKL3f7hqWLVBf3SwwkRAJ+CXCwTVqLnWY=;
        b=UYsSCIAPhuMpJ/rX7qjKV4RWvXlbA+pI6PCtc+Wlw1zQWHpVS8jlpoZ9O8icy6vwqs
         ErKBqvoDbca+P32xP7J6h2TLFQbp1LMdW2Gob0pj2GykvJFROkgcx3fkVGnaNtHn2l6s
         Q+llHCiAPS3oT6AVkIvwyi33LZ1rAxQzHjLytI2r8sUF3sl5JfGt1/L+aR88ff3cFyP0
         akcmLw5qnuRUBvY0s0zgrrL67fuojvHkop0G9zmxmi2dHVuP4pTiSUfqXZ1fYfojonC6
         tkguaTk3a/GZA13Szeo8LjgXpCKwbNoITF8BH9gIvhowo2bZQl/7SSMUdF+dffvZly57
         M18w==
X-Gm-Message-State: AOAM5333k5MQj4W3S7MQNZEdgIqN/Cr6BrGJSkupgUysLO0mN8YYNlaY
        QumO9PgDGwGL5rTRTrzmvf3pfrdwTu78ItE3vvVumVWL/WvVAdHO8PC04I8gkdaa0SQox+obkQq
        WTgnlWjFUm9g64EaiaI8/F9AeWuyy/tV+jQTIBhB2AA==
X-Received: by 2002:a17:906:2802:: with SMTP id r2mr5229480ejc.172.1641933158937;
        Tue, 11 Jan 2022 12:32:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxV0Tyf5mraBWtghCzj/1z3FU1wV/7RpELi8fE8HCTtlMZokp9yMWQiCnhFIdMrFQTwIAA2Q==
X-Received: by 2002:a17:906:2802:: with SMTP id r2mr5229469ejc.172.1641933158801;
        Tue, 11 Jan 2022 12:32:38 -0800 (PST)
Received: from [192.168.0.26] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id gt20sm3963892ejc.11.2022.01.11.12.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 12:32:38 -0800 (PST)
Message-ID: <c78b8062-20a8-262c-99de-8c6b481584cd@canonical.com>
Date:   Tue, 11 Jan 2022 21:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Patch V1 2/4] memory: tegra: Add interrupt mask
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-3-git-send-email-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1641926750-27544-3-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 19:45, Ashish Mhetre wrote:
> Add interrupt masks for all supported interrupts on tegra MCs.
> Update interrupt mask value for T186 and T194 as per supported interrupts.

The commit subject is too generic. The commit description need to also
describe why you are doing it and what you want achieve.



Best regards,
Krzysztof
