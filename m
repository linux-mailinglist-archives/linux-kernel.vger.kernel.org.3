Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4E4F8C36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiDHCAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDHCAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:00:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FBF63C3;
        Thu,  7 Apr 2022 18:58:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so6665088plh.1;
        Thu, 07 Apr 2022 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDV7vyVJua5x627okL/E8Nxi+qH90boTSsIqmiOxLwI=;
        b=bLbexJ08nK+TWPoYlGxZS1ziMwfEiNM87Hlc5Aqszi3h8/f4qux0ng/XTX6ol5mTaA
         H39eWUpuBI9MAYKqMhrxBkAJXd52jvhwp24o4jqVANR7oNkQyNLbPtpOD6TtXAPtRsot
         tIH7+M+u8k5IeGu584A4sF9KCmBn1U3AgmNw0A2vw4VlZ88ynwh2bf0eafSvudh3JkIS
         wDu5j/BMfPTn8yrUGJkMLGFOl5PkBfsD/iH+TJo0R+MOzqC24PSr+HmDAwfKYIly7Lpj
         3OQSIPP6arO/QbH6GuLkzGcBkdH5LD2+lWvUxI/SAW0qm0T/fcc5hgoCMF5pzDBHwGPx
         OBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDV7vyVJua5x627okL/E8Nxi+qH90boTSsIqmiOxLwI=;
        b=XjdMjyJ+i9NxTg4QLTqN3U37p3GGb9L4XrTl4lrzMXzVWEo83Q0kviQyz5/J/d4D3E
         8f8v6YeJctmjFjgver1quvJo6GuQcCYiRd2kJfg/Hg8Rvf8h/KF0SjEKbXSVGbdDORfK
         joqo+5Txt3ibwJGupgEAh75Ss4XY/N/B3WBtmTUPVTCcYTVhdACBdXDtDEiDDaHR0KpL
         s+Z3/jJH/EJ0V7mqCA6fo9s02+vYUII8UtUP019HDFLNcZ4lvUi4tYlHCnXti8Fg4FzS
         iv5jhraTVwtuQLmZz6Tz/6oRWkNHd3ZAR1LlAtUgzIEF3GmOIj74EJ3HPyFxLanPoVWd
         v7pw==
X-Gm-Message-State: AOAM531tVwPfUVi/Q0Y5TqIWVn9e80Hqjk0IHgnm/pavsOQUNJ9GzWeh
        gTVFUAAcjpHs3eYKDBz8PMbKyY3wCcwmyMBaRn4RDMM9gNSw
X-Google-Smtp-Source: ABdhPJx0eXbtrpr/r855v08vuUbK+sfYFO73JqWyYf8oavJH3sMjVil0MSKbotkscRuus74X4yjHtAw2IjvhwhIT/L4=
X-Received: by 2002:a17:90a:5407:b0:1bf:43ce:f11b with SMTP id
 z7-20020a17090a540700b001bf43cef11bmr19285418pjh.31.1649383101050; Thu, 07
 Apr 2022 18:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220404084723.79089-1-zheyuma97@gmail.com> <20220404084723.79089-2-zheyuma97@gmail.com>
 <eb2edc5a-afad-f0c9-012f-9b9f226d2e5a@gmx.de>
In-Reply-To: <eb2edc5a-afad-f0c9-012f-9b9f226d2e5a@gmx.de>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 8 Apr 2022 09:58:10 +0800
Message-ID: <CAMhUBjmm6ADp2Fr89CCQNX5FnhmBBrwFE0EQ3sq7CLER0J3ZEg@mail.gmail.com>
Subject: Re: [PATCH 1/7] video: fbdev: i740fb: Error out if 'pixclock' equals zero
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 3:50 AM Helge Deller <deller@gmx.de> wrote:
>
> On 4/4/22 10:47, Zheyu Ma wrote:
> > The userspace program could pass any values to the driver through
> > ioctl() interface. If the driver doesn't check the value of 'pixclock',
> > it may cause divide error.
> >
> > Fix this by checking whether 'pixclock' is zero in the function
> > i740fb_check_var().
> >
> > The following log reveals it:
> >
> > divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> > RIP: 0010:i740fb_decode_var drivers/video/fbdev/i740fb.c:444 [inline]
> > RIP: 0010:i740fb_set_par+0x272f/0x3bb0 drivers/video/fbdev/i740fb.c:739
> > Call Trace:
> >     fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1036
> >     do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1112
> >     fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1191
> >     vfs_ioctl fs/ioctl.c:51 [inline]
> >     __do_sys_ioctl fs/ioctl.c:874 [inline]
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>
> Hello Zheyu,
>
> I've applied the patches #2-#7 of this series, but left
> out this specific patch (for now).
> As discussed on the mailing list we can try to come up with a
> better fix (to round up the pixclock when it's invalid).
> If not, I will apply this one later.

I'm also looking forward to a more appropriate patch for this driver!

Thanks,
Zheyu Ma
