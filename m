Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5147957C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbhLQU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbhLQU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:29:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C5AC06173F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:29:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so12513214edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaFNELIHWLkYtxS9FFKaGccYxYikTbeuDKRkMvnLyI8=;
        b=QrR95jjjA5DtmjUr6mFxmIKgd/mtTLy/CxzdjUM08QWAD2GpaBBjiPP/+aK8nw4vLp
         R9K2jq6+gZXkk+m+/FkrT1sl4t+C7VQ1JiYlWxLtxwAZ+ZQm20oFc+linFWeEI6n4O1T
         oS2ZXHcs7KFJNvk5V0KAQtcQGVF+8ts+0xYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaFNELIHWLkYtxS9FFKaGccYxYikTbeuDKRkMvnLyI8=;
        b=yo5XnT2qwah75Xa75SuGlDh3GaJKlYyJzI1/KMWsgK5zj0JbG19w/jyp8r6o+66kpd
         UD9YVRxgKFBg8bha8MNJo5ZrUNtDdRB4tiZYLLr27zu83e73h7bemnQPefahsXQG6vnt
         7mrlM+nvGO7aZhwIiE17WIa2QsXi5isMuOpjjZsqLoaW1iRoHrbitwt+ZomWioLr+ODl
         5ytVoUy2QNFJLppLIVYIyakjJAo8ukFLcBCx+SBi5FSZqg4yE5JFwF352tvyNT62yCgm
         U0kkZItBWFA+aTCTnm8r+pf/n9AePkV8Z1qim8F9k09pxpm3R3q9RmfCDy7SyCZr+h87
         DaaA==
X-Gm-Message-State: AOAM532DuslFc/qCWSmBLhZncOuGoqbgS2PYtAe02FfpUalv7O4sfAwy
        KJu+eh+gjeuQAlYRJH8htTQbhlB9X3hknEty
X-Google-Smtp-Source: ABdhPJw7x+BT5TH3wi89Iv0Yxs9rsk8uHnS5miCP5ZZArgrDDkHt9vCkuXhGr9AfSgsPO/BPivgqJw==
X-Received: by 2002:a05:6402:34cf:: with SMTP id w15mr4302782edc.63.1639772942667;
        Fri, 17 Dec 2021 12:29:02 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id x16sm2551705ejs.92.2021.12.17.12.29.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:29:02 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so2271859wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:29:02 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr11004673wmq.8.1639772941784;
 Fri, 17 Dec 2021 12:29:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
In-Reply-To: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:28:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com>
Message-ID: <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#3)
To:     Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:02 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Another small SELinux fix for v5.16 to ensure that we don't block on
> memory allocations while holding a spinlock.  This passes all our
> tests without problem, please merge this for the next v5.16-rcX
> release.

Ugh, pulled.

GFP_NOWAIT can very easily fail, so I'm not convinced your tests would
catch any of the interesting cases.

There is only one single caller of the new
security_sb_mnt_opts_compat() callback, and I get the feeling that
maybe we could parse the options first - into a temporary new
superblock, and then at "test" time (when we're under that sb_lock) it
could compare that temporary sb with pre-existing ones?

That would also avoid the need for doing that mount option parsing
over and over and over again for each sb on the 'fs_supers' lists.

I've pulled this, bit it does smell bad to me, and I think that
original commit 69c4a42d72eb ("lsm,selinux: add new hook to compare
new mount to an existing mount") and ec1ade6a0448 ("nfs: account for
selinux security context when deciding to share superblock") may not
have been fully thought out.

It may have *looked* like just adding that check  to
'nfs_compare_super' was a simple and good idea, but it really doesn't
look great.

Adding a few more people to the cc.

                 Linus
