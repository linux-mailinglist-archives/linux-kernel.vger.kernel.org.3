Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2A4A7084
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbiBBMMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiBBMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:12:23 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2AAC061714;
        Wed,  2 Feb 2022 04:12:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id h7so65004928ejf.1;
        Wed, 02 Feb 2022 04:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VjxU+a2631orSbCKcBoAIyvpjxFX1VaObSlXXapMheA=;
        b=lPmznDYBDqGWnpjW6z/4KKkgngH4UAH6UYRkX022/L/VRYMydkxDBdSnZDIIVpoGf6
         vNz8i22QOdNKX3Mzs1fnpOq6ROt/rxeJkAu3Y/HPYwvaQ8QWSOVvDT4FHhFAI5x782Zp
         dIryYRcfkLwb1VvqsoCIM4lQe/ZMTHA7zTHDhUqTeOusTnG7YgnLzu/m5PY3fGOsAjiX
         bQZ/eZzvXqnfAKD8XR8uGhHUOEAmi5glijpCEW83ULTaLnxW/jkfNXCDeyFEnR/km/r3
         FK7aqARULTQCGWlHiW8xrhACbht9PaXysi/N7RHNQ5ZaZzAJHROL9PK8y6up3JF83pi8
         kCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VjxU+a2631orSbCKcBoAIyvpjxFX1VaObSlXXapMheA=;
        b=alHUbJ0ScROPBpix1k5Jv88EVIiQ2nWAwvZQ2pGVj7C0da3SWNssugmp4mqAssnBkY
         0LmKvm81L6wMMB5AeSYSRMMyFSluLXA3PNz1pg9Ym0eyg3YB7n3KTcr4ozZzZz63/ULD
         ciP4tZx5FTN8g4/+pqTMwpDppdsfQ4/LjH6hqf4ckRsVRN5E4IWaJvZYtlC+TJ1F/yVr
         yeqB1tZm1g5esvbkpnLTmz1v3PIzXW9eP5zYEalOBd9AbIBnIX+SjpW3vJjvQvHwzW15
         XJI2EyvaaV1xi+g49HUeIcxrDKYEpkEv4brtwECVbDGudFq3BkkzDkc5ZEWFitGaSYSQ
         Tm/g==
X-Gm-Message-State: AOAM533F4Quazi9SJ9Jqh87QNcA8GtCBw4LTSzkwfL3a92nzI8Yn4xUL
        OQEN2+70HFDhRX2UEiICcJfvWb9fMgrT+6Zmo5s=
X-Google-Smtp-Source: ABdhPJytPcdANFl4Q+b3tRRf1U9ZJ1u1gJh3CsJfOpIUZz3WCczhVwN0LJHBSl+IL87Pl8TNOg02kfBqbBb37NgLhqI=
X-Received: by 2002:a17:906:c14d:: with SMTP id dp13mr25287460ejc.132.1643803941259;
 Wed, 02 Feb 2022 04:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
 <CACRpkdYEigGHkoGfBg15tFXadgpXUAjDOnw7ePXhmvHJqPEJXw@mail.gmail.com>
 <YfZkis8M81Ejpagq@latitude> <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
 <YfpyjDBH83FE7r4o@latitude>
In-Reply-To: <YfpyjDBH83FE7r4o@latitude>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Feb 2022 14:10:44 +0200
Message-ID: <CAHp75Vdg8zFSHaTP_8jQua5QfRYbvZ4_rLdCtt3ks8YEibseTg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 2:01 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
> On Tue, Feb 01, 2022 at 11:42:11PM +0000, Joel Stanley wrote:
> > On Tue, 1 Feb 2022 at 13:05, Jonathan Neusch=C3=A4fer <j.neuschaefer@gm=
x.net> wrote:

...

> > I assume you're sending a v6 to fix some of the warnings?
>
> No, the warnings are fairly independent of this patchset, it's just that
> the adjacent pinctrl-npcm7xx driver started to be built by the bot, due
> to my Kconfig change. I'll fix them in a separate patchset.

I guess you need to fix that first.

Because now and then all CIs will complain to your patch and confuse people=
.

--=20
With Best Regards,
Andy Shevchenko
