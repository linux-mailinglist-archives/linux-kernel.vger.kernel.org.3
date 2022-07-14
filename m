Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E360574068
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiGNASw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGNASs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AABF49
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7E261BBB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EF9C34114;
        Thu, 14 Jul 2022 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657757924;
        bh=s2jppAvnaEIOitXCk0btEGH24tLzcDR+EAid2TPfudM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uW3/HudbjgoOO8bo1RH4yw4Oymhh7H8tO0AVnNmFCBoQnEYJNquuW8voEeDnQ37dt
         NFDWJ/ONmJLcD1K5BwtyUEAzMAB+b6yiWagd660vcnYe9RCsnwIlHmTWIiCF63Vexv
         fLKJO9TVCYUR9KgW3KPAGlMez1m0c2tEQx/e4ifsjUD3Gy9UCCWdbwwb2hCUfauzbI
         bqERJCc26hoZsKL7hm++T7L4j806pPRCWJZZLGwY/XjjftPPosaxTJL24217mkN2UE
         +qvqAOvXFqk0Z2msgvuXMgbiAhBgl+3WZ4SNivLrAfnClg/MqZESRvCOWBYU3N1RnW
         YoBoOiU6cHY9w==
Date:   Wed, 13 Jul 2022 17:18:42 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ben Hutchings <bwh@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [linux-stable-rc:linux-5.10.y 6996/7120]
 arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10:
 unreachable instruction
Message-ID: <20220714001842.drzq7oeyk4akk2xo@treble>
References: <202207130344.dwXyDmTk-lkp@intel.com>
 <7b7c5908ccb62f365fff8f55d32baae4c4a6ea89.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b7c5908ccb62f365fff8f55d32baae4c4a6ea89.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:41:58AM +0200, Ben Hutchings wrote:
> On Wed, 2022-07-13 at 03:57 +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > head:   ba398a0e54049bb6a1c102245ae84103f103ff2c
> > commit: 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a [6996/7120] objtool: Assume only ELF functions do sibling calls
> > config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220713/202207130344.dwXyDmTk-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
> >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >         git fetch --no-tags linux-stable-rc linux-5.10.y
> >         git checkout 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > > > arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10: unreachable instruction
> > 
> > 
> > objdump-func vmlinux.o ftrace_epilogue:
> > 0000 000000000008ca70 <ftrace_epilogue>:
> > 0000    8ca70:	e9 00 00 00 00       	jmp    8ca75 <ftrace_epilogue+0x5>	8ca71: R_X86_64_PLT32	ftrace_stub-0x4
> > 0005    8ca75:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
> > 
> 
> I don't know what's going on here.  There's a jump to a ret (now
> potentialy a rethunk), and nothing obviously unreachable. 
> ftrace_epilogue got simplified by commit 0c0593b45c9b "x86/ftrace: Make
> function graph use ftrace directly" which maybe avoids the warning in
> the mainline.

The unreachable warning is actually pointing to ftrace_stub().  I think
you need

  18660698a3d3 ("x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub")

-- 
Josh
