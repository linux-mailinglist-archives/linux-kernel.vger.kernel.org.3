Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0384820B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhL3Wov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbhL3Wou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:44:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EAC061574;
        Thu, 30 Dec 2021 14:44:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o6so103022467edc.4;
        Thu, 30 Dec 2021 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qu1iBkqwq4gwDrjzqUJwaE3i7AcALVAHr+dbklNhfGM=;
        b=Hb2X3me5ngwnM9/ovCXQctanhIuWZssE/FpP28bQTN+27vlXffb/DwmYhJlXsefzkV
         6A2jV/+Vs9Pait7i2wf4rxgPdLuHX5DF5r9cyCiAq65wWS3QZSyYrnt7eHmLqX8OggSD
         chLg3CJR5j/f5vRMPHmnz8p6JTzl+qFeq88ApvXU9uW02YL7Yi1FSxLDBJoeR/bgQo4o
         bbNbnV10YkiOUc7azSu8wqDEkBFig81kpmqO5FEkZbmwquUlaympNWoXSADeO/wUwKjV
         hqt9STlGo6LCHkVS4qQmbWbfKea6K5ylQgUV5HkjkEDZ1NIRKY6pwBfF9OSjeYPVrtEz
         Z33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qu1iBkqwq4gwDrjzqUJwaE3i7AcALVAHr+dbklNhfGM=;
        b=o6/vO/oELDC7GHPs35kyYSbQZi986SbeRFlyit5TsJNC0kV1zLF3b6dJuANB07nLFX
         KUr93sk+BHoWwbYLXqIZIlTTkuO5apS2MSdZRav4Rau4kVdgVV0b1vX3P44EP9YKqPYP
         PcRu2Zao34DLurp5Gox1fSkLw15MrDf687YQrxHESlwbFRfBVtD52cpS0atXaQRfGahE
         DzdWEplm4R3wtQQIRD0TSHT/IL2WZaRMTLJ6XWsly+z4GXQ+39z6lllyoQ6hKuHrunxn
         xeuXo6mkUG8S1u5NL3+VaxdrCP4ehPsaEVogHfkeFruADq4hocPjT2L5+y/szPJ+W5pB
         xQOg==
X-Gm-Message-State: AOAM532gLM+mELuQ5KWoQ0yPswMk3L8hzRstdDiZOoY6RgYiuCEMv98b
        ByrrRIUrIPVRZCBaSILFSKWoxmIRWXCJM2+IkD8=
X-Google-Smtp-Source: ABdhPJzsaTcMpcokf1ks8GXkefbPz3tzcAwBpu0OISmNor47kqTcwkW/dfI/sBF2vR4KUIc8q9FXIGbKJ91dMLZZAms=
X-Received: by 2002:a05:6402:2072:: with SMTP id bd18mr31917772edb.280.1640904288271;
 Thu, 30 Dec 2021 14:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-6-yu.tu@amlogic.com>
In-Reply-To: <20211230102110.3861-6-yu.tu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:44:37 +0100
Message-ID: <CAFBinCC7pvT4=LhowZQpH-_5=90KBnczcRfYc3tLQr8hEh49Zg@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] tty: serial: meson: meson_uart_shutdown omit clear
 AML_UART_TX_EN bit
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
[...]
>         val = readl(port->membase + AML_UART_CONTROL);
> -       val &= ~AML_UART_RX_EN;
> +       val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
>         val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
>         writel(val, port->membase + AML_UART_CONTROL);
This looks fine to me but I think it would be good to Cc the author of
commit 855ddcab352c15 ("ARM: meson: serial: only disable tx irq on
stop")
The meson_uart driver which Carlo added eight years ago did clear
AML_UART_TX_EN here, but it was changed with the commit I mentioned
above.


Best regards,
Martin
