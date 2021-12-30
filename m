Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437E44820AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbhL3WlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhL3WlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:41:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A12C061574;
        Thu, 30 Dec 2021 14:41:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so103005169edc.11;
        Thu, 30 Dec 2021 14:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Io66HcUiLdVjjQqfsG6ke9IYSCPIgdy83uGT3iFGDRY=;
        b=fKnkHOWPj9bJBcuLBDjRUjw82wEi6715Sv3LgvoYt2iPafs/3BjDjvZv/lsNwRVCIf
         UdOdo7kDBPKeU8jw3NIMRCMA19K76CPQ2gtywrpOfaHQbIu8u7BxeOKHjCdTtxt12lwv
         WIXS8D5YG4O+fhY4pOPlHkuFPoh1ErwgC0gfEA5hhis3B9IMPp9caigTWJzmK29t4YOQ
         3T78D2/ceYpQfhW3Z4OjEr/3OqOmIYcBzVymHls6nFgoezCFhkr9aHszJNyxRGtnOgkB
         TPUCM/4E+xhrKPwFV86csn3Q40lDwlVuY3IX6mAxzdXJK5jafYQTb8IwsJGGZmXDvaoL
         UYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Io66HcUiLdVjjQqfsG6ke9IYSCPIgdy83uGT3iFGDRY=;
        b=NKAXDr8Ldn0a3w4RlOdPcA1ztFY9H2H1SM8BjNFZx4Hr4V2n1CcFu7eB1txYEHDuB5
         XW/6OxmkwrOZRPDFSmIgsbfBSOFbJvtMssSdonWTiynWNY/fCDjApvZw5hyN0J0tD/MK
         zbAo6S734x52bEq5PXgdg8Y7RlPj2W65gxiqhoEwtbgNN8yVLTA8qDxUIlA64f82Ibzj
         +e2mPZ6CcDhtg6irxJRSulS4fQ4AfZ+AxL/cbKdr6hrt+eNEcRcZLpViGouqqBfcaZgW
         cM6zztrxuT9YLFsYhNq18r3j9KDKwBYo5Mt9RbLt3NiNCT361+dzCXuXf6cAiAFLgRfF
         b2pA==
X-Gm-Message-State: AOAM532wLfZopD+BULwbi+arPK0mf2KylnI1tudBBSAwvgT8niD1akgo
        XcLTIbzjvfem4wgEnjT43hGGBQ9tjTVgiDwbqS8=
X-Google-Smtp-Source: ABdhPJyc3+8pKEBma4UIVLbyKZ0OwEGnDSbOQoseLj9oz+jzU13ksxDgRUoco3UPkmeVynlUMRu417KD4nrZocZsvx4=
X-Received: by 2002:a17:906:ff14:: with SMTP id zn20mr27176133ejb.649.1640904079384;
 Thu, 30 Dec 2021 14:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-7-yu.tu@amlogic.com>
In-Reply-To: <20211230102110.3861-7-yu.tu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:41:08 +0100
Message-ID: <CAFBinCAzDSw6jmpU-S2KGZ32D+U1fNqLgKMmkPSdz=-XN4isDA@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] tty: serial: meson: Change request_irq to
 devm_request_irq and move devm_request_irq to meson_uart_probe()
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:22 AM Yu Tu <yu.tu@amlogic.com> wrote:
>
> Because an interrupt error occurs when the user opens /dev/ttyAML* but
> don't close it, and then opens the same port again. This problem is
> encountered in actual projects.
I would like to hear from the serial driver maintainers whether the
described problem is a userspace or driver bug.

If it's a driver bug then this should be sent as a separate patch
(unrelated to this series) with a fixes tag.

[...]
> +       ret = devm_request_irq(&pdev->dev, port->irq, meson_uart_interrupt,
> +                              0, dev_name(&pdev->dev), port);
You can replace dev_name(&pdev->dev) with NULL to achieve the same
result with less code.
dev_name(dev) is the default value, see [0]


Best regards,
Martin


[0] https://elixir.bootlin.com/linux/v5.15/source/kernel/irq/devres.c#L64
