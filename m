Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BDA49C70B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiAZKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiAZKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:05:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E3C06161C;
        Wed, 26 Jan 2022 02:05:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id k25so37562920ejp.5;
        Wed, 26 Jan 2022 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIBPG5KdggrxdxTcsYEqUFW4Fhlz+KszjlvwSs+5dP8=;
        b=GM+KII2Zv2mUcviteB7pgK0Y9FBFJP2nO//R8vEVHLFufcw/LNeiZV4JarZZlqsYkZ
         typFLgdqp25CkKGspN+0DHGeN5GNkW+3DjPd4XTCHNHBY/e/I6gkmEN3GhUWqlSyGSGj
         Z8B5WazAgU42xBefblCAiNrg3WVNpF3jLD+DvUzBktRcVvkcg6eC9RdHkCs5+8edRKum
         Zrw2I70CN9r2Xef0xxX81h5fp4hrMHnprwD6oxttKhgbvmAZP3/2lGv1TWeIGgPTqozd
         pUsR807hVsRKG2taCPOQU2lv7WJ33Gld6uqElywbeadjRO+VmwV+MOYBV3CETS9ESn/r
         oLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIBPG5KdggrxdxTcsYEqUFW4Fhlz+KszjlvwSs+5dP8=;
        b=gva6oZagseaODRd1Ln3ndje9TFKBHSUByqckvpzWYIEDTOfJ1LAssLUJNRJcC5Tz+2
         wbbq/lrDG10cmgKbxas7iaA9hSQk2JiLXYUU75CnecPHUNyhZw2tA5wBxNczz67klj5w
         XGdZc1JvTrB3yNAL+DQMpxq/ptC9FHnfWV4ijbHA4i6xesH9FeXX9HhNooCiO9RUdPsP
         jYiu2ltQwWma9behbOGCVBeGrj6NfqWNkNM3nTbcbegOCY3eCi8dS5dhVEZYwrihXq+f
         lUfRcGhEooKHbGgvCZ3tMuz3SxLNubUaMy2n3aMDybAz8C6MZKHyz4+3Vei9WN8Rzqoo
         ZiZQ==
X-Gm-Message-State: AOAM533LDGOXdvTBshgf7HZSG97kT0w7t1LrR7JZU2WwCYtin4TlOlHk
        biVJG7u2c+4RQf0WBYlOfmboYXJumDNcyd6buH8=
X-Google-Smtp-Source: ABdhPJxLTWUKmHtcOeib3twEwVqJGJ4TxCtjycPib6a85lcs7VMVl7shvXiH79nfAsy8Iir3ilNC+ATyz+6Lrri68Ok=
X-Received: by 2002:a17:907:60d6:: with SMTP id hv22mr3480319ejc.132.1643191525022;
 Wed, 26 Jan 2022 02:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de> <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
In-Reply-To: <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Jan 2022 12:04:26 +0200
Message-ID: <CAHp75Vd7oaYPKx6bxjCqNnm6fieeQFrtq5K4YYrxYbXoXFy=+Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Carlis <zhangxuezhi1@yulong.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jan 26, 2022 at 10:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Am 25.01.22 um 21:21 schrieb Andy Shevchenko:

...

> > But why? We already have DRM drivers for some of these devices.
>
> No, we do not (only a few are available).

Sorry, I missed your word 'some'. Some == almost none from the list (I
don't remember exact numbers but something like 2 out of 10 are
supported by tiny DRM and see about interfaces).

-- 
With Best Regards,
Andy Shevchenko
