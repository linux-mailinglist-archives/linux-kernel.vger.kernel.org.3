Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC17B5450F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244565AbiFIPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbiFIPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:36:42 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77088191413;
        Thu,  9 Jun 2022 08:36:41 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3137c877092so45051167b3.13;
        Thu, 09 Jun 2022 08:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptxD9HuWbMbreO0BgUNscW2/7MNGEyI3okISSc2DDUc=;
        b=Nso0+68huTwjMjSsIzjDaqxMsTTbz2NbZo71tr1N4VJvEfRSGBd7VPlkb6nVENFzbc
         rAk5BhvsFKeu74v/vO0Z1my2HaGAG8CKU55PNgqMvjDH2MaVfslTH2Weg2xXfw/N0VgA
         a/NuOE5P9v32KBNs3EASFikpq4j97ImOgu5cVoZtYQIWBV6Q51ajFMBF5nRhcvr3wXM4
         o0DaCNgIkF1iIelCcP6ELc0a6HG0/N5uwkkvxrt3l5s58r1T5I2AWjwNqKF6zISg21bR
         ymB23ijl72RUkydYGS6rVvl0gjPXsnBGu2m1zvKUa81Oa/NwrCnPNonX2aNpZYTkmLOp
         yvbA==
X-Gm-Message-State: AOAM530CHPgeIWTJ5cyHtlTnCR29sokaUdP5W1WC/pFWHdAVPKt0XwtV
        4RJSt5EDtywnpSMoyDw4PU3AHOBKdquOSn66Qs4OrSVY4dc=
X-Google-Smtp-Source: ABdhPJxNmotsXk4KuIi1nkv8s/zRRMGGMuD1ivzYU6XTjNGPcS2TJKxe8OG7VRgqdEafa6c8FAs9YOC7iDItW1/YtBk=
X-Received: by 2002:a81:5a0b:0:b0:310:26f7:6217 with SMTP id
 o11-20020a815a0b000000b0031026f76217mr36336684ywb.301.1654789000689; Thu, 09
 Jun 2022 08:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <7414189.EvYhyI6sBW@kreacher> <YqIQ/HbSS9/0Fe/A@smile.fi.intel.com>
In-Reply-To: <YqIQ/HbSS9/0Fe/A@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 17:36:29 +0200
Message-ID: <CAJZ5v0jVapVT-Wz9miJuNYmbpKYNAdydnD-QZTF3vT=2A=+1wg@mail.gmail.com>
Subject: Re: [PATCH v1 04/16] thunderbolt: ACPI: Use acpi_find_child_by_adr()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 5:26 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 03:54:40PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of walking the list of children of an ACPI device directly
> > in order to find the child matching a given bus address, use
> > acpi_find_child_by_adr() for this purpose.
>
> ...
>
> >       if (!adev)
> >               return NULL;
>
> Already checked in the below call, IIUC. Hence can be removed.

Yes, it can, will update.

>
> > +     return acpi_find_child_by_adr(adev, port->port);
>
> --
