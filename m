Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3946AF34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378445AbhLGAiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354421AbhLGAiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:38:12 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75FC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:34:42 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x10so15038184ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR1RamryD4WlthBIR9T26uoYJqyl3qkjodvcg6vvFl0=;
        b=L37PSWY9CKiFUQBvTncBCjHH69u/VLeqJoBuE9TNkKbPkpMzcUH/AogVz5R2Os8hIx
         ebNj9rgwEvq+UQs5rRX9mfhiUaRBdIM8qcgOguUk/feQhKBKfMGhtWhq9aZeVOsEfmWG
         i8hnd6z8VqHPIIvsvUoa4sCB2wr6V3kw12z8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR1RamryD4WlthBIR9T26uoYJqyl3qkjodvcg6vvFl0=;
        b=RA5sgwyOn/Ors5vBsSLD+VfXn2bFM+8cD+7FcYFfhAzyEtny8jK7lkN+AUl4SYqB9/
         Y2EJhVJj7s/WMBpKy0M3VMXQggNHbXC9P0Y6bmE00GnlOVORGvKTqaL2CkYXE6pt9VzI
         qxJ0G7ptyuN1p4fC7x6GGd2L2rU6gEKMsViLDvdumSkVwxzvzE9StE9Ebv/7IVadvG0q
         4OWKeUCs7CpYo3m3DTdbAdeSLDWu6ZBuNIjz3HZl0+k6/5aH+UsLrtFN44LVC9Qy/b1p
         Tp6/8tfZmzJv8YmuVBkMz/WDv0O4vrZO/sxe5IX7pTwKCqjmJHWu2LCSzlKzQidACLG+
         utXw==
X-Gm-Message-State: AOAM530IMpvMRb1Z5CwG+02xFYlqYGtrOCyNqla4fae7nbPgkZZ3PBVl
        LsxeRfTfJfIIs6U8G2df56icsQo8zv10Kg==
X-Google-Smtp-Source: ABdhPJz24O6ijgYVRFksSpuzC6u0e9vqMJGTnDrYlq5lUKI254BggHoXeFCycqRvNhiQsILicfhlpA==
X-Received: by 2002:a05:6638:41a4:: with SMTP id az36mr47603190jab.135.1638837282174;
        Mon, 06 Dec 2021 16:34:42 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id p14sm5724721ilo.11.2021.12.06.16.34.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 16:34:41 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id z18so15041481iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:34:41 -0800 (PST)
X-Received: by 2002:a05:6638:252:: with SMTP id w18mr46736875jaq.54.1638837281443;
 Mon, 06 Dec 2021 16:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20211117065454.4142936-1-swboyd@chromium.org> <CAD=FV=XgV5=5mMuB5KbX38EFtZ6qxGGPMN6HFng_KJEc1KERxw@mail.gmail.com>
 <Ya6pvF8VIwokzqjs@ripper>
