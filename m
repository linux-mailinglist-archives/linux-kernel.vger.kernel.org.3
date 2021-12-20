Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8D47B046
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhLTPac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhLTP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:29:42 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A65C061D60
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:21:29 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id o2so6379737vkn.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hAp0PfmGB2pMZBztL7AeQzwUtbDOof2ro2NrJ2jvCs=;
        b=M+kLpz7Y9EgeUAfkXzReP8pE7rXZLW0/U1Va9YBYOrr7qJWrE06Wt5wA5hc2AkOOnS
         aEDjRMxFcoAKhXyQ0hR+pii4XM1Qyy4qa6yardk03OgJtjRzJlGGldw1Tt8qc4QXUCSk
         oiv/kFWlK2pooudkx3ErmtmvhmKbq5pe0zZYVhaln/r8Glw1kOgRvA6+Cwj8KnSStIP7
         cAewagXibrjGcVn/NhdqnxGhI06M4Cvje+W3sF2NjE2w7w0GculzSfbnOzMfpVmaO5vM
         FOWEzfqQuAAZbKtQo337v2aowvdwYGBjyT4AHdeZAzIn38m+sN5zT02UNAw8PQI20ExE
         SYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hAp0PfmGB2pMZBztL7AeQzwUtbDOof2ro2NrJ2jvCs=;
        b=SI7pgRIgCrCT3zr9ocNWtM2K0mjhIbx9xGJtO9leIkfALhVadUQ9IsbwAuJu2vGRRp
         uCuW55pSVSwZG44uMOuVv6powYWjaTrwlUGM0r0R5zJT/Iep/5bI4LbfHw3Zz4UxifZs
         v3c12GRHijws+L+5TWtO1ep46Q1H7QFEiXQaT2gix/wfGRObtvQfs4G9TNrgmVcCEFUr
         q9pPJD1/Xhm6bhGIn0SFZWyLE9KZ+WDUIyW880IxjRa/r6PYN4L4qKNv3mYEiwDAp+yM
         QuCbXUQFfzYso+9RzkgxP6qvK2RdoKschxH9OKYyro2TBCG1tzv4Rk2RJLY0uc41a0s0
         ttqw==
X-Gm-Message-State: AOAM5317xvdA0vZ4pbQrRaYrNV8DobOWoZEG85srHkWK1PZ5Hje+1n7e
        bEUCMKBpPS0gBMXaZdzyCGPq3xMdhWOt8ycUYMoJkg==
X-Google-Smtp-Source: ABdhPJyTNBpocGV7qtoeL6omBq4tJSpIoSxwQjpiDZ4N44pUz6MFxLuf0bHfL20uGAilVIycAEo0wvXpTET3t9N+9K0=
X-Received: by 2002:a05:6122:c9b:: with SMTP id ba27mr5956186vkb.14.1640013688504;
 Mon, 20 Dec 2021 07:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
 <20211204195757.8600-4-semen.protsenko@linaro.org> <ab15a97b-9351-4d50-f392-21cbfdec1289@canonical.com>
In-Reply-To: <ab15a97b-9351-4d50-f392-21cbfdec1289@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 20 Dec 2021 17:21:16 +0200
Message-ID: <CAPLW+4m0vYZUujki6D4KHV3TjBCZvnO-cZuoOatefQpfTEV3Yw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] tty: serial: samsung: Remove USI initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 at 13:35, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 04/12/2021 20:57, Sam Protsenko wrote:
> > USI control is now extracted to the dedicated USI driver. Remove USI
> > related code from serial driver to avoid conflicts and code duplication.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v3:
> >   - Spell check fixes in commit message
> >
> > Changes in v2:
> >   - (none)
> >
> >  drivers/tty/serial/samsung_tty.c | 36 ++++----------------------------
> >  include/linux/serial_s3c.h       |  9 --------
> >  2 files changed, 4 insertions(+), 41 deletions(-)
> >
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> Greg,
> If you are fine with the changes, please take the serial driver changes
> via your tree.
>

Hi Greg,

If it's ok with you, can you please apply patches 3, 4 and 5 from this
series? If it's possible, would be nice to see those in v5.17.

Thanks!

> Best regards,
> Krzysztof
