Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD0465B57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354836AbhLBAuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:50:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41800 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbhLBAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72A3BB821A1;
        Thu,  2 Dec 2021 00:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6039C5831B;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405996;
        bh=bFfRtrRtDFOG150NdmHj0YGgAFRHc0jQHgaLplFEx9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhJa59qfqeSSTFlTuDnVJsARLpaKwQFsYuskZBW3oP32tGfL3jvTYd22kLLDHcliX
         N28q+uoHGK1LRTyivxYFDw3tPv3iwCpqivi0IxZLzMl2IGvVwhKEkG2U7suCvSH/9F
         Hdinmu/XwT0ovY0g9bwclxvfOXoIjshQguyXSxajt74qql6KOl7rJuPPpVKQll26Ps
         NVuEEWfLi2hU9zr6jcCaWmtZd256RsOtXU6T1MwnY1OQDSPXXqPhUtBg/G3PFsCFUd
         GtYt3TWbRKI+9dq2UEjjWzHAFh9bwO3c/y1TyVnmn4moxmknylRlG+TmtWC17JyO0R
         EpkvjSbaSugGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6F6AA5C1183; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/8] torture: Fix incorrectly redirected "exit" in kvm-remote.sh
Date:   Wed,  1 Dec 2021 16:46:33 -0800
Message-Id: <20211202004634.3130489-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "exit 4" in kvm-remote.sh is pointlessly redirected, so this commit
removes the redirection.

Fixes: 0092eae4cb4e ("torture: Add kvm-remote.sh script for distributed rcutorture test runs")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 67ebc56111e3f..7ab79b0d5ad19 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -144,7 +144,7 @@ do
 	if test "$ret" -ne 0
 	then
 		echo System $i unreachable, giving up. | tee -a "$oldrun/remote-log"
-		exit 4 | tee -a "$oldrun/remote-log"
+		exit 4
 	fi
 done
 
-- 
2.31.1.189.g2e36527f23

