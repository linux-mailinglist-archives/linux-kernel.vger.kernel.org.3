Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B294AA4B5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378568AbiBDX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57180 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378342AbiBDX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B67161C06;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85771C340ED;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=qU/X28t3xt64+svQlUadiSmkrK/1fx6AE+NyJW+8BKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uY6NzbvxZiOXDEVtiBqsv/LFWoLJPS18tYswjVEwTcc6pkBVlJUS4G1w6JRanKqtU
         xM1TpZlKBWCY8m37rwDqeCDcz0XXVuWhOyRGLk0m+6Vgq38F9sg+89tUxPMB12cojw
         uTKkIYvprCaVi/vuqJinlIXuJ0Jq+bDbRp02XAAd1FF1q3wdujvEmjoFmk4KC+6bHs
         dkba2vM9ReR5oBOQTwqBix4oYTsYw/YU1syzBH+f8T/TM8soS6+URe6saSAXVuOTvK
         0yQ2mbtZyHwKhgzzAoFxFVkjQsMoCQx8SIsbZlhgAkONpYT/mjEiJ7OIHQP2vcRxPE
         UmZ4vAYt+n1iQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 573825C0829; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/13] torture: Allow four-digit repetition numbers for --configs parameter
Date:   Fri,  4 Feb 2022 15:55:50 -0800
Message-Id: <20220204235601.3438-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a clear-cut case of "not thinking big enough", kvm.sh limits the
multipliers for torture-test scenarios to three digits.  Although this is
large enough for any single system that I have ever run rcutorture on,
it does become a problem when you want to use kvm-remote.sh to run as
many instances of TREE09 as fit on a set of 20 systems with 80 CPUs each.

Yes, one could simply say "--configs '800*TREE09 800*TREE09'", but this
commit removes the need for that sort of hacky workaround by permitting
four-digit repetition numbers, thus allowing "--configs '1600*TREE09'".

Five-digit repetition numbers remain off the menu.  Should they ever
really be needed, they can easily be added!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6de0c183db5b9..348ad177a5acc 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -280,7 +280,7 @@ configs_derep=
 for CF in $configs
 do
 	case $CF in
-	[0-9]\**|[0-9][0-9]\**|[0-9][0-9][0-9]\**)
+	[0-9]\**|[0-9][0-9]\**|[0-9][0-9][0-9]\**|[0-9][0-9][0-9][0-9]\**)
 		config_reps=`echo $CF | sed -e 's/\*.*$//'`
 		CF1=`echo $CF | sed -e 's/^[^*]*\*//'`
 		;;
-- 
2.31.1.189.g2e36527f23

