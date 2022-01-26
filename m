Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0153549D06F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiAZRLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:11:21 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:38538 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiAZRLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:11:19 -0500
Received: by mail-yb1-f179.google.com with SMTP id i62so792797ybg.5;
        Wed, 26 Jan 2022 09:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzJHhJleSWqF14ZWukjXdo49B2n+jMNE6xZJikDyEFM=;
        b=xkLiMVOWZ4Q8RWkovyECL9bKjhhx80BZ+HHuiFP/YoZ7MwOvM0evKyVSzY+ntklrAU
         xhoBZ93rGoS8wuTZPF9IMHZ3nZBPsoXL46RMbICrqQjzkJWrql6Z77mgrxKUXRCrH6uF
         crzeZVl07QG6HkyswKArI0Ab5AWr+NgdeB/1hR8jAesQWCKqvQWzIVU3+t/mu/tWrjoi
         dPrVpcmnkVX2v7iXSAVg8hRntGIicsF+IaDlLR7FvDR8JZ7WGNz0J57GCh/Mr9jyaL3X
         dhhW6vH+g4sSc0hveYGjvBK3fIVZf4IdKoIiU3SBhET6/FP5xfYcdq0hGuwqg8D2A8IW
         CTrg==
X-Gm-Message-State: AOAM530GtW5BAH6BTAVZqL0nTz43SE9OsMp5wndDdrWk4Yx/J65rWUuv
        Grib9fEgQLutyV39dBNShLoAy3JpRvGb1PSp1go=
X-Google-Smtp-Source: ABdhPJw9ZW3cL9vDSZBWr9fEd5TBzMzfmUkCiWNCvwBVkPc07T31xGpqLjJsBBez807kDQGA6D1N8ISHXLb3q/gjQn0=
X-Received: by 2002:a25:bb93:: with SMTP id y19mr37487436ybg.466.1643217078886;
 Wed, 26 Jan 2022 09:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20220123091004.763775-1-ztong0001@gmail.com> <6a0233cd-d931-8a36-3b9e-08b774cec7b0@redhat.com>
 <CAJZ5v0h51v9fFrJRuaFpSn7J2UEHndEj0f3zpmw=RvgsvAhtvw@mail.gmail.com> <049ccc3a-8628-3e90-a4f4-137a286b6dce@redhat.com>
In-Reply-To: <049ccc3a-8628-3e90-a4f4-137a286b6dce@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jan 2022 18:11:07 +0100
Message-ID: <CAJZ5v0hJWW_vZ3wwajE7xT38aWjY7cZyvqMJpXHzUL98-SiCVQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000047c38c05d67f4ab9"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000047c38c05d67f4ab9
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 26, 2022 at 5:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/26/22 16:54, Rafael J. Wysocki wrote:
> > On Wed, Jan 26, 2022 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi All,
> >>
> >> On 1/23/22 10:10, Tong Zhang wrote:
> >>> when acpi=off is provided in bootarg, kernel crash with
> >>>
> >>> [    1.252739] BUG: kernel NULL pointer dereference, address: 0000000000000018
> >>> [    1.258308] Call Trace:
> >>> [    1.258490]  ? acpi_walk_namespace+0x147/0x147
> >>> [    1.258770]  acpi_get_devices+0xe4/0x137
> >>> [    1.258921]  ? drm_core_init+0xc0/0xc0 [drm]
> >>> [    1.259108]  detect_thinkpad_privacy_screen+0x5e/0xa8 [drm]
> >>> [    1.259337]  drm_privacy_screen_lookup_init+0xe/0xe85 [drm]
> >>>
> >>> The reason is that acpi_walk_namespace expects acpi related stuff
> >>> initialized but in fact it wouldn't when acpi is set to off. In this case
> >>> we should honor acpi=off in detect_thinkpad_privacy_screen().
> >>>
> >>> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> >>
> >> Thank you for catching this and thank you for your patch. I was about to merge
> >> this, but then I realized that this might not be the best way to fix this.
> >>
> >> A quick grep shows 10 acpi_get_devices() calls outside of drivers/acpi,
> >> and at a first glance about half of those are missing an acpi_disabled
> >> check. IMHO it would be better to simply add an acpi_disabled check to
> >> acpi_get_devices() itself.
> >>
> >> Rafael, do you agree ?
> >
> > Yes, I do.
>
> Did you see my follow-up that that is not going to work because
> acpi_get_devices() is an acpica function ?

No, I didn't, but it is possible to add a wrapper doing the check
around it and convert all of the users.

Alternatively, the ACPICA function can check acpi_gbl_root_node
against NULL, like in the attached (untested) patch.

--00000000000047c38c05d67f4ab9
Content-Type: text/x-patch; charset="US-ASCII"; name="acpica-check-root-in-walks.patch"
Content-Disposition: attachment; filename="acpica-check-root-in-walks.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kyvszwmw0>
X-Attachment-Id: f_kyvszwmw0

LS0tCiBkcml2ZXJzL2FjcGkvYWNwaWNhL25zd2Fsay5jIHwgICAgMyArKysKIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykKCkluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2FjcGkvYWNwaWNh
L25zd2Fsay5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL2FjcGlj
YS9uc3dhbGsuYworKysgbGludXgtcG0vZHJpdmVycy9hY3BpL2FjcGljYS9uc3dhbGsuYwpAQCAt
MTY5LDYgKzE2OSw5IEBAIGFjcGlfbnNfd2Fsa19uYW1lc3BhY2UoYWNwaV9vYmplY3RfdHlwZQog
CiAJaWYgKHN0YXJ0X25vZGUgPT0gQUNQSV9ST09UX09CSkVDVCkgewogCQlzdGFydF9ub2RlID0g
YWNwaV9nYmxfcm9vdF9ub2RlOworCQlpZiAoIXN0YXJ0X25vZGUpIHsKKwkJCXJldHVybl9BQ1BJ
X1NUQVRVUyhBRV9OT19OQU1FU1BBQ0UpOworCQl9CiAJfQogCiAJLyogTnVsbCBjaGlsZCBtZWFu
cyAiZ2V0IGZpcnN0IG5vZGUiICovCg==
--00000000000047c38c05d67f4ab9--
