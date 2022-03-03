Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7AC4CC2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiCCQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiCCQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:39:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580854C7A3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:39:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3929B82665
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 16:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A1FC004E1;
        Thu,  3 Mar 2022 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646325541;
        bh=lPZIdwsQWP4Ms3kPLc2NWlJMSgHkLZbSVVfg6uTj2t8=;
        h=From:To:Cc:Subject:Date:From;
        b=vBlcTrMqwITgcgixFeKGIJVNd+QfBd+W+CMDcY3J823vCyevZdebMg/bP50+g8I2t
         l01BDFCW/1Im8tvI4jqM1CvBcz6v9kNkD/5I9wg1UfEc9koWzJs5AHmCewWrOPMz6a
         E5m06ezrjDfUMPwemnFZPZDPQGbD3vzNY7zFgzSgcIFJOu7JnFjZfX2lnzUykEdjL9
         MXBkzH7/d60evcn4ml0IqEMocABCOi4jSFPQShCWkRkx1QVbmQxZapQsCwI23WfrZC
         xRnf7Smp9Wqlp6+jTdHctWl7XSKqRubThHePVVSh4l7Zlm6AebmKjPHCtkv9UxbRnQ
         un+euIfN08gAg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] netfs: Ensure ret is always initialized in netfs_begin_read()
Date:   Thu,  3 Mar 2022 09:38:26 -0700
Message-Id: <20220303163826.1120936-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  fs/netfs/io.c:630:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
          if (sync) {
              ^~~~
  fs/netfs/io.c:655:9: note: uninitialized use occurs here
          return ret;
                 ^~~

There is only one instance of netfs_begin_read() where sync is false and
its return value is not checked so just return 0 in this case, as there
is no return code from another function call to propagate.

Fixes: 33e1e5d53058 ("netfs: Add a function to consolidate beginning a read")
Link: https://github.com/ClangBuiltLinux/linux/issues/1607
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/netfs/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 3db9356eb7c2..4a3b7989cd1c 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -651,6 +651,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
 		if (atomic_dec_and_test(&rreq->nr_outstanding))
 			netfs_rreq_assess(rreq, false);
+		ret = 0;
 	}
 	return ret;
 }

base-commit: 2522c1b16116325f69670076d0c82024fbcc4e8d
-- 
2.35.1

