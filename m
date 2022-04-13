Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD814FF5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiDMLp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDMLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:45:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F25B3F5;
        Wed, 13 Apr 2022 04:43:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D9xvYW032238;
        Wed, 13 Apr 2022 11:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=snGXKT5n6XDtwCnQA9MLkATepstbNlkspFrk9ndNi6U=;
 b=BdRk1rkD6rINJkZWx1YEFObZL3ohwLy3ETlWjYD74GLgaRxfePw6HROebBZ38+h6xO/8
 Ptu3sw4vsoBLLqSjblsLcS3yUp9VtzIashOTd04ncEcijRplK3TH1mbfdvOVESj/LK3W
 bWkquRBU5NcDAP8OLgUXnjON/VP77pvrTe1S2BFj0D5E6cXx/IWheuWkw0BzqGxfgvw0
 eaM1a+JJnqHpss1lytLXAvbG+gJLXbtO7h4fib1g3IoQB2CPLVuWGmdXIn/9uE2LmZjI
 STOAEaWjxJE1FjEjQ4POeQa5qZamYPoK9Z27XcY8RmxLvvrrZZA+789h5iJUhHL7FGEM BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd9da7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 11:43:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DBfRRL010353;
        Wed, 13 Apr 2022 11:43:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k3wau6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 11:43:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23DBhG65016664;
        Wed, 13 Apr 2022 11:43:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k3watn-1;
        Wed, 13 Apr 2022 11:43:16 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, dan.carpenter@oracle.com,
        smfrench@gmail.com, Steve French <sfrench@samba.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cifs: potential buffer overflow in handling symlinks
Date:   Wed, 13 Apr 2022 04:42:51 -0700
Message-Id: <20220413114251.73083-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pmHfV1bQBRIjOkb1odkxWsvclPwJw5bw
X-Proofpoint-GUID: pmHfV1bQBRIjOkb1odkxWsvclPwJw5bw
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
v2: make use of CIFS_MF_SYMLINK_LINK_MAXLEN (same but cleaner).

 fs/cifs/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 852e54e..bbdf328 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -85,6 +85,9 @@
 	if (rc != 1)
 		return -EINVAL;
 
+	if (link_len > CIFS_MF_SYMLINK_LINK_MAXLEN)
+		return -EINVAL;
+
 	rc = symlink_hash(link_len, link_str, md5_hash);
 	if (rc) {
 		cifs_dbg(FYI, "%s: MD5 hash failure: %d\n", __func__, rc);
-- 
1.8.3.1

