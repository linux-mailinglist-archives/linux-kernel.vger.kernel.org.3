Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B5589ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiHDPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiHDPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F201F252BF;
        Thu,  4 Aug 2022 08:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D3D761313;
        Thu,  4 Aug 2022 15:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD07C433D7;
        Thu,  4 Aug 2022 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659627733;
        bh=Qq7NlW7jpulKxTpi/vp74Z763atoHCYyI0gLVo/h6WY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c+mC/Ptmoqk64R5Onm2m28MP+eI0EVeW1BfEOk8Svmh8A9ywPO/rUtM1izNZnDu1i
         95dmQp5l2wX65dfoq6c+kTevxOqknkLbUsb+SbsUaaaRa9gw7Pn/P36+3iDFlCmpdk
         crAg6BWojkQu7YFqo1An79FtMjGLTU54lf+IC6bOcE0viT426MlP5kP6MdPBjekM3p
         dPkDxvp2kW6Uxw9OIkk6mm0TLbjUrfGZu7QzDStOOcbnIZsDXxc7sr5NrBqA7T5nJ0
         kIFZ9KprId96f64GYc+W4yw4EM6Nmlb7jQxeWlSZxlqfrgBAa9TZE2LxAULbiNgprH
         j8F2Pad7oIqYg==
Received: by mail-vk1-f180.google.com with SMTP id c22so7221889vko.7;
        Thu, 04 Aug 2022 08:42:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo0kB+MH2G+xK/QaToWWC2mokGHUy5QvKnyDtrg0KUe382wkUpr9
        PfNE9ky47BUUsES2xhb0HBm7GY1lVhwB06XQdg==
X-Google-Smtp-Source: AA6agR75oE+Wp/3SrMZokWfZBcG1lnqwFNBtXZ4BbBn6bhDGle+sjw5dsgaNvBf0d2CqY58Cs/qb1BDYtXNqctNdUIo=
X-Received: by 2002:a1f:2dc2:0:b0:377:84fa:dbe5 with SMTP id
 t185-20020a1f2dc2000000b0037784fadbe5mr1192421vkt.15.1659627732775; Thu, 04
 Aug 2022 08:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <YuJXMHoT4ijUxnRb@hovoldconsulting.com>
In-Reply-To: <YuJXMHoT4ijUxnRb@hovoldconsulting.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Aug 2022 09:42:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJdEFspgJkJnC4jmeq+qaQjkRQU2-WTRmYVOzWrnKifQ@mail.gmail.com>
Message-ID: <CAL_JsqJJdEFspgJkJnC4jmeq+qaQjkRQU2-WTRmYVOzWrnKifQ@mail.gmail.com>
Subject: Re: Second-source devices and interrupt-mapping race
To:     Johan Hovold <johan@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 3:30 AM Johan Hovold <johan@kernel.org> wrote:
>
> Hi Marc, Rob and Krzysztof,
>
> When adding support for the new Lenovo Thinkpad X13s laptop, we realised
> that it comes with two different touchpad controllers.
>
> To enable some early adopters to use the alternate touchpad, I tried to
> enable both nodes in the devicetree and have the i2c-hid driver bind to
> the one that is actually present.
>
> This turned out to be racy due to the hid driver in question enabling
> async probing so that the populated and non-populated nodes can be
> probed in parallel, which in turn lead to some interesting findings.
>
> Specifically, it seems like the interrupt-domain mapping code is racy in
> that it can return two different mappings for the same hwirq, and when
> the hid driver enables one of them, this may end up looking like
> spurious interrupts for the other mapping:
>
> [  +0.014042] i2c_hid_of 0-002c: i2c_device_probe
> [  +0.000001] i2c_hid_of 0-0015: i2c_device_probe
> [  +0.000025] i2c_hid_of 0-002c: i2c_device_probe - irq mapped (166)
> [  +0.000013] i2c_hid_of 0-0015: i2c_device_probe - irq mapped (167)
> [  +0.000051] i2c_hid_of 0-002c: supply vddl not found, using dummy regulator
> [  +0.000056] i2c_hid_of 0-0015: supply vddl not found, using dummy regulator
> [  +0.000016] i2c_hid_of 0-002c: HID probe called for i2c 0x2c
> [  +0.000374] i2c_hid_of 0-0015: HID probe called for i2c 0x15
> ...
> [  +0.000180] i2c_hid_of 0-002c: Requesting IRQ: 166
> [  +0.000045] irq 167, desc: (____ptrval____), depth: 1, count: 0, unhandled: 0
> [  +0.000014] ->handle_irq():  (____ptrval____), handle_bad_irq+0x0/0x220
> [  +0.000015] ->irq_data.chip(): (____ptrval____), msm_gpio_irq_chip+0x0/0x108
> [  +0.000011] ->action(): 0000000000000000
> [  +0.000006]    IRQ_NOPROBE set
>
> The interrupt is eventually disabled and the populated device fails to
> probe. Note that this only happens intermittently.
>
> This second-source example could obviously be dismissed as something
> which is simply not supported (the boot firmware should have made sure
> only the populated node was enabled), but what if there were actually
> two separate devices sharing an interrupt and that now end up with two
> different virq?
>
> Async probing has been around for a while now and needs to be supported,
> even if the platform bus doesn't use it (yet).
>
> TL;DR:
>
> 1. Marc, does the irq mapping code need to be serialised to handle the
> valid case of two devices sharing an interrupt being probed in parallel?
> It may not be a common setup, but correctness first?
>
> I've just posted a patch that should address this here:
>
>         https://lore.kernel.org/r/20220728092710.21190-1-johan+linaro@kernel.org
>
>
> 2. Rob, Krzysztof, I assume that handling second-source devices by
> enabling multiple variants in the devicetree can not be considered
> correct?

Probably not, but there's not really any defined policy there. What
that looks like in DT depends on the component. Displays are a common
one and don't lend well to populating multiple in the DT. For those,
the only solution so far is we require the 2nd source to be compatible
with the default/1st. I think that was QCom chromebooks...

The easy answer is firmware should deal with figuring out what's
actually there and update the DT accordingly.

> What about the related case of simply non-populated devices (e.g. laptop
> variants without a touchscreen)?

Shouldn't that just be a case of the driver not screaming if there's no device?

> Note that we have at least two cases of "second-source" nodes in mainline
> ("rtc" and "trackpad", respectively):
>
>         85a9efcd4e29 ("ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay")
>         689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
>
> and that, for example, the i2c-hid driver explicitly supports
> non-populated devices:
>
>         b3a81b6c4fc6 ("HID: i2c-hid: check if device is there before really probing")
>
> and the commit message indicates that this is something that Chromebooks
> rely on.
>
> For the X13s, I'm not sure how we would go about to tell the variants
> apart (the ACPI tables that Windows use include both touchpads and an
> optional touchscreen). In the end, the boot firmware might need to
> resort to a similar kind of probing if we don't allow the kernel to do
> it.
>
> Finally, note that while disabling async probing for "second-source"
> nodes (e.g. if we could mark them as requiring that) would take care of
> the irq-mapping race, we'd still currently also need to move any
> pinconfig handles to the parent bus node (as is also done in one of the
> in-tree examples above) to suppress the corresponding pinctrl errors in
> case the populated device is probed and bound first:
>
> [  +0.010217] sc8280xp-tlmm f100000.pinctrl: pin GPIO_182 already requested by 0-0015; cannot claim for 0-002c

If the config is the same for both we could suppress that warning. If
not the same, seems a bit dangerous to configure the wrong config...

Rob
