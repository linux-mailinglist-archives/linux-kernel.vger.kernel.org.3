Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62774FCE32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiDLEmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346571AbiDLEmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:42:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537DE31;
        Mon, 11 Apr 2022 21:39:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BLtKjb031973;
        Tue, 12 Apr 2022 04:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=RpMZW/U3P5tVksdvNelEblhiKLUKeauIp6aIxmelim4=;
 b=eyD6lWkKmsWpksKcTlMbYSYGFTn+0o8//+ZavJVRI2rYyNLIYI5DMUpnQrgJ6BGZZPR0
 eMxk9SPRcHYbQUWlTO4LYt/4KqD3vqd3XUQ2nK+4/gdRt1wctOHNC1w7ns+CAniaMN1e
 /4bjuC40DSqManRJ3Y9d5ZUko9qQHP5vM1YFC5ovXBK4G39n8QXH4pfFpoKrX2/IDUyJ
 9uW5Zjca6JwH1eQw9paxCAkR/C15T0Kzq3+9sOgAZbCwZP+ItebzU0isnMcku0uDlKqG
 eaP8YDDCWN7tenYL6xrtpXmb+FHB8BwhKufhMn+Ayi+DCaPllvtmF9nmg6up+U80oQYw RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd5ekb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 04:39:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C4aCrY035802;
        Tue, 12 Apr 2022 04:39:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9gy4nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 04:39:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23C4dOZX040689;
        Tue, 12 Apr 2022 04:39:24 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9gy4k0-1;
        Tue, 12 Apr 2022 04:39:24 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, dan.carpenter@oracle.com,
        Steve French <sfrench@samba.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: potential buffer overflow in handling symlinks
Date:   Mon, 11 Apr 2022 21:38:22 -0700
Message-Id: <20220412043823.57037-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xqL3uRre6-QmHJhJSpdr_eNJvtynp2K3
X-Proofpoint-GUID: xqL3uRre6-QmHJhJSpdr_eNJvtynp2K3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch printed a warning:
	arch/x86/crypto/poly1305_glue.c:198 poly1305_update_arch() error:
	__memcpy() 'dctx->buf' too small (16 vs u32max)

It's caused because Smatch marks 'link_len' as untrusted since it comes
from sscanf(). Add a check to ensure that 'link_len' is not larger than
the size of the 'link_str' buffer.

Fixes: c69c1b6eaea1 ("cifs: implement CIFSParseMFSymlink()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/cifs/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 852e54e..ebfedae 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -85,6 +85,9 @@
 	if (rc != 1)
 		return -EINVAL;
 
+	if (link_len > buf_len - CIFS_MF_SYMLINK_LINK_OFFSET)
+		return -EINVAL;
+
 	rc = symlink_hash(link_len, link_str, md5_hash);
 	if (rc) {
 		cifs_dbg(FYI, "%s: MD5 hash failure: %d\n", __func__, rc);
-- 
1.8.3.1

