Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37599484B92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiAEAR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:17:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33700 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiAEAR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:17:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3221EB81898
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 00:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F5AC36AE0;
        Wed,  5 Jan 2022 00:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641341843;
        bh=55rSL6GRXICHDK3q3Eo/KMoAX3C/mwtkjeahSiSnbeg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cVTP55TkUgq5ReJ2ahzV5jwCqJYR5qO8/XWtQp3X41LcLtHuSzEvKPOi0fIjX4mZp
         R6cx47d/gZmjQkJcjlcVQilLaW3AMwk2/kBNIpBe1dBP2OOVKPCE7sxYwlG6f1jcU0
         w4nbvFNlZXkrcT47KOJKzHV0trmFr7o9EgQGqBezbJLCoSO4ZfzcXis0CaN8QoCMpS
         cHnVrRmX8xkFrOwCWeqzXSlX372RLUwg0Wjup0303sB9YeZALV9OExrYgQF4xB8DvU
         emp8mY1EyB7wO0G0hOjBa5NTuzhg+b0zFXMVLNwAJPecaBJG+677Xz+F/XmBavQEbC
         bhNhStPbOqxjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 98FAA5C0C34; Tue,  4 Jan 2022 16:17:23 -0800 (PST)
Date:   Tue, 4 Jan 2022 16:17:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     longman@redhat.com, feng.tang@intel.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL clocksource] Clocksource watchdog commits for v5.17
Message-ID: <20220105001723.GA536708@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas,

This pull request contains a pair of changes, both courtesy of Waiman
Long:

1.	Avoids accidental unstable marking of clocksources by rejecting
	clocksource measurements where the source of the skew is the delay
	reading reference clocksource itself.  This change avoids many
	of the current false positives caused by epic cache-thrashing
	workloads.

	https://lore.kernel.org/lkml/20211118191439.1000012-2-longman@redhat.com/

2.	Reduces the default clocksource_watchdog() retries to 2, thus
	offsetting the increased overhead due to #1 above rereading the
	reference clocksource.

	https://lore.kernel.org/lkml/20211118191439.1000012-3-longman@redhat.com/

These have been subjected to the kbuild test robot and -next testing,
and are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource

for you to fetch changes up to 1a5620671a1b6fd9cc08761677d050f1702f910c:

  clocksource: Reduce the default clocksource_watchdog() retries to 2 (2021-11-30 17:22:29 -0800)

----------------------------------------------------------------
Waiman Long (2):
      clocksource: Avoid accidental unstable marking of clocksources
      clocksource: Reduce the default clocksource_watchdog() retries to 2

 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 kernel/time/clocksource.c                       | 52 ++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 12 deletions(-)
