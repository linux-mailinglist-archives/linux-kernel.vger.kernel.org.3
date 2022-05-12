Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68293525355
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356914AbiELRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356909AbiELRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:12:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56CE9E9C2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 840F8B829B9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034FBC385B8;
        Thu, 12 May 2022 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652375517;
        bh=ERf+o50ufn9OF177lvaoSS0BH6EvZkyDYDZBheKGLmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWFzDxPuDAn2wAaGjXuJGcHJwgfrmqcxlSznSQyChlPRrjLVqzRJIKcDWrbaDVN+k
         iJCFmcoBtyPJsPUdkKprabhyMDon/HLfBZ6B5W2GWZjr0o5uhrkpeLEWo8kmzR/cUD
         /0M1mFO7+/sB6r8VXn60VyIB4ithexRdtRJYvzIIIH+h6mw1fZHQDcstTPSIlHzjiR
         lmYWoY/FwapGbzczOTkk/ZUO2dFNC3WnkZ95fUbkjQ6+j+/FIJDUBdRCP8P2fukrFU
         uiYVRWS1NXQo4WhfsG8aqdPVZri0e9ukvoCtqMxl9cD7XlfJ2Z6L3SD9WH/J+KvDlP
         uETXXJzfgUREA==
Date:   Thu, 12 May 2022 10:11:55 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 146/150]
 kernel/futex.o: warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable
 instruction
Message-ID: <20220512171155.53wc7z3tptixhsny@treble>
References: <202205120956.qLpGQurX-lkp@intel.com>
 <20220512081709.GD76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220512081709.GD76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:17:09AM +0200, Peter Zijlstra wrote:
> On Thu, May 12, 2022 at 10:00:33AM +0800, kernel test robot wrote:
> > tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
> > head:   305e905f70311e1b49cc730931a19c3e364f4d8c
> > commit: 45dc9d706619a6814e4063d5431483f94badb5a1 [146/150] x86: Add straight-line-speculation mitigation
> > config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120956.qLpGQurX-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/ammarfaizi2/linux-block/commit/45dc9d706619a6814e4063d5431483f94badb5a1
> >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> >         git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
> >         git checkout 45dc9d706619a6814e4063d5431483f94badb5a1
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> kernel/futex.o: warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable instruction
> > --
> > >> mm/madvise.o: warning: objtool: madvise_behavior()+0x69: unreachable instruction
> > --
> > >> kernel/bpf/btf.o: warning: objtool: __btf_resolve_size()+0x72: unreachable instruction
> 
> Would it be possible for the robot to include the output of this script:
> 
>   https://lkml.kernel.org/r/3eb3f091fd6bd9caba50392ceab98ce756804f3b.1650578171.git.jpoimboe@redhat.com

Ha, I already forgot about that script.  I'll drop it into my
objtool/core branch (eventually for tip) unless anybody objects.

-- 
Josh
