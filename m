Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4EA4942D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357528AbiASWKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiASWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:10:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A909C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:10:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so8895233wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szrglUOKoAQRQL02i1H7q+pkp1ayvzmklTL6wOVwT/s=;
        b=b/pjhf7Ufhd6sE/TL9wGfVLA8ZUgCb4fxEU2pBxi6qcW+J9nNVdu+RuhHHHS5i8zun
         0UzK40qMKlHBZtAEIq9sg4hml/8YIpHn0e8JZDScCaLTNbdSCLGQ2iFy32/ieCbO3Ygy
         846sJwvKK8FsuQcPKxqLm9pu97Hp0MfAr+/xPs78yE9QJvES1YAq6zHnNv9wbcihgrmx
         yyRcyZP2qObq1RATKm9rENCkHWmMySdaL9h9rQQKhlXItbHbwr+Or24AxSo2ulouHhG2
         PZZkeFn/JlxaTyP8JF31uB3fthgI/3V4qWIpBikxYCpnkcbBu7lnEaZaMTkLfTEecZnk
         Lpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szrglUOKoAQRQL02i1H7q+pkp1ayvzmklTL6wOVwT/s=;
        b=JZI6DJCppqgzZEGMlaQ0nwRQbvfwWhHRR7lqGA52ysIaa8mM1GBPn7PSaohUX6wDyJ
         NvqGgxJYImnp8XKesOQvHURhesjGZKFAsNmRPkGI2AQBsZaKNqSfsdXxrOjFoEmaxq9q
         Mlpg7PbEuTCqYbcZlHob5SdS3PHt24W6bFSgBeQl8NOsvy+0H1Y73INqERAgF1CAKIbm
         S4Py/+i0Sy49F2nltmtKUtcq8yUTEzkUBGUkSqq+78fDU3qEzTnhiX18P2mugaL6x0Am
         2lS9bBBmgld4oVM1xbaU50qMg+9Ap37EzHjeCMsWQCRpY9sCWbCvAGqyD9C2x6nG7BU8
         b0Gg==
X-Gm-Message-State: AOAM530IDmxvbgNpPWbmCA0fsgwfhtDFA4lFfNeBzRql2ZKMTwRApRvL
        wsN7DFoQKWDq/f/LxPNN/bYufxp7omicaqRD6dhnIg==
X-Google-Smtp-Source: ABdhPJzGbBUyj7EUYRylWYsQVSn/4u8jYvtro1LgzSOuaaZyieN2jbCY5DvUbQg+W+oh8ulm700AcEz33UFd0c0H6BI=
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr20621093wrz.500.1642630215593;
 Wed, 19 Jan 2022 14:10:15 -0800 (PST)
MIME-Version: 1.0
References: <202201170247.Cir3moOM-lkp@intel.com> <CAJHvVchPpphLefKEOy_C6+0xrGtA3mNCBzQZ3j2i2RgXX3arXQ@mail.gmail.com>
 <CAJuCfpFEfAxtgCfTU=0Ry6g6c-O4OJypGyE-0M+Ce0TKVSAYqA@mail.gmail.com> <CAJHvVciZpSBcQDbqbvwbToo5s2_Q5H2sfr=QAb9UBBWpnD5X-w@mail.gmail.com>
In-Reply-To: <CAJHvVciZpSBcQDbqbvwbToo5s2_Q5H2sfr=QAb9UBBWpnD5X-w@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 19 Jan 2022 14:10:04 -0800
Message-ID: <CAC_TJvc5PwnB5L==4yoXDYeG9g-MKx6Oqb7ghG9gDGqaYEmdYw@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 6517/9999] fs/userfaultfd.c:1519:9: warning: variable 'ioctls_out' set but
 not used
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 2:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> On Wed, Jan 19, 2022 at 1:19 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Jan 19, 2022 at 12:39 PM Axel Rasmussen
> > <axelrasmussen@google.com> wrote:
> > >
> > > Lokesh, I only spent a few moments looking, but my suspicion is that
> > > this is the result of an incomplete backport of these patches to the
> > > Android kernel?
> > >
> > > The UFFDIO_CONTINUE patches introduced ioctls_out since the
> > > computation of it got more complicated, and those same patches also
> > > modified the put_user() on line 1533 here to use ioctls_out. I think
> > > Android backported the first part, but left out the second?
> >
> > The backport https://android-review.googlesource.com/c/kernel/common/+/1652718
> > looks like a mixture of
> > 14819305e09fe4 ("userfaultfd: wp: declare _UFFDIO_WRITEPROTECT
> > conditionally") and f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE
> > ioctl").
> > Not sure why it was done this way, maybe to minimize code changes
> > while backporting.
> > Simplest fix is probably to add __maybe_unused to ioctls_out declaration.
>
> Unfortunately, that doesn't quite do it. That would fix the warning,
> but the code in the original e-mail is still wrong: we incorrectly
> don't report the _UFFDIO_CONTINUE bit, unless we use the value we
> computed in ioctls_out.

I think what happened is that Axel's patch [1] depends on the patch
from Peter [2]. [1] was backported without the dependency and the
conflict resolutions aren't quite correct.

[1] https://lore.kernel.org/lkml/20210301222728.176417-5-axelrasmussen@google.com/
[2] https://lore.kernel.org/lkml/20200220163112.11409-18-peterx@redhat.com/

- Kalesh
