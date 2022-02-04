Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC284AA4B3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378559AbiBDX4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378473AbiBDX4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F72DB788C4;
        Fri,  4 Feb 2022 15:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1517D61CE1;
        Fri,  4 Feb 2022 23:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEAEC004E1;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=yUiNHffYq6iT3ABSzr7h3OVqLh7zD9OXsmxGVa+fEq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5pCX4FJ/JXJTCj22BdQ+GkLccILl1kgLKnViF97QgPStPC335Yw4Uzb2Xn96r9t5
         uNnZBBP/Wa54y1hjglJrKOgIFe2+WrN8sgLgTGCSPSm7yjshooGeVqZAbr+AdBH4Ir
         6nyir0++SQoT1IObj36eSLkslW7FMRonlwAzQognFXC0MeGGnezc7JFWO5srt37Yix
         eYqyqD3nWXP24eA5fMTIyqxerfngcp6+kPSUDwldX+CRpg74BzsmrxxOYVd/NUCZjT
         8bmVUZkv64McuqflXF5EwQ6S5qWGB2lvYSL8L3IUM6ovFS/Xp+lu81lPdsnirIlxg0
         eGazvMKfalbdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51F955C0418; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/13] torture: Drop trailing ^M from console output
Date:   Fri,  4 Feb 2022 15:55:49 -0800
Message-Id: <20220204235601.3438-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Console logs can sometimes have trailing control-M characters, which the
forward-progress evaluation code in kvm-recheck-rcu.sh passes through
to the user output.  Which does not cause a technical problem, but which
can look ugly.  This commit therefore strips the control-M characters.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 1c4c2c727dad1..43e1387234d11 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -25,7 +25,7 @@ stopstate="`grep 'End-test grace-period state: g' $i/console.log 2> /dev/null |
 	    tail -1 | sed -e 's/^\[[ 0-9.]*] //' |
 	    awk '{ print \"[\" $1 \" \" $5 \" \" $6 \" \" $7 \"]\"; }' |
 	    tr -d '\012\015'`"
-fwdprog="`grep 'rcu_torture_fwd_prog n_max_cbs: ' $i/console.log 2> /dev/null | sed -e 's/^\[[^]]*] //' | sort -k3nr | head -1 | awk '{ print $2 " " $3 }'`"
+fwdprog="`grep 'rcu_torture_fwd_prog n_max_cbs: ' $i/console.log 2> /dev/null | sed -e 's/^\[[^]]*] //' | sort -k3nr | head -1 | awk '{ print $2 " " $3 }' | tr -d '\015'`"
 if test -z "$ngps"
 then
 	echo "$configfile ------- " $stopstate
-- 
2.31.1.189.g2e36527f23

