Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB147138C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhLKLEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhLKLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:04:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67098C061714;
        Sat, 11 Dec 2021 03:04:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w1so37223848edc.6;
        Sat, 11 Dec 2021 03:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIb47VprdWFqaYNeUun/Hhz3eQ25TOLB6cdSu9XfynU=;
        b=XrTnbZSRcG/Zj7Tm1WWffuMPxry0mfH24kZV0Jr67trUuKhNh+EaX6jtcEDcQbHTFs
         ZgfMxXsVArf7N8BBNyllGbkzHz0ULuKaJYc19ibvj6UB6MZjXcR4sIMpVbzXuv/h1JGv
         SDYMikMmVfnWy7iqWOmIbF/ppxjQq2m1KyZDVu0rdTz7hG7Xyy3Taq9iiCpx7fTdGITt
         QR5/WK1IRRflaTZInERafwuk4HY6TU/BwyoT8+wvaf6m0IwLcY2WYURyeK8ijeR40t1O
         +T/pApaJvpYRBi8eozfjpr9JZgg+zGucYmoxz5cAjmX5bzaDbI7vT6s99XSbvmZ7MwwG
         bzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIb47VprdWFqaYNeUun/Hhz3eQ25TOLB6cdSu9XfynU=;
        b=lOjOJzBS1ojVVLjIgteYrkS60cnpfZ3Jp/MV9SAMZpyll4Ko/F/+IGF+1vpP+MZB3B
         dQuFW7pW5in7vO0hfYRY9o4avRj+WahDyl6SV9pqp5uLsqOJQJXu5b7uz6hilOXet9LZ
         3VurBv2dtA0EBbIK3M5CY4xlson6e1CWOI7XzMBTzAvLBXGVoVDLyDEm5pgLMpL/mY+r
         bu3ETaI8QFBN6PwpeR0ks5hdo/zSW/xC3m3ZtL4uVGK7eTHBcAX7HUbBeqzSVHGptkkO
         QiznUDYIHXmV+qI14kaqa9ALAoE3zoj2C8+7Q9jTCcTqEYvW+3IDVtCQMsxyxHFUcMty
         IgIQ==
X-Gm-Message-State: AOAM5334KmzL7dJr+pW2/kOmxYR1osF6xmmyDctJ9uDI5IlAf5n3Gfyx
        JFOcKZ8t+nOfBIr9q2jpG08COXgFUErTeoBo/UgJwT4u
X-Google-Smtp-Source: ABdhPJw3+ZBlouBUvfriD6mylDdzfvSHX3McGwZH09ngmXrH/6P3RNs+ETv30Qyo5z1KUncjPopW18qO1AkYd7mojPA=
X-Received: by 2002:a17:907:3f02:: with SMTP id hq2mr9544614ejc.566.1639220650883;
 Sat, 11 Dec 2021 03:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20211124175542.2772-1-i.bornyakov@metrotek.ru> <20211124175542.2772-2-i.bornyakov@metrotek.ru>
In-Reply-To: <20211124175542.2772-2-i.bornyakov@metrotek.ru>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 11 Dec 2021 08:04:00 -0300
Message-ID: <CAOMZO5CLRaFhd31Q4LaFt+R4sNiAmZ6rg0BzjBmWow779OnWCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bus: imx-weim: optionally enable continuous burst clock
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     system@metrotek.ru, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 3:10 PM Ivan Bornyakov <i.bornyakov@metrotek.ru> wrote:
>
> To enable continuous burst clock, add "fsl,continuous-burst-clk" along
> with "fsl,burst-clk-enable" property to the weim bus's devicetree node.
>
> Example:
> weim: weim@21b8000 {
>         compatible = "fsl,imx6ul-weim", "fsl,imx6q-weim";
>         reg = <0x021b8000 0x4000>;
>         clocks = <&clks 143>;
>         #address-cells = <2>;
>         #size-cells = <1>;
>         ranges = <0 0 0x50000000 0x08000000>;
>         fsl,weim-cs-gpr = <&gpr>;
>         fsl,burst-clk-enable;
>         fsl,continuous-burst-clk;
>
>         client-device@0 {
>                 ...
>         };
> };
>
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
