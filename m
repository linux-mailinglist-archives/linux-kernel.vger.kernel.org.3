Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA224B19A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbiBJXjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:39:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbiBJXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:39:01 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BCD5F6E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:39:01 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p19so20086774ybc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWem/pFj/duUmLXR87z8cwj1is547stEysJJncrBbyU=;
        b=nM5t4eZrZMgsT2rSz/IB1/EOFC/nvlZMyN2Xy5qFaJYNZTBobuDmDPcux2czjubZ4Z
         Ku1jaS1Hu5W7ArCQ+Rv/drYv+XCnkJHgF1qiKJu6ewwGWbBTCbmrYSWc1+u+HzNpjqEs
         lhxOOlxuIhfW671gHw1NSfLLl3tIIvP/UatwKYNmNw1VQIadGNUc122zLOoBbVk89fP1
         eEIBbGM8sg9eGGyBej2+RtrQB1KGUmV4AXBPcf2MCzrqu9varZHbAR5S8KzwWbbt+Pto
         RlY+DkMIsvoOWmBN4KnYKVOt19jbaAL+CvlYG1EYyn4xcC3bwNW44uNC+bZA0O3AApg8
         OZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWem/pFj/duUmLXR87z8cwj1is547stEysJJncrBbyU=;
        b=OXiinFddOVLaW4FAYjZ9dP4908TB8+881aPt7xwHnpo8nMpg5yZjtlWZ1g+zB+yeJz
         a0gzudsbURZ4h1MayuI2b53U4sQ3USuHD7bq32NDbtn1103s+Urgsxy+lkWyGeTd8hHx
         0RQb1mUmwmECzalTNvy5dLEyM7MNGuzbmVK2tAo9GkIEOu2JL0akhu0xQRLc9KHjhOzM
         3oZzR2pWR6jmmzfDmSf7ZUDNhwEi6uyT9tcPovdD7ma5hC12PXxXp1xfRSdYitr+9cQh
         JlBCNJMYRUsPcrV3AhuzpsL7UDAXA+D963y5CTmYY9gzClN77xLkU/n9IRmpOv45b8lo
         OASg==
X-Gm-Message-State: AOAM533PPgMiTqPlJOb8GGBNzSzqrNvbNmuJJRpgofPjLUDJXiiTWSpa
        iYGL6A2mhc1MvBmdaVQIJoXXZnJmsCTHySK8bFIiiQ==
X-Google-Smtp-Source: ABdhPJw/AGERv/Fuv3ciYuJgOH/qQi8Md7cZRastkPHUJ8bgZqlEllKxFpsPteU4o/HqNEvvCOtqGQ7w/rsnkAjSUUw=
X-Received: by 2002:a25:103:: with SMTP id 3mr9244416ybb.110.1644536340427;
 Thu, 10 Feb 2022 15:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <20220209162607.1118325-4-maz@kernel.org>
In-Reply-To: <20220209162607.1118325-4-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 00:38:49 +0100
Message-ID: <CACRpkdZkw1efC5viWwr_72V0K_E+txwxGLzwe=NJV3FEdnGinA@mail.gmail.com>
Subject: Re: [PATCH 03/10] irqchip/gic: Switch to dynamic chip name output
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 5:26 PM Marc Zyngier <maz@kernel.org> wrote:

> The last dynamic aspect of the GIC's irq_chip structure is the
> name that is associated to it.
>
> Move the output of that name to the relevant callback, which
> allows us to do a bit of cleanup and mark the structures const.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This naming was once introduced for the ARM PB11MPCore
that had two cascaded GICs (commit 58b8964990dc6)
so it became a pain to see which one
was being used in /proc/interrupts
arch/arm/boot/dts/arm-realview-pb11mp.dts

I see it is not appreciated to use /proc/interrupts for this
type of diagnostics. Ugh. I suppose people do it for the
same reason they keep using the GPIO sysfs, they like
it and they know it.

Yours,
Linus Walleij
