Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1B4768A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhLPDXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhLPDXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:23:47 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F4C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:23:47 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso27343127otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tu2NGSrgJfVwTrxV5gAyRVtFDdQnC1eWVUu1iP8zEN8=;
        b=BlF8OZZXcAlTD9yavJ/2Edp4bspRnEAudkBYiMjp27yXG0WM3UUR+WX7lrDx86g/r1
         1cF4LKNGY4eWGWN1q/+PQI32Xz/2UD9dyaH00o1Bz4yMSYof1gowQ25Tve05nMhwtSon
         wop7AtGlpomNS+xRb6S1LeTK1QzpnQW3IZsWf9wKeNNGmbThmoUzPGUrtYtVyJDWXZVt
         wU7Bn4o+5eYSEuG2glrrrM4VsVYeYQEZ8TlgZpzjNORHL/x4mK2tb55jxY3gxCfSOJPE
         y4DBlM7lzB+0PXsWSV0TlytbpgTRzp0ft0QMpIsyiDFnjweiDywaO4sraUrApVDXMWZx
         aLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tu2NGSrgJfVwTrxV5gAyRVtFDdQnC1eWVUu1iP8zEN8=;
        b=I1o+Cua24XBZKsqMN8YB7FV8eIhhq2omRbsTnD5PKpWQZBnmN1+6+BEhBzWx1PfFMh
         MnQgaZ7aahqtm/pY+CMwyieob4Itz34ovXRSiBdnqRwMMUfly91/rU5QbI2iWOJmUIZ0
         oNC8gPLcVptno2dCMQs/LQvd8krpmufEWsCGNvB8twTQQPP9w+YE0aPZc7RLwlOVTA4N
         i5vwmTtFF1SAMBszO6gWv327LbSJpd6lfRL1g1JI6E4N0h7orLiARzF+5dlC4aBxLPH+
         OuJwtbH7MuHuGiIxRwdh6bs5tg3pnWNZkDFVuJm/RhPMOyRo2X0UI4+/1S7m328wZ9zm
         cyiw==
X-Gm-Message-State: AOAM531tJFx5MgT/LFS7sZCY7+w73oubhWIlup4553lrGnfNfa4Vk3oa
        WYobx3Zs6lxlkM+Y9y8Pa8pmeaUZtSuFdXrmtYGPzg==
X-Google-Smtp-Source: ABdhPJyY+kaKouB91L9mIADgugdeKmhVXLKaMwoLSKVdKhTyrm1W05U50db4LhIhM9NZuvZLM8U0AIG+vZRgFzXO658=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr10939446otl.237.1639625026377;
 Wed, 15 Dec 2021 19:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
In-Reply-To: <20211215141727.4901-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Dec 2021 04:23:34 +0100
Message-ID: <CACRpkdagP-UoSyWeOVoxitaMJru+Z_rRa-V3RbLg2jHOnq=_hQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: mmci: updates for STM32MP13
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        u.kleine-koenig@pengutronix.de, Marek Vasut <marex@denx.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 3:18 PM Yann Gautier <yann.gautier@foss.st.com> wrote:

> The new STmicroelectronics STM32MP13 SoC embeds a new version
> of the SDMMC peripheral (v2.2).
> It supports SDR104 and HS200 modes.

Patches look good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
