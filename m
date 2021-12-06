Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB8B469558
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbhLFMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbhLFMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:01:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCEC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 03:58:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so41599684edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8czfXpKKKBhxk8YRASmGs2oGmsxo+rvu4GKXxhDJOmo=;
        b=eQfk1agmaEGiWLMHRuJlv9dlvf33+lQn78XtYW5EUMfvjN3nwYfI9szIRrmhZkRSYb
         02N3slGJVoM5dkf18YF4SorALJzn8DRJ0ORdJ6P85J2L4RA+cVgyO3XRanT12D/T2QmE
         kgAEizCKCVqxbw+O6/eYWV6RYjNBpmxgFTkB+2JnFVPxBzdLi28fP/icJ17xieBjO4ZI
         lM1aPttCVNaWpa7fjdupztevV6BWTv9qkKQAMqsk7jwPpyx6cTCWNSXSINS/gPisX0FQ
         ou/7wUbNBXuMokhyyV1AHGwayHnplJVhZkGb5qMGoXFa7PbMrOxLT27cYL2R5fPMAUGn
         hI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8czfXpKKKBhxk8YRASmGs2oGmsxo+rvu4GKXxhDJOmo=;
        b=4b7if5TMEJclB6ZnLWTOLSKdfQ5lS8c0YVYK0Kxn+8fHuumf+z8gEq82CoMo9c7qSi
         a+WXtlI5E46G1EzoKV/2M5pPPPBIC5IhFDQRYJjPRuCy6qNnyJQcZCvCS1mP01dJa1ZU
         4is1Ow2wBwhkKAJnjfyq+753nBaA4unppkbivg5PU+GLhpSDzPeEhO/OM2e7CBlTslMW
         tZh+ZSmfqFpBJ/P8EspEOPRYXR+krgsk35pys7o2/Auzi/gDWYmjcTKlc1eR6eKJwFAf
         bYP00I3UpM+cDU/JbPiMi9xEJZ3w1FpvzX7ZI5A+Q6HAWrX+blivx1pVPWXlagqqzGQ7
         wVlA==
X-Gm-Message-State: AOAM533iRSEeoQCL/FdEzFEfq662gsod2H2OcQ28mCRw7Gc1GcSzN1Xk
        1z77cIiSeEvthFoh8SZfwDHq6jpITsPipDfdm0M=
X-Google-Smtp-Source: ABdhPJxqXXr19fzYx3BPsLa+cMipdu652XBtn3+P+HMbwRUSW+KpUc0o4+ZKcsrmE49eZC+PVYzoCn/0puilY2e9wk8=
X-Received: by 2002:a05:6402:604:: with SMTP id n4mr53709810edv.226.1638791904804;
 Mon, 06 Dec 2021 03:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20211206113828.42523-1-stephan@gerhold.net>
In-Reply-To: <20211206113828.42523-1-stephan@gerhold.net>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 6 Dec 2021 08:58:13 -0300
Message-ID: <CAOMZO5A09BDOuEbmWJVD_5d=E6wSf3YcCf0=EkB-B2wWR0r52Q@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Register SoC device only on i.MX boards
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 8:40 AM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> At the moment, using the ARM32 multi_v7_defconfig always results in two
> SoCs being exposed in sysfs. This is wrong, as far as I'm aware the
> Qualcomm DragonBoard 410c does not actually make use of a i.MX SoC. :)
>
>   qcom-db410c:/sys/devices/soc0$ grep . *
>   family:Freescale i.MX
>   machine:Qualcomm Technologies, Inc. APQ 8016 SBC
>   revision:0.0
>   serial_number:0000000000000000
>   soc_id:Unknown
>
>   qcom-db410c:/sys/devices/soc1$ grep . *
>   family:Snapdragon
>   machine:APQ8016
>   ...
>
> This happens because imx_soc_device_init() registers the soc device
> unconditionally, even when running on devices that do not make use of i.MX.
> Arnd already reported this more than a year ago and even suggested a fix
> similar to this commit, but for some reason it was never submitted.
>
> Fix it by checking if the "__mxc_cpu_type" variable was actually
> initialized by earlier platform code. On devices without i.MX it will
> simply stay 0.
>
> Cc: Peng Fan <peng.fan@nxp.com>
> Fixes: d2199b34871b ("ARM: imx: use device_initcall for imx_soc_device_init")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/r/CAK8P3a0hxO1TmK6oOMQ70AHSWJnP_CAq57YMOutrxkSYNjFeuw@mail.gmail.com/
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
