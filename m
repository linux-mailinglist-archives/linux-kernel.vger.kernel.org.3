Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66036463888
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbhK3PEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:04:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59958 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243154AbhK3O4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:56:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6E063CE1A67;
        Tue, 30 Nov 2021 14:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F55C53FCF;
        Tue, 30 Nov 2021 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283989;
        bh=XvDXe8QlYkOVYvlj8rPsLiboo21ZuxznWhjSYzSen4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6x6t91QEzkLH2ieIMjS0BJ/oFQfQkVi+ZnnEzaX66URI2zQg4wt8yBGlPjzFQ+R3
         L/lATZOrqNUWzONeBTpEkBU2RQELogag/8LLwnW+iwZxQ2BSBCYiEbIkTZOpE+8U+q
         6A0NGYMGYhHBMnby+F8frEztZIIaqXZLA+MAoyX3MJbDkJfP7OC4yCxLL6nSVd+09V
         09qWbB3rG6ik7pKHkSiQ0q7Ae7fUADzcQLPlPm2gUDkSAUghc0qFut6467swVu6hxQ
         1H5AOKUpd8fLFHZO4LLEh+60v8NnSe8QR8wrfJck8ntELc/gi3zFWcL4xfCJGiLHGA
         N7CA4ehEKzgUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paulo Alcantara <pc@cjr.nz>, Sasha Levin <sashal@kernel.org>,
        sfrench@samba.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 4.19 13/17] smb2: clarify rc initialization in smb2_reconnect
Date:   Tue, 30 Nov 2021 09:52:37 -0500
Message-Id: <20211130145243.946407-13-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145243.946407-1-sashal@kernel.org>
References: <20211130145243.946407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 350f4a562e1ffc2e4869e3083dc9b0ec4bca6c3a ]

It is clearer to initialize rc at the beginning of the function.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 43478ec6fd67a..757ac782f405b 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -155,7 +155,7 @@ smb2_hdr_assemble(struct smb2_sync_hdr *shdr, __le16 smb2_cmd,
 static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 {
-	int rc;
+	int rc = 0;
 	struct nls_table *nls_codepage;
 	struct cifs_ses *ses;
 	struct TCP_Server_Info *server;
-- 
2.33.0

