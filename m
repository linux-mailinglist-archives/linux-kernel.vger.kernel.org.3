Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484FB4766F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhLPAiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhLPAiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:38:15 -0500
X-Greylist: delayed 362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Dec 2021 16:38:02 PST
Received: from forward106o.mail.yandex.net (forward106o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE9C061574;
        Wed, 15 Dec 2021 16:38:02 -0800 (PST)
Received: from myt6-2da614b3f5d3.qloud-c.yandex.net (myt6-2da614b3f5d3.qloud-c.yandex.net [IPv6:2a02:6b8:c12:5f2e:0:640:2da6:14b3])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id B4F06568C39C;
        Thu, 16 Dec 2021 03:31:43 +0300 (MSK)
Received: from myt5-cceafa914410.qloud-c.yandex.net (myt5-cceafa914410.qloud-c.yandex.net [2a02:6b8:c12:3b23:0:640:ccea:fa91])
        by myt6-2da614b3f5d3.qloud-c.yandex.net (mxback/Yandex) with ESMTP id cfrfelhq3U-Vhe4L3o9;
        Thu, 16 Dec 2021 03:31:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1639614703;
        bh=FC5afVp2USKqEqJ1zm3bwC1ozbn/wxh6ys4nwJy7xbQ=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=aVWLOchVpg7r75VOzZ1dycWzkp1EOkMlWyiRGQSj0ZTEMeEhWr0tDSMYFaPp8t0kd
         4mBeZiRrxtNXPtqX7VbkgNsWrdIKF56RCm3dcJrwH3yQwBEzqjyr2V6Vo6KIsart4Q
         ZdbfC61qptJYwpTaG4Kowyp3VyA0ettqQI54vrzs=
Authentication-Results: myt6-2da614b3f5d3.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by myt5-cceafa914410.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id KCe7ivip69-VgPeV1g1;
        Thu, 16 Dec 2021 03:31:42 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Marcos Del Sol Vives <marcos@orca.pet>
To:     linux-cifs@vger.kernel.org
Cc:     Marcos Del Sol Vives <marcos@orca.pet>,
        linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1
Date:   Thu, 16 Dec 2021 01:31:19 +0100
Message-Id: <20211216003119.1609352-1-marcos@orca.pet>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the official Microsoft MS-SMB2 document section 3.3.5.4, this
flag should be used only for 3.0 and 3.0.2 dialects. Setting it for 3.1.1
is a violation of the specification.

This causes my Windows 10 client to detect an anomaly in the negotiation,
and disable encryption entirely despite being explicitly enabled in ksmbd,
causing all data transfers to go in plain text.

Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2ops.c |  3 ---
 fs/ksmbd/smb2pdu.c | 25 +++++++++++++++++++++----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index 0a5d8450e835..02a44d28bdaf 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -271,9 +271,6 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
 
-	if (conn->cipher_type)
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
-
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 49c9da37315c..6193d5a1d653 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -915,6 +915,25 @@ static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 	}
 }
 
+/**
+ * should_encrypt() - checks if connection should be encrypted
+ * @conn:	smb connection
+ *
+ * Return:	true if should be encrypted, else false
+ */
+static bool should_encrypt(struct ksmbd_conn *conn)
+{
+	if (!conn->ops->generate_encryptionkey)
+		return false;
+
+	/*
+	 * SMB 3.0 and 3.0.2 dialects use the SMB2_GLOBAL_CAP_ENCRYPTION flag.
+	 * SMB 3.1.1 uses the cipher_type field.
+	 */
+	return (conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) ||
+	    conn->cipher_type;
+}
+
 static void decode_compress_ctxt(struct ksmbd_conn *conn,
 				 struct smb2_compression_capabilities_context *pneg_ctxt)
 {
@@ -1469,8 +1488,7 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 		    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
 			sess->sign = true;
 
-		if (conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION &&
-		    conn->ops->generate_encryptionkey &&
+		if (should_encrypt(conn) &&
 		    !(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
 			rc = conn->ops->generate_encryptionkey(sess);
 			if (rc) {
@@ -1559,8 +1577,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
 		sess->sign = true;
 
-	if ((conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) &&
-	    conn->ops->generate_encryptionkey) {
+	if (should_encrypt(conn)) {
 		retval = conn->ops->generate_encryptionkey(sess);
 		if (retval) {
 			ksmbd_debug(SMB,
-- 
2.25.1

