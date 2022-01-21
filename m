Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799A9495A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378874AbiAUHNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:13:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50736 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245097AbiAUHNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:13:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 916C2B81F42;
        Fri, 21 Jan 2022 07:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE92C340E9;
        Fri, 21 Jan 2022 07:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642749188;
        bh=SYu90Dv3l/L+64SNcy50aiw16Lnx3umbKRTsGOMrQkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k3uRWzp0SWvrQt4wpv0wp6HqoqMuube0dVeHTED+DvTqJqQ9JteKgAHFuRzMK7La9
         hdnPtmnF2+6oHL0sMYFETK3B/JMjsOW1iHomI2Xxura1sskJ+xnkPbfy35KWaVO1oF
         26rdD0dYwJ3PYFSq+U3dWovrDZcwDzLVyfSAEZDEYRmJINM8Tmg0Ctmu12Rf81s5Ac
         gTKy8KVDZlLocphtUaf3ZDWDQa7DnN48hoqfKvLktVOOCow1KTrdDLQoLL6djNiLnt
         IAwyIbddJ0s5SrRTLwybw+lS0U5xtFSYhGyprgDLn7Xl/Wos5XISZ+lA6JoDVYmrwQ
         LJ4wkPbrGtrCw==
Received: by mail-ua1-f42.google.com with SMTP id y4so15340383uad.1;
        Thu, 20 Jan 2022 23:13:08 -0800 (PST)
X-Gm-Message-State: AOAM5308pWH6ry++BaLmChZuZ3Tca0RPutSXFGz86STO/h5THSW/2DwP
        H9XGfWX/4Z/iecxCE17m44cgXCq1PA9sQ1deBuY=
X-Google-Smtp-Source: ABdhPJx6xNJuRVb4aLVlJ7P9bbeDPtJXSmXNRd3kkpQg8PkHlzrym8B0ENWLs0YxpXjFKvxlitpnKg+MIWjsd2Jznqg=
X-Received: by 2002:a67:c89e:: with SMTP id v30mr1186161vsk.2.1642749187280;
 Thu, 20 Jan 2022 23:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-14-guoren@kernel.org> <CAK8P3a03-3QTC-vxmnbouK7wBd8iunPGZpX0-Jf6ntS1DY0E=w@mail.gmail.com>
In-Reply-To: <CAK8P3a03-3QTC-vxmnbouK7wBd8iunPGZpX0-Jf6ntS1DY0E=w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jan 2022 15:12:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRMWj0yVLn2=16Gu1O-6tuqLaxcdduw0YnDK6vrizJEsQ@mail.gmail.com>
Message-ID: <CAJF2gTRMWj0yVLn2=16Gu1O-6tuqLaxcdduw0YnDK6vrizJEsQ@mail.gmail.com>
Subject: Re: [PATCH V3 13/17] riscv: compat: signal: Add rt_frame implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 6:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement compat_setup_rt_frame for sigcontext save & restore. The
> > main process is the same with signal, but the rv32 pt_regs' size
> > is different from rv64's, so we needs convert them.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> I hope someone else can properly review this part, it's not my area
> but it looks complex enough that it could bring subtle bugs.
Here are ltp signal test results:

sigaction01                                        PASS       0
sigaction02                                        PASS       0
sigaltstack01                                      PASS       0
sigaltstack02                                      PASS       0
sighold02                                          PASS       0
signal01                                           PASS       0
signal02                                           PASS       0
signal03                                           PASS       0
signal04                                           PASS       0
signal05                                           PASS       0
signal06                                           CONF       32
signalfd01                                         PASS       0
signalfd4_01                                       PASS       0
signalfd4_02                                       PASS       0
sigpending02                                       PASS       0
sigprocmask01                                      PASS       0
sigrelse01                                         PASS       0
sigsuspend01                                       PASS       0
sigtimedwait01                                     PASS       0
sigwait01                                          PASS       0
sigwaitinfo01                                      CONF       32


>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
