Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE9848FA13
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiAPA64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiAPA64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:58:56 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA414C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:58:55 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t9so18023766oie.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Zbir2HQFQZdW9Tmc/FhUTrgl/itixs+HF0NKBgjfVc=;
        b=Yh0vPDd1G6keQC/FJtF4agKsRM/U93onYrsMyZG2hqH4zxiYv8BwcyI2njKr6aFPMB
         iCqLfls8da11QehL5xhjaZRimYnfreZ/848FN6buJv6vnAUW8BBHYWW0tHRCTb+DqBpp
         AQad/LL9E2wlF6MLj9SmH9rh2W96loC1zXRyVTSoJ/a1Rer3usmihSpx+/G1DHnMUsCW
         bdjgrGTE8033EaBQecjg1vG0sBJVERrEnV69ZipfazKz5cdIioboi42YAy4aKi9wTLjY
         SH4HggOONaq8/vGf6WlM3wIqq/5XJLlWaRyz1SYJwEmlBJ/rJp/cZ8jV4Nm9AE5szaek
         uWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Zbir2HQFQZdW9Tmc/FhUTrgl/itixs+HF0NKBgjfVc=;
        b=hw6s48MP48pFShoomdSNGirZkDosncFteItGjYmJsae+S0CxWkQoCPcYfjf0PVyAbu
         lO/3xX/TDveVqNkhLBxq/QJLaqhGSmpGV3pVqRzYOEc8r9MPAfdXcnoS3VrRwFyOt3vp
         68dUytv2nUDMJcTPwq+f23J+6DJzoubTlqAhvY/q+t1lGoPUE9TnFAiHN/yHuCL67pLV
         XpdQaNKQVkRR0CgWtfrHdYqgFgN7ga4Vr4jpHWY+u9UyLXWFKDZJmnIuyMkhZs3/OJbp
         6ZBqrDL/k58qyvUldbs/OHC8aUptLTzwAU/eLPSCeZcq0QSX6hZYfE40LMrrnyaOsqRj
         s3fg==
X-Gm-Message-State: AOAM530Arud8Z199H7z3TMQjL8biKKI3K7Fodzy8nSQnyKIOPC6u5z0O
        PZvLx5u5fhAQjW543uDGfX1VSZ3BDLJ/NVOH0nRgyQ==
X-Google-Smtp-Source: ABdhPJxWMRX3TsxnLYFJRGSaSneOnzs9jAel1b3dZQqFej3Jh5BIbaG7pKz3veRZwsjhuRLRjjczmU3tGMJEt2q+IJ4=
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr8350127oiw.132.1642294735018;
 Sat, 15 Jan 2022 16:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20220111140519.1.Ie2662d6289af1e9758b14b37149703c846d5f509@changeid>
In-Reply-To: <20220111140519.1.Ie2662d6289af1e9758b14b37149703c846d5f509@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 01:58:43 +0100
Message-ID: <CACRpkdZ=dNw19Qx4C5w59hxTuOx7O7x9Dw+5wxSTc99WxPRO8g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: drive-strength doesn't default to 2
 if unspecified
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:05 PM Douglas Anderson <dianders@chromium.org> wrote:

> If the drive-strength isn't specified in the device tree then it
> doesn't actually default to 2. Instead, it defaults to whatever the
> heck the BIOS left it at. If the BIOS doesn't touch it then that means
> it's whatever the heck the initial state of the pin was when the SoC
> booted.
>
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Patch applied.

Yours,
Linus Walleij
