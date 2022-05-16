Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD25285F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiEPNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiEPNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:50:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F13A5DA;
        Mon, 16 May 2022 06:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A62F9B81216;
        Mon, 16 May 2022 13:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618BAC3411A;
        Mon, 16 May 2022 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652708957;
        bh=Z1XATC9uFabr/cJUUJjAm1EmvJAVsCV0ZzQGqjrP+zA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z+GBZ3HlMnS5S30k9vIXcOgsZZ9s2NTFIiE1HhvkWvPHy1bjZ00LgZTijr0M8KGmr
         STXCnHM85F+TIeIvpPTpG9lJp1vA2Dm/Llye5llcupfFc3DrhRP+8bTa1WAu66TGeA
         j/DsK4XK2TUXXSmd4/EUmmfxHNWV6eBhb+iN8YrybsUGbavpI8spHpzmskqUGIvWti
         bNesjElLh27daCKCjj83GRo5P9odygoLEUSbXWLeoVpn5VGXa0/BMtY5u5Z+8Zq3Yz
         Dxa7iXnhmdyqASNVfz96SqOorM96PaPLHL4R1RBqW+eHT3/L6di0va0g0SOjYdn1qn
         w4pbcCKlq/PAQ==
Received: by mail-ed1-f51.google.com with SMTP id y21so18436156edo.2;
        Mon, 16 May 2022 06:49:17 -0700 (PDT)
X-Gm-Message-State: AOAM533ImvKH7a3KRENUQ2DkkfvR+4Qv5+fQI6y0XwDSBU7tzQraS5D/
        fUWvmZXYcs/aGL6LLJerI/dYOGPh3kc0naJ5Jw==
X-Google-Smtp-Source: ABdhPJzHJM/87Poo6lwZbFjNTMwh5WnjP4kK2zZNYqsvkYOJYJ8e9tfRTKjYaXJU+LODgXXZ2NtySTJTP3q9QRcur+c=
X-Received: by 2002:a05:6402:35c7:b0:427:d231:3740 with SMTP id
 z7-20020a05640235c700b00427d2313740mr13373747edc.40.1652708955614; Mon, 16
 May 2022 06:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com> <CAGETcx8=ZX+Pb4ioMVb7LfuF9c3HNP8g1+WMqZR=Pq7-9=DUCA@mail.gmail.com>
In-Reply-To: <CAGETcx8=ZX+Pb4ioMVb7LfuF9c3HNP8g1+WMqZR=Pq7-9=DUCA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 May 2022 08:49:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Y9p2UEgQ=ctFjcsHG9M6iXuGFY-N6uMAqhPM5KLwDjA@mail.gmail.com>
Message-ID: <CAL_Jsq+Y9p2UEgQ=ctFjcsHG9M6iXuGFY-N6uMAqhPM5KLwDjA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Saravana Kannan <saravanak@google.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, May 13, 2022 at 6:58 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Apr 29, 2022 at 5:09 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > The deferred probe timer that's used for this currently starts at
> > > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > > assumption being that all available drivers would be loaded and
> > > registered before the timer expires. This means, the
> > > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > > worst case. But if we set the default value for it to cover the worst
> > > case, it would significantly slow down the average case. For this
> > > reason, the default value is set to 0.
> > >
> > > Also, with CONFIG_MODULES=y and the current default values of
> > > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > > drivers will cause their consumer devices to always defer their probes.
> > > This is because device links created by fw_devlink defer the probe even
> > > before the consumer driver's probe() is called.
> > >
> > > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > > timer on every successful driver registration, with the expectation more
> > > modules would be loaded in the near future, then the default value of
> > > driver_deferred_probe_timeout only needs to be as long as the worst case
> > > time difference between two consecutive module loads.
> > >
> > > So let's implement that and set the default value to 10 seconds when
> > > CONFIG_MODULES=y.
> >
> > We had to revert a non-zero timeout before (issue with NFS root IIRC).
> > Does fw_devlink=on somehow fix that?
>
> If it's the one where ip autoconfig was timing out, then John Stultz
> fixed it by fixing wait_for_device_probe().
> https://lore.kernel.org/all/20200422203245.83244-4-john.stultz@linaro.org/

Yeah, that was it.

Acked-by: Rob Herring <robh@kernel.org>
