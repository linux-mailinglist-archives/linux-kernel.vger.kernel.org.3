Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E864947A1BD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhLSSUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhLSSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:20:38 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19876C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:20:38 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g2so4801101pgo.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u74cWTopnVH44MujokkrRkfCfXsq6ZRs2mw3KCw/CPU=;
        b=Dk0MsH5XNuAraSVgPHFMysD7ERqAqCiLBWVLN/71If7J9EBQPqS0L9VQxOknuDAHK5
         es30u7K3pka8DrQVJFcceYwaStyahPQz+wM84OgG0k91L+bJeLPz8Kr8+ExyOR3/y3Uc
         /+mq1ZZl0ZcEKbN7NjcQmJcSmcyGTQ5ucaGLsIRk/KBAOC7aPtnkxuu4zmHJQQbjeHoA
         5dvhX9YgyFJECc7u186r8K7EjVrL6VJKhkw+PzFyt6LLCRX3kr8hg6y65wWc20uTVkXQ
         B33vPwnwGJC9NEmVdojl2lR1dXBsZYdk/z2MLSaPxDZtXnOPNLN9XTOPiKIIbYE5gduc
         1WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u74cWTopnVH44MujokkrRkfCfXsq6ZRs2mw3KCw/CPU=;
        b=a/u9GUaKE7JIhNoA4jLu0TJekN+3Ij/WEoGUFMrqDWGpBVw929u9B38KlYDX4tVXR2
         a3qJGLfnyf02EG2sTP6K0bpJEm3NXGChtoBFntdlCGT2pp7aQAYTJl8jAO9UG+etApN3
         20kzeYXSEGeuEXbgSuSdw7iS9786+fAnb9/ZCEYwbEUu6SMNeow6d8D03U4oixnM2QaG
         Q+vCaRQNqEAOftdRn1DsT1Rr+jx809Mwz4wZr1ZQlhDYBFg97tgNS8VO+4v08UqS+QiH
         uePTWNq9cQbrSr2qCJS0s6jikVs4AF/sj6xfIsces9Ahd4cUYffpykxgDSq/b7+mjs55
         vJHw==
X-Gm-Message-State: AOAM530t1ATLIIuyaiK58yPw6c1CdG9dRkBm4QKbyJAVVZlSoikLNd/B
        r884EFRw/mKMaD8tCaIj5qA=
X-Google-Smtp-Source: ABdhPJyvN359C0RRu1+t8X0WexVORAvsU8PlbIbx3hHdgYJi+uvSgoAlbRbHICPH70i4d9Qh/LtuBA==
X-Received: by 2002:a63:114:: with SMTP id 20mr8050324pgb.342.1639938037547;
        Sun, 19 Dec 2021 10:20:37 -0800 (PST)
Received: from [10.1.10.177] (c-71-198-249-153.hsd1.ca.comcast.net. [71.198.249.153])
        by smtp.gmail.com with ESMTPSA id n18sm2243641pff.110.2021.12.19.10.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 10:20:37 -0800 (PST)
Message-ID: <f58052cb-bc5c-614c-10f9-8e6bfc7ff24b@gmail.com>
Date:   Sun, 19 Dec 2021 10:20:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] ASoC: bcm: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Michal Simek <michal.simek@xilinx.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211219181039.24812-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211219181039.24812-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/2021 10:10 AM, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> While at it also drop "r_irq" member from struct bcm_i2s_priv as there
> are no users of it.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
