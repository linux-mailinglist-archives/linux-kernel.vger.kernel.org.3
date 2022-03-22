Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0174E3872
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiCVF2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiCVF2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:28:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF64DB2B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:26:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r22so13828354ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fItX+GihZgoJ7uro2VD9Dwj+UocrOzftQvPe7LNkJSk=;
        b=LlIke8AHL/iucw3CHc2GzxIqBABNNKcNOBP6JROnk/K+BwkzZ5jVTmnNpEz0VIDXQZ
         sjWLBDtwEeNgANEVOiHL/hPP+J+aEAfYv8Hd1y+Ic4kLtPZ6N3ppPa8PJTcXEq/LU8sH
         8p9q/e8Et4GaURIgz3lRFq6Dmp62PnWovVRO2qEAD4zZ0GIu8MMwBveyFUaBE0zBQoiD
         jdtS2HxvB53KJ6dzbxjUS9q3dtYE74ngI9HmTN00oCEP4pTaM3TkBn6MJQ2LdxzzjRFK
         ZViTtZ11y0QXZ/fkhPstM//8k3506PYNlLSfJfBq9KaIqghixQTq5PLu2ioZl24eoabu
         8HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fItX+GihZgoJ7uro2VD9Dwj+UocrOzftQvPe7LNkJSk=;
        b=NNojHh6lqpSlT8jk42OHtPJU8nQ8VolIlc0w8PxrJOrZnfUlGSs2BiIbRL2NEKjUUj
         HUQqyp1SLhNM7WIslv1torrvi7mRnlea9ZmkhzSLbbrs0zEXcDPwgLUCBb2SapLigTuv
         1XZT8vduHNUaC2/5FpUJo8uBt0NN1ZcQJVGLjtW0qIz5P/LzlnD2XOBXiIq+rgncJz12
         6fvxhsWpMw3Ls226jZXuKvf7ipJJm8XiJUqY/BJyyhl1EvKIKwVYYL6HeRYMgSCJsRNh
         Tm6oynd8xbZuu476jnCly8um6YQXjFe22G2SZ8OzXOHMsh3+gWDh9XZBwynL63x8qmeL
         GNZA==
X-Gm-Message-State: AOAM531uPlCmXOd0K7aXausJ7eOcMQ6CMCXyvwg40Vnp6XCGqACY4N1g
        CPvRlqWyRRCqyKFYhldN0NCoSWV0zFe6M6rJrpo=
X-Google-Smtp-Source: ABdhPJyx+2b4cTpGIHESEU16rQVCnm/Bmtis9slZwxRlH8QetZws9O5v7cFpnUq4NCJ3YsTA2F86auVYZ9yn/84f9s8=
X-Received: by 2002:a17:907:3f17:b0:6da:68b6:7876 with SMTP id
 hq23-20020a1709073f1700b006da68b67876mr23629274ejc.740.1647926807227; Mon, 21
 Mar 2022 22:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220319035457.2214979-6-guoren@kernel.org> <202203200824.EQJTy8pW-lkp@intel.com>
 <CAJF2gTQXgXJjX6h5d_5tM312Ky_QfCKm-wLZP2SJBuYtHvE9xQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQXgXJjX6h5d_5tM312Ky_QfCKm-wLZP2SJBuYtHvE9xQ@mail.gmail.com>
From:   Stafford Horne <shorne@gmail.com>
Date:   Tue, 22 Mar 2022 14:26:36 +0900
Message-ID: <CAAfxs751zQ=rut1qkNwKZXtMAUmKdcG28YgJ+fqYzT9mXgtDFA@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] openrisc: Move to ticket-spinlock
To:     Guo Ren <guoren@kernel.org>
Cc:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jonas Bonn <jonas@southpole.se>,
        Openrisc <openrisc@lists.librecores.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sun, Mar 20, 2022 at 12:05 PM Guo Ren <guoren@kernel.org> wrote:
>
> Hi openrisc guys,
>
> >    kernel/signal.c:2625:49: sparse:     expected struct sighand_struct *sighand
> >    kernel/signal.c:2625:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
>
> Some warning here, Is that all right? I don't think it is because of
> changing arch_spinlock_t from struct qspinlock to atomic_t.
>
> On Sun, Mar 20, 2022 at 8:07 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on arnd-asm-generic/master]
> > [also build test WARNING on tip/locking/core openrisc/for-next linus/master v5.17-rc8 next-20220318]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/Generic-Ticket-Spinlocks/20220319-115644
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> > config: openrisc-randconfig-s032-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200824.EQJTy8pW-lkp@intel.com/config)
> > compiler: or1k-linux-gcc (GCC) 11.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-dirty
> >         # https://github.com/0day-ci/linux/commit/4e66dc8c71c62011bcb287f66bf5c5363920cd91
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review guoren-kernel-org/Generic-Ticket-Spinlocks/20220319-115644
> >         git checkout 4e66dc8c71c62011bcb287f66bf5c5363920cd91
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >    kernel/signal.c: note: in included file (through include/uapi/asm-generic/signal.h, include/asm-generic/signal.h, arch/openrisc/include/generated/uapi/asm/signal.h, ...):
> >    include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
> >    kernel/signal.c:195:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:195:31: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:195:31: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:198:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:198:33: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:198:33: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:480:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:480:9: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:480:9: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:484:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:484:34: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:484:34: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:517:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:517:9: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:517:9: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:520:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:520:36: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:520:36: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:542:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
> >    kernel/signal.c:542:53: sparse:     expected struct k_sigaction *ka
> >    kernel/signal.c:542:53: sparse:     got struct k_sigaction [noderef] __rcu *
> >    include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
> >    kernel/signal.c:698:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:698:33: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:698:33: sparse:     got struct spinlock [noderef] __rcu *
> >    kernel/signal.c:700:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
> >    kernel/signal.c:700:31: sparse:     expected struct spinlock [usertype] *lock
> >    kernel/signal.c:700:31: sparse:     got struct spinlock [noderef] __rcu *
> > >> kernel/signal.c:887:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t [usertype] *lock @@     got struct atomic_t [noderef] __rcu * @@
> >    kernel/signal.c:887:9: sparse:     expected struct atomic_t [usertype] *lock
> >    kernel/signal.c:887:9: sparse:     got struct atomic_t [noderef] __rcu *

This one is being reported as a new warning. I can see this warning
even when testing with x86_64 which uses qspinlock:

    kernel/signal.c:542:53:    got struct k_sigaction [noderef] __rcu *
    ./include/uapi/asm-generic/signal-defs.h:83:29: error: multiple
address spaces given
    kernel/signal.c:698:33: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:698:33:    expected struct spinlock [usertype] *lock
    kernel/signal.c:698:33:    got struct spinlock [noderef] __rcu *
    kernel/signal.c:700:31: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:700:31:    expected struct spinlock [usertype] *lock
    kernel/signal.c:700:31:    got struct spinlock [noderef] __rcu *
    kernel/signal.c:887:9: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:887:9:    expected struct qspinlock *lock
    kernel/signal.c:887:9:    got struct qspinlock [noderef] __rcu *
    kernel/signal.c:1082:9: warning: incorrect type in argument 1
(different address spaces)
    kernel/signal.c:1082:9:    expected struct qspinlock *lock

It looks like these are treated as *new* by the kbuild robot because
they changed from qspinlock to atomic_t, which changes the match
pattern.

I looked into what it takes to fix it but it seems such a change would
be very intrusive.  I think we can leave as is for now.

-Stafford
