Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5010746AF15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378355AbhLGA0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351473AbhLGA03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:26:29 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84235C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:23:00 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t19so24659732oij.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHt9iHR1qfyahnfWw3jM+F+mgEsMZEAm29A/1YTxn9M=;
        b=Pe+W1bKTR66qdYWTs/RYosSJx2clcU5dNwwx2WzmzEwo6mUVP/fF75kZLD4KxngWqg
         PiDdPFNVKz0YrzJgUXhmdXh8EBcVGj1oJZqqi31yEW9BzK7mMB7rfPQCqne6o13cruOt
         pbCn6CzYgD1auLZdW6HXidcNie1q7DaHE7U8ensJQzmllQhLhK1V8PcAk7XtenfE/qrV
         SZRllQbBOwa3v4nKbr1sMcA/5Ui0BKjnQ0mSeoMs3xdBIK2h1Pcey5JvHa5/QYQrKBrl
         XIBJOYVLrX0I0xA6pbCk6KnVLDxdBKvmvmfu89g7Jle77YUCTZE+v80hCB0qUPalJGr9
         7Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHt9iHR1qfyahnfWw3jM+F+mgEsMZEAm29A/1YTxn9M=;
        b=usMIhwW8Puk7ZU3AZosFCUnb28p1SowMQ1RhlVQFUkhCjNq35pZ0Emk111RSW5yoWF
         +Gc0mfPIeT93tH2g4oAIW5LYbYtwXNEcHjNiamFuNTOzIk96EiQI2NHOEz/fFF+CZFpu
         iTdSruGsvxIRvFKpcvMTgbFVTaHnEXTSe6tk+Zl0CPctENgo/w+QVQYJovXjmV4/pUoU
         9/wYbGwBN0jwVZmGMYU7ekWB0a20Fg9tKDJufxHEP8eg4O0S5HEnFFFJIDVGaxgh1VGs
         T8lBkxtGDO011PBSQzhPhVW/0Y/jlz06MwiV5Lx6qbRw0KT1K9tUhZ7I+7EGSSnL8iJe
         J9Ig==
X-Gm-Message-State: AOAM531H7khMsC1SDNmb6gDK/i/ibUNqlC5H1YLd1tc5L/+myoIklwIj
        72Y7ATgsVC3gxwO9AqBrTF/HxQ==
X-Google-Smtp-Source: ABdhPJzCBc6jyJVppQ+JUalPS2W8Z4sFH78vwuekb7YXv2W5T2dZgeMcrnFAZxidbjDZIVa+r86TTA==
X-Received: by 2002:a05:6808:1642:: with SMTP id az2mr2068680oib.179.1638836579748;
        Mon, 06 Dec 2021 16:22:59 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l9sm2358118oom.4.2021.12.06.16.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:22:59 -0800 (PST)
Date:   Mon, 6 Dec 2021 16:24:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: Don't memcpy_toio more than is provided
Message-ID: <Ya6pvF8VIwokzqjs@ripper>
References: <20211117065454.4142936-1-swboyd@chromium.org>
 <CAD=FV=XgV5=5mMuB5KbX38EFtZ6qxGGPMN6HFng_KJEc1KERxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XgV5=5mMuB5KbX38EFtZ6qxGGPMN6HFng_KJEc1KERxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Dec 16:01 PST 2021, Doug Anderson wrote:

