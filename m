Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED800465753
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhLAUsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:48:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43872 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352957AbhLAUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:44:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 372DDCE2102;
        Wed,  1 Dec 2021 20:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A12C53FD0;
        Wed,  1 Dec 2021 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391277;
        bh=ACBzh+o2miqbby9pnmbvnefEjwo6AwbT8tO0QoE7F34=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BWufx23986sfuXnYxk5SQFnj6yLPLTpatOUjIS4o04GrZV6w93Owya1Xi/PZLKP2g
         VOmoKVpsliHWoGbcUoQVghSfe8D7nF2LCMSUH1aGBnuIfsy/ASWbzWVM+YvqK6hFgr
         eOp7c+ZNWhUCudranf6LmJT2Zkxf4K9+A9KFEMaeHpPwPb3SEFTxbzg2dZWJqAZnF2
         JMbTVB0etR+he2Oc5ipOt1rKtbXPrj8owmXIgYm0FdqvMoG1XIAu3e4eIXgYV+m3+U
         eoc/XdU1SXX475SjrLW2A8RZkuAuD33BNmRz/Vfl4hmnAf/D2pqEWfGCq/57pilVfx
         rhKMhs0pDbdog==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 6/8] fscache: Use only one fscache_object_cong_wait.
Date:   Wed,  1 Dec 2021 14:41:06 -0600
Message-Id: <688eb6554dbe14f0bb09d0b622d7120fefa52742.1638391253.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
In-Reply-To: <cover.1638391253.git.zanussi@kernel.org>
References: <cover.1638391253.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.4.161-rt67-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 514342eb43a760575d6d9a366506a41ab7ec4888 ]

This is an update of the original patch, removing put_cpu_var() which
was overseen in the initial patch.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 fs/fscache/object.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index c93860274f2f..959384c91f79 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -823,8 +823,6 @@ void fscache_enqueue_object(struct fscache_object *object)
 				wake_up(&fscache_object_cong_wait);
 		} else
 			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
 	}
 }
 
-- 
2.17.1

