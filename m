Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974B9524779
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351176AbiELH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351278AbiELH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:56:12 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A0D396BE;
        Thu, 12 May 2022 00:56:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VCzyo8E_1652342166;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VCzyo8E_1652342166)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 15:56:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linkinjeon@kernel.org
Cc:     sfrench@samba.org, hyc.lee@gmail.com, senozhatsky@chromium.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ksmbd: Fix some kernel-doc comments
Date:   Thu, 12 May 2022 15:56:05 +0800
Message-Id: <20220512075605.34240-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/ksmbd/misc.c:30: warning: Function parameter or member 'str' not
described in 'match_pattern'
fs/ksmbd/misc.c:30: warning: Excess function parameter 'string'
description in 'match_pattern'
fs/ksmbd/misc.c:163: warning: Function parameter or member 'share' not
described in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:163: warning: Function parameter or member 'path' not
described in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:163: warning: Excess function parameter 'filename'
description in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:163: warning: Excess function parameter 'sharepath'
description in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:259: warning: Function parameter or member 'share' not
described in 'convert_to_unix_name'
fs/ksmbd/misc.c:259: warning: Function parameter or member 'name' not
described in 'convert_to_unix_name'
fs/ksmbd/misc.c:259: warning: Excess function parameter 'path'
description in 'convert_to_unix_name'
fs/ksmbd/misc.c:259: warning: Excess function parameter 'tid'
description in 'convert_to_unix_name'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ksmbd/misc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 1e2076a53bed..df991107ad2c 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -20,7 +20,7 @@
  * wildcard '*' and '?'
  * TODO : implement consideration about DOS_DOT, DOS_QM and DOS_STAR
  *
- * @string:	string to compare with a pattern
+ * @str:	string to compare with a pattern
  * @len:	string length
  * @pattern:	pattern string which might include wildcard '*' and '?'
  *
@@ -152,8 +152,8 @@ int parse_stream_name(char *filename, char **stream_name, int *s_type)
 /**
  * convert_to_nt_pathname() - extract and return windows path string
  *      whose share directory prefix was removed from file path
- * @filename : unix filename
- * @sharepath: share path string
+ * @share: ksmbd_share_config pointer
+ * @path: path to report
  *
  * Return : windows path string or error
  */
@@ -250,8 +250,8 @@ char *ksmbd_extract_sharename(char *treename)
 
 /**
  * convert_to_unix_name() - convert windows name to unix format
- * @path:	name to be converted
- * @tid:	tree id of mathing share
+ * @share:	ksmbd_share_config pointer
+ * @name:	file name that is relative to share
  *
  * Return:	converted name on success, otherwise NULL
  */
-- 
2.20.1.7.g153144c

