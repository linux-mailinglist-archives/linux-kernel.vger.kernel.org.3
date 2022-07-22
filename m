Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF9957D7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiGVA2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiGVA2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:28:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBC295C17;
        Thu, 21 Jul 2022 17:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF4DEB826E2;
        Fri, 22 Jul 2022 00:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567B9C3411E;
        Fri, 22 Jul 2022 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658449708;
        bh=zlL75xRrx57HJY0xsOBH0q+zchdcxrbFdFBjnUn01MI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sXXcIH5zf10BAPYH8Tc7pj4YOP9WJSsWDbgCEqBFQFluNxbudnj+2mEOBvUK24+jh
         zfoZZv3nGIKa9QGyPNmGM7OOf5UeHnzs9XXdgtHKTAeXYDs/U7YLros1/gsgQ3qYfs
         kYmv0dECLJ4wOR26mvDVH5QSIs8j5WSdzo2dP76cm1vbKzWpVfGvxP0/mURc5e3XpZ
         XzT8XXVNCmclx1UAIN3gJwAFIWem1rPQXSOKPO7oXOlsAiR86bPYxPm2L7RRhTGj7S
         u2d1BkBAMVAsA4Dyj/8LhaCprZa1xqy+KsKgQtFTG2paAM2g5R3cJAIOsLyEoFEnUt
         uQKjcuyZqhT8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CCA595C03A4; Thu, 21 Jul 2022 17:28:25 -0700 (PDT)
Date:   Thu, 21 Jul 2022 17:28:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        zhangfei.gao@linaro.org, chenxiang66@hisilicon.com,
        shameerali.kolothum.thodi@huawei.com, pbonzini@redhat.com,
        quic_neeraju@quicinc.com, maz@kernel.org, yueluck@163.com
Subject: [GIT PULL] Urgent fix for expedited SRCU v5.19 boot-speed regression
Message-ID: <20220722002825.GA2848736@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This pull request fixes a severe boot-speed regression for embedded
systems running in virtual environments, which are commonly
used for development and debugging.  This regression bloats the
edit/compile/boot/debug cycle, causing considerable pain.  Hence the
urgent pull request into v5.19 rather than waiting for the upcoming
merge window.

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.07.21a

for you to fetch changes up to 4f2bfd9494a072d58203600de6bedd72680e612a:

  srcu: Make expedited RCU grace periods block even less frequently (2022-07-19 11:39:59 -0700)

----------------------------------------------------------------
Urgent RCU pull request for v5.19

This pull request contains a pair of commits that fix 282d8998e997 ("srcu:
Prevent expedited GPs and blocking readers from consuming CPU"), which
was itself a fix to an SRCU expedited grace-period problem that could
prevent kernel live patching (KLP) from completing.  That SRCU fix for
KLP introduced large (as in minutes) boot-time delays to embedded Linux
kernels running on qemu/KVM.  These delays were due to the emulation of
certain MMIO operations controlling memory layout, which were emulated
with one expedited grace period per access.  Common configurations
required thousands of boot-time MMIO accesses, and thus thousands of
boot-time expedited SRCU grace periods.

In these configurations, the occasional sleeps that allowed KLP to proceed
caused excessive boot delays.  These commits preserve enough sleeps to
permit KLP to proceed, but few enough that the virtual embedded kernels
still boot reasonably quickly.

This represents a regression introduced in the v5.19 merge window,
and the bug is causing significant inconvenience, hence this pull request.

----------------------------------------------------------------
Neeraj Upadhyay (1):
      srcu: Make expedited RCU grace periods block even less frequently

Paul E. McKenney (1):
      srcu: Block less aggressively for expedited grace periods

 Documentation/admin-guide/kernel-parameters.txt | 18 +++++
 kernel/rcu/srcutree.c                           | 98 +++++++++++++++++++------
 2 files changed, 92 insertions(+), 24 deletions(-)
