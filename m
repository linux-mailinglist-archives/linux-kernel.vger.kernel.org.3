Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B37D4B5560
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355991AbiBNPxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:53:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355985AbiBNPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:53:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD90F60AA9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 519FAB81167
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A84C340E9;
        Mon, 14 Feb 2022 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644853989;
        bh=jLvxgQZxaKOAqXhYrM5X1Wu5kLbIgCnhJeKHmC+J/hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQKVAu2uhc9aOAP+y7UGrprRWpt3DynGUNCiscNmjhGuzfwwkwi5m1z+ikunfTgp0
         A+MtOkmrXFBm+xAdXxuaxv8uXfbzijCAeWyw6P5Enw9ypt94YI6uZDKoyXPp+o+N7q
         s4SIz0xvqbqJP5vqTHLjUnV43SmLu+NDzZ9eQqiE6U/s8dMTZ1SmDDyaBciqkQl/t2
         STkV0H43IJluM5xai44liuwSe/z+RLXM7K8xORHhyrbhCfk4cvOYVp+czWFU0mpE0U
         TZsFtVQRzk8Kepfpzo9uZngSH2iylG1+3YliUMp5yigVnd/zYLL3me2Aotb0NXSoeJ
         2p3i/kiMgKCKg==
Date:   Mon, 14 Feb 2022 08:53:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/ftrace.c:7157:20: error: unused function
 'ftrace_startup_enable'
Message-ID: <Ygp64CsyyKyRykqE@dev-arch.archlinux-ax161>
References: <202202132037.4aN017dU-lkp@intel.com>
 <20220214102000.1d3af66e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214102000.1d3af66e@gandalf.local.home>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, Feb 14, 2022 at 10:20:00AM -0500, Steven Rostedt wrote:
> On Sun, 13 Feb 2022 21:03:29 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > All errors (new ones prefixed by >>):
> > 
> > >> kernel/trace/ftrace.c:7157:20: error: unused function 'ftrace_startup_enable' [-Werror,-Wunused-function]  
> >    static inline void ftrace_startup_enable(int command) { }
> >                       ^
> >    1 error generated.
> 
> Strange. I always thought that static inline functions do not cause
> warnings when not used? Especially, since they are often in headers when
> things are turned off. Or is it because this is in a C file?

With -Wunused-function, clang will warn about unused static inline
functions within a .c file (but not .h), whereas GCC will not warn for
either. The unused attribute was added to the definition of inline to
make clang's behavior match GCC's.

> Is this a new warning caused by a commit, or is it a new warning because
> the compiler now complains about it?

However, in commit 6863f5643dd7 ("kbuild: allow Clang to find unused
static inline functions for W=1 build"), Masahiro made it so that the
unused attribute does not get added at W=1 so that instances of unused
static inline functions can be caught and eliminated (or put into use,
if the function should have been used), hence this report.

I will be honest, I don't know why the robot flagged 172f7ba9772c as the
commit that introduced this warning but it seems legitimate if
CONFIG_DYNAMIC_FTRACE is not enabled, since ftrace_startup_enable() is
only ever used within an '#ifdef CONFIG_DYNAMIC_FTRACE' block so I guess
the stub is unnecessary?

Cheers,
Nathan
