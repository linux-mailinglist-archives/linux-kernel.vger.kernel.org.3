Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2505C48A4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbiAKBV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiAKBV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:21:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F8C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:21:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i5so7296553edf.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VghT5Vb1bGkkfuhJyJBbYpfymLiEG6YlV0Ofo+lXSRs=;
        b=CuoC1S5DPEPzxhaI/t/Zt5/7ZnredBXUx63/7QgMSrKdR6dU+kjwkn5e4Y9dVXNX5l
         Vo7r+EcjrjXKC7eYS94RpKiX0PkhEoqLxQYqUn0fSn6sOhYsh649ExJNudF9PbHfqlwH
         HhetD8jit7LuyHbRhw8nh7NJ4t8W84qHpTvYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VghT5Vb1bGkkfuhJyJBbYpfymLiEG6YlV0Ofo+lXSRs=;
        b=W+PaNIP0AGKU/cmOP11EPegKMRcXICQ4KPGweQF46XuipsZ6N2FmfEAP2PJ9uu7UiF
         VbWaVys8GVKzFTzAhNjzUStfTaJ5yf8QXrXa87lcDnZVzn7pyoAVy83vexmUqN3Lqybm
         /gMIwjSkuO1tL22pQ8iIjhj9cmgup0Bv40qiMfZRkEgvMHVOyrP+8vrUtjCbVt8QnSRD
         ZW0KlFhYS56ZCUKeLMZ/l7UN204pKFC3jZ3PkzQHxZJ/sylmkZ7CfodbY25oDxPP8sqE
         /gejB2xjsmWyGA6sltnsz6Yx7vf33+piDlrU7lA2UNu+CZ2ooUyqtDruFl4v5GGY0iOl
         v4FA==
X-Gm-Message-State: AOAM5309NtzMt9D/Y6u07LJT2fE02ChveqlHDcTi2fT5aujlxNQ55o2P
        O1RgqvcL1izrkHhgQzWffq53ESXessWmRElBPls=
X-Google-Smtp-Source: ABdhPJwSqDpAjBIQZwMdyUV4GZ9CpzuD+BRnmlNKdmWuJho5ecOY4Tbrv4srVcP+Do2DWAdGWdQQFw==
X-Received: by 2002:a17:907:1b0d:: with SMTP id mp13mr1763714ejc.29.1641864086731;
        Mon, 10 Jan 2022 17:21:26 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id l9sm619018ejh.66.2022.01.10.17.21.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 17:21:25 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id v123so9978761wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:21:25 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr337592wmp.26.1641864085524;
 Mon, 10 Jan 2022 17:21:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com> <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
In-Reply-To: <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 17:21:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
Message-ID: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
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

On Mon, Jan 10, 2022 at 5:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> We are putting together a system to try and repro the issue.  Does it
> happen with a single monitor or only with two?

Nope. With a single monitor everything seems to look fine. And when I
plug in the second monitor, it immediately starts happening again.

It also seems to depend a bit on the screen contents - or possibly on
what else is going on. Hiding the browser window makes it happen less,
I think. But I suspect that's about "less gpu activity" than anything
else.

I'll see if I can bisect it at least partially.

                  Linus
