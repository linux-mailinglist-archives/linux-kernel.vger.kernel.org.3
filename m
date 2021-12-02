Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44AF465A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354090AbhLBAMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354117AbhLBAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:10:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C829C061574;
        Wed,  1 Dec 2021 16:06:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 023BFB8219B;
        Thu,  2 Dec 2021 00:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92348C53FCF;
        Thu,  2 Dec 2021 00:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403604;
        bh=kd/t6++JxJ1RnLpmjbHeu60p4SmLhAhEvhkN3dzIdP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WegADlsKCIIvDWQfIlN+wUNr/Zisuw1YTnB90R+CUtgs4p/63HzvZer9mpIq0zgMx
         ABmdC3tqv3u/sFsJOvlkB7aXYjBUMTzun49ESn7aj1PYy+R9r8oiwWS8WxMTGIji1H
         oCEySto5x84IL4WLqQmBY7UCJkLHxWVpRaH0QoERz+H8Lv/nsqENwlbQOGy+JzYPJ0
         HoZn5JSfIBTvaLRUzRwIpoTGiceNcOBgAO3t9/ekOMle5Oj3myrvYn/yw5f5pgWaCy
         H8G3WyFfeY8GZgvLjk078djsjUCP+vDQQNuCwR+aH7lkAr8Mwy4dtHG8C6ag4xA6Sx
         rL/CrSprZOajQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51E0C5C1107; Wed,  1 Dec 2021 16:06:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] doc: Remove obsolete kernel-per-CPU-kthreads RCU_FAST_NO_HZ advice
Date:   Wed,  1 Dec 2021 16:06:40 -0800
Message-Id: <20211202000642.3126064-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202000540.GA3125972@paulmck-ThinkPad-P17-Gen-1>
References: <20211202000540.GA3125972@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document advises building with both CONFIG_NO_HZ=y and
CONFIG_RCU_FAST_NO_HZ=y.  However, CONFIG_NO_HZ=y offloads callbacks from
all nohz_full CPUs, and CPUs with offloaded callbacks do not benefit from
CONFIG_RCU_FAST_NO_HZ=y.  Quite the opposite: CONFIG_RCU_FAST_NO_HZ=y
simply adds a bit of idle entry/exit overhead.

This commit therefore changes that advice to only CONFIG_NO_HZ=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-per-CPU-kthreads.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index 5e51ee5b03589..e4a5fc26f1a9d 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -208,7 +208,7 @@ Do at least one of the following:
 2.	Enable RCU to do its processing remotely via dyntick-idle by
 	doing all of the following:
 
-	a.	Build with CONFIG_NO_HZ=y and CONFIG_RCU_FAST_NO_HZ=y.
+	a.	Build with CONFIG_NO_HZ=y.
 	b.	Ensure that the CPU goes idle frequently, allowing other
 		CPUs to detect that it has passed through an RCU quiescent
 		state.	If the kernel is built with CONFIG_NO_HZ_FULL=y,
-- 
2.31.1.189.g2e36527f23

