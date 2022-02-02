Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC94A6E98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbiBBKW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiBBKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:22:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A047C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E657361582
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 10:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA49C340F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643797377;
        bh=1g6pR90DmE3D5PkPmqUdmdNaw8tNm6G02ZzFamE9Lq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tXVLUGDjsHzDsLHY+60iVaFROuDIexO8Tdmj1lPfp0poEbqCkf7x2jysCo07Mip8S
         5Z2OHVBFuNjWZLHGT5TJiOCA+Kv3JgFzO6DODYSJk39SU22K6MnwlrciGuMcfQBZgG
         VaR8EWw5LNIrqcy72TR13b764tjZYUq1dj6eLzwmfGomNzhu5BoyiAO1A3tHuPdj3c
         yw4MKgyE572mwdpe7Zoz5xa26OBiZg/rk5nqSFaZ7OM+cpKougl0f8vFMrTwiOXBWn
         DyYkPQdU97Akl+8ZUJ2b2COITg8tdljZ8z4MfzrsOmqzyKfgp4F/ynChX/td5cR6M3
         eyvzuyLG/XShQ==
Received: by mail-yb1-f174.google.com with SMTP id p5so59323271ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 02:22:57 -0800 (PST)
X-Gm-Message-State: AOAM530ajUSrI2HAhKvF7vnmbpc/7Si+aGEdNKy8/R48ySh9rad8Jztq
        NpCphS/NBHLq/Yyu6WUg1gZst51JrGrort4iLoA=
X-Google-Smtp-Source: ABdhPJwOhaLNVtCeH3jNGjEAiM4abeBok+LcUMR8mhQccCnrqyHO2Ut/4K44nDupwwdSL/sodkR/MCDd5hxtkfnO9mk=
X-Received: by 2002:a5b:48:: with SMTP id e8mr29816093ybp.64.1643797376434;
 Wed, 02 Feb 2022 02:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20220201172424.3509544-1-jordy@pwning.systems> <CAFCwf12sExpnsBDZX+ay6KKQ1RXoS470a2X_SOUM9KOUwXH4=g@mail.gmail.com>
In-Reply-To: <CAFCwf12sExpnsBDZX+ay6KKQ1RXoS470a2X_SOUM9KOUwXH4=g@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 2 Feb 2022 12:22:29 +0200
X-Gmail-Original-Message-ID: <CAFCwf12QygXk=8WbH9qDhyyqKY6ZGVCUSJM93viQ0armc8dgfg@mail.gmail.com>
Message-ID: <CAFCwf12QygXk=8WbH9qDhyyqKY6ZGVCUSJM93viQ0armc8dgfg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix potential spectre v1 gadgets
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>, Koby Elbaz <kelbaz@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Sagiv Ozeri <sozeri@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 9:50 AM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Tue, Feb 1, 2022 at 7:25 PM Jordy Zomer <jordy@pwning.systems> wrote:
> >
> > It appears like nr could be a Spectre v1 gadget as it's supplied by a
> > user and used as an array index. Prevent the contents
> > of kernel memory from being leaked to userspace via speculative
> > execution by using array_index_nospec.
> >
> > Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> > ---
> >  drivers/misc/habanalabs/common/habanalabs_ioctl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> > index 3ba3a8ffda3e..c1cdf712a10d 100644
> > --- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> > +++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/slab.h>
> > +#include <linux/nospec.h>
> >
> >  static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
> >         [HL_DEBUG_OP_ETR] = sizeof(struct hl_debug_params_etr),
> > @@ -849,6 +850,7 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >         }
> >
> >         if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
> > +               nr = array_index_nospec(nr, HL_COMMAND_END-1);
This needs to be HL_COMMAND_END.
The pattern (as described in array_index_nospec comment) is
if (index < size) {
        index = array_index_nospec(index, size);
        val = array[index];
}

When you do -1, it misses the last value which causes that ioctl to
get rejected.

> >                 ioctl = &hl_ioctls[nr];
> >         } else {
> >                 dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
> > @@ -872,6 +874,7 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
> >         }
> >
> >         if (nr == _IOC_NR(HL_IOCTL_INFO)) {
> > +               nr = array_index_nospec(nr, _IOC_NR(HL_IOCTL_INFO));
same here, it should be _IOC_NR(HL_IOCTL_INFO) + 1

Thanks,
Oded

> >                 ioctl = &hl_ioctls_control[nr];
> >         } else {
> >                 dev_err(hdev->dev_ctrl, "invalid ioctl: pid=%d, nr=0x%02x\n",
> > --
> > 2.27.0
> >
>
> Thanks for the patch.
> I'm going to run this through our CI and if nothing breaks I'll merge
> it to our -next branch.
>
> Oded
