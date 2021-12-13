Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC0471F74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhLMDB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:01:27 -0500
Received: from out203-205-221-236.mail.qq.com ([203.205.221.236]:60027 "EHLO
        out203-205-221-236.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhLMDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639364483;
        bh=Ar1vgOHRn0VRMXJEhuwhOOAsfBXHxoULE7+XbXJ3ITM=;
        h=From:To:Cc:Subject:Date;
        b=RISMWbDW/EGkHG+Z50MEbIzSkHCOQRk0GxzrGhOxnZDfSU845/LK/+80QUhTBapHo
         EFrNXUii4Vf9AgeY0xHKwetfg8xciRGxC/8SMhx2toUcGqgAVZU0EtyV6Y+1tbxXJe
         HWN7P4GViSp07+SpjKR+gEjqHezo/3kaeBBmr2kk=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza28.qq.com (NewEsmtp) with SMTP
        id 54A9094; Mon, 13 Dec 2021 11:01:20 +0800
X-QQ-mid: xmsmtpt1639364480t0hujvqhn
Message-ID: <tencent_CE0F8701456CB89F92C73F28480EF3552E06@qq.com>
X-QQ-XMAILINFO: OLsBWtCIHsg6PDuys+IkkJCwl3Stpg1fXpt1oJ/Vsn4i9W1K4jGFv973ljl0by
         b8e6uIJgO30EKPq1pjEcYQ3RSvMqX5Bo4RwsG1yUSiUqNMxhr9Gust5U9kkihLk1A/2GD+WikDbi
         K3vPhWZNtkBPFTLxk1v5a19GOpSJm6i+mUUKoY029JE0d7EkblixnQ0qfnQIyL9z1L8B5JN++IEO
         m/sEC1yTtmx5kJy/Axcv/X6Nj6yEvWq9QWSLZNf5OPJokMzJ/7sRWkhp1aJzkNY58n1egAlZzgk8
         sa1iV48MDgEyrgao2yCH8Lw5WL95UqCuM7/O7PRFf9NJCIMzDaIwaCoXCvWpqRIAZe+G98xMdbab
         fmuF3c5fHM0/Ns7nOFuR9hawd/vdJeQTc1RfXj1JVMoSGMAxBXIcWjLonat9uE1uOPz1mQe8FsUR
         y73f9Mz1V5EBddYEu+O1bHrR82pNnBFBAF2502BwxEYLPYPdDrs6uVaCeCnCe8t4wBk3DSDq0zjI
         R866RB+1y6+NkEzSY/9g4Rbzrb0Ctia2GiSM1W6gXkHOWRT5Bxd1CNOwZLrM9k/7uOt6IW9SLajy
         mVaiXJLHbdpeAe4g+9i9jwl8ASbCQReQRsAUKPg0+pUK7d+nsu/UA0OcGCbbcNbHPpQXVjieU0dq
         hunfZQCPK7aMeaTyl7Ldew8WKJ1sBTTllJYfjNICZb2XA6w+9ozFj/mPDnJG7ISh9msdtuh/jTSr
         3QYK4jRUwbQzFGNJDs9PNtnIABr3PNkEK3YgkwNOlicq9H8mc4LFM4S4GTRxiUxDNXVZaWlOpyTY
         MbV6IP+Ul8wCwPVR5XqRbJ1XoObzu0ralrCksVc9+xbmVJAVboYwZI6O8kPcPq3zaLifV2apzHI0
         Kovt9SyE8Gee+VJfpbmA4/DVphUDhqu5mBHfaHGCnj1mxgetavLdbHHFJAHwdpFw==
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] nfs: nfs4clinet: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 11:00:10 +0800
X-OQ-MSGID: <20211213030010.3498-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL when some internal memory errors happen, it is
better to check the return value of it so to catch the memory error in
time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 fs/nfs/nfs4client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index af57332..89f13e0 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1372,5 +1372,8 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 		server->nfs_client->cl_hostname = kstrdup(hostname, GFP_KERNEL);
 	nfs_server_insert_lists(server);
 
+	if (server->nfs_client->cl_hostname == NULL)
+		return -ENOMEM;
+
 	return nfs_probe_destination(server);
 }
-- 
