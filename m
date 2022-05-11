Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB3522D12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiEKHVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbiEKHVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:21:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559F63EA94
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:21:12 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MGz9p-1nadtM0sYV-00E5Pa for <linux-kernel@vger.kernel.org>; Wed, 11 May
 2022 09:21:11 +0200
Received: by mail-yb1-f180.google.com with SMTP id j2so2387249ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:21:11 -0700 (PDT)
X-Gm-Message-State: AOAM530oTD0SSpZ1liPFUOslOfDOgTR8+GuRIH05CUHIYCgXrB68JsZo
        pXHiIHCpjuuK+/5i2BUDnOmYeYIDYw5YvmPdiPM=
X-Google-Smtp-Source: ABdhPJyRlZ+X7YgSK1A1Y4q6XvWTj1ygmNVy7jUzODBfApy1u3ivwARxLQlAvlsHsb4g17Z4Fbk9fl90oRba0hopjXo=
X-Received: by 2002:a25:cbc9:0:b0:645:879a:cdd3 with SMTP id
 b192-20020a25cbc9000000b00645879acdd3mr20812555ybg.550.1652253669971; Wed, 11
 May 2022 00:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192134.434753-1-longman@redhat.com> <20220510192134.434753-2-longman@redhat.com>
In-Reply-To: <20220510192134.434753-2-longman@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 May 2022 09:20:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3APecwzfS24Cc2f7rPdZXKU0Y9FB3RZNFTnRYnVXVQzg@mail.gmail.com>
Message-ID: <CAK8P3a3APecwzfS24Cc2f7rPdZXKU0Y9FB3RZNFTnRYnVXVQzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking/qrwlock: Reduce cacheline contention for
 rwlocks used in interrupt context
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tq+5mskS1kQ3BP6miun4JFn36xDSfEX+/5XGVB7JGwq8OkUtjOU
 2TCadcGCpLEbnSP2QKUfQ/Hd8wTsqC+d8Y+PwBSg1qdpGw+eOD4CwnFQSBDHXwlz1cQXSjo
 OMaanguJ1F+NCkK1ztafWezLRW3XrEg6Xlsnco4OVgqXlcE3vVGDIPl5ywe2qHS7UaeziJL
 2ytpOYsrsW23WdWRPstnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xfD/eZO19c=:Roli6S2RDpvpPbRBzSXQS+
 +lB/TTHRwqO6M6tEqPuGr8pKKzVDuecbOLXJszYOKIvQ/dx5J/gad6QIg5XYex7xxC7pqAVwW
 Kdqe+70GsmgiiF9TswS30qbVlat+JxwwcWAfeGQC5D2VMQEd11ojH8cp6mCcWLxP40fyj1WL6
 E/TWc3f/D3j+tXKSdNlfN3zCdWa3mjFiCYPazdyAaPk1oBVQghCUpOBS6q02b+LG7Mu8DAHCi
 lzWVxhuhqq0VHEaEJxPohydfb+0MJpd4nu+nhSw/QZBgfsl8cord3OXOEXe4H2k6jzcBQDgC4
 vm3GGXAWPqYIV+InBEA2b3ODwwJQC9EeehajkHKCkNSP0zrrJvaSxGD9HPH9gwgewD/hDl7x/
 iQRqDz+zgBotaoV0ESTllZPgrPB+5Owv8zEdJZzE7+7yOI2hLUhTRrGD9GkAluhEaUKPGeSMw
 iYdkUfqrwP3IizDW1OsZC+Sx4ohew6ah1hcUZ9STTIXA8DGtoE4njL4Xa7kYAuActf0o2+gN+
 Fw53YeqUTC7XJCUNOJdWlfZGTKRNv3RNWtQA+EdBZNhQeyBq+DfMIf4wIKwFxMhpfBj9rwb4z
 39mv7I/oyULli9Def6rOhvCVxSZOOHbNrp82A/IaInDHTlriXe6CzTOObbVlHvVe5AL1vGAKG
 cscuwdGTI/jSI/B+8NAiO5hTD7fHAWgWcG8oCn7LvgMfkZkBLyd/1n09v2+cEs4QrWN9xV3W9
 OYIVAqdB5/J9PtXz+jIrrEIVzgyyM4pCzbxZrcrCcL9ObCo3oVJTZqeVv8sq8QjJSH25NVMf7
 oOnw1kWlg6mtl5UOPaP73PkaaubPsLEmsA68HjqqqEKKLVKLuo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 9:21 PM Waiman Long <longman@redhat.com> wrote:
>
> Even though qrwlock is supposed to be a fair lock, it does allow readers
> from interrupt context to spin on the lock until it can acquire it making
> it not as fair. This exception was added due to the requirement to allow
> recursive read lock in interrupt context. This can also be achieved by
> just ignoring the writer waiting bit without spinning on the lock.
>
> By making this change, we make qrwlock a bit more fair and eliminating
> the problem of cacheline bouncing for rwlocks that are used heavily in
> interrupt context, like the networking stack. This should also reduce
> the chance of lock starvation for those interrupt context rwlocks.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/asm-generic/qrwlock.h |  6 +++---
>  kernel/locking/qrwlock.c      | 17 ++++++-----------
>  2 files changed, 9 insertions(+), 14 deletions(-)

I have no opinion on the change itself, but I made sure this does
not conflict with the generic ticket spinlock changes that I merged
in the asm-generic tree, since those also touch the comments in
qrwlock.h [1]

I assume you are merging both patches through the tip tree, so

Acked-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic

If you want me to pick them up in the asm-generic tree instead,
just let me know.

        Arnd

[1] https://lore.kernel.org/lkml/20220509222956.2886-4-palmer@rivosinc.com/