> Hi,
> 
> On Tue, Nov 16, 2021 at 10:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > If the string passed into qcom_pil_info_store() isn't as long as
> > PIL_RELOC_NAME_LEN we'll try to copy the string assuming the length is
> > PIL_RELOC_NAME_LEN to the io space and go beyond the bounds of the
> > string. Let's only copy as many byes as the string is long, ignoring the
> > NUL terminator.
> >
> > This fixes the following KASAN error:
> >
> >  BUG: KASAN: global-out-of-bounds in __memcpy_toio+0x124/0x140
> >  Read of size 1 at addr ffffffd35086e386 by task rmtfs/2392
> >
> >  CPU: 2 PID: 2392 Comm: rmtfs Tainted: G        W         5.16.0-rc1-lockdep+ #10
> >  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> >  Call trace:
> >   dump_backtrace+0x0/0x410
> >   show_stack+0x24/0x30
> >   dump_stack_lvl+0x7c/0xa0
> >   print_address_description+0x78/0x2bc
> >   kasan_report+0x160/0x1a0
> >   __asan_report_load1_noabort+0x44/0x50
> >   __memcpy_toio+0x124/0x140
> >   qcom_pil_info_store+0x298/0x358 [qcom_pil_info]
> >   q6v5_start+0xdf0/0x12e0 [qcom_q6v5_mss]
> >   rproc_start+0x178/0x3a0
> >   rproc_boot+0x5f0/0xb90
> >   state_store+0x78/0x1bc
> >   dev_attr_store+0x70/0x90
> >   sysfs_kf_write+0xf4/0x118
> >   kernfs_fop_write_iter+0x208/0x300
> >   vfs_write+0x55c/0x804
> >   ksys_pwrite64+0xc8/0x134
> >   __arm64_compat_sys_aarch32_pwrite64+0xc4/0xdc
> >   invoke_syscall+0x78/0x20c
> >   el0_svc_common+0x11c/0x1f0
> >   do_el0_svc_compat+0x50/0x60
> >   el0_svc_compat+0x5c/0xec
> >   el0t_32_sync_handler+0xc0/0xf0
> >   el0t_32_sync+0x1a4/0x1a8
> >
> >  The buggy address belongs to the variable:
> >   .str.59+0x6/0xffffffffffffec80 [qcom_q6v5_mss]
> >
> >  Memory state around the buggy address:
> >   ffffffd35086e280: 00 00 00 00 02 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
> >   ffffffd35086e300: 00 02 f9 f9 f9 f9 f9 f9 00 00 00 06 f9 f9 f9 f9
> >  >ffffffd35086e380: 06 f9 f9 f9 05 f9 f9 f9 00 00 00 00 00 06 f9 f9
> >                     ^
> >   ffffffd35086e400: f9 f9 f9 f9 01 f9 f9 f9 04 f9 f9 f9 00 00 01 f9
> >   ffffffd35086e480: f9 f9 f9 f9 00 00 00 00 00 00 00 01 f9 f9 f9 f9
> >
> > Fixes: 549b67da660d ("remoteproc: qcom: Introduce helper to store pil info in IMEM")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/remoteproc/qcom_pil_info.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
> > index 7c007dd7b200..aca21560e20b 100644
> > --- a/drivers/remoteproc/qcom_pil_info.c
> > +++ b/drivers/remoteproc/qcom_pil_info.c
> > @@ -104,7 +104,7 @@ int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
> >         return -ENOMEM;
> >
> >  found_unused:
> > -       memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
> > +       memcpy_toio(entry, image, strnlen(image, PIL_RELOC_NAME_LEN));
> 
> The above seems slightly sketchy...
> 
> Let's say:
> 
> image = "modem" (5 characters plus null termination)
> PIL_RELOC_NAME_LEN = 8
> 
> ...so strnlen(image, 8) = 5, right?
> ...so we'll copy characters _not_ including the NULL termination.
> 
> I guess that's OK as long as we're certain that the destination was
> zero-initted, but maybe it would be better/safer to write:
> 
> memcpy_toio(entry, image, strnlen(image, PIL_RELOC_NAME_LEN - 1) + 1);
> 

Yes, I agree that it looks a little bit sketchy.

But we have to assume that either there's remnants from the boot stages
or perhaps remnants of stale data from before a reboot. Therefor I
concluded as I wrote this that I had to memset() the entire region in
qcom_pil_info_init(), so this is taken care of.

The region being zero-initialized is also a requirement for the
conditional jump to "found_unused" based on !buf[0]...

Regards,
Bjorn
