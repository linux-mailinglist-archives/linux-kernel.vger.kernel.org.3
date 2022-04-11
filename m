Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A844FBD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbiDKNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbiDKNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:39:59 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980CE21E15;
        Mon, 11 Apr 2022 06:37:44 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ec0bb4b715so36924437b3.5;
        Mon, 11 Apr 2022 06:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRPXgS5rrx6sR3zmq2oBDmmbLAxRyhhEfq8PnmXGKOM=;
        b=2AzEJp8uHtvEYuA30WTRhmiGMQsAY4eNTevitTDpewlCkigB8iwV2qtDfs+K9X3TeT
         2RR2ybbdq8yvafWtzCoVmwXU8ZOe0hIvm91O+G1Ft7SCq33d4f7VGFPxHxcBWdB6bzru
         uDuP6AerQ1edpcbprO1AR37UEnOnJxdYriMYrZhRbXj5umjHccHLof9tAEizeDovCKLq
         DEBK1HfonCb215g2/OBUB+2axeGQgTemA6cZIN5ODtH4hSb/dzk/eis5R0TZBICH4sFL
         v+Z9fNtjPWh0HwnO8bfDzRXzURhnWL4Jl2K0lq1Kh6OiOmb1xRNqT0Eq5afN0kB5SUcN
         w0Zg==
X-Gm-Message-State: AOAM531DhT4d0EMRwnP5pq0q5TG+Mmy/4VB7fipe5G9RvEsI8pKNIdPS
        qMd2ew1Jzn3+yknmfkh36fbWPLagmSLaiCjaqpk=
X-Google-Smtp-Source: ABdhPJyhw5qM8ctioGl3thWlFUF30jRwNh4wXQXwAC0cABjUGnWdrf7vIaM69biH2WE4vgddp60f9gD5LOtpkE9v3b8=
X-Received: by 2002:a81:ece:0:b0:2ec:9f8:acba with SMTP id 197-20020a810ece000000b002ec09f8acbamr5286430ywo.149.1649684263810;
 Mon, 11 Apr 2022 06:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <Yk7aeAcKIBrTupcq@debian-BULLSEYE-live-builder-AMD64> <708fb1ec-4e57-7a1d-b0a0-a3a10b3cacf3@redhat.com>
In-Reply-To: <708fb1ec-4e57-7a1d-b0a0-a3a10b3cacf3@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Apr 2022 15:37:32 +0200
Message-ID: <CAJZ5v0g2UDOR3mYsdqnPcpYgmecY706YQcTKTWMRtezkK0sfaQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v6] platform: x86: Add ChromeOS ACPI device driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
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

On Mon, Apr 11, 2022 at 3:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 4/7/22 14:35, Muhammad Usama Anjum wrote:
> > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > The x86 Chromebooks have ChromeOS ACPI device. This driver attaches to
> > the ChromeOS ACPI device and exports the values reported by ACPI in a
> > sysfs directory. This data isn't present in ACPI tables when read
> > through ACPI tools, hence a driver is needed to do it. The driver gets
> > data from firmware using ACPI component of the kernel. The ACPI values
> > are presented in string form (numbers as decimal values) or binary
> > blobs, and can be accessed as the contents of the appropriate read only
> > files in the standard ACPI device's sysfs directory tree. This data is
> > consumed by the ChromeOS user space.
> >
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
>
> Thanks overall this looks pretty good to me.  The only remark which
> I have is that I would like to see the Kconfig symbol changed
> from CONFIG_ACPI_CHROMEOS to CONFIG_CHROMEOS_ACPI to match the
> filename.
>
> CONFIG_ACPI_CHROMEOS to me suggests that this is an ACPI subsystem
> Kconfig option which, with the driver living under
> drivers/platform/x86 it is not.
>
> There is no need to send a new version for this, if you agree
> with the change let me know and I can change this while merging
> the driver.
>
> Rafael, before I merge this do you have any (more) remarks
> about this driver?

I'm not sure why it has to be an acpi_driver.

I think that the generic enumeration code creates a platform device
for this ACPI device object, so why can't it bind to that platform
device?

Generally speaking, IMV we should avoid adding drivers binding
directly to ACPI device objects, because that is confusing (it is kind
of like binding directly to an of_node) and it should be entirely
avoidable.
