Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DC0598CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbiHRTlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHRTlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:41:51 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0294D0221;
        Thu, 18 Aug 2022 12:41:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a15so1917298qko.4;
        Thu, 18 Aug 2022 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Vyt7thzr39zGzD+jwdjbrUMpFKsnWCaeVnONmE4AFgo=;
        b=ZaAxj2QMNxNhWbyxxYbh/wlzc/lpYiubkJrWfBxxjEfKiHktq4rm02nEIXrkN8VFun
         1tRITvqVUBVN9GNgwp9AbLrwVQSXbg5LwG2PCo+3jpvlGkms8M0URVFecJn0SfNKxjYv
         3GeRd4GhGgGXpekECxGR/ZuNKN0eGiEIogh1YrKwKmJFS4ta+ILQD7b0GGpScYI6vwmT
         8wRAhYJH9Tu3YfsXGbS91FMH6F+YkKRfVL3vbfk2hEYthFocbBNBkzmwv8v8bdlu20GP
         O6Ul9o7QjPt9kwTh+Z3BgwPmistP029PrzXxoi++xfWN82b99hOHFd9LUXM7Y+GulQ2f
         Xj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Vyt7thzr39zGzD+jwdjbrUMpFKsnWCaeVnONmE4AFgo=;
        b=KsQXvHI1BvQSAmJijyfBFbmaN7mI+A9mSjCygkdivIVMu19ub5ZxS5Ck0dUrGX3QVT
         LbY89MlhNPRHClNQaMIdd7nleOQ5lp3FiDgkMSqRjTnDk+MXbEdXcxGWjJvRN8QrvG7/
         mWUyw5QplSxqO/ffv3/K6cCAaNWC0+eu2YXs+TSXv7bd1xD4TLUVet04HukOj7fGq6PO
         rMa3AxwBxuaYiJX15+M15H3DTqkp3tTQAAMefoBdtzUzm8JohgUrzge9cqMmqyo4XAJ6
         rCRHAK5jiFkWqwhCOT1htU5HcyS9TQFaGWb7Gb6lzeLPRHStRwVaiZXlPaEu3proWFAE
         CT2Q==
X-Gm-Message-State: ACgBeo2U19GcHkjPXpi/VEU2JaqmTJanEaeonynn7Z8aZw53DDSM1O/f
        ccnLEgvqSmW6grj28UtAdK1vE8zrktaA/ISyo75xYA2AsnBzcw==
X-Google-Smtp-Source: AA6agR55NBQavXJrL399ar0NBCJ0wyWApu/5N7JexytNdIVdh1872u0lTxHVpzyXu1b2kmiBZetgCwmLFvhIzL7/rF0=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr3270736qko.383.1660851710030; Thu, 18
 Aug 2022 12:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com> <1660649244-146842-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1660649244-146842-3-git-send-email-john.garry@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 22:41:13 +0300
Message-ID: <CAHp75VdhCovo1uT3oxQAymEO9X+29oDet7LjYkLvpmj+r15Tfg@mail.gmail.com>
Subject: Re: [PATCH PoC 2/3] ACPI: platform: Refactor acpi_create_platform_device()
To:     John Garry <john.garry@huawei.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 2:33 PM John Garry <john.garry@huawei.com> wrote:
>
> There is commonality between acpi_create_platform_device() and
> hisi_lpc_acpi_add_child(), in that it covers 2x main steps:
> - Read resources for the acpi_device
> - Create platform device
>
> Refactor acpi_create_platform_device() so that it may be reused by
> hisi_lpc_acpi_add_child() to reduce duplication.

...

> + * acpi_create_platform_device_ops - Create platform device for ACPI device node

Not sure I understand why _ops is a suffix for the function. I would
expect _ops to be a data struct where the ->xlate() and perhaps other
callbacks may be collected. It may be that I have missed that portion
in the previous discussion.

...

> +       if (name)
> +               pdevinfo.name = name;
> +       else
> +               pdevinfo.name = dev_name(&adev->dev);

> +       pdevinfo.data = data;
> +       pdevinfo.size_data = size_data;

It rather reminds me of platform device registration full with this
device info. May be what you need is
struct acpi_platfrom_device_info {
  properties;
  name;
  id;
  ->xlate();
  ...
};

?

...

> +struct platform_device *acpi_create_platform_device_ops(
> +                               struct acpi_device *adev,
> +                               const char *name,
> +                               const struct property_entry *properties,
> +                               void *data, size_t size_data,
> +                               int (*xlat)(struct acpi_device *adev,
> +                                           struct resource *res,
> +                                           void *data, size_t size_data),
> +                               int id);

...because this looks  a bit too much from the amount of parameters
point of view.

-- 
With Best Regards,
Andy Shevchenko
