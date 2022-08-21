Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6759B461
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiHUOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiHUOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:19:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D4A165B3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661091553;
        bh=i7JBXf2cv8reUQcZbheK88+YSiOap4sMEEkEyTrm4SU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KSFGiRXHjhVIQU8znhYOuabkqY8sFBRBw0wMTn2dIR0fTOWncaY+7GwISFCkXsTJr
         b1DNkW9TYcVeeho0tkWoEhW3qOE+AVF4sFecTiHHrZQgoq2KwAoKIMl9eq2sc1XTMe
         0onyLTQ/rFLyuh30cZOhGeMgMy1y2LTD4eRoVfPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.188.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1pGUny0MQV-00rpmr; Sun, 21
 Aug 2022 16:19:13 +0200
Message-ID: <138d7324-e769-1c5c-2976-d9b1f0bd4e45@gmx.de>
Date:   Sun, 21 Aug 2022 16:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 08/11] parisc: mm: Convert to GENERIC_IOREMAP
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
References: <20220820003125.353570-9-bhe@redhat.com>
 <202208201135.YyN9CXsu-lkp@intel.com> <YwIIYHYnkJkY4yf3@MiWiFi-R3L-srv>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <YwIIYHYnkJkY4yf3@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uh3Mr1Su/PEN4szzyuuy5Jkck43zfhtgf3O8nQX+w+f7YoZZuvv
 aU2Lkz3+NVgtpYHbPOSzS+PZXDve10Ah+ktq+Cf84JFXe81y4hcgFsDYbN7VapP2W9nem7L
 fDbCnjklbuTBffVKavv/oJHvx/EW+a1tF+CDFBSFismwE3tJLOwFltIGaZpYjWXiTNg05QO
 KtlaS/7kDQBN/7bVR6WRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PiyqIqWJSdU=:nJ8WYsb50qAOOr6VkK4Pf9
 4/Ef6SaBzQA9wq26BeN5fiCiNhCEZ1emnCcrkv5ctB1DDH3ZjS3TDMKBM5FEGLDehumCL63JL
 sYYp52u5biKgDFv74uusvm+XePZO+IDskSneeE3bXZpjtLnLoQwmD8FgX+EnEnc3K2sBqslFi
 C8zMh/cLUpUmwMQ+WwoAkWVo5gxhZa5LYL0KxoNi+1f3Aa2ZJ/7mh7+coB8AhJpqR43BIoQkB
 8RHJxRKhPB38w7+yHqR8+Oz/5EZoP1l93LxNXrCJSpqdhBvnHCqCbiloboWURnr++6z49IDZQ
 qzKhJ4CX27RAw9NKZcR+fGIoAj8buBStvT3Cr6+/v/XoFkVLfIDjEzkMsgJsaSAt0GvNgnej+
 n/jJUyNkYQNHRgsbCOREAJBb7bcnSMeHf2MmlhkVUipR0BJYIfe/LvIbW4vPrGca5pk9jQpyd
 ZNmVkUESYDolLD9pB+jwZocaYnNTT5quvO3hqn9dXJrww+V+0SGPPiZ6dItemzhjyLCZEchK1
 ydDWkgQzMOZ5l5SRKrMDi0mpAVYJKXjLzWCmG5I7xYY/6yCT+32PHds/jzTKRurx94pPES0c+
 0QuCoLf3WftDLcVnvi4mWLs1KaPP0lsx0OaE7xrH/ytj1nCgH+aDxJiGrfD3nFFPxvCRa5e6X
 rM0gSLzRsuRdVew58qSFkDmLROTPJKq95fUUnCU7UG+rZnrea7R8Wj2Uu2SJWSDV2DwhaKB4f
 zVcwtwJbY7zAEs/qHFmzSLvWM2YGPFTMeH8FwGN6KBgg8WCzkD3Q3M46gqo25AmqtzXBBJ0CN
 PMi022IykD90TXKj3LHhGzLIRKy+gOoBwvkoR3K0lXUcFadObRJdGvwqCxqVjBb3DnTtL+264
 FXh9/5qMZxtsIDihkdApyyFQRBhDmeIohn2ZjL/u9QZeM/QyPfXMblLBrEYoV2M5GLdggCqp8
 P2f6RtqJBcsfbvTDWIQ1XzINZnS4DBRKmX+spwFXRAkkBdNqOE/inqOIkI0O9GjJYAbuz7/LW
 y3YfLhRFLwcvvSirietQ9Q/DSiV50g5ac9IsZIP+MpN9F0NetHExwXOf94T8lixjqw1MGmOeG
 jIEXHOksplHVkQtIhna7qtb9FYHEZ4gjkwwwSIzQNilHiHDjFcizPM7cw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 12:26, Baoquan He wrote:
