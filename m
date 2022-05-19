Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB7052DBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbiESRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiESRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:45:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F0A5014;
        Thu, 19 May 2022 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1652982333; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5iGfYWb1Bjj/D/QMjHpz5s5R4CGPz0UkXJkKxwJ5+YU=;
        b=O49XgG69PHmWNf8UbLtLJohVQ8DnynXBmYFDfbf4Q9Qt74qWeWbtZt7Ycep6kj1XRwRoki
        MYWA/1hyoxqHlp2QYTyUrfYJdsQ7ncK7U+ji3dzKlHdDoANFOzoAnq8SvYB9LNbxK0zOg5
        GNck9BqmM63dw7a4zRSwK+ltKwUvtg8=
Date:   Thu, 19 May 2022 18:45:24 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: arch/mips/include/asm/checksum.h:195:9: error: unsupported inline
 asm: input with type 'unsigned long' matching output with type '__wsum' (aka
 'unsigned int')
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips <linux-mips@vger.kernel.org>
Message-Id: <OB55CR.QAT1J8A48BK21@crapouillou.net>
In-Reply-To: <202205200128.layu7VXF-lkp@intel.com>
References: <202205200128.layu7VXF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bot,

Le ven., mai 20 2022 at 01:23:43 +0800, kernel test robot=20
<lkp@intel.com> a =E9crit :
> tree:  =20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=20
> master
> head:   f993aed406eaf968ba3867a76bb46c95336a33d0
> commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add=20
> MIPS_GENERIC_KERNEL symbol

I have no idea how that error could be even remotely related to the=20
commit above.

About the real issue: Maybe the last "addu" in csum_tcpudp_nofold()=20
should be a "daddu"?

Cheers,
-Paul

