Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7F4F4290
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380956AbiDENOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 09:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbiDEJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:18:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5948E4E;
        Tue,  5 Apr 2022 02:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAE04B81C19;
        Tue,  5 Apr 2022 09:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2881EC385A5;
        Tue,  5 Apr 2022 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649149549;
        bh=hVMP6vT6nk2Fvww8pqkV4ggGVroKNxjj41ODBDf1TYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDLQK+rKUguf4TiYw6mi6c0GZXnZZfrwEeTZPXEbOoDxF9uEwe7PXx/HVrvg5P2Gl
         qqayoV5fHpIAWkG6JleizICq5pUzOXO4jvmNuBGRSDDTa6g7puOf2MF3kcB5uiAYYO
         oe/mTQ845Sfdm0MhZMzdH0uF1mm6XxEip26fRAKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0718/1017] SUNRPC dont resend a task on an offlined transport
Date:   Tue,  5 Apr 2022 09:27:11 +0200
Message-Id: <20220405070415.581082002@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit 82ee41b85cef16b4be1f4732650012d9baaedddd ]

When a task is being retried, due to an NFS error, if the assigned
transport has been put offline and the task is relocatable pick a new
transport.

Fixes: 6f081693e7b2b ("sunrpc: remove an offlined xprt using sysfs")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 5985b78eddf1..b36d235d2d6d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1065,7 +1065,9 @@ rpc_task_get_next_xprt(struct rpc_clnt *clnt)
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
-	if (task->tk_xprt)
+	if (task->tk_xprt &&
+			!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
+                        (task->tk_flags & RPC_TASK_MOVEABLE)))
 		return;
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt = rpc_task_get_first_xprt(clnt);
-- 
2.34.1



