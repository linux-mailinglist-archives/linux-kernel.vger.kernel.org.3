Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3964638A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbhK3PFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbhK3O4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:56:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB07C0613FE;
        Tue, 30 Nov 2021 06:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25097CE1A11;
        Tue, 30 Nov 2021 14:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A77C53FCF;
        Tue, 30 Nov 2021 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283856;
        bh=6wWFs3hkQjgqwlzHgyhBswQyiC57YWCNC8Fjqf3d1oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXukC24hSKQ96ByZ0enBhws/CTL8MaVNyGZma0Nq07wYdM0fhm4/fk9vr0GrNobiH
         mRzLDX3eCs2tIVe3m9HVezDeZV/IiT/BN2APr41LCZGOjS8re3dTbvSWi2Yp4v02ai
         DQ4yCfWRQJsNewu1PiNG/vOd08rPuhfp0ZviAi9t+1usdJmGAvZsmUjtLkKsGEDdo9
         LZ/OJOuahd+akWBcDDmoymd86xzTPLnHx3Rtiy2+lyChKJT2MIvyLNuW2OMjaXrFq/
         dRlpCm4F6U2ZEW+lXsRl1VeNGRbTwoiNrex2KthZkN/ShvvHtSmAxC2GhqYhzju9md
         ubjt/1pW4UgZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/43] NFSv4.1: handle NFS4ERR_NOSPC by CREATE_SESSION
Date:   Tue, 30 Nov 2021 09:49:49 -0500
Message-Id: <20211130145022.945517-12-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit ea027cb2e1b59c76582af867b71d5c037fa6bb8e ]

When the client receives ERR_NOSPC on reply to CREATE_SESSION
it leads to a client hanging in nfs_wait_client_init_complete().
Instead, complete and fail the client initiation with an EIO
error which allows for the mount command to fail instead of
hanging.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 4bf10792cb5b1..332250dfa4d85 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2000,6 +2000,10 @@ static int nfs4_handle_reclaim_lease_error(struct nfs_client *clp, int status)
 		dprintk("%s: exit with error %d for server %s\n",
 				__func__, -EPROTONOSUPPORT, clp->cl_hostname);
 		return -EPROTONOSUPPORT;
+	case -ENOSPC:
+		if (clp->cl_cons_state == NFS_CS_SESSION_INITING)
+			nfs_mark_client_ready(clp, -EIO);
+		return -EIO;
 	case -NFS4ERR_NOT_SAME: /* FixMe: implement recovery
 				 * in nfs4_exchange_id */
 	default:
-- 
2.33.0

