Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C354EA83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377626AbiFPUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiFPUFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E8D5A2D6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277E561D82
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86742C34114;
        Thu, 16 Jun 2022 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655409948;
        bh=CIhv/QiVwibyHsK/zhUQ8FSNF/K+nRncJ5yBX5akIRU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XyI9B0xloEjiw8cfvPfIH0y4F6dKmXhvwLgTmWZNFsMTQ2fycP1ORfpJwiCPYavUJ
         EprwSBq0RVQKkYn7hspobpnu/SVKA30ihY6gQ48ufxi2EMU+a/+ovcwMiiGxEV6MAL
         GCBtmMrLZfGT5jpOMXrC8GgUS5EsrFAYZVYAS/J0yHboV/Qpty8kZTuG4xYhH5J0oY
         F9T1BgdZdft5/GIJy8Ld7OV9CoB/uR4DmNAoTOutOUIdkDWeGdarkcGfxscF/b8L/Z
         0/GBXVzdLT3W2uBW3gEc6oHPOoIWvnw4sCcpWzgaNPmnQuXJ+a4dhmJJCc1Sm7ee9T
         T28tY+QmNHS7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 23E685C0531; Thu, 16 Jun 2022 13:05:48 -0700 (PDT)
Date:   Thu, 16 Jun 2022 13:05:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:pmladek.2022.06.15a] BUILD SUCCESS WITH WARNING
 0ba7324b44282870af740a5a121add62c7f5f730
Message-ID: <20220616200548.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <62ab8587.j8Ju7IuzIFZk71FR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ab8587.j8Ju7IuzIFZk71FR%lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:33:27AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git pmladek.2022.06.15a
> branch HEAD: 0ba7324b44282870af740a5a121add62c7f5f730  printk: Wait for the global console lock when the system is going down
> 
> Warning reports:
> 
> https://lore.kernel.org/lkml/202206160411.v3iL3YC0-lkp@intel.com
> https://lore.kernel.org/llvm/202206160421.Gnl3tpxc-lkp@intel.com
> 
> Warning: (recently discovered and may have been fixed)
> 
> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section

Here is the alleged fix, and thank you for testing!

							Thanx, Paul

------------------------------------------------------------------------

commit 571252796c089880b804835f6cfc9c3da3ae8c4f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jun 16 09:30:37 2022 -0700

    context_tracking: Use arch_atomic_read() in __ct_state for KASAN
    
    Context tracking's __ct_state() function can be invoked from noinstr state
    where RCU is not watching.  This means that its use of atomic_read()
    causes KASAN to invoke the non-noinstr __kasan_check_read() function
    from the noinstr function __ct_state().  This is problematic because
    someone tracing the __kasan_check_read() function could get a nasty
    surprise because of RCU not watching.
    
    This commit therefore replaces the __ct_state() function's use of
    atomic_read() with arch_atomic_read(), which KASAN does not attempt to
    add instrumention to.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Frederic Weisbecker <frederic@kernel.org>
    Cc: Marco Elver <elver@google.com>
    Reviewed-by: Marco Elver <elver@google.com>

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0aecc07fb4f50..81c51e5f03143 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
 static __always_inline int __ct_state(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
+	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
 #endif
 
