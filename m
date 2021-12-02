Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA18465B61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354973AbhLBAvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbhLBAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A2EC061574;
        Wed,  1 Dec 2021 16:46:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18434B8219F;
        Thu,  2 Dec 2021 00:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA071C53FD0;
        Thu,  2 Dec 2021 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405996;
        bh=ZpvkpYDJ0pUPGjs7Q004GvvQMElUEguBsTV6dimk/T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlFqfFqQ0toO3+81etNCDcoRyPLVFRdMLrQriBAh3Lpg7LjlgclbUuQmAnAegl2Gz
         0rw8fYO6yvBldbw5iR2dNum+LkeraywaViDMM65oKbqWx6HB9THkM00I8FInNFwGih
         ssn//bJ36rFfpBNaRIaPinZq+R7dwCDDluUfd3xCC7K1foAAajyMMHFNjpkyCKJWCz
         ArXFieGjv2gc7M8QQYvjb3VhIursAY0vpsUAMgc6CNuSyOxB+JOt2EsHBJnaA4MJWe
         gRPQSWqc5LximvNw9a+fUQE5PXbMpEgpxOcdQDoqX+iyXhnHFcwUTTjyhasLUubowh
         I9Jkx2veSddsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69EC05C1109; Wed,  1 Dec 2021 16:46:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/8] torture: Retry download once before giving up
Date:   Wed,  1 Dec 2021 16:46:30 -0800
Message-Id: <20211202004634.3130489-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004615.GA3130415@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a transient network error can kill a run if it happens while
downloading the tarball to one of the target systems.  This commit
therefore does a 60-second wait and then a retry.  If further experience
indicates, a more elaborate mechanism might be used later.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index c7d42ef80c534..67ebc56111e3f 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -157,8 +157,15 @@ do
 	ret=$?
 	if test "$ret" -ne 0
 	then
-		echo Unable to download $T/binres.tgz to system $i, giving up. | tee -a "$oldrun/remote-log"
-		exit 10 | tee -a "$oldrun/remote-log"
+		echo Unable to download $T/binres.tgz to system $i, waiting and then retrying. | tee -a "$oldrun/remote-log"
+		sleep 60
+		cat $T/binres.tgz | ssh $i "cd /tmp; tar -xzf -"
+		ret=$?
+		if test "$ret" -ne 0
+		then
+			echo Unable to download $T/binres.tgz to system $i, giving up. | tee -a "$oldrun/remote-log"
+			exit 10
+		fi
 	fi
 done
 
-- 
2.31.1.189.g2e36527f23

