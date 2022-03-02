Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C24CAEC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiCBTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiCBTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:33:39 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166F27B1B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:32:55 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C886E3F1DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249574;
        bh=Fsve2Z1+2DlDH884jXd1jvwOOWbk6tjyys3i7c3ykcw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=spKoPnypxuC41fY3hA3lRy+ebpX8kq8A6TntcQ6iYJK3h8gHJrRaDlnzB1JFu1eEI
         zHfJPFpLzt7uFe40mcZmCR4GnEejpgR77OeWYJyXpasmQsTMD3W2cKbR+Z9Kp3fDPv
         nvhsyblLkBfpqsfdeA4ARUgPQ6bRETJV+FbLubMUoIpxOxHQzZUd3V+ryTcKLFCEfg
         aFy3Ah5VX1ALPKanB3523iEa7uTTN0vPQvXC+DofniZ7Qa4JjmFEkZpUcl18y1UlX5
         l4nEyl9kKYtoR4ubXIZtTCWH9R/3KWW+QfzvRpLL85JQOLcEVpE0PH3y1FklcOzAZU
         AXm+aeViS0MZQ==
Received: by mail-wm1-f70.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so1206998wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fsve2Z1+2DlDH884jXd1jvwOOWbk6tjyys3i7c3ykcw=;
        b=lau7heEpZb8EeFMGm4DYAQq0RgNPPf7VFLTN0qVq1by9K3HXrXmO/ojuz3DLsa+dHQ
         jnKeqjM49BFwUX6WnLN5SaunlqnF+jUQqfSB2I2k0OD1RqY4ErmdBwH486IfTPZg/6J0
         sCVWjGXc5yQ/WJ8zrrIIT5/HeVufXFoi05xS2ISMpHtujBcIX9pbQgwPb3Y18hq8oJ18
         qBhoFIA71sSb5qXfzSLKazYxCpmyFqD/BKLxd3BkFnkTwLdqJVnHsgwn15FgVRwWQ8u8
         p9AV6ozyH9EMkL6lUOs555FurqIzcQ0RrT5Blt7SkID+4O0epBLRhET6W4zbxe2wByMc
         9UCw==
X-Gm-Message-State: AOAM530Ci86gCgIQ+KZbiWkl9/JqbX3MTKD/WTX3cZTZTQ0+27+KaxGl
        xs7ytzl5Ax8yMFHUr+udsu1N1pMQtySzaVJoEPMC7tKWkfBeKAyRO6Ja3tMr8NQFtEjHXPQATdm
        SE6bB71jftiDYtwuTVGmS8eJnDtLsltd74D5SZpNtHg==
X-Received: by 2002:adf:f091:0:b0:1f0:3432:bdd9 with SMTP id n17-20020adff091000000b001f03432bdd9mr3055560wro.576.1646249574209;
        Wed, 02 Mar 2022 11:32:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbo+NTTlfRAgu7/y3Dnm0J+c8MNRAdAg+mjaQeWpRHqSLbstTpeFSOrsN8yG5bpqc14FxYsg==
X-Received: by 2002:adf:f091:0:b0:1f0:3432:bdd9 with SMTP id n17-20020adff091000000b001f03432bdd9mr3055550wro.576.1646249574017;
        Wed, 02 Mar 2022 11:32:54 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm9576404wms.7.2022.03.02.11.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:32:53 -0800 (PST)
Message-ID: <6c94494a-19a5-c62d-7a38-a79dfdd5692c@canonical.com>
Date:   Wed, 2 Mar 2022 20:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v4 1/4] arm64: tegra: Add memory controller channels
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
 <1646210609-21943-2-git-send-email-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646210609-21943-2-git-send-email-amhetre@nvidia.com>
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

On 02/03/2022 09:43, Ashish Mhetre wrote:
> From tegra186 onwards, memory controller support multiple channels.
> During the error interrupts from memory controller, corresponding
> channels need to be accessed for logging error info and clearing the
> interrupt.
> So add address and size of these channels in device tree node of
> tegra186, tegra194 and tegra234 memory controller.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi |  7 ++++++-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 21 ++++++++++++++++++---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 21 ++++++++++++++++++---
>  3 files changed, 42 insertions(+), 7 deletions(-)
> 

You send DTS patch before, which is wrong order and actually it points
my attention to probably ABI break.

DTS goes always separately from driver changes so it is not only ABI
break, but also non-bisectable.

Best regards,
Krzysztof
