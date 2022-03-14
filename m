Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19464D829E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbiCNMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbiCNMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:05:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8778848E7B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:02:03 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A37BB1EC01CE;
        Mon, 14 Mar 2022 13:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647259317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EXzvUYnVA1bHebasBXnECfFY2YfAaZOPqS4CjTkMFw4=;
        b=ZdTRD+gl824VDlabbTXdlHHx3TMzcbUecmjNNGhO+H1Mm3SWwi52CpsSCVaf1ZBah2BEip
        +G+qMtrN9u2V5aBlAVlH3xMe9D/o53X56Wz2M7Ozo5sUz3EHML+WNDNt+d1CTd9gCG+QIX
        JowryStWJkJv1T7G75KqpfA2kaFoLEk=
Date:   Mon, 14 Mar 2022 13:01:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core 4/5] vmlinux.o: warning: objtool:
 do_machine_check()+0x419: call to mca_msr_reg() leaves .noinstr.text section
Message-ID: <Yi8ur4I5RJ2CT0Rx@zn.tnic>
References: <202203141947.9KhIyyR7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202203141947.9KhIyyR7-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 07:40:08PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   cd27ccfc727e99352321c0c75012ab9c5a90321e
> commit: acb13ea0baf8db8d05a3910c06e997c90825faad [4/5] asm-generic/bitops: Always inline all bit manipulation helpers
> config: x86_64-randconfig-a005-20220314 (https://download.01.org/0day-ci/archive/20220314/202203141947.9KhIyyR7-lkp@intel.com/config)
> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=acb13ea0baf8db8d05a3910c06e997c90825faad
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip locking/core
>         git checkout acb13ea0baf8db8d05a3910c06e997c90825faad
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: mce_read_aux()+0x42: call to mca_msr_reg() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: do_machine_check()+0x419: call to mca_msr_reg() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: enter_from_user_mode()+0x4a: call to on_thread_stack() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x53: call to on_thread_stack() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4a: call to on_thread_stack() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4a: call to on_thread_stack() leaves .noinstr.text section

You need to test tip/ras/core with that .config - not some random
patches inside of locking/core. Fixing the noinstr issues is split into
a couple of patches in locking/core and ras/core.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
