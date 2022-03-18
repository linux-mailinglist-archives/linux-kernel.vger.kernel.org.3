Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9603B4DE1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiCRTXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiCRTXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:23:09 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 12:21:47 PDT
Received: from smtp68.ord1d.emailsrvr.com (smtp68.ord1d.emailsrvr.com [184.106.54.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E562EDC0D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1647630844;
        bh=j+0ohAmi9HWZJArU6TnTPJhcATINnKKBBR79VYiub/w=;
        h=From:To:Subject:Date:From;
        b=gqSkprVJmFWd4GEIZOXeYSz0EmXR1DWvRwO4QhzMBlHx6c+KmHZ8zRbY4vj9B+Jh5
         PmJon/V5ZAfT64o7LXHjroz3eFSBGyyJSYjtL6S8JYQR5R0LuYK7b9Tkh/hpeRnmlJ
         m30udf8nDVtNGE8ccRW1FFLCVRx2LUiMT49SMDzY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BA025C015A;
        Fri, 18 Mar 2022 15:14:03 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] ioctl_userfaultfd.2: Corrections for returned .ioctls members
Date:   Fri, 18 Mar 2022 19:13:43 +0000
Message-Id: <20220318191343.72812-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: dae17b9c-d724-4394-a06a-be3edb530318-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the `UFFDIO_WRITEPROTECT` operation is not indicated in the
`ioctls` member of `struct uffdio_api`.  It is indicated in the `ioctls`
member of `struct uffdio_register` along with indications of support for
the `UFFDIO_COPY`, `UFFDIO_WAKE` and `UFFDIO_ZEROPAGE` operations (and
also the `UFFDIO_CONTINUE` operation supported since Linux 5.13 but
that is not documented by this man page yet.)

Fixes: f559fa36a678 ("ioctl_userfaultfd.2: Add write-protect mode docs")
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 man2/ioctl_userfaultfd.2 | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 504f61d4b..e930af520 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -235,11 +235,6 @@ operation is supported.
 The
 .B UFFDIO_UNREGISTER
 operation is supported.
-.TP
-.B 1 << _UFFDIO_WRITEPROTECT
-The
-.B UFFDIO_WRITEPROTECT
-operation is supported.
 .PP
 This
 .BR ioctl (2)
@@ -333,8 +328,26 @@ If the operation is successful, the kernel modifies the
 bit-mask field to indicate which
 .BR ioctl (2)
 operations are available for the specified range.
-This returned bit mask is as for
-.BR UFFDIO_API .
+This returned bit mask can contain the following bits:
+.TP
+.B 1 << _UFFDIO_COPY
+The
+.B UFFDIO_COPY
+operation is supported.
+.TP
+.B 1 << _UFFDIO_WAKE
+The
+.B UFFDIO_WAKE
+operation is supported.
+.TP
+.B 1 << _UFFDIO_WRITEPROTECT
+The
+.B UFFDIO_WRITEPROTECT
+.TP
+.B 1 << _UFFDIO_ZEROPAGE
+The
+.B UFFDIO_ZEROPAGE
+operation is supported.
 .PP
 This
 .BR ioctl (2)
-- 
2.35.1

