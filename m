Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38385733A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGMJ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiGMJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:59:49 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124265D51;
        Wed, 13 Jul 2022 02:59:47 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p129so18415551yba.7;
        Wed, 13 Jul 2022 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3V7JNBzAmCFMy3KxZokjQA49UEMuoZy2lqB3+H595sU=;
        b=VZ4UJtzK8yDW1jD4r6pXDGeurS3US2G79ZHGbw++f7O8EcsTWHlHnWZ3YdgXIrm+TB
         h3ehiMpWVlBbisUH55ntPt3Fwulgmn8JeLuLarVKHc1NbCyUrp2NxXAKWCRDRtsS8486
         ROx3NR/YyUeny7fkiPCmMgTsYvP7+YItl2cFmbJY5DHNrtdODQf0rWMcDcqQXGV7W+g3
         2DrFgGZjAsqiE/E7Nu8jBcidl9+6Nqen0Pvui+LSoLfer4pV0sY7qBq/KbwSEOiU+P6B
         9dke3usKPuSmxFp2suGzxV4T+lG3Zn1ATGKE3Hw41OLfKH/9cd2K8NJ4+n9zMIhHZ/oz
         CZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3V7JNBzAmCFMy3KxZokjQA49UEMuoZy2lqB3+H595sU=;
        b=bKpc73mF46vOMBH91b2JpDcivVIDn375cyTpnjjuuAozm1+OwURkwrVufVrqCFHK93
         2duxSEuPrMGbnKjfvg+IKnqt/JvKVxWu2MF4M0/RgAEs+wCRjLfG3CR13qKlkmtBx1DY
         SeNtd/wyYy3A86MgNvRsoVATzkgYolYHMCn+NHWUzgiZFjF3lkIn/kck2m53o9o5dgdp
         /dE73Qz7V7La4w/SIjCLBDHqf6TA1Q0eBhdbcJ0C03wwG5Gouv8m3/rgvOQelZeQM0Sk
         dSgb6KmznQ1WdKbYJ8Eoktb5MbTta0eWrqGoOCqIkdfxRHicoXsQeaPQYdWVxOvQqyCr
         mp2g==
X-Gm-Message-State: AJIora9hiFl3mjn9WB+FcJ/TpqG61vE68f+jciWIOPKKA81kh9DF5a5s
        wav/IY+20Wlhqg1Ydz9GdFQoTxepPkWMTK5mYSQ=
X-Google-Smtp-Source: AGRyM1sikGdrKDgS1wWPc2PwWg67hih6R2IQ9l/6VFeL3SbKFA6k29BWl/ZIaykidyteAhSp2mqDvRth5yWYVnALiIc=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr2556805ybt.385.1657706387134; Wed, 13
 Jul 2022 02:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220713013721.68879-1-warthog618@gmail.com> <20220713013721.68879-5-warthog618@gmail.com>
In-Reply-To: <20220713013721.68879-5-warthog618@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 11:59:10 +0200
Message-ID: <CAHp75VeRshC3Db8Q2J80fk7=UvLiRymrkoAbuWceOfncfzvr7A@mail.gmail.com>
Subject: Re: [PATCH 4/6] gpiolib: cdev: simplify line event identification
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
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

On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Reorganise line event identification code to reduce code duplication,
> and replace if-else initializers with the ternary equivalent to
> improve readability.

...

> +               le.id = level ? GPIO_V2_LINE_EVENT_RISING_EDGE :
> +                               GPIO_V2_LINE_EVENT_FALLING_EDGE;

It seems several times you are doing the same, perhaps a helper?

-- 
With Best Regards,
Andy Shevchenko
