Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF814C2060
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbiBXAHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbiBXAHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:07:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6147558
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:07:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB7B4B82285
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1ECC340E7;
        Thu, 24 Feb 2022 00:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645661238;
        bh=TG+Tehz63mxbHbYm3guFDQurqZUP6yX9o5UlX3VsU1g=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=mhTqHL7SgydLyS3/SSxbidj13tRdu5TWpePBYmGE8PDDUjT+yAq5aoqFCXDG2pYwm
         negB51HhZ4nC3nBLBqiFNW/kCCnVnVpCj+66uNY6Nt1+eh/3RrkUeDu39ed5ik6d7z
         Gzr/pz+nfQ2UVDF9SFzv7cIKh0uLMTN9o19B5rRC9so91zf3Wl7hXalAOXXa9Ajs9p
         eZ7CSeQEBpZ9qfsA7KW9VnM/0WxXG9g3/8Yzyr6Uj1MYaVxKjc8sckoilAaDVajKLK
         ViNXoVio1I02W8xGdW8zllYOxaKO3wpAhiW6h983dnv8HW2sL3ZQywMradhFfYSI+2
         cIBFCOnoc9ZpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 070B95C0870; Wed, 23 Feb 2022 16:07:18 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:07:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        john.stultz@linaro.org, ak@linux.intel.com, rong.a.chen@intel.com,
        sboyd@kernel.org, longman@redhat.com
Subject: [GIT PULL clocksource] Clocksource watchdog commits for v5.18
Message-ID: <20220224000718.GA3747431@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas,

This pull request contains a single change that allows build-time
adjustment of the clocksource watchdog maximum skew.  The default remains
100 microseconds, but a new CLOCKSOURCE_WATCHDOG_MAX_SKEW_US Kconfig
option allows kernels to be built with this skew set in a range from
50 to 100 microseconds.  This Kconfig option depends on the existing
CLOCKSOURCE_WATCHDOG option.  This change has been posted to LKML:

https://lore.kernel.org/lkml/20211206033815.871823-1-longman@redhat.com/

this has been subjected to the kbuild test robot and -next testing,
and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource.2022.02.01b

for you to fetch changes up to fc153c1c58cb8c3bb3b443b4d7dc3211ff5f65fc:

  clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW (2022-02-01 17:35:43 -0800)

Please note that this is based on this mainline commit:

da123016ca8c ("rcu-tasks: Fix computation of CPU-to-list shift counts")

which is in turn based on v5.17-rc1.

----------------------------------------------------------------
Waiman Long (1):
      clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW

 kernel/time/Kconfig       | 9 +++++++++
 kernel/time/clocksource.c | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)
