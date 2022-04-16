Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC77050353E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiDPIk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDPIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:40:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5592090CCC;
        Sat, 16 Apr 2022 01:38:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u18so12301022eda.3;
        Sat, 16 Apr 2022 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1J3BIIZR6KeiQOhB2J1CTx8VgkOpEsswq3W09NSWH8=;
        b=HB5itmbak+pVvvZ4x6vjn+fdml+2lGAieLL25o47IzXAVgU+K/xkLTurgzalYWKktq
         koHqKYgnEnvjEKhtM0+7OsU0cg3saJPuE7xT8LaIILw/VWeOc7nWUm0UwlkSuG16glW1
         jAGp5lYVySBpRD4y3Wk6BXMKWPFJAxQ4Pzq/iRV1DH1NHesd7Mc1AhFysTOtQt2grBxW
         xT2DY203qwJF3Fn1nS9xrAa8eMC1bq2eJa/PZ8uSW+mezwBL96lmkYdcRjdKUBfZBmBl
         xRQvyiE+3gwuAAn0N0brGbWglEfAE+N2pjxbfu7T7dSPQrI8V8d/q7wbKUEob9beYUSy
         pOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1J3BIIZR6KeiQOhB2J1CTx8VgkOpEsswq3W09NSWH8=;
        b=BgB26M3NF/YgRxlEKRBlUSFVmJXT7lezRSHkJH9ydtEj5exRCvoOt2GiJtT82r+fF3
         gqu6dv5PIWpuX7T+vbws/mYvqG5d2SoQPOomiwlET8UJEi4DSJBAAxJBAlynntnhZGy9
         sZw3GyLFzUYhHBqS3gcbHeGQut7b8qaOON4xbw7HFVbXnM/XZpgn9VtoZL5elEQMzpuc
         DAoUm8VRpEJ7jESUOP6mMYbQQE2rKd8zM+9TamZjA866wnwqqLDLqmfXOyIG7TpQp3rJ
         k83Z/A0r3ufMHy7LKsnbTp59AMwmf+2/aQNA9WIHUhLFM+yaip/HsR/7/p+1NSO4y2XH
         f9qA==
X-Gm-Message-State: AOAM531yPQIaGw4mbP9U5RUffpbDiO0oNLNup9EJO7vwcAXVUTFzH46L
        QOBlORBdn5KlaXVm7DNBzOQ5R3p21UZiJ5KVzoc=
X-Google-Smtp-Source: ABdhPJykggy9VhjNsTpBwcYb4YKYCF+BxZO3hY1bLUz/y48a0JaFAwpe7AUPGt39irfrfzzHJw8DIQlVQkBxpLtltUs=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr2961701edm.122.1650098302900; Sat, 16
 Apr 2022 01:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com> <20220415130005.85879-4-andrea.merello@gmail.com>
In-Reply-To: <20220415130005.85879-4-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Apr 2022 11:37:47 +0300
Message-ID: <CAHp75VdmN41k7AwcmutR5NBMrJymOGief3Q8GqnRECJ3jQ8b7w@mail.gmail.com>
Subject: Re: [v4 03/14] iio: event_monitor: add linear acceleration modifiers
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

On Fri, Apr 15, 2022 at 4:00 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>

Missed commit message.

> Signed-off-by: Andrea Merello <andrea.merello@iit.it>

-- 
With Best Regards,
Andy Shevchenko
