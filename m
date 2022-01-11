Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4200C48B8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiAKUaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:30:04 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38910
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234189AbiAKUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:30:02 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C763340029
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641933001;
        bh=CKTP4p5lODINceD9QcpC5IgySAHEx93ke4CpXm6ZAAY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gpt25tHmfxDZIhPFFakgK7YDhzTr1GM5DLGbsxzUz82GXSLu3ovpUGfeDmCYpc25+
         DeiyB8UA8T6uW4d49ZntgMpHqPPTFmAQ86CkwTye5CM2gM/DBSg5nI1WjZaqgWnKHp
         +wG/53ouu4LIqEcLVZ7S/QCqRLAVU9Yth+ptUJVj9nJqoFFVwY6IJlnU3kkDnmTZxz
         ALz3CiwC+rxb6vP6Ry/HhSbK8lMPt68pB+5wVGrIFbKG2fVcZhnXW2wLyjCDBJsaT8
         l+gJyBHZHETxWS9EZayZxAWyXDBl0PYjmVFvl2WU5bCfs8/xx7CQcDJ4F33BBBlRcG
         kU/Xml8WFHOsQ==
Received: by mail-ed1-f69.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso216625edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CKTP4p5lODINceD9QcpC5IgySAHEx93ke4CpXm6ZAAY=;
        b=cU9kmWTH7ZEcGZqDIr5m9A2WIRkl5y/I/wt62ZEd5AxiCgM7fFY7rHRxJpBnlDB3II
         V+ORCBC/+f3yFzTh3P00xhiVIbb+bUd3zBJN6H3dLpsoH7AIfMmvNP7K/Ce65tTALF4G
         ZEoZXZsOj6s+LqfRM/IL0PPsI30lSLmTnHanTNRFIWenKEnm4moNJNywdLJ7r3SNAIN1
         Jlk4VyMX0yuqLPVSi8tcj8/HATopmuHIx8IBs4nepAu+FQFmT2L0jdS+lxt8QW4BFcri
         4vo7E2MOSMTAx40puYgizrmyWe4aNgJyu5zAY8BUSqSPe91WawJYaKLLp6uk49g5+zTa
         xnPA==
X-Gm-Message-State: AOAM532/HZGSwNdAP9oFexwt6u/+JK1iWhR12FlkyZY5TbgmfxuaQjG7
        BfnCbh4vBIoprQRJL1tar7v5Q8WzPMmJzxu8K2ublgagZV8xv8yfxax2nwnLXvPKBu14JskDLAT
        o88CnsPw9H6btH3Cg5rvelNxk3gqEYK6aXz4r8Nem4Q==
X-Received: by 2002:a17:906:7307:: with SMTP id di7mr4873913ejc.516.1641933000954;
        Tue, 11 Jan 2022 12:30:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzLNnL2OVU/iajkRhtGdk6AJwVnE1QBwlSx7fu8yVqXILHBQvXFbDwXh8xzUICR8K3JFlGJg==
X-Received: by 2002:a17:906:7307:: with SMTP id di7mr4873901ejc.516.1641933000810;
        Tue, 11 Jan 2022 12:30:00 -0800 (PST)
Received: from [192.168.0.26] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g9sm3866418ejo.222.2022.01.11.12.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 12:30:00 -0800 (PST)
Message-ID: <c71e09a8-0170-ce05-3fef-3e32c990b377@canonical.com>
Date:   Tue, 11 Jan 2022 21:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Patch V1 1/4] memory: tegra: Add support for mc interrupts
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 19:45, Ashish Mhetre wrote:
> Implement new structure for function related to mc interrupts.

s/mc/MC/

> Move handle_irq into this structure.
> Add support for clearing interrupts.

The subject says you are adding support for MC interrupts, so before
they were not supported at all?

Here you also mention clearing of interrupts - another new feature. One
commit for refactoring (adding new structure) which does not change
functionality, second commit for adding new feature.

Different question - why do you need new structure for just two function
pointers? Why these different IRQ handling functions cannot be in
tegra_mc_ops? To me, it's unnecessary code complexity (plus performance
impact, but it's not that important). If this is really, really needed,
please describe the rationale in the commit message.

> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c       | 14 +++++++++++---
>  drivers/memory/tegra/mc.h       |  1 +
>  drivers/memory/tegra/tegra114.c |  1 +
>  drivers/memory/tegra/tegra124.c |  2 ++
>  drivers/memory/tegra/tegra186.c | 14 ++++++++++++++
>  drivers/memory/tegra/tegra194.c | 12 ++++++++++++
>  drivers/memory/tegra/tegra20.c  |  6 +++++-
>  drivers/memory/tegra/tegra210.c |  1 +
>  drivers/memory/tegra/tegra30.c  |  1 +
>  include/soc/tegra/mc.h          |  7 ++++++-
>  10 files changed, 54 insertions(+), 5 deletions(-)
> 


Best regards,
Krzysztof
