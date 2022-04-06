Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764FE4F6B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiDFU0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiDFUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2C934B623
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05F6661655
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 18:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BE6C385A3;
        Wed,  6 Apr 2022 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649270657;
        bh=DPD+gqGzilTAFAdB9aUrsXNWCMtoAzNXiS9BO63EI/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVCh48hz43pgjqInjX7Bo/gSSRRPliJ8dHTisa1UOb7B/eWMVRkJLM72CP1MI6oeR
         lDA84PovMpi37QEcddBo8kV7vVyRBZnm+mM4Ok4yJDMNGXDRFKfBtrB5ZT1+HK2wzZ
         ENNdJh6cKSkjKPl5uCmX/7X470tvDkwdeScCLJoi9olzKla3iHrLuNAy9w1TWZUsDy
         +i2hu+TKE63n70QW/9NsGjXhyOTAFFKg3eP+R0HJaBobggX7Gcif6h4BFCTIaxi18a
         kuVYOmj4wsEJavokjss7pS97m3wO5efreOW0jBg7JwVoicT9xTK3HJI0dgwGSxMGKG
         LApxOFCJhYwCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E85A40407; Wed,  6 Apr 2022 15:44:13 -0300 (-03)
Date:   Wed, 6 Apr 2022 15:44:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <Yk3ffdJ6a3Q2uWRG@kernel.org>
References: <202204041241.Hw855BWm-lkp@intel.com>
 <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
 <20220406000500.5hlaqy5zrdqsg5mg@treble>
 <87czhv11k1.ffs@tglx>
 <20220405212032.3d858b31@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405212032.3d858b31@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 05, 2022 at 09:20:32PM -0400, Steven Rostedt escreveu:
> On Wed, 06 Apr 2022 02:46:22 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > This covers the trace_printk() case which uses do_trace_printk(), but
> > the same problem exists in trace_puts() and ftrace_vprintk()...., no?
> 
> Hmm, I'm not even sure why ftrace_vprintk() is there. It seems redundant.
> 
> Arnaldo,
> 
> Was there a reason for it. The commit that added it isn't very descriptive.

Yeah, I was young and in a hurry.

- Arnaldo
 
> commit 9011262a37cb438f0fa9394b5e83840db8f9680a
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Jan 23 12:06:23 2009 -0200
> 
>     ftrace: add ftrace_vprintk
>     
>     Impact: new helper function
>     
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> 
> -- Steve

-- 

- Arnaldo
