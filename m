Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929A3493719
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353019AbiASJU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352755AbiASJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:20:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136FC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:20:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z22so8060344edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrKLop8goJNAb7F3nsn024T54b0Rb1lNYvD3dS3QIUg=;
        b=IysqV66EW2ES4sCLHdqMGUXBEuQJc4fTU3SXkhhXKLiMJAWtXrH5G+5FT/Jm4oauK1
         OndgKqCg0VKgwrpn9LiBUfoANaWFs71Hu8FjcSLktWZFpxHzkgN4PdgqA7jeuFABJwhw
         AI3KoA629xhfoZN9ioXEHjbTTG8OtmtEmxIb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrKLop8goJNAb7F3nsn024T54b0Rb1lNYvD3dS3QIUg=;
        b=gJLDV+YGe1WMPqnT3ZU6BCf4scajScHoBScVKrkGI7JV11VVccbT4+p9kPKZ2HqBR3
         8OE0r7JqGs6TLA2GZ1nGBLowUXeAdHoft62NbU5iRW0W2xfrxc0y5Bz9l06rM8aVe809
         gGzTLsl1f9UblQYiyT7Ph1/szxVMaNzlBaFtBYdzr2ci1XElhaFA1IBOSaB3RGkNdcn9
         8IRP90eySgdIS5Il6ATuv8HbaXt+1NIZThDScQ17IarR1Rz7N6Qspgo7GKa8BndtfVqC
         /0wRkQhgYSWrXwRf7wjDVkYymHyXPSfV4CfynlFnZh8SsVwp8VREtRD40pXD3YjuYfMD
         JPkg==
X-Gm-Message-State: AOAM531BDkRRW7lJWSLZgHO5A6ZCSmt7kQh1ERrmHnd1HcjZYUoqTBDN
        Af+Pcvl9uqtjmjPUvTsT4T0lj/KG1c13yZJ18gw=
X-Google-Smtp-Source: ABdhPJxja0fUzwvLzt+AtxFc8CGANqUwEO7eM+NHLAUywlmMjxKeRD+cyW8N/0AgWxrnk037PANwSw==
X-Received: by 2002:a17:906:5d05:: with SMTP id g5mr23681005ejt.61.1642584023847;
        Wed, 19 Jan 2022 01:20:23 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id qa35sm6112220ejc.67.2022.01.19.01.20.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 01:20:23 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id v123so4004788wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:20:23 -0800 (PST)
X-Received: by 2002:a5d:5582:: with SMTP id i2mr3756654wrv.442.1642584022918;
 Wed, 19 Jan 2022 01:20:22 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAShL3dfQ0Ter2avCvGPjrd0YTJau-S4+8rJyWXmu0tG0Q@mail.gmail.com>
In-Reply-To: <CAK7LNAShL3dfQ0Ter2avCvGPjrd0YTJau-S4+8rJyWXmu0tG0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jan 2022 11:20:06 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiizVi7p_VbaXgKxSne9fAEqNR8F_ivx95_2mkGOxxPqg@mail.gmail.com>
Message-ID: <CAHk-=wiizVi7p_VbaXgKxSne9fAEqNR8F_ivx95_2mkGOxxPqg@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v5.17-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 9:43 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> You will see a trivial conflict in scripts/link-vmlinux.sh
> (commit 72b3942a173c in the mainline
> vs 7d153696e5db from this PR)
> The fix is available in linux-next.

The resolution in linux-next seems to be wrong.

It missed a new case of

        if [ -n "${CONFIG_SLS}" ]; then

in scripts/link-vmlinux.sh, which no longer works after commit
7d153696e5db ("kbuild: do not include include/config/auto.conf from
shell scripts").

That needed to be converted to

        if is_enabled CONFIG_SLS; then

too.

I think that was the only case. Knock wood.

             Linus
