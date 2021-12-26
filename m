Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3647F5EB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhLZIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:36:52 -0500
Received: from smtp2.ustc.edu.cn ([202.38.64.46]:53174 "EHLO ustc.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231480AbhLZIgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:36:51 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Dec 2021 03:36:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=aYBtzLSIsckjaVB7NEd+HnkH+vEuZvJZrp
        ig/CtlFFo=; b=h38x0TYrWNI2mdnzBpWoDq01VjZp6pPsYyjNG+NoBNjYVCpkeq
        UvvfhDLcbr/JBj0Qxqu6/gd+FwvnfKzfMYGuz9I4U5NnGXsmvo05EAIASa37Xw92
        8+RO3tjTAxvxkI3sP6UOeFNpH1k4WZYnD0QLmEzUzABBkuRqWF6LsNLLc=
Received: from xhacker (unknown [101.86.42.35])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygC3v2_yJ8hh8Y3CAA--.59233S2;
        Sun, 26 Dec 2021 16:29:38 +0800 (CST)
Date:   Sun, 26 Dec 2021 16:22:23 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        "Wei Wu (=?UTF-8?B?5ZC05Lyf?=)" <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
Message-ID: <20211226162223.795f9417@xhacker>
In-Reply-To: <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
References: <20211221163532.2636028-1-guoren@kernel.org>
 <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
 <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygC3v2_yJ8hh8Y3CAA--.59233S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF13Zr4UXrWfWr1rWF17ZFb_yoW5JF47pa
        90g3WDtanrAryfAw4Sqw1xXFWYq395tr45ta4jqry8Cws09F18tr18ta1ruasrurnYgw42
        vFW2gry7ua9ava7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7y89DUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 20:59:30 +0800
Guo Ren <guoren@kernel.org> wrote:

> On Wed, Dec 22, 2021 at 2:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:  
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
> > > s390, mips, sparc) have supported COMPAT mode. But they all have
> > > history issues and can't use standard linux unistd.h. RISC-V would
> > > be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
> > > /unistd.h.
> > >
> > > The patchset are based on v5.16-rc6, you can compare rv64-compat32
> > > v.s. rv32-whole in qemu with following step:  
> >
> > Looks good overall, see my individual replies for minor comments I had.  
> Thx for the review :)
> 
> >
> > I think there is a bigger question to answer though, which is whether this is
> > actually a useful feature for rv64. In general, there are two reasons for
> > wanting compat mode:
> >
> > a) compatibility with existing binaries and distros
> >
> > b) reducing the memory footprint of user space in a memory constrained
> > environment, either deeply embedded or in a container.
> >
> > For the other architectures, a) is clearly the main driver, but equally so
> > this is not the case on riscv, which does not have any legacy 32-bit
> > code. Without that, adding compat mode would mainly introduce a
> > second ABI to a lot of environments that at the moment only need to
> > support one, and that adds complexity to the implementation and
> > the extra attack surface of the second syscall ABI when an exploit
> > may be possible only in compat mode.
> >
> > There is still some benefit in b), but it would need to be weighed
> > against the downsides above. Can you explain in more detail what
> > use cases you have in mind, and which CPU cores actually support
> > this mode?  
> The most reason is about b), see our customer's product:
> https://www.cnx-software.com/2021/10/25/allwinner-d1s-f133-risc-v-processor-64mb-ddr2/
> 
> So I think all our next generation rv64 cores should support
> compat-mode. Compare to releasing rv32-full core, rv64 compat-mode is
> very cheap for our CPU design.
> 
> You would get the answer when our new generation CPU is announced and it's soon.
> 

What about adding RV64 ILP32 support instead? This don't need HW side
modifications so can benefit all RV64.

Thanks
 
> Currently, only qemu supports rv64 compact mode, that is my colleague
> (LIU Zhi Wei) contributed.

