Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA6472D51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhLMNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhLMNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:30:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:30:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so11567914wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r2HS8LXycqYlvkyk1XtSS91naiCW1cjlSGDJBqmdHWg=;
        b=RUCPa4BU55mGZ3TPxnm4P9VciYv4X75/TbhC+EkFMF61gjOKbFsj5x49+Ef4rCRs0y
         CjN/eRIvxorXtf5guYPabAbXaRmpiQQB/t9gB+FOiMM2fXsIJpuUqTbmEjW4Tvf3+TOV
         zlHbinqcNCTNdGL6iyXFR5f/ulG5ButbS/JmOy1gErM30r0DBGytKnLJ4nFx0FmzoDkz
         /+8+8wCetkc8kX0RxeS0qbLymfqJMSHlAfD9IFapDXQDT1yYPUycajrNjucdZPgfVf4O
         WhnBvW/AsrmRm95+9g/Eo/9xMzQbeNQ0OuziNbYZNHZvIMuoEN130pKeF11Qpd1DDbjJ
         B6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r2HS8LXycqYlvkyk1XtSS91naiCW1cjlSGDJBqmdHWg=;
        b=cpEFLYADN8HbfgIpyL5QbVN5H52gD+teU94B8TKFfCve6ONuWA5UXfvmDIcEuqsosF
         DuKz0q5TLcTEgmMd3BtjW104rKK2eClyAVtNUBNCjcHOyU7neAzkhKEuqmN0Qs44Vo7i
         opy/B+LssNEl1K+bfVel3An8GYsKrRqzpQzZL3HY2amFffhLX2WxUi6u3IrPOGz6oFvU
         rbbsxTXJXFp6g6pgh+VtPQxkvMgZ/T0e1R1oLmJBKhb9wfGx8DeOkBAxSfowlwH/sICG
         Jow5SUM9umc2fbVOy1vH6qn/RPHBK9nsfdIZ1RNR1Ve6mXhaulN/d7HQMtHAwbzGKAIe
         SCOw==
X-Gm-Message-State: AOAM530hvPXLWFCAT6ghGxUEA6ZaS358Je6GFkVkYJLe87z8/LKq3qIk
        XUccLjoL0mtPASVad8OlPFz6Hy7wBqQnC0Jb
X-Google-Smtp-Source: ABdhPJyWkKnbNBpJs/AcEzDRZ6MIPMKl4r6vPgd/oMbTn650gQez7KXqYtOuijioggr4iU7HWEvJcg==
X-Received: by 2002:a05:600c:3c85:: with SMTP id bg5mr37251416wmb.58.1639402254025;
        Mon, 13 Dec 2021 05:30:54 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:3328:f8ef:d20f:532a? ([2001:861:44c0:66c0:3328:f8ef:d20f:532a])
        by smtp.gmail.com with ESMTPSA id g124sm7083697wme.28.2021.12.13.05.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 05:30:53 -0800 (PST)
Subject: Re: [PATCH v5 0/3] usb: meson: fix shared reset control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, khilman@baylibre.com
Cc:     p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20211212201844.114949-1-aouledameur@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <91db0d03-aa52-9810-8831-b5e44793a4d4@baylibre.com>
Date:   Mon, 13 Dec 2021 14:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211212201844.114949-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amljad,

On 12/12/2021 21:18, Amjad Ouled-Ameur wrote:
> This patchset fixes a usb suspend warning seen on the libretech-cc by
> using reset_control_rearm() call of the reset framework API. 
> This call allows a reset consummer to release the reset line even when 
> just triggered so that it may be triggered again by other reset
> consummers.
> 
> reset_control_(de)assert() calls are called, in some meson usb drivers, 
> on a shared reset line when reset_control_reset has been used. This is not
> allowed by the reset framework.
> 
> Finally the meson usb drivers are updated to use this new call, which
> solves the suspend issue addressed by the previous reverted 
> commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
> use").
> 
> changes since v4:
> - call reset_control_rearm() after clk_prepare_enable() fails
> 
> Amjad Ouled-Ameur (3):
>   phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
>   phy: amlogic: meson8b-usb2: Use dev_err_probe()
>   phy: amlogic: meson8b-usb2: fix shared reset control use
> 
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
>  drivers/phy/amlogic/phy-meson8b-usb2.c   | 9 +++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 

For whole serie:

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks for fixing that !

Neil
