Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D34C1A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbiBWRsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiBWRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:48:50 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621D62E0;
        Wed, 23 Feb 2022 09:48:17 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d19so14836621ioc.8;
        Wed, 23 Feb 2022 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKBwjSNATVWVksf5vYyDJmSVutEByHwPHr5mJXUV4XA=;
        b=Hf1IP9xlPWhpt+MsH2DW/FYNl57mtNMp6NLqN8tLaq03hnPZ79MdCSnAXOgP33K/H4
         EbG1SsJShFgfb0Zp5EV6O9IcT6QrW8oQWxgaz5gVUuV30p4r3VieD72Lr3mGJBCsM7Hf
         swUwth93FbrW7ehcrWbcx5oxRIJiOLg3XH4+Fx6hpzSUTp6mT1Dz5StJgS0YDwUCZZxD
         WeXHlZx8h2w9iBj3b/A6fbwo+s3i629qQrEbM9SOrPM02MQvr+K067mNYX3GAACaLauQ
         4l8hCoDDarJ6y/Zm9r77Nxr1F5b5XrxU0tBs1Tyvx7YUs2Tf3EAlIXifTJwXCujNVP9X
         JiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKBwjSNATVWVksf5vYyDJmSVutEByHwPHr5mJXUV4XA=;
        b=OuWrMbe6owVbeQZ+HepvJy48QvGFRrYh6ibU6HztpWY2lpqpBqHJUH6/XKH6yElPjT
         S018Pj1VoH9HzVj9xADU525yz/hiMndBWQ6RdoWQFZJWgWM5E/UMVl/P1BKstxwsKeqM
         XQHggQCOBfTce9+ILmeOCoRO5fp2eXn0kMvEnMiw0IsH6RV1DVBD7HXMufSgVXxUdh7J
         AbowaBNC8WdAwBLxTidlJ5x2NegMKLds2us63AaBiR2CVJn3gdFTGatWyc0v77czwN1R
         H2HnR9JNUM5oS4fck8uH7WXMdel84C0BO7W9W40fvwwIsarGyzJUGqlMyNOwjYrhXH+I
         Slrw==
X-Gm-Message-State: AOAM532bQh3A6D/eqjySGTh0OOk3ElTd3p9BvoBXVrYpYf/oAtCi3GhO
        hus4coozEYyJ3DXdtVAaGdWPbU6K/a07qfCL/WM=
X-Google-Smtp-Source: ABdhPJw1QGF4dIOqwEyMjlrNSfRM/nBD5W5mlC/KkVQ4i73WQviit1rKbjjwGfVZKdBSx8DoP1ZUyosB8+1+D85BmrI=
X-Received: by 2002:a5d:970d:0:b0:5f2:9242:d881 with SMTP id
 h13-20020a5d970d000000b005f29242d881mr401153iol.187.1645638497000; Wed, 23
 Feb 2022 09:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20220223154405.54912-1-maz@kernel.org> <20220223154405.54912-2-maz@kernel.org>
In-Reply-To: <20220223154405.54912-2-maz@kernel.org>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Wed, 23 Feb 2022 10:48:06 -0700
Message-ID: <CAOCk7NpJ5ui+uTKvKeShKmzeKpZkwqCDtyAd_bt2PJKGhE=Gww@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpio: Don't fiddle with irqchips marked as immutable
To:     Marc Zyngier <maz@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gpio <linux-gpio@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:40 AM Marc Zyngier <maz@kernel.org> wrote:
>
> In order to move away from gpiolib messing with the internals of
> unsuspecting irqchips, add a flag by which irqchips advertise
> that they are not to be messed with, and do solemnly swear that
> they correctly call into the gpiolib helpers wueh required.

"wueh"?  Should that be "when"?
