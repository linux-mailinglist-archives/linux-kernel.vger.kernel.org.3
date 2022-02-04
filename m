Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3554A93BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbiBDFxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiBDFxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:53:33 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD637C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:53:32 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id s6so4542689qvv.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYsZplQCWhMg5A+bT/pC03ERRgBVVGDzmghNtqEQDr0=;
        b=YBivNNSPLPS90P9KanrM2iXgWGM9hWxwxA3cqwPEs0O+rRpVly9+LQwEvvJEX+WosN
         Cw8s0KI5wt9MO3OpPlCUiGTFse+3KKZ/AzysoAgshKxrQySVr9haOsvZXRi5+VroDUz8
         BTE63MbJ+nz1+UP0MXiQKKvLtuGnwItdTM2yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYsZplQCWhMg5A+bT/pC03ERRgBVVGDzmghNtqEQDr0=;
        b=yYq1ak9/QC0l1mqe8mqAgcNga5TrBoUOFuimKWi/6cfSXL45N7QSCMRgw1MYxtPC1g
         BdyO3ouc5iCdvoxJP39WtCx6h4J0GHCvOTdQn795SWTkVsP9vrsSzzX9i2ns1K8HQv2L
         t3aGcvNEj0us1asVhlShAKEkc0jKMYWm39qZc8ueR/IfUAacVCvwZkzMIh3fJzs2omZl
         78lhZb2ZP4HW+l3UVdc2VwO3HNLk7nksxqxVoAt4jiIdHDkIHHUGTgKYQGLT82y4cl2h
         Q37umoIPb15LsX6PteFPzk2cV4BRCGXuXVdIZA2l8VrDxueaBSD+EnmnibgComEt1H15
         zMlw==
X-Gm-Message-State: AOAM532Koq0g8gsn/bMfRVTxygJh1RUFXzDyXxR9d2E1UKpMn8OFZaow
        ZByhhm2ao0JgBpxSJZaTJsX7YMzhqfDowpA2N3BfIujy
X-Google-Smtp-Source: ABdhPJxzV9x3lo5VCczp8QlRvauAgQ3xtN6M8nj+/uAMvK/1xvpmzR2BHbFocweO2eKRTPo+WwYrOvSqosvPmjV5APE=
X-Received: by 2002:ad4:5f89:: with SMTP id jp9mr815712qvb.130.1643954011111;
 Thu, 03 Feb 2022 21:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20220203115344.267159-1-joel@jms.id.au> <20220203115344.267159-2-joel@jms.id.au>
 <f44d2e01-b6cb-5f22-f651-f4dd7ced166f@arm.com>
In-Reply-To: <f44d2e01-b6cb-5f22-f651-f4dd7ced166f@arm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 4 Feb 2022 05:53:18 +0000
Message-ID: <CACPK8Xed3AESz2JjqJa2v=6ipXDBBMd=CxmiwruJS5cBEE+Qfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] firmware: Add boot information to sysfs
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 at 14:23, Robin Murphy <robin.murphy@arm.com> wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> > new file mode 100644
> > index 000000000000..cd6c42316345
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> > @@ -0,0 +1,43 @@
> > +What:                /sys/firmware/bootinfo/*
> > +Date:                Jan 2022
> > +Description:
> > +             A system can expose information about how it was started in
> > +             this directory.
> > +
> > +             This information is agnostic as to the firmware implementation.
> > +
> > +             A system may expose a subset of these properties as applicable.
> > +
> > +
> > +What:                /sys/firmware/bootinfo/secure_boot
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system was started with secure boot enabled in
> > +             the firmware.
> > +
> > +
> > +What:                /sys/firmware/bootinfo/abr_image
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system was started from the alternate image
> > +             loaded from an Alternate Boot Region. Often this is a result of
> > +             the primary firmware image failing to start the system.
> > +
> > +
> > +What:                /sys/firmware/bootinfo/low_security_key
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system's secure boot was verified with a low
> > +             security or development key.
> > +
> > +What:                /sys/firmware/bootinfo/otp_protected
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system's boot configuration region is write
> > +             protected and cannot be modified.
> > +
> > +What:                /sys/firmware/bootinfo/uart_boot
> > +Date:                Jan 2022
> > +Description:
> > +             Indicates the system firmware was loaded from a UART instead of
> > +             an internal boot device.
>
> I'd be concerned about how well details like "uart_boot" and "abr_image"
> scale beyond one SoC family from one vendor. The combinatorial explosion
> of possible boot configurations across Linux-capable SoCs and firmware
> in general is larger than I'd care to imagine, even before considering
> that the nuances don't necessarily stop there - e.g. whether a given
> storage interface is hard-wired or user-accessible is not a fixed
> property on many SoCs, and even a socketed SD card might be "trusted" if
> a board is deployed in a product with a sealed enclosure.

This is a fair point. The first iteration of this idea was specific to
the aspeed soc.

For the system I'm building, secure_boot and otp_locked tell our
manufacturing test process that the machine has been correctly
provisioned. I'd like to get something agreed upon so we can start
using those sysfs files in the testing without having to go back and
change things.

abr_image is an indication that something went wrong at boot time. I
thought this was a standard eMMC concept, but taking a closer look
it's specific to the aspeed soc.

Would it help if we gave them generic names?

 - abr_image -> alternate_boot

I welcome other suggestions.

I'll drop the uart_boot property for now.

Cheers,

Joel
