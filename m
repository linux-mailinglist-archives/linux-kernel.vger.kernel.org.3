Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE1507C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357708AbiDSWFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiDSWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:05:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CFC40E71
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:02:28 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ebf3746f87so187820187b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnSoh+ZD8DR5nKk6CV9UyrxaQEV9KgNslgMO1bDltQg=;
        b=Yqp9wQBCWbWPglTxek38iaFNVPN4Zk+RjRomb858O7NzPfSZ+56DcTmtbbra8cwo8A
         51LXzN/RhH4+O0qrKK90KipDzYk0rjXH0fWgauClW+t4NGUHEgy+QmXTqGliJ7ZrFAMo
         fyyaKKW3Nkt+GpV/6fmKo89PXd1xCQz8RXD9uQJtIgvvcwQDmo9JieU4vft39lVG7Akt
         EBG1oVJHmTxwINgk2kTxL9uYGLrCfT5FGn6QKAHpfvtDhDtE/kNyEKA6I/ESzJq6rvT7
         3qCxECIIz8g/Hpac47uzFVgZwz15uhtU4EDCj69W7Jd/qxQac3Irst/sGaDuFPswElMM
         FSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnSoh+ZD8DR5nKk6CV9UyrxaQEV9KgNslgMO1bDltQg=;
        b=BN7Y95NT4k+FZ9mAg1ze5qr6UWiiRpgXIgvrYkMqfQKM/3qkn/edbH6cj5GaJah+Ke
         iylv63nGoG4f4383rIDQoNqeVPxQizX8zXZEGEB0a4L5trQ8OzCQTCSy2CxaNwRHIh5k
         kg7NvJcKHFjxLpp1SQiv4aN/+XzyjUVVFWtK22FCJyw0L/qkRy18d0zpe0Auql/YQDUN
         amCWjvn6V3KA30iCvrvX/n6jWaNpUnk5pUWdv8wnrnPFOqz9Evr8J32phdb20pnitbON
         sUjKtMpgkMQkBL2YdgKBA1JInSn8kZnCk51GY/XCE1Rx2Qhi1nUZlOsFpiPEK+WwYwc+
         G0tQ==
X-Gm-Message-State: AOAM532yzj8GAHgt9YfI03+wtVHVyM2eVMoYwQSVtzaj54sww6F+CXVQ
        xWwgLr5LcvGd4K17fhBSYYBKQdG78lziGNGbZya6iQ==
X-Google-Smtp-Source: ABdhPJykrSD9spRkBNNbl3jZqUx8W2pxKdem4xATAM88TeGKzKQGRYCeHgf3K2yq3M35hvoxd/8Cjlx/QFKC/zbTbBk=
X-Received: by 2002:a81:5dc5:0:b0:2eb:3feb:686c with SMTP id
 r188-20020a815dc5000000b002eb3feb686cmr18267528ywb.268.1650405747502; Tue, 19
 Apr 2022 15:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220414025705.598-1-mario.limonciello@amd.com>
 <20966c6b-9045-9f8b-ba35-bf44091ce380@gmail.com> <67df4178-5943-69d8-0d61-f533671a1248@amd.com>
In-Reply-To: <67df4178-5943-69d8-0d61-f533671a1248@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:02:16 +0200
Message-ID: <CACRpkdbvN0ZJnn+N=Vt2n_aO4CnM=E4qpe_3dmu-c8_Ufp8ZzQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Request interrupts after IRQ is initialized
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     firew4lker <firew4lker@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Natikar@amd.com, Richard.Gong@amd.com,
        stable@vger.kernel.org
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

On Mon, Apr 18, 2022 at 6:34 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> Linus Walleij,
>
> As this is backported to 5.15.y, 5.16.y, 5.17.y and those all had point
> releases a bunch of people are hitting it now.  If you choose to adopt
> this patch instead of revert the broken one, you can add to the commit
> message too:
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1976

I am on parental leave kind of, but Bartosz knows what to do,
in this case, since it is ACPI-related, Andy knows best what
to do, and I see he also replied.

Yours,
Linus Walleij
