Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DB447B0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhLTQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhLTQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:21:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F305FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:21:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so13312747edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxAt0bfr/H0QS/HJ9br3P24OWShNSRoA32oX8zvXLR4=;
        b=Lbr7ibJTUG+4o3FhoPZb8emxESmevKlCt+g/wLXaQMH3UeSYCfMO5xRcrbUSMV8MG+
         jBTMcFzlqEIQs1ZgjftYdf5BG1jlzUIDNr0h624CSGYZj0qXOgMxgf0asXX1t6OO3MC+
         zF/FOyDzXzHSfWgWksGLYGbMYZksRi4iFpgdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxAt0bfr/H0QS/HJ9br3P24OWShNSRoA32oX8zvXLR4=;
        b=hqa14aoYo2ZhvyIv7mkaeGFUNY808lB3A3WAgxxV96vmSoxgXcG4ct+RMC665AS4R0
         BnP4D3II7TrQCIHJKuA+hvLm/QS/wrEBepQnADdoLxRWwGkzOhnXtypy0Y7VzBuGYW9P
         oHXgiC0B5kNGp4p4UU1XVd8pEgRmuXhmOgh2Of1308plhGRn8wHMDGm0+nn/6E92FLHC
         nP+Y850kfoYvIgUwE4ExPGekIJI1j1y3PqdsO+jQ5ww3B/p3dYYuddZvu9rL/yPOFevb
         QTuucFqiRwWJrnrZlImEUyXleYrD92HYZJ6OSmHZAEhWFcaNSInpvIzshRCpoUm5Y19o
         MWQQ==
X-Gm-Message-State: AOAM531O637TNGT0XlfnMeYR3L4FX1CJpnlII4KFdpsaZOFjdnY8Rdb+
        lx//XWIAHvBE+4vGxV/qn4kUBrpdO7lbeUBkaSw=
X-Google-Smtp-Source: ABdhPJylUrU/vGOFbJZXVhnwL0YEgzzw0CFRsBWzSi0/ofETqfibyW0mn0HP1EbkRTwTqy5yAwpZRg==
X-Received: by 2002:aa7:d957:: with SMTP id l23mr16587074eds.116.1640017272321;
        Mon, 20 Dec 2021 08:21:12 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id t10sm5412282edt.83.2021.12.20.08.21.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 08:21:11 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id v11so21137650wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:21:11 -0800 (PST)
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr13026744wrc.274.1640017271617;
 Mon, 20 Dec 2021 08:21:11 -0800 (PST)
MIME-Version: 1.0
References: <Yb82O5i2DVcK9nAJ@zn.tnic> <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
 <15b1a9af-f8ff-c3e2-ba3e-cdbd29ae38db@intel.com>
In-Reply-To: <15b1a9af-f8ff-c3e2-ba3e-cdbd29ae38db@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Dec 2021 08:20:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMEnZqKcUEH9ADg38ifSJa_Mui7FF=-L1-8=_MQfNFAw@mail.gmail.com>
Message-ID: <CAHk-=wgMEnZqKcUEH9ADg38ifSJa_Mui7FF=-L1-8=_MQfNFAw@mail.gmail.com>
Subject: Re: [GIT PULL] core/urgent for v5.16-rc6
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 9:25 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> The patch definitely makes the code easier to read.  But, it looks like
> we need to invert the sigaltstack_size_valid() condition from the patch:

Yup, that's just me messign up when moving code around and adding the
second "unlikely()",

> Also, the sigaltstack_lock() lock really is needed over the assignments
> like this:
>
> >                 t->sas_ss_sp = (unsigned long) ss_sp;
> >                 t->sas_ss_size = ss_size;
> >                 t->sas_ss_flags = ss_flags;
> to prevent races with validate_sigaltstack().

Ugh. This code is garbage. Why the hell does it want a lock for
something stupid like this?

That lock should just be removed entirely as pointless. If some thread
has a sigaltstack that is too small, too bad.

We've never done that validation before, why did people think it was a
good idea to add it now?

And when added, why did people think it had to be done so carefully
under a lock?

Sure, go ahead and make it a "be polite, don't let people ask for
xstate features that won't fit an altstack". But at the point where
people noticed it caused lock contention, just give it up, and do the
unlocked version since it has no actual important semantics.

Whatever. I don't care that much, but this all smells like you just
dug your own hole for very questionable causes, and instead of a
"don't do that then" this all is doubling down on a bad idea.

                 Linus
