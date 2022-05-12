Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E4524C52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353521AbiELMDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353525AbiELMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:03:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D265B24641F;
        Thu, 12 May 2022 05:03:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dk23so9754104ejb.8;
        Thu, 12 May 2022 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8DztgiE9mGfQ9+syuvCxSlmidaYWBeDuE+eqHZI9lA=;
        b=HNZvzGlvSX2igikUFuv/1QDtRHTZ57NYU+kNwE/eD+XkmJSeji+sxMOp69qq0s884y
         EZfx0+oC6/iAVlvONYXChFp6C74oF9WPt5zoYq/c/8qQfAGn9+0tcO+8BbRXxLQkexO2
         B4bgiXafIWkstwOXpEStjspqCxOBbLGVrhL1yPn2MSvSxQ/TobXbxgKIFYfe04aiQeKd
         2A8H4Ey23E2p+g0qx75OxIw2OBIwtFL8aQKTxYs0elcezdv4WPDn3wN0EGRhGOE/ok2N
         +cr56Aa+XxzCxQRVk+pygSTh4HXgAb85njr+8hCQCrJ2RaXS0dL0pb8RvY9xewU5CYId
         1rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8DztgiE9mGfQ9+syuvCxSlmidaYWBeDuE+eqHZI9lA=;
        b=R3hxZWVhXw7Yhm0uDA0bkK/B/HXbMPoAVM+o/YYe6sSOb2FaRbTXUXxIiIJhK5CCEH
         RgVL+LEo2sqSmM1anI2nKI5uWnPuRsykFsGrt2Jqvq1tvk60TA7x9gsn21vjp0q+AHX8
         ActEUr+jMlym6EUR523rH5i58LzAzeWAhazKEeQk3KgCA4QZCUrO2lXhgYuTTYejYM1K
         BZhYSPPulKNLwIywBwHKrZuT9e9WOM2k/GTBjYH0g/gwRR3VD9dM4gkNyyA1AM6Vos6M
         hXx3sasxyeI0I+SOwJNZsjTkwCOtDdRvdmZMIwyf1yfioRXtGNnUSa8zTuNR6YAhm4M4
         qDbg==
X-Gm-Message-State: AOAM532wiVz3OdjawgyXMZvOlzcS6/zGPiF7mQ+9lQo8ZK5oOYGZZUVo
        JLmhKj0cXikXKS5h97vOse5OpdDtTNaHSmJ+lEc=
X-Google-Smtp-Source: ABdhPJxi0li8Rp85YKbP4hlNqLqT33IF1kfJdmoXMOeGWis0z1a7KLfAAh/HXJh1CYP/i//1EhTuWgZWrqVCMLYaYj8=
X-Received: by 2002:a17:906:c10d:b0:6f4:a770:846e with SMTP id
 do13-20020a170906c10d00b006f4a770846emr30333355ejc.497.1652356982129; Thu, 12
 May 2022 05:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112106.2356120-1-zheyuma97@gmail.com>
In-Reply-To: <20220512112106.2356120-1-zheyuma97@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 May 2022 14:02:25 +0200
Message-ID: <CAHp75Vfz-Qq3qo3Re7tsL0mfXNVYZYspGDFCDXhtZxwac7bEiw@mail.gmail.com>
Subject: Re: [PATCH] gpio: ml-ioh: Add devm_free_irq() call to remove flow
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, May 12, 2022 at 1:21 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> When removing the module, we will get the following flaw:

Thanks for the report and patch! My comments below.

> [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
> [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
> [   14.209994] RIP: 0010:remove_proc_entry+0x389/0x3f0
> [   14.217820] Call Trace:
> [   14.218057]  <TASK>
> [   14.218264]  unregister_irq_proc+0x14c/0x170
> [   14.218674]  irq_free_descs+0x94/0xe0
> [   14.219019]  mp_unmap_irq+0xb6/0x100
> [   14.219357]  acpi_unregister_gsi_ioapic+0x27/0x40
> [   14.219796]  acpi_pci_irq_disable+0x1d3/0x320
> [   14.220206]  pci_disable_device+0x1ad/0x380
> [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
> [   14.221075]  pci_device_remove+0x92/0x240

Can we remove not so important lines from the above? I guess ~3-4
selected ones would be enough.

> Fix this bug by adding devm_free_irq() call to remove flow.

Fixes tag?

> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

The code looks okay on the first glance.

P.S. Do you have such hardware?

-- 
With Best Regards,
Andy Shevchenko
