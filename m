Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFCD4D3D64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiCIXK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiCIXKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:10:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2B74E3BA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7D40B82443
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D513C340E8;
        Wed,  9 Mar 2022 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646867392;
        bh=ibHZIpp5hEnoCg+q6FN9PuIaT2D/qY/GSosZEsHZ2tg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=afb38Szwtnh5oFv17U8cT3v2S5KMa3QRhS+q5FQbRxe7JHYT3NhJQJki4rTuLxswW
         0qCh1fHS8MANQH8HeheJisbcT8i7df3kTd+cndZzquefKyfGLsqf+NmgHMRofZs9QQ
         5MO1K1l8btLqsExCflkVGk+2Kv+7M1IysDylbohfUtcb92VWvN6M/OdQOk593Q7apB
         S1olQJxl3DGtaVmqlizg7730+1n0cojCShDMYqT83yUL0iPCWov/uzymg/pmk15KQe
         91d0tTDn13RuH+4/mCaLsM3l/xdYxeWbcu3R8ITcvhSv2xPAwIRPmf2xG0FurClY6E
         49WI3dJFpRtMw==
Date:   Wed, 9 Mar 2022 17:09:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [lpieralisi-pci:pci/rcar 2/2]
 drivers/pci/controller/pcie-rcar-host.c:139:3: error: instruction requires:
 data-barriers
Message-ID: <20220309230950.GA89632@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203091741.IetDk7a7-lkp@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:04:28PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/rcar
> head:   9775965dbae50a04f12879179d6d6fb58f240d6b
> commit: 9775965dbae50a04f12879179d6d6fb58f240d6b [2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception
> config: arm-randconfig-c002-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091741.IetDk7a7-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=9775965dbae50a04f12879179d6d6fb58f240d6b
>         git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>         git fetch --no-tags lpieralisi-pci pci/rcar
>         git checkout 9775965dbae50a04f12879179d6d6fb58f240d6b
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/pci/controller/pcie-rcar-host.c:139:3: error: instruction requires: data-barriers
>                    __rcar_pci_rw_reg_workaround("str")
>                    ^
>    drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
>                    "2:     isb\n"                                          \
>                     ^
>    <inline asm>:2:4: note: instantiated into assembly here
>    2:      isb
>            ^
>    drivers/pci/controller/pcie-rcar-host.c:153:3: error: instruction requires: data-barriers
>                    __rcar_pci_rw_reg_workaround("ldr")
>                    ^
>    drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
>                    "2:     isb\n"                                          \
>                     ^
>    <inline asm>:2:4: note: instantiated into assembly here
>    2:      isb
>            ^
>    2 errors generated.

I don't know how to fix this.  We currently have these on Lorenzo's
pci/rcar branch:

  9775965dbae5 ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception")
  de6b5097f58b ("PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()")

To avoid this error, for now I have cherry-picked de6b5097f58b to a
local pci/host/rcar branch and dropped 9775965dbae5.

> vim +139 drivers/pci/controller/pcie-rcar-host.c
> 
>    132	
>    133	static int rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val,
>    134						 unsigned int reg)
>    135	{
>    136		int error = PCIBIOS_SUCCESSFUL;
>    137	#ifdef CONFIG_ARM
>    138		asm volatile(
>  > 139			__rcar_pci_rw_reg_workaround("str")
>    140		: "+r"(error):"r"(val), "r"(pcie->base + reg) : "memory");
>    141	#else
>    142		rcar_pci_write_reg(pcie, val, reg);
>    143	#endif
>    144		return error;
>    145	}
>    146	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
