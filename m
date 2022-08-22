Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA54A59C1CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiHVOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiHVOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:43:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551EE0F0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BD9BB81236
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A708C433D6;
        Mon, 22 Aug 2022 14:43:37 +0000 (UTC)
Date:   Mon, 22 Aug 2022 10:43:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol
 'da_mon_wip' was not declared. Should it be static?
Message-ID: <20220822104354.2ea2a6f7@gandalf.local.home>
In-Reply-To: <202208210332.gtHXje45-lkp@intel.com>
References: <202208210332.gtHXje45-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2022 03:57:25 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Stephen,
> 

I don't know who this "Stephen" is. There's no-one on the Cc list named
that.

> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   50cd95ac46548429e5bba7ca75cc97d11a697947
> commit: 10bde81c74863472047f31304064018c40f488ee rv/monitor: Add the wip monitor
> date:   3 weeks ago
> config: arm64-randconfig-s032-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210332.gtHXje45-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10bde81c74863472047f31304064018c40f488ee
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 10bde81c74863472047f31304064018c40f488ee
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/trace/rv/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/trace/rv/monitors/wip/wip.c: note: in included file:
>    kernel/trace/rv/monitors/wip/wip.h:30:22: sparse: sparse: symbol 'automaton_wip' was not declared. Should it be static?

So we have:


   struct automaton_wip automaton_wip = {

Which is used only in the one file that includes it. I'm guessing it should
be static. Daniel?

-- Steve


> 
> vim +/da_mon_wip +20 kernel/trace/rv/monitors/wip/wip.c
> 
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  18  
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  19  struct rv_monitor rv_wip;
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @20  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  21  
> 
> :::::: The code at line 20 was first introduced by commit
> :::::: 8812d21219b9c649dd25eb93915e00939944aeb7 rv/monitor: Add the wip monitor skeleton created by dot2k
> 
> :::::: TO: Daniel Bristot de Oliveira <bristot@kernel.org>
> :::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

