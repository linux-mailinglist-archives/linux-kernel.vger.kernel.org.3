Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D7561B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiF3NkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3NkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:40:14 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BAD1F615;
        Thu, 30 Jun 2022 06:40:13 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31bf327d4b5so89955587b3.13;
        Thu, 30 Jun 2022 06:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4EqGBirXKDcf9WNpbRPzeXkxUlfCYbtVRjNQitJ5Gc=;
        b=DDeDs6akHIDbDq8tzkm9PzrqWn1T7DKhcbUaiP1fnZtdRz+I6kNztzl+9hDcidYDma
         HjPn+ciNJW31MMvhaWyAO8cR+uaIrPacQkYSVq3LvCOUGCsb+wWRHMc1t0Cm+al60CvG
         ki11Q/RtXVt6E1kecXAZhmv2WbO4lM7nIykApvoJu2a1unwUZc9ZRbmb8f7SjCMyDVTy
         5lWUWNGCE7WQSrXzYMq3zQf2A5FhNJCZomsHXNli/wvPsJ980xUGITUHA1XLW8eK2baV
         xokVbB4J6BhFAJGz2YPmxT481IcY9mib2VVF4WKKf0UXrLrsiUfTyIFhZwQV0cRFjhRW
         BgMA==
X-Gm-Message-State: AJIora8pp1WA5Uj0kDU6jFO6CtyiEzpWAisrun1fkQbTZNzZ61TxcxPa
        Cvlq0KVccrrYwgB54KlPy0wSY7BcQo/L3Iy/Sg4EQSN9
X-Google-Smtp-Source: AGRyM1vfdsvlXmjZY7KC0erDfOEp2sCNtyNHDONrPqb2l/gJoA8lfJ2HVCBq3MO9pfuG5hPFneOfE5xeb3NgTo8FMQE=
X-Received: by 2002:a0d:d086:0:b0:31b:d0b2:e11f with SMTP id
 s128-20020a0dd086000000b0031bd0b2e11fmr10281349ywd.515.1656596413216; Thu, 30
 Jun 2022 06:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <CAJZ5v0jNOsAXSuX9dw9N3w12Y_nq62Z=OL4QQTwH=OnReGpQvA@mail.gmail.com> <7aad2916-1774-76c5-339a-bbcac4655642@huawei.com>
In-Reply-To: <7aad2916-1774-76c5-339a-bbcac4655642@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jun 2022 15:40:02 +0200
Message-ID: <CAJZ5v0hfJUj4ob2KSoMxbzHy88f_a+EGkFsxNxB6PjR3y-FCRA@mail.gmail.com>
Subject: Re: [PATCH v2] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Thu, Jun 30, 2022 at 3:37 PM John Garry <john.garry@huawei.com> wrote:
>
> On 30/06/2022 13:48, Rafael J. Wysocki wrote:
> > On Wed, Jun 29, 2022 at 3:47 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Instead of walking the list of children of an ACPI device directly,
> >> use acpi_dev_for_each_child() to carry out an action for all of
> >> the given ACPI device's children.
> >>
> >> This will help to eliminate the children list head from struct
> >> acpi_device as it is redundant and it is used in questionable ways
> >> in some places (in particular, locking is needed for walking the
> >> list pointed to it safely, but it is often missing).
> >
> > I've overlooked another usage of the children list in hisi_lpc, in
> > hisi_lpc_acpi_probe(), and eliminating that one is a bit more
> > complicated.
> >
> > So please scratch this one and I will send a v3 when 0-day tells me
> > that it builds.
>
> Hi Rafael,
>
> If it makes things simpler then I can just fix the driver so that we
> can't unload it. Let me know if that suits better.

I'd rather do the ACPI change first.

Also it looks like the "remove" is needed to do the cleanup in the
"probe" error path anyway.

Cheers!
