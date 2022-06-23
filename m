Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F30557DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiFWOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiFWOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:36:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C042ECD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:36:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pk21so18389654ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qp/cRCbGIgaCK9Ty5kMpVAtTHuKK7E2w/DMIg7EAxo8=;
        b=FO8cBP0K4xsPceTBKKHnUGgnYHY1Skq6ChggmGpBCgZGpla/bByE6oUaAlWXyWU0vF
         PLhf3kmatH5of8GlqKiHPsRCyA5+r7g41edN+j8JCyhoVtTvCLU8KnaJSihfW9NPUtiE
         nmoc/SF+baFHe+LoOgYH0o6VZ1Lz3ZwDdgerB0kAiYWTGdZARohhrhB5wpCbDTC/OnW5
         Db+cMHuhKmYI8yDaUhdbaOSBdGyYNHD7+pbSEks0YpCyXh7IS1Yczau7NBKgqZU6lJvu
         tF2SxqKZmSGq3uSzUjsN364b9VQui0bWtNcoey7TDDTr8EcUiQThWwTnhH/4221dF58O
         TVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qp/cRCbGIgaCK9Ty5kMpVAtTHuKK7E2w/DMIg7EAxo8=;
        b=2qUiJt/IegcEgV9j/4djdArKyA8SMeo96RwRILredsiLBTPodl9UK3afcVtS96yzbv
         2isxTM6vfzLx4Bn0OyR713ob9zTYrngFnDp/wwIW9DLTxajE6gguMCNThy7GI9mfouzC
         QBZgEj5YCJyzXN2guDJ7zZwnxHksG0PyFLrNJlFjY6FduhCpklnwv9FvR4C8U2+rI1zS
         ioevm9xRDmlLHCacC0jg+zAQeGhfrljVLCJhbUBTVsBsVcwOgm8PeSBQo56RSVCywIqa
         wDIgT7GHxu/hyYTmwd8KgJLQCzcsMSwqS1ZUFdcWSts+KNurtx86H4Cswp1aGieN2Nqb
         7a0Q==
X-Gm-Message-State: AJIora9I2MaAIPxewmu/Haj2mB0yLxhC5dQSyih/JCPUj4fNmVuoaB9p
        vXfjCiiKUAWzsBOygUCiy7tJeCXEs5sSgs5PCODoxA==
X-Google-Smtp-Source: AGRyM1s564s3fiLiyBxM2nC5JNnQByLI+ku9H6xw8kOmrjGeURS4OVf9zehn05tp04En+oZZWCKo/XjwQ4Fy2TyI2f8=
X-Received: by 2002:a17:907:60cc:b0:722:e564:eb11 with SMTP id
 hv12-20020a17090760cc00b00722e564eb11mr8899574ejc.736.1655995009719; Thu, 23
 Jun 2022 07:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220622172842.86713-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220622172842.86713-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jun 2022 16:36:39 +0200
Message-ID: <CAMRc=Mfqo19we+0ShbpCtbbsXgU6trKbwQR2Zg7LcAWSJ_834A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: devres: Get rid of unused devm_gpio_free()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>
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

On Wed, Jun 22, 2022 at 7:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The last user, which in fact was a dead code, has gone a year ago,
> previous one 3 years ago. On top of that we want to drop away the
> legacy GPIO APIs in the kernel, so take a chance to get rid of
> unused devm_gpio_free() and accompanying stuff.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Always a pleasure to remove code. :) Applied, thanks!

Bart
