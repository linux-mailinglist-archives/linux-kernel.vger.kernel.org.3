Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B0C5545F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356020AbiFVIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiFVIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:44:15 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5738D87
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:44:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p69so17286099ybc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp81BI1YGsRbTuF4u1pZcpKCs6UI8Y55+4798O1CWVk=;
        b=T+Y6FO8pX4ioyAi81ZJh+H3jqqKbrzeylZwpyEPnZQ2fKXlT+k8zNUyacEsjt5Isvj
         9cQPAjzfg9a1d+IzZv5DgMGCjW1C2owU1i5Z2wFf0ZushObCV4Fgi/MJaklP1XMjKhz7
         XNB0oEghcMbSalXUZ7bJWHduPIDUXmXgr8otxxk5vlGkL88lww2X366J7JHxVXB+fOlL
         VHnTuHLGCpLb/S2eDPJCKCgHjFPBZZ4yI8h40AIngWqoipfSxqA5d/LTpOd8fL1aqhM8
         397Z4g9oWPb9NicHsMVy99lSPW7lwd4qailMrmu1dsK8Y71wF0alGOcCVYQKc2oM55P4
         zGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp81BI1YGsRbTuF4u1pZcpKCs6UI8Y55+4798O1CWVk=;
        b=BFDYYhqBG4DuHSFSwwBfUKvnoHgV4yeP5/4WplyRo0Qdu88TUdm0X0j8NEl9H774Th
         EKwIMhAgnGMbLOwl8YvTmv5eqCxWdRTqlk9Bh2wOhX4ZKUJeSmUn3ituSSzrDOSoY30s
         V/6XKTlJrZ8+sZSdxEqnWLaHsCpMUJ0n7NDjS11k4L46cT4mnBCpT0ot2BG5J05jlJf2
         ebGLnzVTGdzmgYWM/sDGANjgnsya/Rt4OIF6aMpIBOwO5le7U+PnaIjUXeE3J7+xzRjV
         Bu3qmmf+++6jycf0C4Loyaj6bUln0PWpmXjNUkux9jrGcRrpie0auFR+el241d+VSmIj
         +qBg==
X-Gm-Message-State: AJIora9/e8IcJ14xtbA1yedINZ1zjOa53OewKjEmT4RMK0t18Sbfkm9k
        qyxCk6hrrJUvHfBHRbn8kyxTpYmj4HByxg1yURErTg==
X-Google-Smtp-Source: AGRyM1skbX81eTWmx6oS9meEepf1lQ4R1N0UrNlFhHcSYFyL8Map6cXN+y6MD6tuATRRVquGHtXlFiJYYBINvtWwFds=
X-Received: by 2002:a25:7255:0:b0:668:a372:b433 with SMTP id
 n82-20020a257255000000b00668a372b433mr2433058ybc.626.1655887452923; Wed, 22
 Jun 2022 01:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com> <20220622074756.GA1647@pengutronix.de>
In-Reply-To: <20220622074756.GA1647@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Jun 2022 10:44:01 +0200
Message-ID: <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 9:48 AM Sascha Hauer <sha@pengutronix.de> wrote:

> This patch has the effect that console UART devices which have "dmas"
> properties specified in the device tree get deferred for 10 to 20
> seconds. This happens on i.MX and likely on other SoCs as well. On i.MX
> the dma channel is only requested at UART startup time and not at probe
> time. dma is not used for the console. Nevertheless with this driver probe
> defers until the dma engine driver is available.
>
> It shouldn't go in as-is.

This affects all machines with the PL011 UART and DMAs specified as
well.

It would be best if the console subsystem could be treated special and
not require DMA devlink to be satisfied before probing.

It seems devlink is not quite aware of the concept of resources that are
necessary to probe vs resources that are nice to have and might be
added after probe. We need a strong devlink for the first category
and maybe a weak devlink for the latter category.

I don't know if this is a generic hardware property for all operating
systems so it could be a DT property such as dma-weak-dependency?
Or maybe compromize and add a linux,dma-weak-dependency;
property?

Yours,
Linus Walleij
