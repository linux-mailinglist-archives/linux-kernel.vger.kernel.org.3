Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AD4AA4AE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378372AbiBDX4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiBDX4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3407D84F2B6;
        Fri,  4 Feb 2022 15:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A78A0B83971;
        Fri,  4 Feb 2022 23:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5DFC004E1;
        Fri,  4 Feb 2022 23:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018958;
        bh=BktStQzin+/As+Ke35kasrGp3jVELJq1EFpMB9fq+z0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QXmkIRZtwyNFQfNOY4Wo1mHy+Vmi5ssWLKvJwkaTgfPsbG+/2pRAFHUkeBk22QPOS
         X46DHEvEcVygITv/UlmnoBv9lJmNWvFTwDFae+rmLQ39jbDMAMlwiM3w/ZkkbyGQqW
         Kbh0JlIWmA+B5eSLU8gAgVf9TCo3++sIG30AmwN2k1xbvPa8usQIwWLrhGR+9JHDeV
         vxIaNqrSno9YFeI6mYat6hzObtToxbRFMjz8ySeED4cSzKOnh9i1jro44eiGGGw410
         BCBJxokZ/nEkbxlu4yXQZRo1siqELjkNGsmUSJuOhX/lJnRwjkYm4a/YF0BD1HdkIF
         j1lQpnvYE2vJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 229655C0418; Fri,  4 Feb 2022 15:55:58 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:55:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/13] Torture-test scripting updates for v5.18
Message-ID: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides updates to the torture-test scripting.

1.	Drop trailing ^M from console output.

2.	Allow four-digit repetition numbers for --configs parameter.

3.	Output per-failed-run summary lines from torture.sh.

4.	Make kvm.sh summaries note runs having only KCSAN reports.

5.	Indicate which torture.sh runs' bugs are all KCSAN reports.

6.	Compress KCSAN as well as KASAN vmlinux files.

7.	Make kvm-remote.sh try multiple times to download tarball.

8.	Print only one summary line per run.

9.	Make kvm-find-errors.sh notice missing vmlinux file.

10.	Change KVM environment variable to RCUTORTURE.

11.	Make torture.sh help message match reality.

12.	Test SRCU size transitions.

13.	Provide non-power-of-two Tasks RCU scenarios.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/testing/selftests/rcutorture/bin/console-badness.sh    |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-again.sh          |    4 -
 b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh |    4 -
 b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh  |    4 -
 b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh    |    6 +
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh    |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh         |   17 ++--
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                |    2 
 b/tools/testing/selftests/rcutorture/bin/parse-console.sh      |   10 ++
 b/tools/testing/selftests/rcutorture/bin/torture.sh            |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01        |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N.boot   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot   |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01       |    2 
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh           |    8 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh                  |   14 +--
 tools/testing/selftests/rcutorture/bin/torture.sh              |   40 ++++++----
 17 files changed, 78 insertions(+), 44 deletions(-)
