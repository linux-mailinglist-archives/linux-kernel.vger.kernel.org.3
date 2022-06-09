Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA574545176
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiFIP7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiFIP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:59:49 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26665207EE1;
        Thu,  9 Jun 2022 08:59:48 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id s39so14938914ybi.0;
        Thu, 09 Jun 2022 08:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkjwIFSBShSANVnKqlWkqSbwyA6d8VE+MCw2zkRvhXA=;
        b=4duzRHL/mWY2EU9hjFyElqH8UQy+ACfqvRTFeWNWd3oDNUa4cuIdrZuVp9QyJoFBlQ
         lWhI+Wma08EWQ8VgN7b5SFNBEglML9o6immKUxG3+EEc/GuktZHwWAko6hk5ZnEGXyuV
         V4DfOqbvLFqxZjfN/UN8hO//Ziuux1VXJNvB87Ya9AX4MiQiORS0fOkrn2tVhLImNdBN
         VqdjGg5CQ7Y4PFPuyNko+K7fYTdG8YNSHjIIRP1QAd74zp4rl97ngD0WIIWSdXLFlGLd
         gVPTGb9svZDZlLmmQYbZIMpm64KoOQq05T3uh2ChwWZve4XqXnRQom0q/wRawNF03wkM
         QKMw==
X-Gm-Message-State: AOAM5330MrRtTGS1VgNNZPMpL8CSBS3IxbpLRWng3TCJzUyGe/smIOKB
        /QunUF/1qAnu9uvQOvRwl1ZRmGyoZTUK0ocoCsQ=
X-Google-Smtp-Source: ABdhPJxZxgOlYZgUOk85MKiKsr8XETr6V05/C8IXLMp/Vcw8hooCyGguGpjUs/aqav35n0uQm5h9NbQaXvBP7YQSD70=
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr39274465ybg.365.1654790387429; Thu, 09
 Jun 2022 08:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <YqIYS3TVZvkIVcOm@smile.fi.intel.com>
In-Reply-To: <YqIYS3TVZvkIVcOm@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 17:59:36 +0200
Message-ID: <CAJZ5v0jF67vWwaZzx1xzPrHzOAbHNPm2_JV0O3TTXk6S7gQY=w@mail.gmail.com>
Subject: Re: [PATCH v1 00/16] ACPI: Get rid of the list of children in struct acpi_device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
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

On Thu, Jun 9, 2022 at 5:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 03:44:27PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > Confusingly enough, the ACPI subsystem stores the information on the given ACPI
> > device's children in two places: as the list of children in struct acpi_device
> > and (as a result of device registration) in the list of children in the embedded
> > struct device.
> >
> > These two lists agree with each other most of the time, but not always (like in
> > error paths in some cases), and the list of children in struct acpi_device is
> > not generally safe to use without locking.  In principle, it should always be
> > walked under acpi_device_lock, but in practice holding acpi_scan_lock is
> > sufficient for that too.  However, its users may not know whether or not
> > they operate under acpi_scan_lock and at least in some cases it is not accessed
> > in a safe way (note that ACPI devices may go away as a result of hot-remove,
> > unlike OF nodes).
> >
> > For this reason, it is better to consolidate the code that needs to walk the
> > children of an ACPI device which is the purpose of this patch series.
> >
> > Overall, it switches over all of the users of the list of children in struct
> > acpi_device to using helpers based on the driver core's mechanics and finally
> > drops that list, but some extra cleanups are done on the way.
> >
> > Please refer to the patch changelogs for details.
>
> Cool series, thanks for doing that!
>
> You may add my
> Revieweed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> to all non-commented, by me, patches (excluding soundwire) and to ones
> where comment just about one line/two lines split (address them if you
> are okay, otherwise ignore those comments).

Thank you!
