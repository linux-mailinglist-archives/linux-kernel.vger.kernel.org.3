Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED747689B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhLPDTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhLPDTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:19:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DF1C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:19:21 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w64so574683oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWM/2Tdo+A39zviPt3A6JldRYsbUDOs2gZmt1TWRfEU=;
        b=zRWPUcug9JLw4lLpjR5FRm7N3TahpWbYFQnGkQdY0nnpN0NcMRzW1rPNPX2iUOk+fz
         wqb2Z9a1/S63sZxUor6sGazjkdHQXZfktqexaXyD3BN2xxB3TLdiriHQSLyOSe0gdWtn
         IP+TVnZklGicQ0oM1CwDLRlXFz5vx0Qw+MJ72Ye/aRXa2mhUUMemZO6K/Bk+sFO9qcGe
         TOwf8L9Izfo45NtjGjU+076dqTi7ndUdP3E9jIOqVUAkMS6nRj9BnMFTny39NDTvu0Xm
         yvkv1F4ZMghOB5QWYM0X7vwbuQT6eofb57B8D4yRhQJl+4SFgLfOS6uC/bAaI4RaNfNd
         L5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWM/2Tdo+A39zviPt3A6JldRYsbUDOs2gZmt1TWRfEU=;
        b=0cNzSz2oaXR6MSTYAekUG9tsXHSUMiT0dtGEyr/jjYCCMJacfmQsKog4D1Ux/usiWO
         Di5/F5VXmK9Pk9P+m4X18ryMxaS8RODYRQXe5GdPk/Yagb4OF0HX93ocARl7lnHZwqMK
         0+m5ACYHJjic4UfLRLhtlFDkPq93ZtGagmgOMp90SS77LezyOIqjMgeII4BerWCQwwGo
         /Z/WzVbisi9jOObuaV7FaJP/gj3Ad6b2dMmNd5YDEtSAELqQqPQg8ijxq7KsVqgihTvk
         AtG9dorQ6u2//FuQFEaGsMZGpCTH+0Er2dIe2bwiRQg1snpqGYr7FK7eoKk5udIO8Btm
         lv7A==
X-Gm-Message-State: AOAM5333+1GV+LLBF91SDA0oRFcd5irmd/NkFNxqs5rKk/mP1j7jcbGM
        cMH3nBtFq8wTfpNzzfuoO4+kM41AXCIR20/bMO/ZKw==
X-Google-Smtp-Source: ABdhPJxMt8LsH5solEGiTCgX6vrLS/Lejlh/uyv5vtoK/cjjDQdtu3LiiiFa8vkEePPWEVkSf5rT4Xe4hzEx6EQxyiM=
X-Received: by 2002:a54:4791:: with SMTP id o17mr2719065oic.114.1639624760385;
 Wed, 15 Dec 2021 19:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20211214125855.33207-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211214125855.33207-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Dec 2021 04:19:08 +0100
Message-ID: <CACRpkdZxfOZtibKgywx_XL_ayp5NEQiCK-NRrEtbvCUGYSojVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Get rid of duplicate of_node assignment
 in the drivers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Sam Shih <sam.shih@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sean Wang <sean.wang@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 1:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
>
> For the details one may look into the of_gpio_dev_init() implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes

Applied this patch 1/2 of the v2 patch set!

Yours,
Linus Walleij
