Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B274D49FE81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350354AbiA1Q6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbiA1Q6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:58:03 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31594C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:58:03 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id g10so3772603vss.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQ49Pm+NuV21ZdxRaCCTPqWR9V7O6HMPgYzi6Se2cCk=;
        b=YMmOGsPKN/42+Y8geSgWOMJpClWLqd6H1k/dnva47Y4FJqcSxZqKOSoezxMWfLmSCV
         QU5l9N/E/hLka91qBRtoUNzREjrVdSNWxESYfPQvlb1SXxa3esUhuGSfiqddyfBAHk8F
         fYg8AGyY2GB58T+yLQQre3Ng8izZdDxRIDspURJTIf+zdmhEc3L1YejetUc0VNSN5HgZ
         1haR5ZaaFNezLoP8Si2/hgUTmDL2tagY10vye8EMr2VtFtuk9LeiKi+zt0x7y2Xdtilp
         6q+9PHSjWoilbJDKGpaSbKIQeV6jOgpa7yIoOdftYg2OGkQok4QGZ2S2SX9uE7dlUNou
         +W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQ49Pm+NuV21ZdxRaCCTPqWR9V7O6HMPgYzi6Se2cCk=;
        b=4CULCuOGq92wtSMarDKfW2JRvGdQm8uiyyB8Qty1h8BBhOa/8Ao84JlMpiJZxVpKHs
         zYRDRbLYx7S1fcS64QO3p1rcZBpQs8X+Myf6waFMqwN9IRaqeCJhBBlpWuf0qvtn0nP+
         FxOFJe3KFjht02euuxIbw6lP0qQqKaD304dmv1AURmpL6OxLiEqwDQqalVRMBnALmTTH
         4lwOOBWuaqnbOnJKL5BW44splxXXVp+48kGr3Ir5WTjntPEX/FNCKKfgwrnh2kRM6OgL
         +ATrq8a5HvjfkGgKXlrZ0g4E7e/n9JjX8e0B8oIUFsDu+YnRJgLO5UvAjFDIs690q3+L
         tc1A==
X-Gm-Message-State: AOAM530deGeAXSCZXx5K1EDUXEzTktGncJ/Ba/OrZUztBtFpRHpuuleG
        xepVsigHQkXoQWr1FUEm+g3P0nABkxWm5XN32iKn+w==
X-Google-Smtp-Source: ABdhPJwEGsw4vp/T4oYUuh6vSmSOMK5nv6anNu4o4p3jwd/0S7IoP3HapEHFTFg4WkNiZeIdCl+IYio7/ZBZt5C+b3E=
X-Received: by 2002:a67:c205:: with SMTP id i5mr3971465vsj.6.1643389082319;
 Fri, 28 Jan 2022 08:58:02 -0800 (PST)
MIME-Version: 1.0
References: <1211272108.4257.1643246572499.JavaMail.zimbra@efficios.com>
In-Reply-To: <1211272108.4257.1643246572499.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 28 Jan 2022 08:57:53 -0800
Message-ID: <CAFTs51UsQgZkc-Xg3XaBvxssVCyfA=JCS4npBGBAeWJK0yUOuw@mail.gmail.com>
Subject: Re: rseq vcpu_id ideas
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 5:22 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi Paul,
>
> I remember our LPC discussions about your virtual cpu ids ideas, and noticed some tcmalloc code
> with "prototype" fields for vcpu_id and numa node id
> (https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/linux_syscall_support.h#L34).
>
> I'm currently toying with ideas very close to vcpu_ids to solve issues with overzealous
> memory allocation for LTTng-UST (user-space tracer) in use-cases where containers use few
> cores.
>
> My current thinking is that we could use your vcpu_id idea, but apply it on a per-pid-namespace
> basis rather than per-process. We may have to be clever with NUMA as well to ensure good NUMA
> locality.
>
> Do you have any thought about this, and perhaps some prototype rseq extension code you could
> share as a starting point ?

We've been using rseq vcpu extensions in production for more than a
year, with good results. We have a perfect use case, though: wide
machines (hundreds of CPUs) with many narrow processes (restricted to
a small number of CPUs). Our extension can be configured to either do
a "flat" vcpu accounting, or a "per numa node" vcpu accounting. We
currently only use "flat" accounting, I guess because most of our
processes are affined to a single numa node.

I plan to post the code to the list after the UMCG saga comes to a
clear resolution.

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
