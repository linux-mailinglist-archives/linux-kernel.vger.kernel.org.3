Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632835060CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbiDSASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiDSASI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41F140B4;
        Mon, 18 Apr 2022 17:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1F661330;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D769C385A8;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=KulOCDaNqGZ/wljeeFNucBYC2d7vGuKyhnnCjYaSZ40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZyvZLMAOmTR2AjS1hGsalgqq177bHFa93tgxV+JYOOHl47UL+/xxTNlqVNIrH55Q
         9J/FLgDYR2tvLkHIrMJLK5EHtTE2wR2voGeTUf2HuB8IQDTP1djbKiRuDEqY9jFGzT
         OkAKP0jBSn+/ZCbB1HEnlcFIHPlfp2EpslR+ugh6Y4Iz1+2BhRMACromb1eC0bmhi8
         YVC15P07GJAhHIhqyBU72gHbZDxftZ+zgTbgv/riB4zMpIqMIWGHOt55JLrRSNxMAl
         3lDpA6CxdesuZwiWi6jP8qZrGS8Ra7ho8YlftMcgBCphbv5flEaGAOASj3jnXoADxX
         xztFJIQTTjl6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C173C5C04BD; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/12] torture: Reposition so that $? collects ssh code in torture.sh
Date:   Mon, 18 Apr 2022 17:15:14 -0700
Message-Id: <20220419001525.3950505-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "echo" slipped in between an "ssh" and the "ret=$?" that was intended
to collect its exit code, which prevents torture.sh from detecting
"ssh" failure.  This commit therefore reassociates the two.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 8c4c1e4792d0..03d7dede5f9b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -139,13 +139,13 @@ chmod +x $T/bin/kvm-remote-*.sh
 for i in $systems
 do
 	ncpus="`ssh $i getconf _NPROCESSORS_ONLN 2> /dev/null`"
-	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
 	ret=$?
 	if test "$ret" -ne 0
 	then
 		echo System $i unreachable, giving up. | tee -a "$oldrun/remote-log"
 		exit 4
 	fi
+	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
 done
 
 # Download and expand the tarball on all systems.
-- 
2.31.1.189.g2e36527f23

