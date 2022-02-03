Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB81C4A7F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbiBCGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbiBCGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:15:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33E1C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 22:15:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C234B83331
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1B9C340E4;
        Thu,  3 Feb 2022 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643868931;
        bh=0W3MXm7AhCQh+fkNw/0vWeS15IdVWVGV0elLE0piY4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sPEFibGakjMHOgLqN2u6qZnycBP6DWHjEHexjxhoWMeevZ1h8KjrKilAjCrw80pdz
         KaXYdMpKqhc/bv/GKIABhaM+vyi13X/TMS0YfxRXQj/q0XZVlscVqXD+HXRD0iN55p
         sRahFcMn3Nbp9i7d483idkELmWTWh8alOyRDrm/39wAQvhYdXwKmjyVZPXI6vnVYkT
         RWpoXAHGs882Q0eDIW1gy+ID4yP59gk62A0bJYoj4KKtAiKlzUV4RzgbiHrpYKRLN2
         hapGe/jy7HWa768GvT4pYrAXQLGforXOx45HyO+gGicZt/bjmts0EztU0jZf9fHSg1
         o2IVjTyoyzrBQ==
Date:   Thu, 3 Feb 2022 15:15:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [jolsa-perf:bpf/fprobe_link 3/10] include/linux/fprobe.h:20:33:
 error: field 'ops' has incomplete type
Message-Id: <20220203151527.70ae91707dcf69f1e3d276e6@kernel.org>
In-Reply-To: <202202031105.OEGj0FZz-lkp@intel.com>
References: <202202031105.OEGj0FZz-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

This may happen if CONFIG_FUNCTION_TRACER=n. Let me fix it.

Thank you,


On Thu, 3 Feb 2022 11:20:41 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fprobe_link
> head:   f35f5b111d32e11c2201dcbfa5e3c8c0560a0a43
> commit: 5292dedae3df76ecaa8b83f3a440172a78fff570 [3/10] bpf: Add support to attach kprobe program with fprobe
> config: arc-randconfig-r043-20220130 (https://download.01.org/0day-ci/archive/20220203/202202031105.OEGj0FZz-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=5292dedae3df76ecaa8b83f3a440172a78fff570
>         git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>         git fetch --no-tags jolsa-perf bpf/fprobe_link
>         git checkout 5292dedae3df76ecaa8b83f3a440172a78fff570
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/bpf/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/bpf/syscall.c:35:
> >> include/linux/fprobe.h:20:33: error: field 'ops' has incomplete type
>       20 |         struct ftrace_ops       ops;
>          |                                 ^~~
> 
> 
> vim +/ops +20 include/linux/fprobe.h
> 
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26   9  
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  10  /**
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  11   * struct fprobe - ftrace based probe.
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  12   * @ops: The ftrace_ops.
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  13   * @nmissed: The counter for missing events.
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  14   * @flags: The status flag.
> 806149decce8b0 Masami Hiramatsu 2022-01-26  15   * @rethook: The rethook data structure. (internal data)
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  16   * @entry_handler: The callback function for function entry.
> 806149decce8b0 Masami Hiramatsu 2022-01-26  17   * @exit_handler: The callback function for function exit.
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  18   */
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  19  struct fprobe {
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26 @20  	struct ftrace_ops	ops;
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  21  	unsigned long		nmissed;
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  22  	unsigned int		flags;
> 806149decce8b0 Masami Hiramatsu 2022-01-26  23  	struct rethook		*rethook;
> 806149decce8b0 Masami Hiramatsu 2022-01-26  24  
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  25  	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
> 806149decce8b0 Masami Hiramatsu 2022-01-26  26  	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip, struct pt_regs *regs);
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  27  };
> 8249a1c232ade1 Masami Hiramatsu 2022-01-26  28  
> 
> :::::: The code at line 20 was first introduced by commit
> :::::: 8249a1c232ade17392af10f640a79a5200744474 fprobe: Add ftrace based probe APIs
> 
> :::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
> :::::: CC: Masami Hiramatsu <mhiramat@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
Masami Hiramatsu <mhiramat@kernel.org>
