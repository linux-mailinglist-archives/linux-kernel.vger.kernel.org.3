Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC84951D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376824AbiATPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376718AbiATPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:53:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EABC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:53:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f21so30504608eds.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miHQqHvTi6uNk+KpO2ktO68R7ziuvLbIMJiH1uT6JE8=;
        b=WZU35Ix3qzzyvPEMn6FTozbA8yxxxJx/MgkNOS2Oo81IAotubCyzrFts+5kvBPnCXd
         CPwMXu6gwbAw4BlivOqh+M/w+E+Ld98tp5BwGQQ8l/sTnAdAOfgKB8+UdFeppa73c7ix
         W7AqZkyAzFIcr9qbNx4K8sxV+KXwB9CTJ2UK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miHQqHvTi6uNk+KpO2ktO68R7ziuvLbIMJiH1uT6JE8=;
        b=DRvknRRAujsJgYaekMBHsuYAUZlKaMPogTZDki7k8243c0J6p59yOVYBivat1bLRL+
         NyhmG0jLmi+w/OPbQR0SfYf4bbx81sqgmXantad+4B3o8SEzENpDQvdS42ZkR3fZSoWI
         ybGfXJBJ/Kg+SDolBP/qlp5LXoEhERI2W30L/vgmEvCL2Ubnc7LOlfJZwUuC9pIOyr1B
         UXiMCcbOx0ykS98vc7c71yMEquM2RCREIZXhQ+YgErJJNkf0UHgiF/iGmjWiDVkDY7Sw
         iJ64bDma1wf59KV3CtPpAiUh2Ku1BKwZmyOrCCA9eHuu0j7WEDk0OZAB4HkLi43c6nk5
         K07Q==
X-Gm-Message-State: AOAM533BtQ8yFYgvF8Om2zzLVp52zkabIsjWak4B51dMJBGcoTlwi4/U
        rqTbJO/V7WDkkhMg/GpCrEti2YS16MMOoL0J
X-Google-Smtp-Source: ABdhPJy6wvKQnWu7ruyax/iaq63LShaPb25eI8HLg7X1O13BfOU25cX+GflR3FedX+XiQ8hqaoZ4CA==
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr29814337ejy.530.1642693997955;
        Thu, 20 Jan 2022 07:53:17 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id d2sm1164368ejw.70.2022.01.20.07.53.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:53:17 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id c2so13045723wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:53:16 -0800 (PST)
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr20222060wrg.281.1642693995967;
 Thu, 20 Jan 2022 07:53:15 -0800 (PST)
MIME-Version: 1.0
References: <CAAH8bW_3mVqCxebkYeY0XKBfTAjPi1dtygCBEy4GpqvyeKAPqA@mail.gmail.com>
In-Reply-To: <CAAH8bW_3mVqCxebkYeY0XKBfTAjPi1dtygCBEy4GpqvyeKAPqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jan 2022 17:53:00 +0200
X-Gmail-Original-Message-ID: <CAHk-=whc9DAJN-TWPTnw=bSjHwXk1zDGeJ9A8eniaK7Jfax5aQ@mail.gmail.com>
Message-ID: <CAHk-=whc9DAJN-TWPTnw=bSjHwXk1zDGeJ9A8eniaK7Jfax5aQ@mail.gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for 5.17-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dennis Zhou <dennis@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-mm <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 7:10 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> bitmap patches for 5.17-rc1
>
> Hi Linus, please pull these patches for bitmap. They were supposed to
> be pulled in 5.16 cycle, but due to merge glitch we decided to merge them
> in 5.17.

So I'm looking at this pull request that changes quite a bit of random
files, and some rather core headers, and I see *no* actual explanation
for what this pull request does and why I should pull it.

Only a "we didn't do it last cycle, so we should do it now". That's
not much of an argument.  If anything, it makes me go "there was
something wrong with it last time".

I can look at the commits (and I did), but that's really not how this
is all supposed to work.

When I _do_ look at the commits, one thing that stands out is how this
was all appears to be rebased after the merge window opened (just
minutes before you sent the pull request, I suspect).

Which is *also* not how things are supposed to work.

I also don't have your pgp key (not your fault - pgp key distribution
is broken because keyservers are broken) and I haven't pulled from you
before. That all just makes this pull request something where I think
it's all likely good, but there are enough problems that I haven't
actually pulled it.

Put another way: the contents do not appear _wrong_ per se, but there
are many things in this pull request that keep me from actually doing
the pull..

                   Linus
