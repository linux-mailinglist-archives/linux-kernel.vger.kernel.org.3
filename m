Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C13D476F11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhLPKoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbhLPKoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:44:05 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Dec 2021 02:44:05 PST
Received: from forward101p.mail.yandex.net (forward101p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84823C061574;
        Thu, 16 Dec 2021 02:44:05 -0800 (PST)
Received: from sas1-0a2be8f95474.qloud-c.yandex.net (sas1-0a2be8f95474.qloud-c.yandex.net [IPv6:2a02:6b8:c08:f21f:0:640:a2b:e8f9])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 8081159CCE00;
        Thu, 16 Dec 2021 13:37:39 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net (sas8-b61c542d7279.qloud-c.yandex.net [2a02:6b8:c1b:2912:0:640:b61c:542d])
        by sas1-0a2be8f95474.qloud-c.yandex.net (mxback/Yandex) with ESMTP id BJmvtfpYM5-bdeuFB9F;
        Thu, 16 Dec 2021 13:37:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1639651059;
        bh=Nf3LvXH5AXN+JC9P+ix28xro/gBL7qkBplUcuybM6lA=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=U+s/h9l0u5kShf3mXigHbGHjM2XStxiGACPEiXDq/1xYLN6NoBuEOIFTTiRc9h9Tb
         ppwWBZ2ABxjbG2NUigdE4EKBCfRWZ4KLB2NgQ+V+3NhRBATMeNO9Fga7Jun7CbOBbg
         cg5nWy+Qh6StKns5Gs0/j8sK+d0yn3yIFPhJ4vT0=
Authentication-Results: sas1-0a2be8f95474.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id TkkqXHcr21-bbPqYmKS;
        Thu, 16 Dec 2021 13:37:38 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Marcos Del Sol Vives <marcos@orca.pet>
To:     linux-cifs@vger.kernel.org
Cc:     Marcos Del Sol Vives <marcos@orca.pet>,
        linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2] ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1
Date:   Thu, 16 Dec 2021 11:37:22 +0100
Message-Id: <20211216103721.1686600-1-marcos@orca.pet>
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
index 49c9da37315c..049fa81281b4 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -915,6 +915,25 @@ static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 	}
 }
 
+/**
+ * smb3_encryption_negotiated() - checks if server and client agreed on enabling encryption
+ * @conn:	smb connection
+ *
+ * Return:	true if connection should be encrypted, else false
+ */
+static bool smb3_encryption_negotiated(struct ksmbd_conn *conn)
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
+		if (smb3_encryption_negotiated(conn) &&
 		    !(req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
 			rc = conn->ops->generate_encryptionkey(sess);
 			if (rc) {
@@ -1559,8 +1577,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
 		sess->sign = true;
 
-	if ((conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) &&
-	    conn->ops->generate_encryptionkey) {
+	if (smb3_encryption_negotiated(conn)) {
 		retval = conn->ops->generate_encryptionkey(sess);
 		if (retval) {
 			ksmbd_debug(SMB,
-- 
2.25.1

