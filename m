Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257684AA7B4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378878AbiBEIcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:32:08 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:42618 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbiBEIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:32:05 -0500
Received: by mail-ua1-f42.google.com with SMTP id e17so14679911uad.9;
        Sat, 05 Feb 2022 00:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YGDXhWoC0YDK4LN4ffYmnnoBIU82UZ+ZgHex0wJpV0=;
        b=UncjMw8rqY4UjHLo07WkzkBdCSnTOrfNQv0PISQI9WHY90YdCZm0595xuRp/8pUT6F
         Av40KqNEsbtUlDl6jGjXLit0+aDWWCkcpGiuzpP31QQYLfRKbG1mZgkc2JweVviP3m/W
         Mpn4t5FUv+0uH+lez2d0cJjUF8Z5t9MLIIWj78fhxL0lf07W+1/4lkG0R//umphWYbv5
         /FV27L/nm52kX9Ih0PS2vpDUrg5H/gTg378xgKfyTcUksZYw4XNmdFYbKe2fhJ6I95kp
         igOoT/pKQJEBuY3VCaO3WyoiyNu+os8U8tAxbpiTZwbDR6LXv58+S7mFCxwdGLHbPtmO
         QMkg==
X-Gm-Message-State: AOAM530wLwwginW4T8y4k0zJ3XKIGhx+Mfd0gOVAmcBqtHtxx4xuqnhq
        TkiW4A4N2urqzacp5v0uOfM1wjy2KElHFQ==
X-Google-Smtp-Source: ABdhPJy7ZLCm1kKQr1s9QL09MgO6qIPHGSmkklGiAIjhqlHgQpBqjv19XbQW/j31Ag9ZvWyQ3QDkeA==
X-Received: by 2002:ab0:5a70:: with SMTP id m45mr918793uad.84.1644049924889;
        Sat, 05 Feb 2022 00:32:04 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 10sm1515017uaq.9.2022.02.05.00.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 00:32:04 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id v5so3712575uam.3;
        Sat, 05 Feb 2022 00:32:04 -0800 (PST)
X-Received: by 2002:ab0:384c:: with SMTP id h12mr469698uaw.122.1644049923955;
 Sat, 05 Feb 2022 00:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20220128173006.1713210-1-geert@linux-m68k.org>
 <63c80eba-7c55-2a92-8078-c63cec3c9efb@gmail.com> <8913a0a2-9496-143c-18c2-f3023fd37ba0@gmail.com>
 <8d215dab-cd0f-452b-281b-f67c9324b53b@gmail.com>
In-Reply-To: <8d215dab-cd0f-452b-281b-f67c9324b53b@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 5 Feb 2022 09:31:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnkvSCHKt5ouZP7HrMBg7nPg7fjiio-KVJ7dehA=FwyQ@mail.gmail.com>
Message-ID: <CAMuHMdVnkvSCHKt5ouZP7HrMBg7nPg7fjiio-KVJ7dehA=FwyQ@mail.gmail.com>
Subject: Re: Regression in 5.17-rc1 on pata-falcon (was: Re: [PATCH] m68k: mm:
 Remove check for VM_IO to fix deferred I/O)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        Laibin Qiu <qiulaibin@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sat, Feb 5, 2022 at 1:04 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> commit 180dccb0dba4f5e84a4a70c1be1d34cbb6528b32 (blk-mq: fix tag_get
> wait task can't be awakened) does cause a regression on my m68k hardware
> test rig (m68k Falcon030, IDE disk attached through pata-falcon driver
> which does use polled IO instead of interrupts, so may be a little on
> the slow side).

> Bisection between v5.16 and v5.17-rc1 points to
> 180dccb0dba4f5e84a4a70c1be1d34cbb6528b32 as the culprit, which is
> corroborated by reverting that commit in v5.17-rc1 and booting as
> rapidly as before.

Now you know the culprit, it looks like several other people ran into this.
Does this fix help?
https://lore.kernel.org/all/1643040870.3bwvk3sis4.none@localhost/

It is commit 10825410b956dc1e ("blk-mq: Fix wrong wakeup
batch configuration which will cause hang") in v5.17-rc2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
