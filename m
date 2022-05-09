Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BF851F223
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiEIB27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiEIBTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 21:19:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D1DEAA
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9JrCOCM30ilOC9vzCqWbSPlDJ7txpo/M+NzbZ8p3R0E=; b=WVjIBbD7AL0NyglpP6OcDY6XvD
        cLHBlr4nlgTK1UpZtsOne3hlswXVeWg6YdtNHoQyX5yUoUAYd7sCtyk1eT1vZWYpDAPjYEyLKkgCZ
        crvcRALGOijK2C9L4cxd9BB3YKXq3v8rkY7Hks3fwlqgp3VKquNj1zz3Ac89y8heVAoj6HEieLjNp
        0MzPrzrx8+3ptaHQFfqSqdbNKmvppEUx2SLZ9nbFDiOULEJicK1lg/6AZlrrkZ4pGjb/iweV/WH7k
        fqSO4RyXHB0Hve66aTaZjPh3j3tKrOiFIY3WLlg1FeDzW9LgnSraji+0P6SpcORzF+af72Tv0EhKV
        BOX6kI6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnrzR-002zYW-Tg; Mon, 09 May 2022 01:15:09 +0000
Date:   Mon, 9 May 2022 02:15:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: modpost: vmlinux.o(.text+0xa76d36): Section mismatch in
 reference from the function rtc_update_irq() to the variable .init.text:.L0
Message-ID: <YnhrHXHv8tjotmnE@casper.infradead.org>
References: <202205090847.j9NvIYxI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205090847.j9NvIYxI-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:14:44AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> commit: 170f37d6aa6ad4582eefd7459015de79e244536e block: Do not call folio_next() on an unreferenced folio
> date:   4 days ago
> config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205090847.j9NvIYxI-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=170f37d6aa6ad4582eefd7459015de79e244536e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 170f37d6aa6ad4582eefd7459015de79e244536e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text+0xa76d36): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
> The function rtc_update_irq() references
> the variable __init .L0 .
> This is often because rtc_update_irq lacks a __init
> annotation or the annotation of .L0 is wrong.
> 
> Note: the below error/warnings can be found in parent commit:
> << WARNING: modpost: vmlinux.o(.text+0xa7418e): Section mismatch in reference from the function rtc_month_days() to the variable .init.setup:__setup_root_delay_setup
> << WARNING: modpost: vmlinux.o(.text+0xb2080e): Section mismatch in reference from the function thermal_zone_device_unregister() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb34ff0): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB18955
> << WARNING: modpost: vmlinux.o(.text+0xb5964e): Section mismatch in reference from the function cpuidle_switch_governor() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xbacbfa): Section mismatch in reference from the function comedi_buf_map_get() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1100

I'm going to suggest that my commit is not responsible for anything
other than moving a warning around.  I do not intend to investigate
this further unless someone tells me otherwise.
