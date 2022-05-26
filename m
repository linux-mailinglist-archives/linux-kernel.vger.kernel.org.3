Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA8534B46
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbiEZIOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbiEZIO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:14:28 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09DAAE250;
        Thu, 26 May 2022 01:14:24 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nu8dS-0000HP-00; Thu, 26 May 2022 10:14:22 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0A26AC0325; Thu, 26 May 2022 10:14:13 +0200 (CEST)
Date:   Thu, 26 May 2022 10:14:12 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] MIPS: RALINK: Define pci_remap_iospace under
 CONFIG_PCI_DRIVERS_GENERIC
Message-ID: <20220526081412.GA5108@alpha.franken.de>
References: <1653478195-21095-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653478195-21095-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 07:29:55PM +0800, Tiezhu Yang wrote:
> kernel test robot reports a build error used with clang compiler and
> mips-randconfig [1]:
> 
>     ld.lld: error: undefined symbol: pci_remap_iospace
> 
> we can see the following configs in the mips-randconfig file:
> 
>     CONFIG_RALINK=y
>     CONFIG_SOC_MT7620=y
>     CONFIG_PCI_DRIVERS_LEGACY=y
>     CONFIG_PCI=y
> 
> CONFIG_RALINK is set, so pci_remap_iospace is defined in the related
> arch/mips/include/asm/mach-ralink/spaces.h header file:
> 
>     #define pci_remap_iospace pci_remap_iospace
> 
> CONFIG_PCI is set, so pci_remap_iospace() in drivers/pci/pci.c is not
> built due to pci_remap_iospace is defined under CONFIG_RALINK.
> 
>     #ifndef pci_remap_iospace
>     int pci_remap_iospace(const struct resource *res, ...)
> 
>     $ objdump -d drivers/pci/pci.o | grep pci_remap_iospace
>     00004cc8 <devm_pci_remap_iospace>:
>         4d18:	10400008 	beqz	v0,4d3c <devm_pci_remap_iospace+0x74>
>         4d2c:	1040000c 	beqz	v0,4d60 <devm_pci_remap_iospace+0x98>
>         4d70:	1000fff3 	b	4d40 <devm_pci_remap_iospace+0x78>
> 
> In addition, CONFIG_PCI_DRIVERS_GENERIC is not set, so pci_remap_iospace()
> in arch/mips/pci/pci-generic.c is not built too.
> 
>     #ifdef pci_remap_iospace
>     int pci_remap_iospace(const struct resource *res, ...)
> 
> For the above reasons, undefined reference pci_remap_iospace() looks like
> reasonable.
> 
> Here are simple steps to reproduce used with gcc and defconfig:
> 
>     cd mips.git
>     make vocore2_defconfig # set RALINK, SOC_MT7620, PCI_DRIVERS_LEGACY
>     make menuconfig        # set PCI
>     make
> 
> there exists the following build error:
> 
>       LD      vmlinux.o
>       MODPOST vmlinux.symvers
>       MODINFO modules.builtin.modinfo
>       GEN     modules.builtin
>       LD      .tmp_vmlinux.kallsyms1
>     drivers/pci/pci.o: In function `devm_pci_remap_iospace':
>     pci.c:(.text+0x4d24): undefined reference to `pci_remap_iospace'
>     Makefile:1158: recipe for target 'vmlinux' failed
>     make: *** [vmlinux] Error 1
> 
> Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC can fix the build
> error, with this patch, no build error remains. This patch is similar with
> commit e538e8649892 ("MIPS: asm: pci: define arch-specific
> 'pci_remap_iospace()' dependent on 'CONFIG_PCI_DRIVERS_GENERIC'").
> 
> [1] https://lore.kernel.org/lkml/202205251247.nQ5cxSV6-lkp@intel.com/
> 
> Fixes: 09d97da660ff ("MIPS: Only define pci_remap_iospace() for Ralink")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/include/asm/mach-ralink/spaces.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
> index f7af11e..a9f0570 100644
> --- a/arch/mips/include/asm/mach-ralink/spaces.h
> +++ b/arch/mips/include/asm/mach-ralink/spaces.h
> @@ -6,7 +6,9 @@
>  #define PCI_IOSIZE	SZ_64K
>  #define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
>  
> +#ifdef CONFIG_PCI_DRIVERS_GENERIC
>  #define pci_remap_iospace pci_remap_iospace
> +#endif
>  
>  #include <asm/mach-generic/spaces.h>
>  #endif
> -- 
> 2.1.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
