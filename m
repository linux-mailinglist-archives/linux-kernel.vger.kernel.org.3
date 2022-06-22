Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19D45554CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358028AbiFVTmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377319AbiFVTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:41:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6241FBE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:40:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n144so27875491ybf.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=639SSWBKWeFVnHTVsnIzN/TZ7k1h9fmNPATWBIChIyw=;
        b=G8X3vA4e0jP9t9yyHPeLuRESdA24DMIkCfPu5Bfly53+tjcz8sJhQ87fS6AXPhrj4D
         Un0+CsiNBNRkm4IMgtVYtfnz51k0ntH+Z/3iFO1RMOODYIqV/UBhtGLiE6uMxkRDcJnF
         nBzwU3BLS98dR46DcTYYm16g7QD+8x51mtncSUWBF2CT0gxsflBQY1tA+debjqlmAe/q
         QlIdhuNK1QLuPaAil54LAi0aU9ZBoGbjoKHY+saslronaFmEGNRD4FcpKtnLjn9L/jCM
         gkuC3dDE+vRq/hUVUcyd3LzadOyq92dTU7kKgQlsx31ixW959JxLJACf7pjhr7yqWvBy
         3Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=639SSWBKWeFVnHTVsnIzN/TZ7k1h9fmNPATWBIChIyw=;
        b=oha38c//tTVxpf3uwC+mlc9qvajaR7hgrLB0BrMDccjpdDfPlDkrbEDSEyK04RRlaE
         5YB+T/BO+CPc4z/GrCWPY9oHYyGYi6OuntzVb60d4Ai0jKmW0Z2mHBT0dnZ2K1M+KSxF
         DWGflFyhSf4mgjf2Ge5UEZg9jqdA3ouDoz3XBCEtTo8jVrjsivm7EcrKWjz33eXlVQaV
         O5gNgNvJwXdztRpuejOgoC8bLNtAG7pw7hvX2gaGWWpvjztyjodX7TZaE7jsVe0y6dj7
         osOdBLb6BFKfGFXhrDJII9OMjiwH7ImnZ43nIU6FHqPCKSFR80finpgBwPhCtiPsX0N1
         SeFQ==
X-Gm-Message-State: AJIora+SsN/BNwaTSiJ2qBye2KyQdEAGfizI2MUXzm7p91g5S7BcQM74
        UGDgFM84n5h0SwnSTcLx9tq03ETfxhBopVEkw2HBnw==
X-Google-Smtp-Source: AGRyM1uGAbZ+vgElx+1b7AwZLGy2A0tJFHcsPRwmnxA3B57ZLQRr7LNkm5trT+iojrHOETV01ceBq2pLIkgfpdHeMcA=
X-Received: by 2002:a25:cad1:0:b0:668:69b5:bbba with SMTP id
 a200-20020a25cad1000000b0066869b5bbbamr5789800ybg.352.1655926857785; Wed, 22
 Jun 2022 12:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com> <20220622074756.GA1647@pengutronix.de>
 <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
In-Reply-To: <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jun 2022 12:40:21 -0700
Message-ID: <CAGETcx_qm7DWbNVTLfF9jTgGA8uH8oAQzbPcMDh4L6+5mdRFog@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sascha Hauer <sha@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 1:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jun 22, 2022 at 9:48 AM Sascha Hauer <sha@pengutronix.de> wrote:
>
> > This patch has the effect that console UART devices which have "dmas"
> > properties specified in the device tree get deferred for 10 to 20
> > seconds. This happens on i.MX and likely on other SoCs as well. On i.MX
> > the dma channel is only requested at UART startup time and not at probe
> > time. dma is not used for the console. Nevertheless with this driver probe
> > defers until the dma engine driver is available.

FYI, if most of the drivers are built in, you could set
deferred_probe_timeout=1 to reduce the impact of this (should drop
down to 1 to 2 seconds). Is that an option until we figure out
something better?

Actually, why isn't earlyconsole being used? That doesn't get blocked
on anything and the main point of that is to have console working from
really early on.

> >
> > It shouldn't go in as-is.
>
> This affects all machines with the PL011 UART and DMAs specified as
> well.
>
> It would be best if the console subsystem could be treated special and
> not require DMA devlink to be satisfied before probing.

If we can mark the console devices somehow before their drivers probe
them, I can make fw_devlink give them special treatment. Is there any
way I could identify them before their drivers probe?

> It seems devlink is not quite aware of the concept of resources that are
> necessary to probe vs resources that are nice to have and might be
> added after probe.

Correct, it can't tell them apart. Which is why it tries its best to
enforce them, get most of them ordered properly and then gives up
enforcing the rest after deferred_probe_timeout= expires. There's a
bit more nuance than what I explained here (explained in earlier
commit texts, LPC talks), but that's the gist of it. That's what's
going on in this case Sascha is pointing out.z

> We need a strong devlink for the first category
> and maybe a weak devlink for the latter category.
>
> I don't know if this is a generic hardware property for all operating
> systems so it could be a DT property such as dma-weak-dependency?
>
> Or maybe compromize and add a linux,dma-weak-dependency;
> property?

The linux,dma-weak-dependency might be an option, but then if the
kernel version changes and we want to enforce it because we now have a
dma driver (not related to Shasha's example) support, then the
fw_devlink still can't enforce it because of that property. But maybe
that's okay? The consumer can try to use dma and defer probe if it
fails?

Another option is to mark console devices in DT with some property and
we can give special treatment for those without waiting for
deferred_probe_timeout= to expire.

-Saravana
