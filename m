Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5D4E5F95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347046AbiCXHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348681AbiCXHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:37:49 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 00:36:17 PDT
Received: from mail-m121144.qiye.163.com (mail-m121144.qiye.163.com [115.236.121.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124D1B6;
        Thu, 24 Mar 2022 00:36:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:1400:8d00:6c1a:b96f:c32f:6296])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 90949AC04CD;
        Thu, 24 Mar 2022 15:28:11 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Eugene Korenevsky <ekorenevsky@astralinux.ru>,
        Steve French <stfrench@microsoft.com>,
        Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH] cifs: fix FILE_BOTH_DIRECTORY_INFO definition
Date:   Thu, 24 Mar 2022 15:26:51 +0800
Message-Id: <20220324072651.3418236-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNMGEpWSx9KSx0ZTE9LTk
        gZVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktPSElVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mww6PQw4HT5DDRJJNAI5KxI6
        DDgKFB9VSlVKTU9DSktNQ0JJSk9CVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0tLQUMfS0tBTRhKGkEZQk0dQRhISR1BTUlCTVlXWQgBWUFKQ01PNwY+
X-HM-Tid: 0a7fbad369dbb039kuuu90949ac04cd
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM28,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Korenevsky <ekorenevsky@astralinux.ru>

commit 9bbf8662a27b56358366027d1a77c0676f85b222 upstream.

The size of FILE_BOTH_DIRECTORY_INFO.ShortName must be 24 bytes, not 12
(see MS-FSCC documentation).

Signed-off-by: Eugene Korenevsky <ekorenevsky@astralinux.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
---
 fs/cifs/cifspdu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
index 1ce733f3582f..504a20250f73 100644
--- a/fs/cifs/cifspdu.h
+++ b/fs/cifs/cifspdu.h
@@ -2588,7 +2588,7 @@ typedef struct {
 	__le32 EaSize; /* length of the xattrs */
 	__u8   ShortNameLength;
 	__u8   Reserved;
-	__u8   ShortName[12];
+	__u8   ShortName[24];
 	char FileName[1];
 } __attribute__((packed)) FILE_BOTH_DIRECTORY_INFO; /* level 0x104 FFrsp data */
 
-- 
2.34.1

