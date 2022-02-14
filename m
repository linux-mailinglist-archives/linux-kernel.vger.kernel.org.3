Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425014B5DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiBNWbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:31:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiBNWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:31:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D323713E9C;
        Mon, 14 Feb 2022 14:31:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0D1EB80C6D;
        Mon, 14 Feb 2022 22:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2DFC340E9;
        Mon, 14 Feb 2022 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644877888;
        bh=U9FS+HbROd6gXASD/1YFQXlW6ra2q4lCYkPCYYdKZzE=;
        h=Date:From:To:Cc:Subject:From;
        b=Lobos/mRirqUrrb/uzx6jBqU9QlkWKLRqWIns9GiMrotTuxIx2uPk8VwRBhvRBNP6
         5l9MSsfHVd+AG/trcUCUHZ1gVGTmBECg15Fy+FvjZhpmS6BgRUFDXWq7/53xuTwnJk
         i1gjAzU1emFp2bnoEJamngEaxtOnZUhnjGWyaUgxP2JWrPWPXRQDtWwqdBRVzLIMST
         +vTDEhugRBS5/qvX3uvImYtXxQg/ahBxIGFKG8TIe/tP+28aKiC76W/pWiaw8cM5c+
         8OAr2jGYXND6YM48GNK0k0Wz8nISudZGLAjjSmE+7Xtpj2z+x6Zn6iBwmX6Kgt8rn3
         KMpyKplQQsOYA==
Date:   Mon, 14 Feb 2022 16:39:03 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2][next] scsi: fc: Replace one-element arrays with
 flexible-array members
Message-ID: <20220214223903.GA859464@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use flexible-array members in struct fc_fdmi_attr_entry and
fs_fdmi_attrs instead of one-element arrays, and refactor the
code accordingly.

Also, this helps with the ongoing efforts to globally enable
-Warray-bounds and get us closer to being able to tighten the
FORTIFY_SOURCE routines on memcpy().

https://github.com/KSPP/linux/issues/79
https://github.com/ClangBuiltLinux/linux/issues/1590
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Revert changes for _port_ due to protocol definition conflict.
   Link: https://lore.kernel.org/lkml/22139a80-3f64-1f21-6b5c-65d250bafe09@linux.ibm.com/
 - Update subject line.
 - Update changelog text.

 drivers/scsi/libfc/fc_encode.h | 2 +-
 include/scsi/fc/fc_ms.h        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_encode.h b/drivers/scsi/libfc/fc_encode.h
index 74ae7fd15d8d..7dcac3b6baa7 100644
--- a/drivers/scsi/libfc/fc_encode.h
+++ b/drivers/scsi/libfc/fc_encode.h
@@ -246,7 +246,7 @@ static inline int fc_ct_ms_fill(struct fc_lport *lport,
 				   &entry->type);
 		put_unaligned_be16(len, &entry->len);
 		put_unaligned_be64(lport->wwnn,
-				   (__be64 *)&entry->value[0]);
+				   (__be64 *)&entry->value);
 
 		/* Manufacturer */
 		entry = (struct fc_fdmi_attr_entry *)((char *)entry->value +
diff --git a/include/scsi/fc/fc_ms.h b/include/scsi/fc/fc_ms.h
index 00191695233a..56a5d2b5a624 100644
--- a/include/scsi/fc/fc_ms.h
+++ b/include/scsi/fc/fc_ms.h
@@ -158,7 +158,7 @@ struct fc_fdmi_port_name {
 struct fc_fdmi_attr_entry {
 	__be16		type;
 	__be16		len;
-	__u8		value[1];
+	__u8		value[];
 } __attribute__((__packed__));
 
 /*
@@ -166,7 +166,7 @@ struct fc_fdmi_attr_entry {
  */
 struct fs_fdmi_attrs {
 	__be32				numattrs;
-	struct fc_fdmi_attr_entry	attr[1];
+	struct fc_fdmi_attr_entry	attr[];
 } __attribute__((__packed__));
 
 /*
-- 
2.27.0

