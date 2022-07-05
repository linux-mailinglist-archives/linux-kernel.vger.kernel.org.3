Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AEE567041
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiGEOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiGEOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:06:13 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5423177;
        Tue,  5 Jul 2022 06:54:18 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31caffa4a45so37967517b3.3;
        Tue, 05 Jul 2022 06:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Uu9hwOGiD/JMtKy0CbMp9uQfluVDVZ6jIujueeyIoM=;
        b=BgGc6D7gEM0HWTm9uPgGgWrhgTWFpvEa16JmksTk2RR2hj4++kLV1RTG/tNKdArAaG
         Eq0z9QBj76W8jQcYTWHOE2tjnf+FK3OCZOWMeZLVhiMJ67aQxyaGHxQWjJRFubqVoR4z
         oaE5Y+I3wLM+XFXUIxuFQZ+MUrtSyQO83pYmUZNgAvYhBtKQR98lOlXlsg+LVP6HnN8Q
         V9og1bFkgNun06C4P3g46UgWOyPP/Lz8foY5rmeBd/z2obVXea+vp7O6i2xOJWtr+eyK
         Ua11c3SS1CK5XtK0b++f7vPY48WzsBBecqohJl/+0ObwBLjKk8FiT33qFFBjJJZSPBwL
         ZQgQ==
X-Gm-Message-State: AJIora/ckW7TIQpDQJu1Fhb962gXIhpS6bJ5dur1z7UAWNr6fr5xkv5V
        usgSOAQmL/0yMOSjQzYFhoxoxgRi6jCQJOPog5o=
X-Google-Smtp-Source: AGRyM1t7cfmBA8M5X4gxAOWSv3vNQehmp6QlyDp/f5HN1WJWEs71pBLVwkkIZlx18zuEEYXGc64gNJ5X04WKemqvxtw=
X-Received: by 2002:a81:17d0:0:b0:31c:c5e2:fc1e with SMTP id
 199-20020a8117d0000000b0031cc5e2fc1emr3841737ywx.196.1657029257826; Tue, 05
 Jul 2022 06:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
 <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
 <61fbd71b-9c36-345c-7aed-561b81c34259@huawei.com> <CAHp75VdxaBG8Sj3j7Wa7BrZOrn1j2eAtJMw0N8z255HwMSohYw@mail.gmail.com>
 <df8c0a5d-e950-1726-5d30-80dcc8b20ff9@huawei.com> <CAJZ5v0hv7nm57QrCYX+aX=fVoE0s0BxEpJfz+a8bsPzzSZt7+g@mail.gmail.com>
 <71dfc3cd-c2ae-8096-9280-67e77c21055e@huawei.com> <CAHp75VfqJwF4YypH3QE0MRgZAyjEMKche-4czUuiC=aTYoYwig@mail.gmail.com>
 <CAHp75VfpQfBYD-AmVhbxm4tp_1EVv8xqCChYpuuRKOC=P_Y_og@mail.gmail.com> <050e5a2f-42b9-f851-ec6e-e2a9d3fdbe1c@huawei.com>
In-Reply-To: <050e5a2f-42b9-f851-ec6e-e2a9d3fdbe1c@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 15:54:04 +0200
Message-ID: <CAJZ5v0j++HZJfL2+0uWgDRqVeZPviaZSWyL3Yn7T2Ky=bcRQMQ@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Tue, Jul 5, 2022 at 12:16 PM John Garry <john.garry@huawei.com> wrote:
>
> On 05/07/2022 10:39, Andy Shevchenko wrote:
> > On Tue, Jul 5, 2022 at 11:38 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com>  wrote:
> >> On Tue, Jul 5, 2022 at 10:37 AM John Garry<john.garry@huawei.com>  wrote:
> >>> On 04/07/2022 20:02, Rafael J. Wysocki wrote:
> >> ...
> >>
> >>> I gave these a quick test on my board and they look fine.
> >>>
> >>> Acked-by: John Garry<john.garry@huawei.com>
> >> John, I believe now you may send a formal clean up to convert to platform_device
> > Hit Enter too early:-)
> >
> > ...to platform_device_register_full().
>
> Sure, I can look at that now. But I just found where we previously
> mentioned the possibility of factoring out some of the ACPI platform
> device creation code:
>
> https://lore.kernel.org/linux-acpi/CAHp75VfOa5pN4MKT-aQmWBwPGWsOaQupyfrN-weWwfR3vMLtuA@mail.gmail.com/
>
> There is actually still a comment in the hisi_lpc driver - I should have
> checked there first :)
>
> So my impression is that the hisi_lpc code is almost the same in
> acpi_create_platform_device(), apart from we need do the resource fixup
> in hisi_lpc_acpi_set_io_res().
>
> So we could factor out by dividing acpi_create_platform_device() into 2x
> parts: resource get and then platform dev create. But that does not seem
> wise as we have 2x parts which don't make sense on their own. Or else
> pass a fixup callback into acpi_create_platform_device(). Any other
> ideas if we want to go this way?

Personally, I would do the cleanup that can be done without
refactoring the library function as the first step, just to reduce the
amount of changes made in one go if nothing else.

Next, I'd look at introducing something like

acpi_create_platform_device_ops(struct acpi_device *adev, const struct
property_entry *properties, const struct *platform_device_create_ops
*ops);

where ops would be a set of callbacks to invoke as a matter of customization.

Then, acpi_create_platform_device() can be defined as a wrapper around
the above.
