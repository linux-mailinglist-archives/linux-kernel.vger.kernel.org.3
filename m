Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1749FE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350191AbiA1RFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:05:15 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:46279 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiA1RFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:05:14 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D12C7200007;
        Fri, 28 Jan 2022 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643389513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFYyWikS9axvsLIq/lr15Z5P7RuvOnwGkrjHaVqpdzk=;
        b=nKIwLDcNWWekb0xu+t4Ec/Rc6hwdVh7jaVHRsNGrdAHrOeMjtBPMClo7FhR+EzfOusLVBe
        XQcQO29r1lFyBlMK2lu+STgJYPJsKtY1k4exJaxtIKSxzBmCcuIRsx2852YzATYbjc86JP
        qjVk/p33u8bEJyjWUA+QBEPqD/Oq4KXJ8D6abXywOSftYXf26KFw45/ao+0U9H9sUruSm5
        3kBI+Vmk5E1KRjMp6eMe+3KZ/nLre7dQGt+UGhaR6ZM+ZgteErF5OuMJIVmiTj2kl86eba
        Fv+kC7uPl/mTCYsI7g1QLyBvtl2Ac61s2Ea2IrFQiEb+rvI0bU4DEbJ/3XalpA==
Date:   Fri, 28 Jan 2022 18:05:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [mtd:spi-mem-ecc 29/29] drivers/spi/spi-mxic.c:688: undefined
 reference to `nand_ecc_unregister_on_host_hw_engine'
Message-ID: <20220128180510.51d304ea@xps13>
In-Reply-To: <202201282024.dNzYfD56-lkp@intel.com>
References: <202201282024.dNzYfD56-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


lkp@intel.com wrote on Fri, 28 Jan 2022 21:01:33 +0800:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi=
-mem-ecc
> head:   493b08141c0086ddb2126179cca7a8a7936b3582
> commit: 493b08141c0086ddb2126179cca7a8a7936b3582 [29/29] spi: mxic: Add s=
upport for pipelined ECC operations
> config: i386-randconfig-a014-20210930 (https://download.01.org/0day-ci/ar=
chive/20220128/202201282024.dNzYfD56-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=3D1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/c=
ommit/?id=3D493b08141c0086ddb2126179cca7a8a7936b3582
>         git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/gi=
t/mtd/linux.git
>         git fetch --no-tags mtd spi-mem-ecc
>         git checkout 493b08141c0086ddb2126179cca7a8a7936b3582
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    ld: drivers/spi/spi-mxic.o: in function `mxic_spi_mem_ecc_remove':
> >> drivers/spi/spi-mxic.c:688: undefined reference to `nand_ecc_unregiste=
r_on_host_hw_engine' =20

Today I learned that unlike "depends on", "select" does not enforce any
type (y or m), which can lead to the following situation:

SPI_MXIC=3Dy expects the NAND symbols to be built statically
SPI_MXIC depends on MTD_NAND_ECC
MTD_NAND_ECC selects MTD_NAND_CORE
In this case MTD_NAND_CORE=3Dm is "valid" but will trigger link errors
such as the one below.

The problem does not directly come from that patchset but more on
the way dependencies are described under drivers/mtd/nand/. I will fix
this in another patch and apply it right before merging this series on
top of the spi-mem-ecc branch to avoid any further reports.

>=20
>=20
> vim +688 drivers/spi/spi-mxic.c
>=20
>    683=09
>    684	static void mxic_spi_mem_ecc_remove(struct mxic_spi *mxic)
>    685	{
>    686		if (mxic->ecc.pipelined_engine) {
>    687			mxic_ecc_put_pipelined_engine(mxic->ecc.pipelined_engine);
>  > 688			nand_ecc_unregister_on_host_hw_engine(mxic->ecc.pipelined_engine=
); =20
>    689		}
>    690	}
>    691=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Thanks,
Miqu=C3=A8l
