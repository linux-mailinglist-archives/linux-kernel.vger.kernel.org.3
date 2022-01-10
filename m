Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503EB48A1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbiAJVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbiAJVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:31:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831BDC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:31:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b13so5725085edn.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMStWYTxwVQaJhyJLae6t3+kMoMNGINbvb8xY3neOIA=;
        b=RJK9CS19sfnbMmdtWYqqmTO2hIF99alsdGsEpyVHVEUBRpibJULk/RKplq79VHg/q7
         6T/HpbgtqNtD5zfQJXao1BMv7sBp5Izw+BaNbRDW33RDryM8DXQYXXjsa9WGGO9vCSuZ
         IQXd0a940P9InsBz4RLmgppWGLz2MBym6mCL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMStWYTxwVQaJhyJLae6t3+kMoMNGINbvb8xY3neOIA=;
        b=ytVaMY7gsjZEnpajwpLB62cSbrN8ZzTqkvd41okwocrfGyGmsdwhxWR9j4/se+ELvQ
         2cc153dUz76vdTfZJjoq0pO5NSOZyTHp0tqLfBjmSq1Us12F3hXpaTrIUsZTE2SM8O+7
         EXglgmqoyXvLl6XPew3Qpj7GPfv+KQ+nzAOpwbyKUu6voJUiEd5ozYajVolmmaHO5I//
         9z7KEGRRm6Yd6kQ8V7ozweDQSYDcsxkRQhl2ceR+zxD8KLH4rnyNN/+e4WL8hrXv7+4V
         FiwLws+M5FoaoAHmO0h8odHzhEsaaphpRSDoiU6IM/oj6VQzK57OzG7JAjnHWARLc5PM
         JdnA==
X-Gm-Message-State: AOAM531yRhZkfQNZm/r2WN4W7c26b7o1mWu42+lStXvGQqo1BT/+M3ej
        7M+wo16MK+LjyzJZW448pGhjcIlTzUq/YWDIK0M=
X-Google-Smtp-Source: ABdhPJwpRsN44alk4AdIWsPg41HxM/xfjmAeqBIlBCDc/Bu11I9r/JlhXprj8iI073bT+aFpREcHvg==
X-Received: by 2002:a17:906:6a20:: with SMTP id qw32mr1173146ejc.724.1641850258701;
        Mon, 10 Jan 2022 13:30:58 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id d1sm2893597ejo.176.2022.01.10.13.30.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 13:30:57 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so267774wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:30:57 -0800 (PST)
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr20561566wmz.155.1641850257383;
 Mon, 10 Jan 2022 13:30:57 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
In-Reply-To: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 13:30:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
Message-ID: <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 10:12 PM Dave Airlie <airlied@gmail.com> wrote:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-01-07

Gaah. I merged things and it built cleanly, and I pushed it out.

But then I actually *booted* it, and that's not pretty.

It *works", but it's almost unusable because of random scanline
flickering.  I'm not sure how to explain it, but it's as if there
wasn't quite enough bandwidth on the scan-out, so you get these lines
of noise and/or shifted output. They are temporary - so the
framebuffer contents themselves is not damaged (although I don't know
how the compositor works - maybe the problem happens before scanout).

This is on the same Radeon device:

   49:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)

with dual 4k monitors.

Any idea?

                  Linus
