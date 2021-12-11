Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4555C47155D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhLKSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhLKSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:38:43 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E54C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 10:38:43 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 14so13976172ioe.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5p3GJXSJ4l1Ge129QsL/p+gQMy3VOuyRrx3Fb3Lj0Z0=;
        b=bfBrgMgSUp3u8RSBZmqpH3U+1VTInLj4TNrA/kTb1ublTptkIw9/KBHZeRPyLwgCrl
         sJQ768kqEnH6q+Oo2WzZDNPqeaezxDmJe08DhAN1pJTv/TI/wKUP0DlaYID4o1LaM8L8
         /p0u+/vNpUgL1ki+a7G9VuIf4Mpr9UFCeZ1gCVaTqlbefMCs50RfhElwbcK1N935KBK/
         BIny7N8qY2WXJEJFAEagDInHhki8e+ariXXZJnJE6kMWBpLNpLorteJSPpnoc2edlsWT
         fgrTAOgbNBa/ocD18s27E+1W3gHXwYXoD5iDjsc5+zp8W5zrradXCesvoGhRkefcAurY
         NT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5p3GJXSJ4l1Ge129QsL/p+gQMy3VOuyRrx3Fb3Lj0Z0=;
        b=Yx4BlINVowSQ16fVoRJIevxHe6Y+tJpdaIbDyYxuB0lw+cAT+dMt+LaWmUbOyzd31q
         4mg6UM0RKIYgz3oftcZVuvuJld49rvaCbGglHcjv1p8yPcttGBJQs7Xhu6sB+rvUXLoE
         DL6Txsz5ZNKr3YU53K6jPkoyT6J08eeeXMuffiCpTgs4Yb+bXyWkF2RKSex0FDHNLGiJ
         uTB5eeh1IbgSRF+dsvHj2wyvP3h8VhF/ov7F0vS7wm7CBXiTmUkJHfLvrjqQ+FKu75cc
         tvQ8w9e9Um4EYyKlNDE1UodqIFrVLl+KrhvuBczWIQSwZGU94d5SybChILlyhv11J9h3
         FcLg==
X-Gm-Message-State: AOAM533EmNEOElyD7Vg0q6ndCJBrOnnVR2FctnZNIYFgblJbB2HuB+D8
        lsiQ+clHOCYWy4EV492jTwTA04MNQOMQKOWJP2ua99sJIKfFnQ==
X-Google-Smtp-Source: ABdhPJwOLryi+Vt3XTHfOqRA0l+DWHue39abogkIdE2spUESv3XdJv+edxkknI+iJ2ocSOo2lj0XMfneEf7QmW5Ysm4=
X-Received: by 2002:a02:cb8f:: with SMTP id u15mr25374083jap.131.1639247922540;
 Sat, 11 Dec 2021 10:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20211210221033.912430-1-cmirabil@redhat.com> <20211210221033.912430-4-cmirabil@redhat.com>
In-Reply-To: <20211210221033.912430-4-cmirabil@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 11 Dec 2021 19:38:31 +0100
Message-ID: <CANiq72=3jtTn97Kkh1LBhrM4Kcs76b-SZnJ3=b+bNjX-BQM6vw@mail.gmail.com>
Subject: Re: [PATCH V5 3/6] drivers/auxdisplay: sensehat: Raspberry Pi Sense
 HAT display driver
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        fedora-rpi@googlegroups.com, Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles, Mwesigwa, Joel, Serge,

On Fri, Dec 10, 2021 at 11:11 PM Charles Mirabile <cmirabil@redhat.com> wrote:
>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

The "submitting author" should be the last one, i.e.:

Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>

> +config SENSEHAT_DISPLAY
> +       tristate "Raspberry pi Sense HAT display driver"

pi -> Pi

> +static int sensehat_update_display(struct sensehat *sensehat);

Can the function be directly defined instead?

> +       if (*f_pos >= VMEM_SIZE)
> +               return 0;
> +       if (*f_pos + count > VMEM_SIZE)
> +               count = VMEM_SIZE - *f_pos;

`min` / `min_t`?

> +       if (ret < 0)
> +               dev_err(sensehat->dev,
> +                       "Update to 8x8 LED matrix display failed");

Could this happen a lot of times? Is it expected to happen under some
condition or should never happen?

Cheers,
Miguel