> date:   1 year, 8 months ago
> config: mips-randconfig-r036-20220519=20
> (https://download.01.org/0day-ci/archive/20220520/202205200128.layu7VXF-l=
kp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project=20
> e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
> reproduce (this is a W=3D1 build):
>         wget=20
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross=20
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         #=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc434b9f80b0923e6460031b0fd964f8b0bf3c6a6
>         git remote add linus=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross=20
> W=3D1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash arch/mips/cavium-octeon=
/=20
> drivers/dma-buf/heaps/ net/ipv6/
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>    In file included from arch/mips/cavium-octeon/octeon-platform.c:10:
>    In file included from include/linux/etherdevice.h:20:
>    In file included from include/linux/if_ether.h:19:
>    In file included from include/linux/skbuff.h:28:
>    In file included from include/net/checksum.h:22:
>>>  arch/mips/include/asm/checksum.h:195:9: error: unsupported inline=20
>>> asm: input with type 'unsigned long' matching output with type=20
>>> '__wsum' (aka 'unsigned int')
>            : "0" ((__force unsigned long)daddr),
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from arch/mips/cavium-octeon/octeon-platform.c:15:
>    In file included from arch/mips/include/asm/octeon/octeon.h:11:
>    In file included from arch/mips/include/asm/octeon/cvmx.h:72:
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:323:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NULL)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:323:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:324:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_SIM)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:324:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:325:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBT3000)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:325:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:326:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KODAMA)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:326:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:327:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIAGARA)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:327:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:328:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NAC38)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:328:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:329:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_THUNDER)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:329:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:330:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_TRANTOR)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:330:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:331:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH3000)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:331:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:332:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH3100)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
> --
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                   =20
> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
>                   =20
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KONTRON_S1901)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                   =20
> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
>                   =20
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_NULL)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_SIM_TYPE_DEPRECATED)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_OCTEON_SAMPLE)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_MAX)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    arch/mips/cavium-octeon/smp.c:99:6: warning: no previous prototype=20
> for function 'octeon_send_ipi_single' [-Wmissing-prototypes]
>    void octeon_send_ipi_single(int cpu, unsigned int action)
>         ^
>    arch/mips/cavium-octeon/smp.c:99:1: note: declare 'static' if the=20
> function is not intended to be used outside of this translation unit
>    void octeon_send_ipi_single(int cpu, unsigned int action)
>    ^
>    static
>>>  arch/mips/cavium-octeon/smp.c:194:5: warning: no previous=20
>>> prototype for function 'plat_post_relocation' [-Wmissing-prototypes]
>    int plat_post_relocation(long offset)
>        ^
>    arch/mips/cavium-octeon/smp.c:194:1: note: declare 'static' if the=20
> function is not intended to be used outside of this translation unit
>    int plat_post_relocation(long offset)
>    ^
>    static
>    81 warnings generated.
>    Assembler messages:
>    Warning: a different -march was already specified, is now octeon
> --
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:394:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                   =20
> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
>                   =20
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:397:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:398:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:399:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KONTRON_S1901)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:400:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                   =20
> ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
>                   =20
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:401:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:318:20: note:=20
> expanded from macro 'ENUM_BRD_TYPE_CASE'
>            case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_NULL)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:412:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_SIM_TYPE_DEPRECATED)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:413:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_OCTEON_SAMPLE)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:414:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: warning:=20
> adding 'int' to a string does not append to the string=20
> [-Wstring-plus-int]
>                    ENUM_CHIP_TYPE_CASE(CVMX_CHIP_TYPE_MAX)
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                           ~~~^~~~
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:415:3: note: use=20
> array indexing to silence this warning
>    arch/mips/include/asm/octeon/cvmx-bootinfo.h:407:20: note:=20
> expanded from macro 'ENUM_CHIP_TYPE_CASE'
>            case x: return(#x + 15);        /* Skip CVMX_CHIP_TYPE */
>                              ^
>    In file included from=20
> arch/mips/cavium-octeon/crypto/octeon-sha1.c:23:
>    In file included from include/crypto/internal/hash.h:11:
>    In file included from include/crypto/algapi.h:13:
>    In file included from include/linux/skbuff.h:28:
>    In file included from include/net/checksum.h:22:
>>>  arch/mips/include/asm/checksum.h:195:9: error: unsupported inline=20
>>> asm: input with type 'unsigned long' matching output with type=20
>>> '__wsum' (aka 'unsigned int')
>            : "0" ((__force unsigned long)daddr),
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    79 warnings and 1 error generated.
> ..
>=20
>=20
> vim +195 arch/mips/include/asm/checksum.h
>=20
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  162
> 01cfbad79a5e2b arch/mips/include/asm/checksum.h Alexander Duyck=20
> 2016-03-11  163  static inline __wsum csum_tcpudp_nofold(__be32=20
> saddr, __be32 daddr,
> 01cfbad79a5e2b arch/mips/include/asm/checksum.h Alexander Duyck=20
> 2016-03-11  164  					__u32 len, __u8 proto,
> 8e3d8433d8c22c include/asm-mips/checksum.h      Al Viro        =20
> 2006-11-14  165  					__wsum sum)
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  166  {
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  167  	__asm__(
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  168  	"	.set	push		# csum_tcpudp_nofold\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  169  	"	.set	noat		\n"
> 875d43e72b5bf2 include/asm-mips/checksum.h      Ralf Baechle   =20
> 2005-09-03  170  #ifdef CONFIG_32BIT
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  171  	"	addu	%0, %2		\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  172  	"	sltu	$1, %0, %2	\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  173  	"	addu	%0, $1		\n"
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  174
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  175  	"	addu	%0, %3		\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  176  	"	sltu	$1, %0, %3	\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  177  	"	addu	%0, $1		\n"
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  178
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  179  	"	addu	%0, %4		\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  180  	"	sltu	$1, %0, %4	\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  181  	"	addu	%0, $1		\n"
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  182  #endif
> 875d43e72b5bf2 include/asm-mips/checksum.h      Ralf Baechle   =20
> 2005-09-03  183  #ifdef CONFIG_64BIT
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  184  	"	daddu	%0, %2		\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  185  	"	daddu	%0, %3		\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  186  	"	daddu	%0, %4		\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  187  	"	dsll32	$1, %0, 0	\n"
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  188  	"	daddu	%0, $1		\n"
> 66fd848cadaa6b arch/mips/include/asm/checksum.h Ralf Baechle   =20
> 2017-01-26  189  	"	sltu	$1, %0, $1	\n"
> e97288386a316e include/asm-mips/checksum.h      Ralf Baechle   =20
> 2005-09-20  190  	"	dsra32	%0, %0, 0	\n"
> 66fd848cadaa6b arch/mips/include/asm/checksum.h Ralf Baechle   =20
> 2017-01-26  191  	"	addu	%0, $1		\n"
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  192  #endif
> 04988d6fda5c1c include/asm-mips/checksum.h      Thiemo Seufer  =20
> 2005-07-08  193  	"	.set	pop"
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  194  	: "=3Dr" (sum)
> 66218da212bf14 include/asm-mips/checksum.h      Atsushi Nemoto =20
> 2007-01-24 @195  	: "0" ((__force unsigned long)daddr),
> 66218da212bf14 include/asm-mips/checksum.h      Atsushi Nemoto =20
> 2007-01-24  196  	  "r" ((__force unsigned long)saddr),
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  197  #ifdef __MIPSEL__
> 8e3d8433d8c22c include/asm-mips/checksum.h      Al Viro        =20
> 2006-11-14  198  	  "r" ((proto + len) << 8),
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  199  #else
> 8e3d8433d8c22c include/asm-mips/checksum.h      Al Viro        =20
> 2006-11-14  200  	  "r" (proto + len),
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  201  #endif
> 1d464c26b56252 include/asm-mips/checksum.h      Dave Johnson   =20
> 2007-04-18  202  	  "r" ((__force unsigned long)sum));
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  203
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  204  	return sum;
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  205  }
> b4b5015a1c1450 arch/mips/include/asm/checksum.h Ralf Baechle   =20
> 2014-12-17  206  #define csum_tcpudp_nofold csum_tcpudp_nofold
> ^1da177e4c3f41 include/asm-mips/checksum.h      Linus Torvalds =20
> 2005-04-16  207
>=20
> :::::: The code at line 195 was first introduced by commit
> :::::: 66218da212bf141532d678a699f5789c78145ab1 [MIPS] Fix wrong=20
> checksum calculation on 64-bit MIPS
>=20
> :::::: TO: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>=20
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


