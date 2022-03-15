Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B454DA28F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiCOSoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351122AbiCOSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:44:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF85F04;
        Tue, 15 Mar 2022 11:42:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 3439F1F4303B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647369771;
        bh=OqBz4qNcyZ8R5pFma1baORhNdguifW2BoSXyepNU+m4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SKhbQisBAbD2ljdjGfwkMMG1lX3B5SLyBKin3hdMyXoPGgvGQ3dR75hz2J2fWgM4F
         mNRog7HcWuwr4xXOmp+cdZngXqx0gg8X/vBl3J7B9FlUcNRewT1IZs5VDggdrvG+Fr
         ja7vtn8dFRgRkCtoscrtNiCkV/wz/ayg5RkNj2fNgS8cwUZeqr2CbjmetK6U/HSG+0
         kCO1/MtrF52P5Jp5CafUZ3E7QyMANcYsEVBENHTSVoIJaiuc3KlU3M6e2fuMYxLcCY
         C2MlFgGbqfuboxPD3VcD9EkAJgMVJeIXu56gb81DuAVy5QUmVUrUUamaQrhfNhcG5n
         laG4KdHzLDaHg==
Subject: Re: [PATCH v2] gpio: Restrict usage of gc irq members before
 initialization
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, krisman@collabora.com,
        kbuild-all@lists.01.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20220315103813.84407-1-shreeya.patel@collabora.com>
 <202203160100.PENzQsMs-lkp@intel.com>
 <CAHp75Vcsxn+8H-tpkN_ipjW4XGsfnhd7NA5Rz+cvGt7T4C9xfQ@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <0a011be5-6f08-a9dc-3e62-f9296c7b9d2e@collabora.com>
Date:   Wed, 16 Mar 2022 00:12:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcsxn+8H-tpkN_ipjW4XGsfnhd7NA5Rz+cvGt7T4C9xfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/03/22 11:35 pm, Andy Shevchenko wrote:
> On Tue, Mar 15, 2022 at 7:38 PM kernel test robot <lkp@intel.com> wrote:
>> Hi Shreeya,
>>
>> Thank you for the patch! Yet something to improve:
>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/gpio/gpiolib.c: In function 'gpiod_to_irq':
>>>> drivers/gpio/gpiolib.c:3068:29: error: 'struct gpio_chip' has no member named 'irq'
>>      3068 |         if (gc->to_irq && gc->irq.gc_irq_initialized) {
>>           |                             ^~
> Exactly, because this check should go under ifdeffery.


Makes sense to me now. gc->irq.initialized must be checked inside
gpiochip_to_irq() wrapped around an ifdef CONFIG_GPIOLIB_IRQCHIP

Thanks Andy, I'll send a v3 with this change.


Shreeya Patel