In-Reply-To: <Ya6pvF8VIwokzqjs@ripper>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Dec 2021 16:34:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UWT-snUqHjtj11VdSh+ekbzzSjeHmGRGV2LkhUr5iDmA@mail.gmail.com>
Message-ID: <CAD=FV=UWT-snUqHjtj11VdSh+ekbzzSjeHmGRGV2LkhUr5iDmA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom: Don't memcpy_toio more than is provided
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 6, 2021 at 4:23 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 06 Dec 16:01 PST 2021, Doug Anderson wrote:
>
> > Hi,
> >
> > On Tue, Nov 16, 2021 at 10:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > If the string passed into qcom_pil_info_store() isn't as long as
> > > PIL_RELOC_NAME_LEN we'll try to copy the string assuming the length is
> > > PIL_RELOC_NAME_LEN to the io space and go beyond the bounds of the
> > > string. Let's only copy as many byes as the string is long, ignoring the
> > > NUL terminator.
> > >
> > > This fixes the following KASAN error:
> > >
> > >  BUG: KASAN: global-out-of-bounds in __memcpy_toio+0x124/0x140
> > >  Read of size 1 at addr ffffffd35086e386 by task rmtfs/2392
> > >
> > >  CPU: 2 PID: 2392 Comm: rmtfs Tainted: G        W         5.16.0-rc1-lockdep+ #10
> > >  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> > >  Call trace:
> > >   dump_backtrace+0x0/0x410
> > >   show_stack+0x24/0x30
> > >   dump_stack_lvl+0x7c/0xa0
> > >   print_address_description+0x78/0x2bc
> > >   kasan_report+0x160/0x1a0
> > >   __asan_report_load1_noabort+0x44/0x50
> > >   __memcpy_toio+0x124/0x140
> > >   qcom_pil_info_store+0x298/0x358 [qcom_pil_info]
> > >   q6v5_start+0xdf0/0x12e0 [qcom_q6v5_mss]
> > >   rproc_start+0x178/0x3a0
> > >   rproc_boot+0x5f0/0xb90
> > >   state_store+0x78/0x1bc
> > >   dev_attr_store+0x70/0x90
> > >   sysfs_kf_write+0xf4/0x118
> > >   kernfs_fop_write_iter+0x208/0x300
> > >   vfs_write+0x55c/0x804
> > >   ksys_pwrite64+0xc8/0x134
> > >   __arm64_compat_sys_aarch32_pwrite64+0xc4/0xdc
> > >   invoke_syscall+0x78/0x20c
> > >   el0_svc_common+0x11c/0x1f0
> > >   do_el0_svc_compat+0x50/0x60
> > >   el0_svc_compat+0x5c/0xec
> > >   el0t_32_sync_handler+0xc0/0xf0
> > >   el0t_32_sync+0x1a4/0x1a8
> > >
> > >  The buggy address belongs to the variable:
> > >   .str.59+0x6/0xffffffffffffec80 [qcom_q6v5_mss]
> > >
> > >  Memory state around the buggy address:
> > >   ffffffd35086e280: 00 00 00 00 02 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
> > >   ffffffd35086e300: 00 02 f9 f9 f9 f9 f9 f9 00 00 00 06 f9 f9 f9 f9
> > >  >ffffffd35086e380: 06 f9 f9 f9 05 f9 f9 f9 00 00 00 00 00 06 f9 f9
> > >                     ^
> > >   ffffffd35086e400: f9 f9 f9 f9 01 f9 f9 f9 04 f9 f9 f9 00 00 01 f9
> > >   ffffffd35086e480: f9 f9 f9 f9 00 00 00 00 00 00 00 01 f9 f9 f9 f9
> > >
> > > Fixes: 549b67da660d ("remoteproc: qcom: Introduce helper to store pil info in IMEM")
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  drivers/remoteproc/qcom_pil_info.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
> > > index 7c007dd7b200..aca21560e20b 100644
> > > --- a/drivers/remoteproc/qcom_pil_info.c
> > > +++ b/drivers/remoteproc/qcom_pil_info.c
> > > @@ -104,7 +104,7 @@ int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
> > >         return -ENOMEM;
> > >
> > >  found_unused:
> > > -       memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
> > > +       memcpy_toio(entry, image, strnlen(image, PIL_RELOC_NAME_LEN));
> >
> > The above seems slightly sketchy...
> >
> > Let's say:
> >
> > image = "modem" (5 characters plus null termination)
> > PIL_RELOC_NAME_LEN = 8
> >
> > ...so strnlen(image, 8) = 5, right?
> > ...so we'll copy characters _not_ including the NULL termination.
> >
> > I guess that's OK as long as we're certain that the destination was
> > zero-initted, but maybe it would be better/safer to write:
> >
> > memcpy_toio(entry, image, strnlen(image, PIL_RELOC_NAME_LEN - 1) + 1);
> >
>
> Yes, I agree that it looks a little bit sketchy.
>
> But we have to assume that either there's remnants from the boot stages
> or perhaps remnants of stale data from before a reboot. Therefor I
> concluded as I wrote this that I had to memset() the entire region in
> qcom_pil_info_init(), so this is taken care of.

Ah, right! I had missed the memset_io() in qcom_pil_info_init()


> The region being zero-initialized is also a requirement for the
> conditional jump to "found_unused" based on !buf[0]...

OK, makes sense. Even though that's only checking the first character
we know that the whole thing must be zero-initted because we memset it
and never write it more than once. OK, you have me convinced.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
