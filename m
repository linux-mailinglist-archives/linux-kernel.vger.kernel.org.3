Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4053BA1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiFBNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiFBNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:50:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B39F59E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E78CB81F5E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D5CC385A5;
        Thu,  2 Jun 2022 13:50:21 +0000 (UTC)
Message-ID: <25e89d5b-f3b1-1fe1-96d1-745de3c2998a@linux-m68k.org>
Date:   Thu, 2 Jun 2022 23:50:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: arch/m68k/68000/ints.c:82:30: error: 'ISR' undeclared
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <202205310707.ppwnnzce-lkp@intel.com>
 <CAMuHMdWvE=TtqHLOgcdpKGzYgg4JeBcB7YGRBq0qubFxYepULg@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdWvE=TtqHLOgcdpKGzYgg4JeBcB7YGRBq0qubFxYepULg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2/6/22 17:23, Geert Uytterhoeven wrote:
> On Tue, May 31, 2022 at 5:44 PM kernel test robot <lkp@intel.com> wrote:
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
>> commit: 6b8be804ff376f6657ccdf6b29974e7c793d88c4 m68knommu: fix 68000 CPU link with no platform selected
>> date:   6 days ago
>> config: m68k-buildonly-randconfig-r004-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310707.ppwnnzce-lkp@intel.com/config)
>> compiler: m68k-linux-gcc (GCC) 11.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6b8be804ff376f6657ccdf6b29974e7c793d88c4
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 6b8be804ff376f6657ccdf6b29974e7c793d88c4
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/68000/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     arch/m68k/68000/ints.c:77:6: warning: no previous prototype for 'process_int' [-Wmissing-prototypes]
>>        77 | void process_int(int vec, struct pt_regs *fp)
>>           |      ^~~~~~~~~~~
>>     arch/m68k/68000/ints.c: In function 'process_int':
>>>> arch/m68k/68000/ints.c:82:30: error: 'ISR' undeclared (first use in this function)
>>        82 |         unsigned long pend = ISR;
>>           |                              ^~~
>>     arch/m68k/68000/ints.c:82:30: note: each undeclared identifier is reported only once for each function it appears in
>>     arch/m68k/68000/ints.c: In function 'intc_irq_unmask':
>>>> arch/m68k/68000/ints.c:135:9: error: 'IMR' undeclared (first use in this function)
>>       135 |         IMR &= ~(1 << d->irq);
>>           |         ^~~
>>     arch/m68k/68000/ints.c: In function 'intc_irq_mask':
>>     arch/m68k/68000/ints.c:140:9: error: 'IMR' undeclared (first use in this function)
>>       140 |         IMR |= (1 << d->irq);
>>           |         ^~~
>>     arch/m68k/68000/ints.c: At top level:
>>     arch/m68k/68000/ints.c:153:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
>>       153 | void __init trap_init(void)
>>           |             ^~~~~~~~~
>>     arch/m68k/68000/ints.c:172:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
>>       172 | void __init init_IRQ(void)
>>           |             ^~~~~~~~
>>     arch/m68k/68000/ints.c: In function 'init_IRQ':
>>>> arch/m68k/68000/ints.c:176:9: error: 'IVR' undeclared (first use in this function)
>>       176 |         IVR = 0x40; /* Set DragonBall IVR (interrupt base) to 64 */
>>           |         ^~~
>>     arch/m68k/68000/ints.c:179:9: error: 'IMR' undeclared (first use in this function)
>>       179 |         IMR = ~0;
>>           |         ^~~
> 
> If M68000=y, but none of M68{,EZ,VZ}328 are enabled, ISR and IMR are
> not defined. Most of the code in arch/m68k/68000/ints.c is specific
> to the '328 series, and does not apply to plain 68000, but we can't
> just not compile ints.c, as we do need definitions of trap_init()
> and init_IRQ().
> Factor out the '328 parts in dragonball.o, and keep a __weak dummy
> init_IRQ() in ints.c?

Seems like a reasonable approach. I think the 68000/m68328.c might be
an appropriate place to put the '328 specific parts.

I will put a patch together.

Regards
Greg



> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
