Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8627E46CDC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbhLHGcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbhLHGcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:32:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDAFC061574;
        Tue,  7 Dec 2021 22:29:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so4876377edx.2;
        Tue, 07 Dec 2021 22:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ge8duN4sNFU8LlP54a+ac/TMCJbGoRstlWztgA2oT2k=;
        b=p7Tlb9qJ5H1ZRRcrMS0mlr42Jn6hA8VP2orglLASnbMQBgx1S1WeBr/AMrOSeesXnQ
         FRluYxOh0U5Ov4HWvBNuv3hTTSzYgFlsq7AC/NSoeEDrdP722tiB+4a45G8ysaCsuumR
         N25uK9AtBpGiUL2MR7tvUHfXrY4R+C7lwVL22UrSyvojE1/GcpIkz0ZhSJhVcQc3EXuo
         t1K8/XnGJZowgX+uPrPPkDOfUFvdLzuLndBaVJDj8uHnw9dAq+q/5vmn6PfqnXlaHXkV
         GC9QBRXfkEqG4YTtx0xMcskL1XccmQ2vBPQsdaCDfBrNPvXnr2YcsX+X7j2hq+9RRlQs
         VBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ge8duN4sNFU8LlP54a+ac/TMCJbGoRstlWztgA2oT2k=;
        b=VdYQ0oU03AZwKpXahwajRVV4LroqulA2PGSpUZqmqlIuSY4KaXAinPX2Uji7J7nYp+
         +mp5LpkVDPLhH025ik/i8kIsL0I9wzPdPPsFmIesJuOgLkU8/fEF4XMNdtAUpX5Pl24n
         nnseltVNIybMF8CFQzn949OGV3wRwCZojijzWD+bif7wIevvIY/Cth3ownKEPO/hP6Oh
         V7IxvZcN+xl5W8p+0Oyd47N9YwTfqcOIgCyct/JfYLci1EYyGZYuewyAyUk4SqWYC2n1
         9JpMex3ew6zh8dVXDOniuznghPIKf4OMkH+RoUby6NMbYnRBIAL5RbWatzGPB/rpxQJR
         p8wQ==
X-Gm-Message-State: AOAM533efU7HrkYJZ/UBBJePJPJChS91EyW3bT2Wj7hlPG/BWTW8CZBe
        vXy/QyHkrExGNCYMD5szQk/4rtQbQVPNRXHzIgE=
X-Google-Smtp-Source: ABdhPJzGz+VCI7qEgxFax+wzk8JXXv7V0YRLbnxVV2888/gXpKyM/ex1MlxEgxzSYFGBmpSEppU47Zmhh0wuCDsftjc=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr4989169ejq.567.1638944939879;
 Tue, 07 Dec 2021 22:28:59 -0800 (PST)
MIME-Version: 1.0
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com> <1638891339-21806-4-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1638891339-21806-4-git-send-email-quic_srivasam@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Dec 2021 08:28:23 +0200
Message-ID: <CAHp75Vd=47Tv9Sf+styPhxS2=O1H2KUDeKQXTULUYU5fDgGwwA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] pinctrl: qcom: Extract chip specific LPASS LPI code
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, plai@codeaurora.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 2:39 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> Extract the chip specific SM8250 data from the LPASS LPI pinctrl driver
> to allow reusing the common code in the addition of subsequent
> platforms.

...

> @@ -661,8 +454,10 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
>
>         return ret;
>  }
> +EXPORT_SYMBOL(lpi_pinctrl_probe);

> +

Stray change.

...

> +#ifndef __PINCTRL_LPASS_LPI_H__
> +#define __PINCTRL_LPASS_LPI_H__

Missed headers.
At least bits.h.

...

> +#define NO_SLEW                                -1

Naming sucks for the header.

LPI_NO_SLEW ?

...

> +struct lpi_pingroup {
> +       const char *name;
> +       const unsigned int *pins;
> +       unsigned int npins;
> +       unsigned int pin;
> +       /* Bit offset in slew register for SoundWire pins only */
> +       int slew_offset;
> +       unsigned int *funcs;
> +       unsigned int nfuncs;
> +};

Are you going to convert this to use struct group_desc?

...

> +       LPI_MUX__,

Strange naming. Besides, if it is the terminator, drop the comma.

-- 
With Best Regards,
Andy Shevchenko
