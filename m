Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4121248A50E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiAKB3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiAKB3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:29:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367EAC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:29:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i5so7349882edf.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvnMrqyyprPM82tM0QymR8SVUNtcjFg9kaau7vLVoys=;
        b=bJYuXFund9ha/pHIpixqe7ZULRG3XbPW/bwVA7ekt6FXGMxCxnXxW4Fckng6N5csqk
         CyQhn5VacnnVs0QpdCxP+hbBvwGfQp/bqct74HUPFt2EyD1c2GPpLFRq3POifHGPxFQr
         PP+TEmIue3otyL9vk0BEUmsF4uO6DbqkrFWHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvnMrqyyprPM82tM0QymR8SVUNtcjFg9kaau7vLVoys=;
        b=O7Pwv6IkzbuBTr9izkHTfdQWZ2hYRXTmaVk+C8k0GsAEPIdqD+FOfBd+l0LZ67tjQh
         JxB2bkTP95AVyesF8PZFdf2o95hBTB95Zs3Cw4PwQ5MNtmWCVbPgUCdCZ2E4LtF0LPvw
         giyhYhL9AMToYklIXj8K+cwvrLzAURzKFAw61MY1j9CHOaffUxt177runJt7yAhY/vUk
         0pw3kRQzQGyaiytQPDy/siKLt9fsGuGahomRFXOeDz/b5bH1TdreGXXfhreqsKnN0bX9
         SlhPSSxZAdm83u4isB7E/XO2T0Ks5bEtgI96vOvSgTrnG7L7gITGYhiZtcqVreN4kQ6n
         DT1Q==
X-Gm-Message-State: AOAM530PQWnZrIMW20F2bx4cjJjbi78PZ5XtB+RJRxc7xh3Qv6SUpjtx
        rz0fmrmJ3t8dFECS4vmlviU7B+6HkdyKnRN0su0=
X-Google-Smtp-Source: ABdhPJwpAHNPeiRac/Me75rVrQIZAE8JYsVSCJmE0Hlwqqj8LSLq5GXA5swij/kepDQP9KSiMVHGAw==
X-Received: by 2002:a05:6402:b58:: with SMTP id bx24mr2213820edb.414.1641864546695;
        Mon, 10 Jan 2022 17:29:06 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id n26sm4351300edy.96.2022.01.10.17.29.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 17:29:05 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so926970wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:29:05 -0800 (PST)
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr334541wmz.155.1641864544815;
 Mon, 10 Jan 2022 17:29:04 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com> <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 17:28:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9EQdO=gdgrajp03xNf6dtcE03oYucXmJJst0GgSs=VA@mail.gmail.com>
Message-ID: <CAHk-=wj9EQdO=gdgrajp03xNf6dtcE03oYucXmJJst0GgSs=VA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 5:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It also seems to depend a bit on the screen contents - or possibly on
> what else is going on. Hiding the browser window makes it happen less,
> I think. But I suspect that's about "less gpu activity" than anything
> else.

Actually, sometimes "more activity" makes it go away too. Moving a
window around wildly with the mouse makes it *stop* happen.

But moving the mouse over different elements of the screen - or
writing text in the web browser email window - seems to make it worse.

Funky.

It does "feel" to me like some bandwidth limitation, it has kind of
the same behavior that I remember from the bad old times when you were
pushing the video card past a resolution that it could really handle.

But that can't be the case, this card has had no problems with this before.

               Linus
