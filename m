Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BAD48DC51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiAMQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiAMQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:59:10 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ABBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:59:10 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id s21-20020a05683004d500b0058f585672efso6964548otd.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1qzO0Lv2v0FK/dNRkB4nuLA84ADuQ4YN39zArumryk=;
        b=asif9ejzgciliN4B2WovmWkRpzRnGvwZmPSoESXq48Y7ie8AOQ3Y4uQIJod5ccZjfv
         gv77nzGn8qLcaWgjmuo3+9Lf2ebcTRqWBzNsqizn5F2RRrkelisBchxSvXdJ6oqcv+US
         27nzpnQm0uyPh0xTxtdbAXtENXP5zcqhu5aJhzrYJ+Do7NwqP1MuXKqJIqkIeLXyU1PB
         DKosN27ik2o4JRhQw5vsIdaOs7G+SSlGbWJcGJHyT2nK+gGLcJ9DUdcyiA8TYNq/PHMT
         ZpoG7US3rtruxtBLm8aie6XNGNoEjpqNtvXJeEp+sXbxe514W9lZyDHauAN/lWGXSgw0
         OGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1qzO0Lv2v0FK/dNRkB4nuLA84ADuQ4YN39zArumryk=;
        b=deu7BCPMR2OIesHR7Nmm02sAv6Ne9Of5PO+E+q77fJp9YnKC8/yn9jMSbufMG+7BuX
         XVjitwvSCbNUcoKCTe1n92eKbfQ7aw/0RYKDomv290bMbEgyluMlaZXBYsjPxVDn+07O
         xQwPFY0MOLX/fTWBI4dvTALT3w6w6JRAUx98hQfTs5GOzD5jZ0fEpAb0HO21UT4C9wwj
         a8YLjnQkn5GPSly3HrBzsaYBQr/6FaNvAFvr75L3MIcWs2XvTcB/f0bkyZVqVmn7+PHz
         x+VjUOr1mGoRcJEidEsRNU30VU62iMi1Cyq9622tPPdsmcLDgwlfAXQL+rUvn+l+0ijl
         iS9Q==
X-Gm-Message-State: AOAM5305OAeE7+j3OTmvrh5+Gtfqc1oYM6ieqKz657O1JRvSpDXTqWtx
        rpb+ZhmH+Ayke51uv/lGreOt0bwyMk5ICvgDuQHOPPW1JgdeVQ==
X-Google-Smtp-Source: ABdhPJxNX4xoy+CCXpfIcESHnZXqtkuOeJck13AhCpT6qiGjc8FqY7dlsZi4Py2Wqy9ijSqDDZuatZW05tPxeyjDxtI=
X-Received: by 2002:a05:6830:244c:: with SMTP id x12mr2362318otr.194.1642093149107;
 Thu, 13 Jan 2022 08:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20220113155357.4706-1-bp@alien8.de>
In-Reply-To: <20220113155357.4706-1-bp@alien8.de>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 Jan 2022 17:58:57 +0100
Message-ID: <CANpmjNO2mGJjb6YO0EsgjYsEuuF9sGP26Vazb2w0NZ2svevcsA@mail.gmail.com>
Subject: Re: [PATCH 0/2] generic/bitops: Always inline some more generic helpers
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 at 16:53, Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Hi all,
>
> a build report by the 0day robot:
>
>   https://lore.kernel.org/r/Yc7t934f%2Bf/mO8lj@zn.tnic
>
> made me look at asm and how gcc, at least, generates funky calls to the
> *_bit() bit manipulation functions on x86 instead of inlining them into
> the call sites as on x86 that's a single insn, in most of the cases.
>
> So PeterZ says the way to go is to always inline them. So here they are.
> The fun thing is that on x86 there is even a size decrease of more than
> a Kilobyte for a defconfig, which is nice, see patch 1.
>
> As always, comments and suggestions are welcome.
>
> Thx.
>
> Borislav Petkov (2):
>   asm-generic/bitops: Always inline all bit manipulation helpers
>   cpumask: Always inline helpers which use bit manipulation functions
>
>  include/asm-generic/bitops/instrumented-atomic.h | 12 ++++++------
>  .../asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
>  include/linux/cpumask.h                          | 14 +++++++-------
>  3 files changed, 21 insertions(+), 21 deletions(-)

Acked-by: Marco Elver <elver@google.com>

Yup, this is probably something we should have done a long time ago. :-)

Thanks!
