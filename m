Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53133470FB5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbhLKBFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhLKBFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:05:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54ECC061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:02:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v1so35406126edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+VYFSYnNeYGBOmVHlMou1aZLKIUgry0C9z0rOqYiUo=;
        b=hBPjcKrHywCdnQahr7+PHO+sZ6ZD2XFQEomAabeUBUfyhJqlXWbQB7CA7MxuDhUhoy
         +MWMFvPNe+y0KpYFTs/xVu770Ge0QAod5sGcqZ3OcOplCF4PH/64mpWUqVKhngWtp1l4
         PxhZODtRNeuU2UW3I9R1uMliTXVYIVdafm738=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+VYFSYnNeYGBOmVHlMou1aZLKIUgry0C9z0rOqYiUo=;
        b=uhfgRceWM2EDBmaPb2G6JRpp7mwQ2cqy3f5okiwNW7veB0QyVZvjGTc1pRo/FnXq3l
         l/rcGKEpAvR00uBmo7bDQebpfP372WKXMDS0gGZld8o+mmuNU2Vr5AjM+5BriaS+Yp9t
         mq7x4h5xPUj4+Qq8FcivzzOonWSRgRgOLkv6YmIvdXzBj1eKFDKnwTiEjv9rpMof1hUD
         gxbeX+WJSKQlIoTLqZSuab8TV1CZMqR9THFHWGtkKlbCK0pqPYX52Bb+K3bQ/skE0OaY
         hz5liK3xNQJyf8OOmn0vrAaBix3K3bQHJBeQsyUpYISY0pas5MgUgQbjYuBg0RzNa+fh
         aveQ==
X-Gm-Message-State: AOAM532D34Yj4m8P4dQgO9zrh2dFKqgS8RgampmdMUx3JPX4JQ/AUp0T
        UfzWLrc1gxT1T+ZXA/E3PA7H12teLNX6j2wTemc=
X-Google-Smtp-Source: ABdhPJyA66Jct1nfQdyv8tdqAV18EFZiJFDyDpnQvi99s1JCzF2tb57nyo+5ldnnqHIBR4UhmnMVYw==
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr42895520edw.346.1639184536119;
        Fri, 10 Dec 2021 17:02:16 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id t5sm2180313edd.68.2021.12.10.17.02.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 17:02:15 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso10213190wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:02:15 -0800 (PST)
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr20417181wmg.152.1639184534965;
 Fri, 10 Dec 2021 17:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
 <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
 <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com> <CAG48ez2YE08+vo+E+ZtxeikN4vVCJC+-BrWJUYWb0f0vRA0Uug@mail.gmail.com>
In-Reply-To: <CAG48ez2YE08+vo+E+ZtxeikN4vVCJC+-BrWJUYWb0f0vRA0Uug@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 17:01:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7Ymejr65Skmxgz12cou44uGhO1YWGoYRYrQTKC5AeYA@mail.gmail.com>
Message-ID: <CAHk-=wh7Ymejr65Skmxgz12cou44uGhO1YWGoYRYrQTKC5AeYA@mail.gmail.com>
Subject: Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Jann Horn <jannh@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 3:30 PM Jann Horn <jannh@google.com> wrote:
>
> One nit: The original implementation is using rcu_dereference_raw()
> because it can run in different contexts, but here plain
> rcu_dereference() would probably be more appropriate?

Well, I actually did that somewhat on purpose.

The RCU locking is right there, so doing the checking seems pointless.

That's particularly true since the whole point of the patch was "this
is truly critical, let's rewrite it to generate basically perfect
code"..

                 Linus
