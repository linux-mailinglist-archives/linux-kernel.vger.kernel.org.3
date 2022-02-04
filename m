Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E614AA4B4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378588AbiBDX4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46806 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378438AbiBDX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48F90B83976;
        Fri,  4 Feb 2022 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF03C340F8;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=ACmcwdY4MgtqGSA8Oxt64UKc7QSVDvDydQ0r63LBD8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjYdkp31gvi5iNiPukP5WLzCsoVzVY4gv1dvsC8S+SXj+oTEATUN8LTqSTJguNMGC
         CWNYUd1ekSgyQOYkSdLpA279hBC7y+innoCfn3Doo1yya12ZektPo5rl6f2w3ASaSb
         78dmFYW6idVlOsuW48oxYqB5y5r8hgzHQ4NfQjuEq+xsX17aUQZe5La4lXKDj97BfM
         9oN2SX0nJcUgKzRWXztYk3lCw9epi79WOqsQAp1W7OHJ1ncHbYMRoTiYXLZvQ8nA6q
         p6xrnyYuHTcRXrCFZvckbevTRfp0LgugNENvc5GWgyGqkfkgDC1vfFb45d5+1ZI9c4
         a5TC1lQUednRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6086E5C0A21; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/13] torture: Make kvm-remote.sh try multiple times to download tarball
Date:   Fri,  4 Feb 2022 15:55:55 -0800
Message-Id: <20220204235601.3438-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit ups the retries for downloading the build-product tarball
to a given remote system from once to five times, the better to handle
transient network failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-remote.sh      | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index e09b1bc787084..29b068a55b466 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -155,18 +155,23 @@ do
 	echo Downloading tarball to $i `date` | tee -a "$oldrun/remote-log"
 	cat $T/binres.tgz | ssh $i "cd /tmp; tar -xzf -"
 	ret=$?
-	if test "$ret" -ne 0
-	then
-		echo Unable to download $T/binres.tgz to system $i, waiting and then retrying. | tee -a "$oldrun/remote-log"
+	tries=0
+	while test "$ret" -ne 0
+	do
+		echo Unable to download $T/binres.tgz to system $i, waiting and then retrying.  $tries prior retries. | tee -a "$oldrun/remote-log"
 		sleep 60
 		cat $T/binres.tgz | ssh $i "cd /tmp; tar -xzf -"
 		ret=$?
 		if test "$ret" -ne 0
 		then
-			echo Unable to download $T/binres.tgz to system $i, giving up. | tee -a "$oldrun/remote-log"
-			exit 10
+			if test "$tries" > 5
+			then
+				echo Unable to download $T/binres.tgz to system $i, giving up. | tee -a "$oldrun/remote-log"
+				exit 10
+			fi
 		fi
-	fi
+		tries=$((tries+1))
+	done
 done
 
 # Function to check for presence of a file on the specified system.
-- 
2.31.1.189.g2e36527f23

