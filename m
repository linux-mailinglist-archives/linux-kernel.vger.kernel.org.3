Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08E51BFAC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377577AbiEEMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358748AbiEEMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:45:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B055364
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:42:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a21so5071622edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nToHf9Yxrt+r3K1vMdQKligyD+NhWuMXaR0L1laGIcQ=;
        b=MIGeaU48Hxcr0gAk/0JUERKudMJ+2VgGvtXQOyQR2FUEQeC8eFnEf5W06jJVA9iQfU
         +IG5oyZaIHvk1wNlDTpmYhOH8uLeDZPV4etYWxHGMqd7p28h9+iY0E03t+Z58hHrTiHZ
         Gqvid7MFQkRM2KTWd8vs1lxMo6aVE3S83f3+qzfkkL2LzrOwKU/YoJgs49dHnyOt6n2j
         piYz00xlNGfUgi78mOiyQ31sAwWJuqxkjm+KxvB42oQSXZPiFZfrtXhS68YI2hANPBQ9
         cMhT6NwUeHuY62ICFtRx9YBHEpchMriV7lpMAkoiUuZrCsFFtmbFFfH9rVp5pH5VwyeZ
         wWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nToHf9Yxrt+r3K1vMdQKligyD+NhWuMXaR0L1laGIcQ=;
        b=1uoXaOJnlIQTquvvDXdg2g423UExtzyABvNIKAWjzhvJ2pRGJXz5xSIx5L/3HGn0hk
         g9ICnjNvi/e6prvPa81q4OFkiQc3q6Ink44UicCPCpYnPUdfJMoU8QOhEyktG0x7lnO+
         EH6wep/72N3qfS5OpOKQRbGPFt3swo1e0mo9uYqbLL+ZrkcZMg/x35i/COOqNUAjoWRC
         stAgO/clcIXslBo6Eld1oCm3UpursLF0T0WehpBBQ0/AwQSso7zbH9As/uzT1BO1b2wR
         NeI9ZehnGCxCP16HHulWRU6xuykdx1Lp9eXWLeLwbMAzu8UZDPXJzuj/Bgs5+T2E4sit
         txLQ==
X-Gm-Message-State: AOAM5332QN9jyamKxZJp/atbEHN3Z1R6qwjNj2moQ8TlyoqiCuq/iwUE
        7vdyrmFI+jOEv6AuvBFhRwvebb86MZiaQTdE35/saA==
X-Google-Smtp-Source: ABdhPJy+UBUQ27FMN0Soniwr9i5FVjEAqUBJaKMZp7kF/Zi2oKeANJCiph04E/neh8RBlyNRknfzqdKMu9O4zIR2y1s=
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id
 ec12-20020a0564020d4c00b00410a415fd95mr29329998edb.288.1651754537667; Thu, 05
 May 2022 05:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220504144406.36744-1-jonathanh@nvidia.com>
In-Reply-To: <20220504144406.36744-1-jonathanh@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 May 2022 14:42:07 +0200
Message-ID: <CAMRc=MeXUN6P8kWxB75GsXdKD7Owz9mX5HpgfQoMGeJh-z3=Rw@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: max77620: Make the irqchip immutable
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 4:44 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> immutable") added a warning to indicate if the gpiolib is altering the
> internals of irqchips. Following this change the following warning is
> now observed for the max77620 gpio driver ...
>
>  WARNING KERN gpio gpiochip0: (max77620-gpio): not an immutable chip,
>         please consider fixing it!
>
> Fix the above warning by making the max77620 gpio driver immutable.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Queued for fixes, thanks!

Bart
