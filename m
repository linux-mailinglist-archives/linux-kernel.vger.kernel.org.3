Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5472495A08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378738AbiAUGgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378720AbiAUGgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:36:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3126C061574;
        Thu, 20 Jan 2022 22:36:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11A9CCE2221;
        Fri, 21 Jan 2022 06:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C982C340EA;
        Fri, 21 Jan 2022 06:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642746964;
        bh=OapTYucU006/664lVqAyS8BT5iSkNJKlZLbM69QQ02s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GyeoGBec3Mxxwihc80e8LN96Gzd5XeBsuNCOi7xxq0OUlO7wI66J+kph/004N5YlM
         ZphpsSdABXAW0cGfBs8tDJ2kaQt1QFdvMTjCMTyr6Bg8OcqIWKmeOaRmmnBE13F1EM
         AuEdwDMswd2hT0y57hMztgmKAEzQCaUypXzFkzAxSJ0+w8Q/Xs8m4tpDWn+VYnqnnN
         z9Ejp2Exvg1liCnyEAPgNaaENyPLldmhKZgF1KSYkIDtAxyFKfemjvExbxV5m4Xmou
         +f+05ibW2RAfW0HnazvCqTXvAO8o7EkoN+/B2BScAQl+D+PHtXxrtHd+6loQi9uk+g
         TzEikaKl0BY1Q==
Received: by mail-ua1-f41.google.com with SMTP id w21so15156096uan.7;
        Thu, 20 Jan 2022 22:36:04 -0800 (PST)
X-Gm-Message-State: AOAM53068lAFo1d1oYGEHQPov6DrJv1z3ZlPyfBGculqPESW1Zl1iGMQ
        d147kzLAW058K9nO5QrvmHe+/X2UKQSAmRsVUSM=
X-Google-Smtp-Source: ABdhPJwE7D6l9CEOckPMqifjprc+HPS6gXhdx42Itd64DW8S7D8rq3j2EK3bHxYHAPm3yMKSrqoSRwZpgjSjhZ4KQwc=
X-Received: by 2002:ab0:728c:: with SMTP id w12mr1223277uao.108.1642746963165;
 Thu, 20 Jan 2022 22:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-18-guoren@kernel.org> <CAK8P3a1_qwRpfHRyF75WEqfxGxgVnfB15vNS-egQctx7R5-DvA@mail.gmail.com>
In-Reply-To: <CAK8P3a1_qwRpfHRyF75WEqfxGxgVnfB15vNS-egQctx7R5-DvA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jan 2022 14:35:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTCwOiTPJO1B6Asa2NUNR0D624t26nnA8S4vrSSax8R-Q@mail.gmail.com>
Message-ID: <CAJF2gTTCwOiTPJO1B6Asa2NUNR0D624t26nnA8S4vrSSax8R-Q@mail.gmail.com>
Subject: Re: [PATCH V3 17/17] KVM: compat: riscv: Prevent KVM_COMPAT from
 being selected
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

On Thu, Jan 20, 2022 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Current riscv doesn't support the 32bit KVM/arm API. Let's make it
> > clear by not selecting KVM_COMPAT.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  virt/kvm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> > index f4834c20e4a6..a8c5c9f06b3c 100644
> > --- a/virt/kvm/Kconfig
> > +++ b/virt/kvm/Kconfig
> > @@ -53,7 +53,7 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
> >
> >  config KVM_COMPAT
> >         def_bool y
> > -       depends on KVM && COMPAT && !(S390 || ARM64)
> > +       depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
>
> Maybe this should be flipped around into a positive list now?
I think it's another patch to do that. Not in this series.

> The remaining architectures would be mips, powerpc and x86, but it's unclear
> if this actually meant to work on all of them, or any potential ones
> added in the
Yes, it's unclear and arch maintainers need to confirm that.

> future.
>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
