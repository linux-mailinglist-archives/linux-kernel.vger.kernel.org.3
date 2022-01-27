Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D413D49E3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiA0NgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:36:12 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:34756 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiA0NeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:34:03 -0500
Received: by mail-yb1-f169.google.com with SMTP id v186so8804013ybg.1;
        Thu, 27 Jan 2022 05:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwIU7q542/Majhq966D+41zjzGbPYbtJbtOu0ZRQ3As=;
        b=DLPdBI7j7GtcJ6fgOGH8ILGgC/xlOaTlADW7+9eeH5x9mdQYWH7Zno7gd8nap4YFe0
         QnMsabrKXBy6Q5pDdLgLIgBEQI930tex75iCNxyz+QmbmoKC3m6rF1LLdXarfXQg1LzW
         oiVM+xbxMeCtJ5eA6gbdRUNEcMnxAUgbAzFSNzFomH+dDQzIVwwi1U8Hb1WSrIGT85Sx
         NetYAkLUIxXK9uO4vmJ5rVXYnggh3KEWRuQc++Krk1ymFfeNxvutPEttk5WYi288WS5Q
         WsUwmh1CynLl3kClhYMqYNJHTDmq8iYF/IpCzplnrm3p8yuodo2l2TFZdQal14kyH1Gs
         A1JQ==
X-Gm-Message-State: AOAM5333R6rzPj/LFtYDc20S0IYct2hfPKC5yN3ADLxKSAyYt+xcGVHs
        h9RTpAThBp5GoUbwiQiq/9QlGSVRcYE5ThQs/0A=
X-Google-Smtp-Source: ABdhPJx5o6SjJD6Sr3giZs1kpJ/iEQnMh6yOLpDp+jztp116PA4onXa6gPegmQzAF6j36v7rIaCFiiI6WAkjpYmMEs4=
X-Received: by 2002:a25:4ac4:: with SMTP id x187mr5580851yba.466.1643290443015;
 Thu, 27 Jan 2022 05:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20220123091004.763775-1-ztong0001@gmail.com> <6a0233cd-d931-8a36-3b9e-08b774cec7b0@redhat.com>
 <CAJZ5v0h51v9fFrJRuaFpSn7J2UEHndEj0f3zpmw=RvgsvAhtvw@mail.gmail.com>
 <049ccc3a-8628-3e90-a4f4-137a286b6dce@redhat.com> <CAJZ5v0hJWW_vZ3wwajE7xT38aWjY7cZyvqMJpXHzUL98-SiCVQ@mail.gmail.com>
 <994f94b2-61d3-1754-d733-732a0fb47d50@redhat.com>
In-Reply-To: <994f94b2-61d3-1754-d733-732a0fb47d50@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jan 2022 14:33:52 +0100
Message-ID: <CAJZ5v0hXKJhCSKki8JHs+Q=3BWYygDNz9LLAaiVKpDvLPr6-ZA@mail.gmail.com>
Subject: Re: acpi_get_devices() crash when acpi_disabled==true (was [PATCH v2]
 drm/privacy-screen: honor acpi=off in detect_thinkpad_privacy_screen)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 2:05 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/26/22 18:11, Rafael J. Wysocki wrote:
> > On Wed, Jan 26, 2022 at 5:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 1/26/22 16:54, Rafael J. Wysocki wrote:
> >>> On Wed, Jan 26, 2022 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Hi All,
> >>>>
> >>>> On 1/23/22 10:10, Tong Zhang wrote:
> >>>>> when acpi=off is provided in bootarg, kernel crash with
> >>>>>
> >>>>> [    1.252739] BUG: kernel NULL pointer dereference, address: 0000000000000018
> >>>>> [    1.258308] Call Trace:
> >>>>> [    1.258490]  ? acpi_walk_namespace+0x147/0x147
> >>>>> [    1.258770]  acpi_get_devices+0xe4/0x137
> >>>>> [    1.258921]  ? drm_core_init+0xc0/0xc0 [drm]
> >>>>> [    1.259108]  detect_thinkpad_privacy_screen+0x5e/0xa8 [drm]
> >>>>> [    1.259337]  drm_privacy_screen_lookup_init+0xe/0xe85 [drm]
> >>>>>
> >>>>> The reason is that acpi_walk_namespace expects acpi related stuff
> >>>>> initialized but in fact it wouldn't when acpi is set to off. In this case
> >>>>> we should honor acpi=off in detect_thinkpad_privacy_screen().
> >>>>>
> >>>>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> >>>>
> >>>> Thank you for catching this and thank you for your patch. I was about to merge
> >>>> this, but then I realized that this might not be the best way to fix this.
> >>>>
> >>>> A quick grep shows 10 acpi_get_devices() calls outside of drivers/acpi,
> >>>> and at a first glance about half of those are missing an acpi_disabled
> >>>> check. IMHO it would be better to simply add an acpi_disabled check to
> >>>> acpi_get_devices() itself.
> >>>>
> >>>> Rafael, do you agree ?
> >>>
> >>> Yes, I do.
> >>
> >> Did you see my follow-up that that is not going to work because
> >> acpi_get_devices() is an acpica function ?
> >
> > No, I didn't, but it is possible to add a wrapper doing the check
> > around it and convert all of the users.
>
> Yes I did think about that. Note that I've gone ahead and pushed
> the fix which started this to drm-misc-fixes, to resolve the crash
> for now.

OK

> If we add such a wrapper we can remove a bunch of acpi_disabled checks
> from various callers.
>
> > Alternatively, the ACPICA function can check acpi_gbl_root_node
> > against NULL, like in the attached (untested) patch.
>
> That is probably an even better idea, as that avoids the need
> for a wrapper altogether. So I believe that that is the best
> solution.

Allright, let me cut an analogous patch for the upstream ACPICA, then.
