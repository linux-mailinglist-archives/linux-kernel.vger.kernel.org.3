Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2594DA203
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350964AbiCOSIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350921AbiCOSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:07:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433AE205E8;
        Tue, 15 Mar 2022 11:06:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qt6so43207555ejb.11;
        Tue, 15 Mar 2022 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DqLwMrvPQ/wnh2ehxH+QJFHD8HRJuELJ1v5J97L+RI=;
        b=c1DKnKuJRok3+TPiYMHhnHctTrPVhk4hRHKg9fYgE43zfIxHiiHdmE5Tvih62JVfTA
         4lTfZVTLJRxRt+8x5qFfazVhO7/GeO3ZR/NgHr76ErZPOnkhkZGJpkvdXmZE+pAahsTz
         tcjijr+Dqf9gRZ3CNdMOt1+ap4Er6AYdrAcw+PYbI4HzIQn8pSit9pANGkrBCt3qUFSI
         CpelUPNt5WONnKSEG8I9TEyKIm8TzrAEQGGHJ3tZISMDQw4fcNSCYXmUew0FSZqEeSHG
         S29AoBzAnci8dagTMjTxjRd70crFC0K6f5Z0DMKWeAx0iKXwmfC9wwBYS86i4xiKwNnv
         z2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DqLwMrvPQ/wnh2ehxH+QJFHD8HRJuELJ1v5J97L+RI=;
        b=cD/+E32xUjs3aeR9KIf4RMZKZir6PFRVroiC/TpR5NPTknI6l7h1aNc5poTfrZ7VUY
         5f+CO2Anv3QmtiPXRfFbznvahPsD4eMIPZYYCUDafekkj0xKCAJ0UmhuIzOk+AElOgmS
         r7CUFQkRxO21s9IxB0gzl8gHyeoSLE8RuDBCi0QdHcpH7DpJmxVrnTT7WgzQxkiQcB4R
         /eBuaK6AixJh5GlePKDyW3NrM7BmKzZIGZLepX6nxIa2SOsulPqYsfshxynTJ2kk+NgA
         JBDczrot6QO+vuLNasjkPkG0J8fouzX0rrvpV3XLTm5hW0rvQu0kIxiqsNkWT4uShQsh
         O6uA==
X-Gm-Message-State: AOAM530dkfL1axFVdaRyXsJTr1rrbNEkmPuWRZ5Yp8GRbeB14WTWnK/x
        6DaYed5s+L8rNfx9OOumuhKyrgv+l/2ilbYcM84=
X-Google-Smtp-Source: ABdhPJwdQyXN5k2p78XgzGhp4lriRWEnCPovSyfSbyKNLg2s0EOTUDHWB76HTxhyGbDhAh8OjpKMp9TV21lBoCAtyYI=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr24504743ejc.132.1647367593775; Tue, 15
 Mar 2022 11:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220315103813.84407-1-shreeya.patel@collabora.com> <202203160100.PENzQsMs-lkp@intel.com>
In-Reply-To: <202203160100.PENzQsMs-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Mar 2022 20:05:20 +0200
Message-ID: <CAHp75Vcsxn+8H-tpkN_ipjW4XGsfnhd7NA5Rz+cvGt7T4C9xfQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Restrict usage of gc irq members before initialization
To:     kernel test robot <lkp@intel.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, krisman@collabora.com,
        kbuild-all@lists.01.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
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

On Tue, Mar 15, 2022 at 7:38 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Shreeya,
>
> Thank you for the patch! Yet something to improve:


> All errors (new ones prefixed by >>):
>
>    drivers/gpio/gpiolib.c: In function 'gpiod_to_irq':
> >> drivers/gpio/gpiolib.c:3068:29: error: 'struct gpio_chip' has no member named 'irq'
>     3068 |         if (gc->to_irq && gc->irq.gc_irq_initialized) {
>          |                             ^~

Exactly, because this check should go under ifdeffery.

-- 
With Best Regards,
Andy Shevchenko
