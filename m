Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA1472C20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhLMMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhLMMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:15:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F91C061574;
        Mon, 13 Dec 2021 04:15:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so51041409edd.0;
        Mon, 13 Dec 2021 04:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APONv3SOJu6jCNgkwpRGUa5SLi10GbfkrOQc9B4NjY8=;
        b=pnT73e/Ftu4uEmb+E16AXdk5b6ca4DPxjdMjO8quZZKijpit8bPkMgIn+X6xOj3NKT
         h4e19eBUv5LF+pjrK/eGrMS/xiCz6iSxTlHBC1hDlE+vFIW11dLfJPHw+ibiDBGpDzIB
         ZLOprS+pTuporKHrxq7MEsOksS7mm2k2P4oezg0BuOSaezMZqAL3kWhXh0zA+rlmx19N
         kqqzHtFdH79xHwI/zNe/Ye0Bu39MY4VWBiNj9v3onZo3tIAQkVTuceOBNwBN2wg3saNJ
         WbBSImyM2PeZW3+dd/Y17EKHRVautWP9DJpwJzsPg83X+eNO7AXU+B55oEK7DGq1qnmp
         h+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APONv3SOJu6jCNgkwpRGUa5SLi10GbfkrOQc9B4NjY8=;
        b=lWTSBlQ+WCSBgjzyWMcikwYJX2ScF4VuD/jxxuHxu9Vnq3l8aiY1u2AMrXMdOzLFC2
         A8no0kTa40qdcIyQJwEm5SC55WoCse5IvCvEqhCloeUoI94knyBncRmQwc2Slhr0SmRY
         W9SXBKGeIlPxjLgMo+7OlwXf/LEoEojGXKVLpJrtjwFQ9ainYJNF7AW9G8lzg7mZ7y3s
         a3J7xJP7KV5wa6gddEh6zIGdGwMShVpCWeCPhq/eFk+yoI7Qpri3lE1rC13h+/BIaAiV
         Z5HX8xEPP2nY+ikvEWuM3DGaF0H1NKxBmeOGhlvNOT+eaWjbthaSmyqIL6JJ8swAwLlm
         Zcqw==
X-Gm-Message-State: AOAM530EbYIS+pAdM6tvDU9lns5VVwC0Kex8dFPCW4sTDbwXCPP8QFUg
        3ZsL/fhKAOkSyWk5YbDPYY7WAKMVm9jDDDKAJxA=
X-Google-Smtp-Source: ABdhPJzIhAFiXAukZI7VpH2AcmByRzDMPngbJIecaJ7gymB6ARFyfskeqZxnSgWa4URc7fbRLHmlfOwb6iPmIjZkKBw=
X-Received: by 2002:aa7:d495:: with SMTP id b21mr65090593edr.363.1639397701965;
 Mon, 13 Dec 2021 04:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-8-Mr.Bossman075@gmail.com> <YbcuweQlw3inhye1@ryzen> <bc7a718c-2cb7-1c23-a8fe-524b327fbcd5@benettiengineering.com>
In-Reply-To: <bc7a718c-2cb7-1c23-a8fe-524b327fbcd5@benettiengineering.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 Dec 2021 09:14:50 -0300
Message-ID: <CAOMZO5D9ytHBACojwk3mtaypdc4s5gWT7ctJQiUzmmP15hzGww@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] clk: imx: Add initial support for i.MXRT clock driver
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giulio,

On Mon, Dec 13, 2021 at 9:06 AM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:

> > I would suggest module platform driver instead.
>
> Can you please point us an example?

Here is an example of a commit that converts the imx8mm clk driver to
platform driver:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.7&id=af7e7ee0e4280c29c41b6ec64b892bb53987a997
