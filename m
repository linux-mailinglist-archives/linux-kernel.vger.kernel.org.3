Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF452686E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383068AbiEMR0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382999AbiEMR0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:26:31 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79270907
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:26:29 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso97337657b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yncJ85+SIlrUyfibchlOo3nGcBtZSYvrpkr6At33oFM=;
        b=tELgWSqPJ2XeK5KWJc0j3Izxo5P0JYNJpS1LDlgAuPlebbh9e6WMDgeVVLegGeIaAG
         VVkPFzkgs9492PO60P9XWePlc06wmWZFRlwvZJOZcx5xgrMhBpFW0sOXiKbdsVgYAIRK
         zjP+gEQNqrUKj69da/qFLQkvCuZ4GjCjn29S2q5SXBtTpeqs0++CM4HRgIxA5FD6F1rD
         PV/soEr2Mv4iexAm30OrWfc/UQepJQ0ZaQQ+CqJ76d1FTyEX4rQxfaOahQA70NByLksO
         DRAsanWwPBz8CdNJ7IaHIeXq66XPKKcVg1BFmGAU10mdurV7Lixpw2rYJxRhb1PbLjk0
         QcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yncJ85+SIlrUyfibchlOo3nGcBtZSYvrpkr6At33oFM=;
        b=lvGOfySkaCJKUsp6tGknRfQM1NNqP7rvaYr6cw6YEeVFkKUyrQASsiRZ1JeLenFJx/
         KQkX//i2LYByxhU4c6xDjOehfNJ5yxh64yE04jQbnYiC+4GlG0bayHUeyNnNwjV5yzyc
         buhZI9cRX10hp+Mg0GK/wviVQ/Pi36qqcWuLqlJyy9PNKKwVffza6gstjIW6uy8w1Bci
         w1BT3l4gfy7+1qe2rNaSZKfP6f7jjLw3+g6E/AKwIvhp9gVdUxy7FxtIoLJnEzJWD224
         C5ahWjda8vAsJWuNQnS4ig7kwwl4btdMHU97hVw29J8dc3BOjOx64l9Lmr+yWzSZbqUk
         QJsw==
X-Gm-Message-State: AOAM531hN1DcdBrKNM0eFYzyQ+CIa5s9+97nEQWOGY9lhYwUcYEb+xUX
        OlXH52tDs0/8mu2KBzprfifrScs0MKMrtEOfQCEYrg==
X-Google-Smtp-Source: ABdhPJwDc39YV2aEhsT7aNk3yasAQxRbPZaXjabeYzrpzhFybpEVGwlpZU8+hsRWlLkM/kxsOCa4BRf6isC84kd7cTg=
X-Received: by 2002:a81:1e09:0:b0:2fe:c53c:a0aa with SMTP id
 e9-20020a811e09000000b002fec53ca0aamr2051320ywe.455.1652462788378; Fri, 13
 May 2022 10:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com> <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 May 2022 10:25:52 -0700
Message-ID: <CAGETcx8=ZX+Pb4ioMVb7LfuF9c3HNP8g1+WMqZR=Pq7-9=DUCA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 6:58 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 29, 2022 at 5:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > The deferred probe timer that's used for this currently starts at
> > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > assumption being that all available drivers would be loaded and
> > registered before the timer expires. This means, the
> > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > worst case. But if we set the default value for it to cover the worst
> > case, it would significantly slow down the average case. For this
> > reason, the default value is set to 0.
> >
> > Also, with CONFIG_MODULES=y and the current default values of
> > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > drivers will cause their consumer devices to always defer their probes.
> > This is because device links created by fw_devlink defer the probe even
> > before the consumer driver's probe() is called.
> >
> > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > timer on every successful driver registration, with the expectation more
> > modules would be loaded in the near future, then the default value of
> > driver_deferred_probe_timeout only needs to be as long as the worst case
> > time difference between two consecutive module loads.
> >
> > So let's implement that and set the default value to 10 seconds when
> > CONFIG_MODULES=y.
>
> We had to revert a non-zero timeout before (issue with NFS root IIRC).
> Does fw_devlink=on somehow fix that?

If it's the one where ip autoconfig was timing out, then John Stultz
fixed it by fixing wait_for_device_probe().
https://lore.kernel.org/all/20200422203245.83244-4-john.stultz@linaro.org/

If you are referring to some other issue, then I'd need more details.

-Saravana
