Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4D4B8F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiBPRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:20:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiBPRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:20:55 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416EBC3368;
        Wed, 16 Feb 2022 09:20:43 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d646fffcc2so6305427b3.4;
        Wed, 16 Feb 2022 09:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zm99wFyMLWOW6zNGSmJZfjDJGqoAK+iiiXMMA8S8X84=;
        b=ZQVoltJtm6jzIvHWb8WeB6Lk4GINIqOW0QjoPkMXoRJ2lpeQsaSo6Ug08xKO/7/ij9
         xiAfYC5/WKVi6gLrqDOTMwxLFV1rziAQ3864gFT0QtfW4F/CJSgxud5196JP0rnLwdcm
         0eEoCNTGKSmlbs8IpvHUg3ZeRS8CCNPGuq5MrfjCoKuVmNWZHyk7WVPkHPVjpH1m5M98
         0SY128hSNUtrnewLfNpCirJXeK8mpn2uATA4Hd9zZWyYSEa4jTy7HEYRKnEBzSqwm/Y/
         NHRahkoAYNGSVmU94C2pvPyTidLqdkIEbUILrVbI7TPXHJxZ8XQtGGFdOaSYwFqqWCSf
         zO7A==
X-Gm-Message-State: AOAM532LuPd0DVk54JPa7Iu5kaJVdZVgLnbyr/U+dgjfgxCD0WByBLeb
        JimQhHPtTJEmTMOHMyh1UrFV/ESTbwSwuZ0X8ms=
X-Google-Smtp-Source: ABdhPJysdJFsx6Ce3YKaUcCNKNNGG72GDzTJ3a2hk+CKoZRkVucpPwTAJSyQjDLJQTbTeTkcy4RRh3GtrvWWWciC6ko=
X-Received: by 2002:a81:f008:0:b0:2d0:cd72:74e5 with SMTP id
 p8-20020a81f008000000b002d0cd7274e5mr3420459ywm.301.1645032042553; Wed, 16
 Feb 2022 09:20:42 -0800 (PST)
MIME-Version: 1.0
References: <80742062-8629-3978-e78d-92ffc9bb2e0b@gmail.com> <ecd789b3-74df-f4fe-ae66-8728f9bf24ab@redhat.com>
In-Reply-To: <ecd789b3-74df-f4fe-ae66-8728f9bf24ab@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Feb 2022 18:20:31 +0100
Message-ID: <CAJZ5v0g6DLfVYY+j5Zv-2N46st7E3uskRG1Kh6YLPsmKr9ULFQ@mail.gmail.com>
Subject: Re: [PATCH] fix linux 5.16 freeze regression on 32-bit ThinkPad T40
To:     Hans de Goede <hdegoede@redhat.com>,
        Woody Suwalski <wsuwalski@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/9/22 22:05, Woody Suwalski wrote:
> > From: Woody Suwalski <wsuwalski@gmail.com>
> >
> > Add and ACPI idle power level limit for 32-bit ThinkPad T40.
> >
> > There is a regression on T40 introduced by commit d6b88ce2, starting with kernel 5.16:
> >
> > commit d6b88ce2eb9d2698eb24451eb92c0a1649b17bb1
> > Author: Richard Gong <richard.gong@amd.com>
> > Date:   Wed Sep 22 08:31:16 2021 -0500
> >
> >     ACPI: processor idle: Allow playing dead in C3 state
> >
> > The above patch is trying to enter C3 state during init, what is causing a T40 system freeze. I have not found a similar issue on any other of my 32-bit machines.
> >
> > The fix is to add another exception to the processor_power_dmi_table[] list.
> > As a result the dmesg shows as expected:
> >
> >     2.155398] ACPI: IBM ThinkPad T40 detected - limiting to C2 max_cstate. Override with "processor.max_cstate=9"
> > [    2.155404] ACPI: processor limited to max C-state 2
> >
> > The fix is trivial and affects only vintage T40 systems.
> >
> > Signed-off-by: Woody Suwalski <wsuwalski@gmail.com>
> > ---
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
> > --- a/drivers/acpi/processor_idle.c    2022-02-04 09:09:54.515906362 -0500
> > +++ b/drivers/acpi/processor_idle.c    2022-02-04 14:21:08.264911271 -0500
> > @@ -96,6 +96,11 @@ static const struct dmi_system_id proces
> >        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
> >        DMI_MATCH(DMI_PRODUCT_NAME,"L8400B series Notebook PC")},
> >       (void *)1},
> > +    /* T40 can not handle C3 idle state */
> > +    { set_max_cstate, "IBM ThinkPad T40", {
> > +      DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> > +      DMI_MATCH(DMI_PRODUCT_NAME, "23737CU")},
> > +     (void *)2},
> >      {},
> >  };

Applied as a fix for 5.17-rc5, thanks!
