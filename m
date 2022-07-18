Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4F578564
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiGRO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiGRO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:29:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17472B1;
        Mon, 18 Jul 2022 07:29:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y11so19635091lfs.6;
        Mon, 18 Jul 2022 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYPlqlfmPSur8GF0RqYSY08DVBhvxgeO+GWpvl7QarY=;
        b=O6W1Zn/nePJWHmpM9MJ5H5o0Hi8rLzd2XYj9JrC9Job3qR3iLLcHWbd39W8O1xS7K1
         +WtOVEzd4owHyN7J+e7uHHSuN5DIMOdH1e3BtMsgToI1yJK7Fa1UgqcoJVZ7g5QTQPuo
         M7FCXLyyMKVTJoUIB5z2/SeiI9jds8m8qWg7VXucYTlGdOgXBBd6GeQswW1N5oELxOf/
         wYH+zjzrxZWHQHGIooHu/3qBEHN845Jw+2o6EJK6WOespU2r7rekF0Su+28xctX1vexn
         10AR8goH4+mU5ixAh+bodnIClmZrdeCNJqPW31bDoLair1fDeEGj0gh4kUOZwTDukrZe
         HWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYPlqlfmPSur8GF0RqYSY08DVBhvxgeO+GWpvl7QarY=;
        b=yVZoPBi1Ic0FrhuSIQIoMjSHmGhlEdOlYCZLLOdfFeUNZG/TtwRmGG+BXVDo81p4tl
         6ckFF5bAPgZVn8lLCMxQk1DB7xXIh11rKs51TsTgdzPjs4beEChBhAOQ82q5SatJJz2r
         FzIqimSoBwisT3jHEXiqsD7uaMd537OLdFkUJ3zvGL4/H/Puxst+itjw9DFjHf9B7NXn
         KRWfhpvLM53aa41BwFukq7eC6N4DjTIw3d3MEafjPqB3W9Ib9zriJc2x6nfrOXm65ZWW
         d9QktInrHG2HzeWLYQpbJeHdjhAA/H+6MOmfotOsoVA5i9Qk2EAQ9/38n2OZlgeEZz3A
         Li3w==
X-Gm-Message-State: AJIora9IN8/lAjM/iw0Ymesg9FH4qU+3l+YW79MPzWHe03+5RFSnFp0+
        dneUNp36605Lm0iyA7muFXR+i5Yaz5bkXoLjw4U=
X-Google-Smtp-Source: AGRyM1su+O+roIcGgBfi1ZQAZ9kFAtsirLqd2tk0nDsGSCWiNaBhhwAAIkoESJDWUM8YccBK47WieVmI65WD8GHrZO0=
X-Received: by 2002:a05:6512:22d2:b0:48a:1ec7:2220 with SMTP id
 g18-20020a05651222d200b0048a1ec72220mr9287388lfu.668.1658154583941; Mon, 18
 Jul 2022 07:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220718122922.9396-1-tmaimon77@gmail.com> <20220718122922.9396-2-tmaimon77@gmail.com>
 <CAK8P3a2PM9pe5tN=N7BMdkwZZKNv9Wa+CEFCyQT_6Ur=O7P5pQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2PM9pe5tN=N7BMdkwZZKNv9Wa+CEFCyQT_6Ur=O7P5pQ@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 18 Jul 2022 17:29:32 +0300
Message-ID: <CAP6Zq1gFnLYspn5+dYbSSOicZibCTbF9Z8bmNV+_HDP3=nLp8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] usb: host: npcm7xx: remove USB EHCI host reset sequence
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Lindgren <tony@atomide.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your detailed explanation.

I will remove this modification in the next version.

On Mon, 18 Jul 2022 at 15:38, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 18, 2022 at 2:29 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> >  config USB_EHCI_HCD_NPCM7XX
> >         tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
> > -       depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
> > +       depends on (USB_EHCI_HCD && ARCH_NPCM7XX && RESET_NPCM) || COMPILE_TEST
> >         default y if (USB_EHCI_HCD && ARCH_NPCM7XX)
> >         help
> >           Enables support for the on-chip EHCI controller on
>
> I would leave out this Kconfig change, there is really no need to enforce
> this specific dependency.  It is expected that a device driver has dependencies
> on several other subsystems (irqchip, reset, pinctrl, clock, ....) and will only
> work if the required drivers are also built for the same kernel.
>
> Also, forcing the USB driver to be a loadable module when the reset driver
> is a module (rather than built-in) does not guarantee that they are initialized
> in the correct order. If only the USB driver is built-in and the reset driver is
> a module, or both are loadable modules and USB gets loaded first, then
> the probe() function should notice this and return -EPROBE_DEFER so
> it will be retried after the reset driver is successfully loaded.
>
>         Arnd

Best regards,

Tomer
