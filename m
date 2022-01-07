Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A913487DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiAGUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAGUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:54:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F81C061574;
        Fri,  7 Jan 2022 12:54:49 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j6so26504839edw.12;
        Fri, 07 Jan 2022 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYqun+LwcFZngeUshoTPTihl/JBvURcYFS+g3dFr7pY=;
        b=JmeQL+nQXNozJbExGxXiex7Z2lWmVrtO5jQd2GIF1Cs/LpIekKoxfAXcGOeeeUeJoW
         Ju70RuLvrys6cGD2dvAMj+2J/M34hu1JcNlyooeifO6BG1qhdYBDNddYpKYB97Gq2JeW
         m3mSZm7Pzvxy89rRjVQuXakRW/9LuDJbCMInmh7vyKN+CdV0BpGf2d7w0JX7VkzNf6Dz
         KH+bu/cvolM+ZrTnNiZ3LRYldSdUnHKxyi+9WBMIQD2HX7xGiL5wCv+lGv+E3F9xcZsq
         DB3UT055T4CcG8sffjs1G0FUGugnWprHwlozwB32xImqMH4Gu1rqN/ngwKPAnbkvGNJu
         ZH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYqun+LwcFZngeUshoTPTihl/JBvURcYFS+g3dFr7pY=;
        b=pW0ltc6XME27CMiKWyIP4DmAEAH/p+/JkG3Vn1dV/OnJw3+sxxoCNa7eEDTDX6inUB
         De+9+rIXD3P/BfgZ+EbnLvP8Ohq+HlLGb2sxOkvy+KxW/IRB5VoBF8eotAk1pF7R3Tqr
         who1oTJsIjacRdyK702srV/mJhA++Bgh46DvS35+YJa/UO3FmAwHMQbsjxqMJTFRpbyP
         rTg1TEGXkP9sJ8aN0h0q2GYajSpIP/0ENL/6fdypmPVMjxjD+wrlXjZejHMVe1vAMs6h
         /D7aWUvHJ37SRPTTqmTHsid0LtCXUVVL53yzTdTo0Yt9AlebpxZ7vkTBSx4OcXP13Puf
         cyGw==
X-Gm-Message-State: AOAM530PxasoUn67w3rRj/FVkLow6FgaO0PDzyCnXoWTcJpWiQm1ft5B
        YEVGDc1ZQvwPUW7trPzbHUXlFPIUAv3vOfKKwvY=
X-Google-Smtp-Source: ABdhPJw4kjvtMSCN/EYkF9HQv+yinFPUdFSWCQCaD0VtTsfhAU4vzaDMumOlD/8dnaiaNaBdAXVAsEp5WqwMU7joCYY=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr62289532edx.218.1641588888229;
 Fri, 07 Jan 2022 12:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20220107170616.2041589-1-gsomlo@gmail.com> <20220107170616.2041589-4-gsomlo@gmail.com>
In-Reply-To: <20220107170616.2041589-4-gsomlo@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Jan 2022 22:54:12 +0200
Message-ID: <CAHp75VfBUomALtdhRXN-Z12RDAvLUiNHzazK0Mit6ExzRUTtRw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 7:06 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
>
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!

...

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LiteX LiteSDCard driver
> + *
> + * Copyright (C) 2019-2020 Antmicro <contact@antmicro.com>
> + * Copyright (C) 2019-2020 Kamil Rakoczy <krakoczy@antmicro.com>
> + * Copyright (C) 2019-2020 Maciej Dudek <mdudek@internships.antmicro.com>
> + * Copyright (C) 2020 Paul Mackerras <paulus@ozlabs.org>
> + * Copyright (C) 2020-2021 Gabriel Somlo <gsomlo@gmail.com>

> + *

I guess I have commented on this and there was no discussion about the
necessity of this blank line. I dunno what else has been ignored, so I
will wait either for the continuation of the discussion (as per v6) or
amending code in v8.

> + */

...

On top of that it might still be the ordering issues in the error path
of ->probe() and in ->remove(). I believe we will likely see v8.

-- 
With Best Regards,
Andy Shevchenko