> Hi,
>
> On 08/20/22 at 12:03pm, kernel test robot wrote:
>> Hi Baoquan,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on akpm-mm/mm-everything]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-io=
remap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-=
everything
>> config: parisc-randconfig-r005-20220820 (https://download.01.org/0day-c=
i/archive/20220820/202208201135.YyN9CXsu-lkp@intel.com/config)
>> compiler: hppa-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=3D1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/intel-lab-lkp/linux/commit/570f2a3347cc83c=
9ea71d3dbbebfad8ea085ecc6
>>         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
>>         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-=
architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>>         git checkout 570f2a3347cc83c9ea71d3dbbebfad8ea085ecc6
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dparisc prepare
>
> Thanks for reporting. While it failed with "hppa-linux-gcc: unknown comp=
iler" as below showing. Could you help check and tell what's wrong?

You need to install the gcc-hppa64-linux-gnu and gcc-hppa-linux-gnu DEBs/R=
PMs.
As COMPILER you probably only need "gcc" (or leave COMPILER empty/unset).

Then run "make ARCH=3Dparisc64"  (64bit)   or  "make ARCH=3Dparisc" (32bit=
).
The Makefile should automatically detect your compiler..

Helge

>
> [root@ ~]# ls
> 0day  anaconda-ks.cfg  bin  EFI_BOOT_ENTRY.TXT  linux  NETBOOT_METHOD.TX=
T  original-ks.cfg  RECIPE.TXT
> [root@ ~]# ls 0day/gcc-12.1.0-nolibc/
> hppa-linux  x86_64-gcc-12.1.0-nolibc_hppa-linux.tar.xz
> [root@ ~]# ls bin/make.cross
> bin/make.cross
> [root@ ~]# pwd
> /root
> [root@ ~]# cd linux/
> [root@ linux]# pwd
> /root/linux
>
> [root@ linux]# COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 =
make.cross W=3D1 O=3D/root/linux/build_dir ARCH=3Dparisc prepare
> Compiler will be installed in /root/0day
> PATH=3D/root/0day/gcc-12.1.0-nolibc/hppa-linux/bin:/root/.local/bin:/roo=
t/bin:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
> make --keep-going --jobs=3D160 W=3D1 O=3D/root/linux/build_dir ARCH=3Dpa=
risc prepare
> make[1]: Entering directory '/root/linux/build_dir'
> /root/0day/gcc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: /root/0day/g=
cc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: cannot execute binary file
>   SYNC    include/config/auto.conf.cmd
> /root/0day/gcc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: /root/0day/g=
cc-12.1.0-nolibc/hppa-linux/bin/hppa-linux-gcc: cannot execute binary file
>   GEN     Makefile
> hppa-linux-gcc: unknown compiler
> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
> make[3]: *** [../scripts/kconfig/Makefile:77: syncconfig] Error 1
> make[2]: *** [../Makefile:632: syncconfig] Error 2
> make[1]: *** [/root/linux/Makefile:734: include/config/auto.conf.cmd] Er=
ror 2
> make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
> make[1]: Failed to remake makefile 'include/config/auto.conf'.
>   GEN     Makefile
> Error: kernelrelease not valid - run 'make prepare' to update it
> make[1]: Target 'prepare' not remade because of errors.
> make[1]: Leaving directory '/root/linux/build_dir'
> make: *** [Makefile:222: __sub-make] Error 2
> make: Target 'prepare' not remade because of errors.
>
>
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    In file included from arch/parisc/include/asm/io.h:315,
>>                     from include/linux/io.h:13,
>>                     from include/linux/irq.h:20,
>>                     from arch/parisc/include/asm/hardirq.h:13,
>>                     from include/linux/hardirq.h:11,
>>                     from arch/parisc/kernel/asm-offsets.c:21:
>>>> include/asm-generic/iomap.h:97: warning: "ioremap_wc" redefined
>>       97 | #define ioremap_wc ioremap
>>          |
>>    arch/parisc/include/asm/io.h:135: note: this is the location of the =
previous definition
>>      135 | #define ioremap_wc(addr, size)  \
>>          |
>>    include/linux/io.h: In function 'pci_remap_cfgspace':
>>>> include/linux/io.h:89:44: error: implicit declaration of function 'io=
remap'; did you mean 'ioremap_np'? [-Werror=3Dimplicit-function-declaratio=
n]
>>       89 |         return ioremap_np(offset, size) ?: ioremap(offset, s=
ize);
>>          |                                            ^~~~~~~
>>          |                                            ioremap_np
>>>> include/linux/io.h:89:42: warning: pointer/integer type mismatch in c=
onditional expression
>>       89 |         return ioremap_np(offset, size) ?: ioremap(offset, s=
ize);
>>          |                                          ^
>>    cc1: some warnings being treated as errors
>>    make[2]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-off=
sets.s] Error 1
>>    make[2]: Target '__build' not remade because of errors.
>>    make[1]: *** [Makefile:1207: prepare0] Error 2
>>    make[1]: Target 'prepare' not remade because of errors.
>>    make: *** [Makefile:222: __sub-make] Error 2
>>    make: Target 'prepare' not remade because of errors.
>>
>>
>> vim +89 include/linux/io.h
>>
>> 7d3dcf26a6559f Christoph Hellwig 2015-08-10  72
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  73  #ifdef CONFIG_PCI
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  74  /*
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  75   * The PCI specificati=
ons (Rev 3.0, 3.2.5 "Transaction Ordering and
>> b10eb2d50911f9 Hector Martin     2021-03-25  76   * Posting") mandate n=
on-posted configuration transactions. This default
>> b10eb2d50911f9 Hector Martin     2021-03-25  77   * implementation atte=
mpts to use the ioremap_np() API to provide this
>> b10eb2d50911f9 Hector Martin     2021-03-25  78   * on arches that supp=
ort it, and falls back to ioremap() on those that
>> b10eb2d50911f9 Hector Martin     2021-03-25  79   * don't. Overriding t=
his function is deprecated; arches that properly
>> b10eb2d50911f9 Hector Martin     2021-03-25  80   * support non-posted =
accesses should implement ioremap_np() instead, which
>> b10eb2d50911f9 Hector Martin     2021-03-25  81   * this default implem=
entation can then use to return mappings compliant with
>> b10eb2d50911f9 Hector Martin     2021-03-25  82   * the PCI specificati=
on.
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  83   */
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  84  #ifndef pci_remap_cfgs=
pace
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  85  #define pci_remap_cfgs=
pace pci_remap_cfgspace
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  86  static inline void __i=
omem *pci_remap_cfgspace(phys_addr_t offset,
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  87  					       size_t siz=
e)
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  88  {
>> b10eb2d50911f9 Hector Martin     2021-03-25 @89  	return ioremap_np(off=
set, size) ?: ioremap(offset, size);
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  90  }
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  91  #endif
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  92  #endif
>> cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  93
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
>>
>

