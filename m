Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5F47B560
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhLTVtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhLTVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:49:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5EC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:49:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g26so8950859lfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gfwB1Y7WC9PzSYQgy+aXs+dGdxRfl9cHOHvCWDuJnkU=;
        b=kDYD5ludLUCahkPbmHfYN+HOIKqU686radMmzyGW8pUbmGj5NrZtro7jjcNPRgkIm7
         Yf3HEeLzUG9wx5jj/mh775SCi0vaUmjBjKqI4B5v3Q+0PoiAeyM7ND7UKLaPOCLECo9W
         T6TaMrlpAudBkc6EXUhIKgEZOxxxTUd97O0N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gfwB1Y7WC9PzSYQgy+aXs+dGdxRfl9cHOHvCWDuJnkU=;
        b=UtCc1XrJ3hGp9gWtFEHP2U8iYTZd4uPi0hUbkuupb2UnYcjd2zkvxqMG3BObtbOKX+
         Nw0PYhkqDMHXXJhEvc1GbeW+QL4N8LxStn4Zv86BB05cQhdgby+M0fT9eoVRmI6Ea7Mj
         iOt6HLWQMY6LQCmejtrqQ7CO5lbijCDHURrs+IUfMttgjTUmHvhX3x6E4DyHDijR2MXI
         Tr8sd1auPnIEjgzeT4rSiLS9NXjufbhZPJTxo8yIEy0wsoSrGGa1zXWpREnmLTaWkFPA
         yC9HeodMCvTZpCXxiO+C+233F/VNlv63k5hjus22dTB2iGAHwHSRlD+Kup8CTYPd42F1
         gTTA==
X-Gm-Message-State: AOAM533kH95+GT6VVMZwVViSZuAmqx97ihee2rdNAuN++meOgLb+XS5Q
        Umfh5rhNhwtPeqiDMdDuih/XpuKumbnHQhYe
X-Google-Smtp-Source: ABdhPJwR9Sf7UBeFxZsIFe/QVnfZg5EjBWKmUS5s/O5yNjgdaVxQNbvbmABXO0WOP8GgYNbiV4Vfcw==
X-Received: by 2002:a05:6512:3a87:: with SMTP id q7mr109898lfu.642.1640036969444;
        Mon, 20 Dec 2021 13:49:29 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m2sm1340621lfu.254.2021.12.20.13.49.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 13:49:27 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id bn20so18158881ljb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:49:26 -0800 (PST)
X-Received: by 2002:a2e:8848:: with SMTP id z8mr17346ljj.429.1640036966379;
 Mon, 20 Dec 2021 13:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20211220210643.47842-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20211220210643.47842-1-pmenzel@molgen.mpg.de>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 20 Dec 2021 13:49:10 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ_Lg1ODV5sEqtW=SauhSXxi6+fh3msOuhnJy8-sNtORcg@mail.gmail.com>
Message-ID: <CAE_wzQ_Lg1ODV5sEqtW=SauhSXxi6+fh3msOuhnJy8-sNtORcg@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: i2c: Add device property for probing
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        coreboot@coreboot.org, Matt DeVillier <matt.devillier@gmail.com>,
        Felix Singer <felixsinger@posteo.net>,
        Duncan Laurie <dlaurie@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Dec 20, 2021 at 1:07 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> From: Furquan Shaikh <furquan@google.com>
>
> Dear Linux folks,
>
>
> Google Chromebooks are often built with devices sourced from different
> vendors. These need to be probed. To deal with this, the firmware =E2=80=
=93 in
> this case coreboot =E2=80=93 tags such optional devices accordingly =E2=
=80=93 I think
> this is commit fbf2c79b (drivers/i2c/generic: Add config for marking
> device as probed) =E2=80=93 and Chromium OS=E2=80=99 Linux kernel has the=
 patch at hand
> applied to act accordingly. Right after the merge, Dmitry created a
> revert, which was actively discussed for two days but wasn=E2=80=99t appl=
ied.
> That means, millions of devices shipped with such a firmware and Linux
> kernel. To support these devices with upstream Linux kernel, is there an
> alternative to applying the patch to the Linux kernel, and to support
> the shipped devices?

*sigh* I should have pushed harder, but I see it managed to
proliferate even into our newer kernels. Not having this patch should
not cause any problems, it can only hurt, because the i2c core has no
idea how to power up and reset the device properly. The only downside
of not having this patch is that we may have devices in sysfs that are
not connected to actual hardware. They do now cause any problems and
is how we have been shipping ARM-based devices where we also dual- and
triple-source components. However if we were to have a device that
switches between several addresses (let's say device in bootloader
mode uses 0x10 address and in normal mode 0x20) this "probing" may
result in device not being detected at all.

If we wanted to do this correctly, coreboot would have to implement
full power and reset control and also add drivers for I2C controllers
to be able to communicate with peripherals, and then adjust _STA
methods to report "not present" when the device is indeed absent. And
note that even in this case we would have issues with "morphing
devices", so coreboot would also need to know how to reset device out
of bootloader mode, and maybe flash firmware so device can work in
normal mode.

However coreboot does (or did?) not want to add code to handle i2c
controllers, and would like to push this knowledge to the kernel. And
the kernel does know how to handle peripherals properly, but that
knowledge lies in individual drivers, not i2c core.

We should remove "linux,probed" from coreboot and not propagate to
newer Chrome OS kernels, and keep it away from upstream.

Thanks,
Dmitry
