Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4C246B94B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhLGKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:43:54 -0500
Received: from mail.avm.de ([212.42.244.119]:56326 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233914AbhLGKnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:43:49 -0500
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (Postfix) with ESMTP;
        Tue,  7 Dec 2021 11:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1638873106; bh=JaKvOTLAp1U9jAsh80xyjH9Bbx0SOKEvl7BnUe1w4Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQhReA+WKDeucvJv3TGI8MVbl4x8+zn62AaYkMrDD/PTUNnnaVhlMsyUmXg2cp5G8
         +b5jMvPOZxEFWK2AIAck3U399GXUPGFL5VqTCRQKobjl47v/sWVuEMnxCmkhApED47
         SEx5ujgrIf9i9VaHQzqoHZjVb5m6/Bmc0kv6aAvE=
Received: from tkh-linux.avm.de ([172.17.33.53])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021120711314570-7976 ;
          Tue, 7 Dec 2021 11:31:45 +0100 
From:   =?UTF-8?q?Thomas=20K=C3=BChnel?= <thomas.kuehnel@avm.de>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20K=C3=BChnel?= <thomas.kuehnel@avm.de>,
        Nicolas Schier <n.schier@avm.de>
Subject: [PATCH 1/3] fs/ntfs3: fix endian conversion in ni_fname_name
Date:   Tue, 7 Dec 2021 11:24:53 +0100
Message-Id: <20211207102454.576906-2-thomas.kuehnel@avm.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207102454.576906-1-thomas.kuehnel@avm.de>
References: <20211207102454.576906-1-thomas.kuehnel@avm.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 07.12.2021 11:31:45,
        Serialize by Router on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 07.12.2021 11:31:45,
        Serialize complete at 07.12.2021 11:31:45
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
X-purgate-ID: 149429::1638873106-0000056E-4206DADD/0/0
X-purgate-type: clean
X-purgate-size: 1141
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ni_fname_name called ntfs_cmp_names_cpu which assumes that the first
string is in CPU byte order and the second one in little endian.
In this case both strings are little endian so ntfs_cmp_names is the
correct function to call.

Signed-off-by: Thomas Kühnel <thomas.kuehnel@avm.de>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---
 fs/ntfs3/frecord.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 6f47a9c17f89..f3afdc91af76 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1588,6 +1588,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
 {
 	struct ATTRIB *attr = NULL;
 	struct ATTR_FILE_NAME *fname;
+	struct le_str *fns;
 
 	*le = NULL;
 
@@ -1610,7 +1611,8 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
 	if (uni->len != fname->name_len)
 		goto next;
 
-	if (ntfs_cmp_names_cpu(uni, (struct le_str *)&fname->name_len, NULL,
+	fns = (struct le_str *)&fname->name_len;
+	if (ntfs_cmp_names(uni->name, uni->len, fns->name, fns->len, NULL,
 			       false))
 		goto next;
 
-- 
2.25.1

