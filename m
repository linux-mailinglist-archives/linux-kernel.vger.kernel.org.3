Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CBC57487F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiGNJUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbiGNJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:20:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F6B545CE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A24AB823EF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989A0C34114;
        Thu, 14 Jul 2022 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657790251;
        bh=AqWLm0A0re9k6XzaqKJt9/6aUdpL6f/earpvIab68qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIxFF/bQB36iQeO6AyHEvJdN76oyyAT4Gm/QabEwk8woXG8WjzaBDYgeKmVngMbgy
         aFi3pu0kV3veSaCjUGeoqUD2j9+Qgg21+v6O9Ao5h18qUs0b4/uEC0mnpNzZDeeRzK
         Z2xFGBpVpD9ueK2LpE6JI4lM4F4haqK1DFoJw1cI=
Date:   Thu, 14 Jul 2022 11:17:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ben Hutchings <bwh@kernel.org>, kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-stable-rc:linux-5.10.y 6996/7120]
 arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10:
 unreachable instruction
Message-ID: <Ys/fKEc9gAVAgN7T@kroah.com>
References: <202207130344.dwXyDmTk-lkp@intel.com>
 <7b7c5908ccb62f365fff8f55d32baae4c4a6ea89.camel@kernel.org>
 <20220714001842.drzq7oeyk4akk2xo@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714001842.drzq7oeyk4akk2xo@treble>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:18:42PM -0700, Josh Poimboeuf wrote:
> On Thu, Jul 14, 2022 at 01:41:58AM +0200, Ben Hutchings wrote:
> > On Wed, 2022-07-13 at 03:57 +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > head:   ba398a0e54049bb6a1c102245ae84103f103ff2c
> > > commit: 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a [6996/7120] objtool: Assume only ELF functions do sibling calls
> > > config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220713/202207130344.dwXyDmTk-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> > > reproduce (this is a W=1 build):
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
> > >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > >         git fetch --no-tags linux-stable-rc linux-5.10.y
> > >         git checkout 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > > > arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10: unreachable instruction
> > > 
> > > 
> > > objdump-func vmlinux.o ftrace_epilogue:
> > > 0000 000000000008ca70 <ftrace_epilogue>:
> > > 0000    8ca70:	e9 00 00 00 00       	jmp    8ca75 <ftrace_epilogue+0x5>	8ca71: R_X86_64_PLT32	ftrace_stub-0x4
> > > 0005    8ca75:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
> > > 
> > 
> > I don't know what's going on here.  There's a jump to a ret (now
> > potentialy a rethunk), and nothing obviously unreachable. 
> > ftrace_epilogue got simplified by commit 0c0593b45c9b "x86/ftrace: Make
> > function graph use ftrace directly" which maybe avoids the warning in
> > the mainline.
> 
> The unreachable warning is actually pointing to ftrace_stub().  I think
> you need
> 
>   18660698a3d3 ("x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub")

Thanks for the hint, now queued up!

greg k-h
