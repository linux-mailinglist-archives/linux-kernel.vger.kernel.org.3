Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97524AA4BF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378682AbiBDX4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46810 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378452AbiBDX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57222B8397A;
        Fri,  4 Feb 2022 23:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71F1C340FA;
        Fri,  4 Feb 2022 23:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018962;
        bh=Gwph+6DFWT1q7W++nX8g5zeBJ1g1d8ZNxVvDQktd4fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2Ma0UpmlX7Je1Tnn0PKojj/xv3SVL8eVKk5ceEV1DOzPx1NYkSdKD5qI9PfOY2+F
         NC6jcwtyXvqbsrYlmJdRf52rtr1vnEQcDLvHJS0oKA/AFXrPvp7X+WNRlnZqOTKJxY
         0LP4pKyjCLPQqxcONzxowaBXNulIeTQk/fR+JCHZuNLgNEiH6sTiTci4N0ebmcdJgm
         n5MAbQ/4AOceh9sNyrM+oZNZVAfXkSFICdFSaS/w5SJa2OP4TkbVU82w7M/FDS9yaM
         /doXMiyywl5bB7wvJ0TwA05N7THXqrbaMvxrgEt5SnRUCwKQWLj5yt2sfD4w6yvVnU
         8aNyW0TyNVBCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 63EFA5C0AEF; Fri,  4 Feb 2022 15:56:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH rcu 09/13] torture: Make kvm-find-errors.sh notice missing vmlinux file
Date:   Fri,  4 Feb 2022 15:55:57 -0800
Message-Id: <20220204235601.3438-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235558.GA3221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, an obtuse compiler diagnostic can fool kvm-find-errors.sh
into believing that the build was successful.  This commit therefore
adds a check for a missing vmlinux file.  Note that in the case of
repeated torture-test scenarios ("--configs '2*TREE01'"), the vmlinux
file will only be present in the first directory, that is, in TREE01
but not TREE01.2.

Link: https://lore.kernel.org/lkml/36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de/
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 2e9e9e2eedb69..5f682fc892dd4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -30,10 +30,16 @@ editor=${EDITOR-vi}
 files=
 for i in ${rundir}/*/Make.out
 do
+	scenariodir="`dirname $i`"
+	scenariobasedir="`echo ${scenariodir} | sed -e 's/\.[0-9]*$//'`"
 	if egrep -q "error:|warning:|^ld: .*undefined reference to" < $i
 	then
 		egrep "error:|warning:|^ld: .*undefined reference to" < $i > $i.diags
 		files="$files $i.diags $i"
+	elif ! test -f ${scenariobasedir}/vmlinux
+	then
+		echo No ${scenariobasedir}/vmlinux file > $i.diags
+		files="$files $i.diags $i"
 	fi
 done
 if test -n "$files"
-- 
2.31.1.189.g2e36527f23

