Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8747755D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhLPPH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:07:57 -0500
Received: from elvis.franken.de ([193.175.24.41]:50683 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235074AbhLPPH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:07:56 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mxsMK-0001iD-01; Thu, 16 Dec 2021 16:07:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D50FAC09A0; Thu, 16 Dec 2021 16:03:47 +0100 (CET)
Date:   Thu, 16 Dec 2021 16:03:47 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/9] Kconfig symbol clean-up on ./arch/mips/
Message-ID: <20211216150347.GB15172@alpha.franken.de>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:16:33PM +0100, Lukas Bulwahn wrote:
> Dear Thomas,
> 
> The script ./scripts/checkkconfigsymbols.py warns on invalid references to
> Kconfig symbols (often, minor typos, name confusions or outdated references).
> This is a patch series addressing the issues reported by
> ./scripts/checkkconfigsymbols.py in the ./arch/mips/ directory, quickly
> filtered down with:
> 
>   ./scripts/checkkconfigsymbols.py | grep "arch/mips" -B 1
> 
> without considering kernel configs, i.e., after removing ./arch/mips/configs
> in the working tree. It addresses all issues I considered to be "true
> positives"; so, issues that should be addressed and cleaned up. 
> 
> The patches on updating the comments might arguably be considered of lower
> value by itself, but as the other patches show, checkkconfigsymbols does detect
> some relevant issues in the kernel tree otherwise being unnoticed.
> So, it might be worth to clean up the kernel tree to have checkkconfigsymbols
> produce a rather short list of issues and then continuously follow and check
> what checkkconfigsymbols reports.
> 
> These are the remaining reports from checkkconfigsymbols in ./arch/mips, which
> are not addressed in this series:
> 
>   SGI_IP35
>   Referencing files: arch/mips/include/asm/sn/addrs.h, arch/mips/include/asm/sn/agent.h, arch/mips/include/asm/sn/klconfig.h
> 
>   Rationale: Ralf Baechle rejected a patch to remove the "upstream-dead"
>   SGI_IP35 code in 2014, because there was still some out-of-tree users.
>   We might want to recheck if these out-of-tree users still exist or if this
>   code can be dropped now.
>   See email discussion: https://lore.kernel.org/lkml/1400584909.4912.35.camel@x220/T/#mf1d73d4f531bab670beb30aa0adfce34cbcad528
> 
>   SHELL
>   Referencing files: arch/mips/Makefile, arch/mips/kernel/syscalls/Makefile
> 
>   Rationale: Ignore CONFIG_SHELL. Default variable in Kbuild build system.
> 
> 
> Each patch in this series can be discussed and applied individually. They are
> sent in one patch series, as they all orginate from the investigation guided
> by the same tool and hence share similar topics and resolutions.
> 
> Please pick this series of minor clean-up patches on ./arch/mips/. It applies
> cleanly on next-20211210. The patches with Fixes: tags might be considerable
> for stable.
> 
> 
> Best regards,
> 
> Lukas
> 
> 
> Lukas Bulwahn (9):
>   mips: drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250
>   mips: add SYS_HAS_CPU_MIPS64_R5 config for MIPS Release 5 support
>   mips: drop selecting non-existing config NR_CPUS_DEFAULT_2
>   mips: dec: provide the correctly capitalized config CPU_R4X00 in init
>     error message
>   mips: kgdb: adjust the comment to the actual ifdef condition
>   mips: remove obsolete selection of CPU_HAS_LOAD_STORE_LR
>   mips: alchemy: remove historic comment on gpio build constraints
>   mips: txx9: remove left-over for removed TXX9_ACLC configs
>   mips: fix Kconfig reference to PHYS_ADDR_T_64BIT
> 
>  arch/mips/Kconfig                  |  9 +++++----
>  arch/mips/alchemy/common/gpiolib.c |  2 --
>  arch/mips/dec/prom/init.c          |  2 +-
>  arch/mips/include/asm/kgdb.h       |  2 +-
>  arch/mips/txx9/Kconfig             |  3 ---
>  arch/mips/txx9/generic/setup.c     | 28 ----------------------------
>  6 files changed, 7 insertions(+), 39 deletions(-)
> 
> -- 
> 2.26.2

applied patches 2-8 to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
