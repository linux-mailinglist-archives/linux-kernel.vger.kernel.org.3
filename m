Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02C4FAD00
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 11:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiDJJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiDJJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 05:04:27 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 300D06BDCD;
        Sun, 10 Apr 2022 02:02:17 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 7C4207A0310;
        Sun, 10 Apr 2022 11:02:15 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH 1/7] video: fbdev: i740fb: Error out if 'pixclock' equals zero
Date:   Sun, 10 Apr 2022 11:02:13 +0200
User-Agent: KMail/1.9.10
Cc:     Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220404084723.79089-1-zheyuma97@gmail.com> <eb2edc5a-afad-f0c9-012f-9b9f226d2e5a@gmx.de> <CAMhUBjmm6ADp2Fr89CCQNX5FnhmBBrwFE0EQ3sq7CLER0J3ZEg@mail.gmail.com>
In-Reply-To: <CAMhUBjmm6ADp2Fr89CCQNX5FnhmBBrwFE0EQ3sq7CLER0J3ZEg@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 3115
X-UID:  8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <202204101102.13505.linux@zary.sk>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 April 2022 03:58:10 Zheyu Ma wrote:
> On Fri, Apr 8, 2022 at 3:50 AM Helge Deller <deller@gmx.de> wrote:
> >
> > On 4/4/22 10:47, Zheyu Ma wrote:
> > > The userspace program could pass any values to the driver through
> > > ioctl() interface. If the driver doesn't check the value of 'pixclock',
> > > it may cause divide error.
> > >
> > > Fix this by checking whether 'pixclock' is zero in the function
> > > i740fb_check_var().
> > >
> > > The following log reveals it:
> > >
> > > divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> > > RIP: 0010:i740fb_decode_var drivers/video/fbdev/i740fb.c:444 [inline]
> > > RIP: 0010:i740fb_set_par+0x272f/0x3bb0 drivers/video/fbdev/i740fb.c:739
> > > Call Trace:
> > >     fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1036
> > >     do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1112
> > >     fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1191
> > >     vfs_ioctl fs/ioctl.c:51 [inline]
> > >     __do_sys_ioctl fs/ioctl.c:874 [inline]
> > >
> > > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> >
> > Hello Zheyu,
> >
> > I've applied the patches #2-#7 of this series, but left
> > out this specific patch (for now).
> > As discussed on the mailing list we can try to come up with a
> > better fix (to round up the pixclock when it's invalid).
> > If not, I will apply this one later.
> 
> I'm also looking forward to a more appropriate patch for this driver!

I was not able to reproduce it at first but finally found it: the monitor must be unplugged. If a valid EDID is present, fb_validate_mode() call in i740fb_check_var() will refuse zero pixclock.

Haven't found any obvious way to correct zero pixclock value. Most other drivers simply return -EINVAL.

> Thanks,
> Zheyu Ma
> 


-- 
Ondrej Zary
