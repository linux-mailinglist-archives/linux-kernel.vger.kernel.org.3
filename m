Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43557F7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 01:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiGXX0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 19:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiGXX0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 19:26:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85BA19E
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE0EDB80D6E
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD017C3411E;
        Sun, 24 Jul 2022 23:26:02 +0000 (UTC)
Date:   Sun, 24 Jul 2022 19:26:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: modpost: vmlinux.o(.text.unlikely+0x1998): Section
 mismatch in reference from the function
 trace_define_generic_fields.isra.0() to the variable
 .init.data:initcall_level_names
Message-ID: <20220724192601.5823c3af@rorschach.local.home>
In-Reply-To: <202207240538.J7vypIlv-lkp@intel.com>
References: <202207240538.J7vypIlv-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 05:29:40 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Steven,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   515f71412bb73ebd7f41f90e1684fc80b8730789
> commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
> date:   8 months ago
> config: xtensa-randconfig-c023-20220722 (https://download.01.org/0day-ci/archive/20220724/202207240538.J7vypIlv-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 12.1.0

This is probably due to the xtensa compiler not inlining the function
like pretty much any other compiler does. It could use a __init, just
because the only function that calls this function also has an __init.

-- Steve


> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a55f224ff5f238013de8762c4287117e47b86e22
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a55f224ff5f238013de8762c4287117e47b86e22
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> << WARNING: modpost: vmlinux.o(.text.unlikely+0x17c8): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names
> >> WARNING: modpost: vmlinux.o(.text.unlikely+0x1998): Section mismatch in reference from the function trace_define_generic_fields.isra.0() to the variable .init.data:initcall_level_names  
> The function trace_define_generic_fields.isra.0() references
> the variable __initdata initcall_level_names.
> This is often because trace_define_generic_fields.isra.0 lacks a __initdata
> annotation or the annotation of initcall_level_names is wrong.
> 

