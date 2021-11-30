Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC984628E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhK3ALe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:11:34 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39509 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhK3ALc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:11:32 -0500
Received: by mail-ot1-f54.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso27813312ots.6;
        Mon, 29 Nov 2021 16:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8pPDA8BhqYxJlGll70Jfs/EV2c/vlH3kHLgmxR36Bk=;
        b=rWLe9jssgGiqIjfQXsquA8EriPxUGdczEjaWZg5mJ1/9W+nv3kwc+056ww7gJQb3kJ
         zZZF5Et7Wdnm70x7VGLlWHaNLWC8aUHy1XESRLjgGGLndLgw/yE/ZEJBeG1sM8Z5KV+o
         +2JN+7CPKJ9ZRcYsoQraaeVfqPLxWsVURyDU72KD+W2QE7jaLrj+kT666AjW6Qdx7C5C
         OTRs1XhHe5J7qnvJ31q+0CypiAXt6xGGfBtM/oJnfhQWTjbodAOu56fqkKUb9GF6SK2K
         sjdNB7t0sqkPSDgZsmCEKjzEXyyiGk8zLEaamBJIkk3Y75Gn9SyWqWdDH/asm2aGUazL
         PvOg==
X-Gm-Message-State: AOAM530N2rKLF8F131l4vNfM7/NQhJJzjB7GAO4IgRW9EfMM5DoSe5ag
        OiWTJ2ubvlehyI9+yeh47Q==
X-Google-Smtp-Source: ABdhPJwHdVFEp5hd/T8aXyXLlCP6k0CfP+fpF2T3r+PJoHiG4EwmK+ob5JSJ6nKmQgmurmZ684PLSA==
X-Received: by 2002:a9d:4702:: with SMTP id a2mr47864106otf.262.1638230893962;
        Mon, 29 Nov 2021 16:08:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bi20sm3422829oib.29.2021.11.29.16.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:08:13 -0800 (PST)
Received: (nullmailer pid 864351 invoked by uid 1000);
        Tue, 30 Nov 2021 00:08:10 -0000
Date:   Mon, 29 Nov 2021 18:08:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Calvin Zhang <calvinzhang.cool@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Jinyang He <hejinyang@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Andreas Oetken <andreas.oetken@siemens.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Thierry Reding <treding@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauri Sandberg <sandberg@mailfence.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] of: remove reserved regions count restriction
Message-ID: <YaVrahm+ysoQRGKe@robh.at.kernel.org>
References: <20211119075844.2902592-1-calvinzhang.cool@gmail.com>
 <YZnqo3oA7srQik4N@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZnqo3oA7srQik4N@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 08:43:47AM +0200, Mike Rapoport wrote:
> On Fri, Nov 19, 2021 at 03:58:17PM +0800, Calvin Zhang wrote:
> > The count of reserved regions in /reserved-memory was limited because
> > the struct reserved_mem array was defined statically. This series sorts
> > out reserved memory code and allocates that array from early allocator.
> > 
> > Note: reserved region with fixed location must be reserved before any
> > memory allocation. While struct reserved_mem array should be allocated
> > after allocator is activated. We make early_init_fdt_scan_reserved_mem()
> > do reservation only and add another call to initialize reserved memory.
> > So arch code have to change for it.
> 
> I think much simpler would be to use the same constant for sizing
> memblock.reserved and reserved_mem arrays.

Do those arrays get shrunk? Or do we waste the memory forever?

Maybe we can copy and shrink the initial array? Though I suspect struct 
reserved_mem pointers have already been given out.

> 
> If there is too much reserved regions in the device tree, reserving them in
> memblock will fail anyway because memblock also starts with static array
> for memblock.reserved, so doing one pass with memblock_reserve() and
> another to set up reserved_mem wouldn't help anyway.
> 
> > I'm only familiar with arm and arm64 architectures. Approvals from arch
> > maintainers are required. Thank you all.
> > 
> > Calvin Zhang (2):
> >   of: Sort reserved_mem related code
> >   of: reserved_mem: Remove reserved regions count restriction
> > 
> >  arch/arc/mm/init.c                 |   3 +
> >  arch/arm/kernel/setup.c            |   2 +
> >  arch/arm64/kernel/setup.c          |   3 +
> >  arch/csky/kernel/setup.c           |   3 +
> >  arch/h8300/kernel/setup.c          |   2 +
> >  arch/mips/kernel/setup.c           |   3 +
> >  arch/nds32/kernel/setup.c          |   3 +
> >  arch/nios2/kernel/setup.c          |   2 +
> >  arch/openrisc/kernel/setup.c       |   3 +
> >  arch/powerpc/kernel/setup-common.c |   3 +
> >  arch/riscv/kernel/setup.c          |   2 +
> >  arch/sh/kernel/setup.c             |   3 +
> >  arch/xtensa/kernel/setup.c         |   2 +
> >  drivers/of/fdt.c                   | 107 +---------------
> >  drivers/of/of_private.h            |  12 +-
> >  drivers/of/of_reserved_mem.c       | 189 ++++++++++++++++++++++++-----
> >  include/linux/of_reserved_mem.h    |   4 +
> >  17 files changed, 207 insertions(+), 139 deletions(-)
> > 
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
