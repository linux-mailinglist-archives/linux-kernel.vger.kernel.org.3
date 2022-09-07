Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BC5B0F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIGVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:40:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FD34DB15
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:40:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b16so21586989edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1+r8REDwT5jqFd4iekhBAgCjdytGvxfkT9M2TlUtQ+A=;
        b=ujoEz4yNgaFAhWrRlSXxOyeGpVOqcTbZgMZwD+jtFOqqw5Fao+ro063VkjwbftTqT3
         9Sy2KBjAeZi2qFdbnkN18VfCp/2V9Ne65wWRKxH6Z09J5xHTnvCGZ6SS7g2oz7ztrFyr
         Bf42AC/xv6Put2LF+7DsM1Y8X3+6sAFUEPcx3q/gTp3iynfYiU9FAEEhHMm/PwPBzYqw
         PXpc2LlACiOKzrlZ3AXGQzdxYgsU6d/hfWYH5KLa+pyT0kDbbocw3xNJa47hxlF2zR4Y
         rOFhcRxNcJqrbQ1m2JsJhUTpEiS6cQCutOdS9BLF+K+Cc1OJmrFo94kp479nl7w4zsjO
         gbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1+r8REDwT5jqFd4iekhBAgCjdytGvxfkT9M2TlUtQ+A=;
        b=furk99lW5/qaya6rUfmf14AZBAWCdogDDgJQ+5BO0BwDyo0JvE98wxWwzFZ2aMcLoG
         K78i88JNl2IE/5vjZQTqDiqeB6+KH34kdaPAHjWYEnceNg9RXG34CD3YoHN59KeK5HkI
         0ZHsdkYnqa7943UQ1ba4LfQs4bIrQ4nwk8a0L6KkfbyGuBFtlZy8Rp0gGx9s9mEvKi+p
         88U9+lADij5K+ctuIbucz/p2cHR/boFS9OHxhHmGYE/nEoQnEmKx9swIhe51bTnGK/Hr
         xyOJZDuoUwjJSjZK1TI24mLkUIvEj1hyoP1WAxSoXX3RQG8Ebm3NO+vWjdY3n/3OTgIq
         hylg==
X-Gm-Message-State: ACgBeo2qBXnqbGW4fdC26DQxxLvVLB+pH7l+gOzVzmNyFDLuXc5oXOw9
        5oOx2qjEmY5xHz0LcY6QaWrXaq6BEKm7tIeUD9E4TQ==
X-Google-Smtp-Source: AA6agR4pPLHI4u/P2bVSh3w1nV9QSAR6LaOEe4rOr9uUfp9Os4MAgzxwpuyxTRv5tZLVk2H4EPNl4LIrRT/3KJl1nmE=
X-Received: by 2002:a05:6402:2691:b0:43d:ba10:854b with SMTP id
 w17-20020a056402269100b0043dba10854bmr4515673edd.158.1662586853740; Wed, 07
 Sep 2022 14:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204603.3762756-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20220906204603.3762756-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Sep 2022 23:40:42 +0200
Message-ID: <CACRpkdZNhqbWkr=xxyW=-aa5d40tosdPLvuav5R_xp2sDatuhA@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: s5k5baf: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 6, 2022 at 10:46 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
