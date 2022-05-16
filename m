Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A96528177
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiEPKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiEPKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E011452;
        Mon, 16 May 2022 03:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 842D46093C;
        Mon, 16 May 2022 10:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACDCC385AA;
        Mon, 16 May 2022 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652695478;
        bh=qwMeOyDxZFuqD6KQw3J705rH3w/y6FDNYmqKPSYVm3A=;
        h=From:To:Cc:Subject:Date:From;
        b=S4+qYbgBDMnf8CrM8i8T2yYLJPx1EV2O2H38OZ5tqHfCxdkSXqk8pyNa08HtDr67z
         SEVEnjYWSiiWsRTm/hk44FievUyDqWPKuOJ/pq2TIHZMfk68koO+NrCbzasdePVmkI
         v8EEXJtDc0QFP7KKYnUm+SqpPube4SIbgOXWh4rE0rllYmPE5XtRxPfs48bEYd3lfy
         0yl/F4GqtV9PQUZmwqqkWq3XMWks5PzdVdXgH2EhdIgp2h0PPrR04+HI87c/1kOSOz
         /MveAJXcC3QHS/v8YG1LdpZO7t2b1lCqg0YOK1T1Y1jfJ5TZhQ1l2B+fah2lsWRWo9
         b2PZJ+RctXEeA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v1] binder: convert `BINDER_*` ioctl `#define`s into an `enum`
Date:   Mon, 16 May 2022 12:04:01 +0200
Message-Id: <20220516100401.7639-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bindgen (a tool which generates the "raw" C bindings for Rust) only
works (so far) with "simple" C `#define`s. In order to avoid having
to manually maintain these constants in the (potential) Rust side,
this patch converts them into an `enum`.

There may be support in the future for expanding macros that end up in
a "numeric" one: https://github.com/rust-lang/rust-bindgen/issues/753.

Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Two notes:
  - Let me know if you prefer that I base this on top of a binder branch.
  - Wedson should OK the changes for his `Signed-off-by` tag (and probably
    he should be the author of the patch).

 include/uapi/linux/android/binder.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 11157fae8a8e..ed4d11a0bb99 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -236,19 +236,21 @@ struct binder_frozen_status_info {
 	__u32            async_recv;
 };
 
-#define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
-#define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
-#define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
-#define BINDER_SET_IDLE_PRIORITY	_IOW('b', 6, __s32)
-#define BINDER_SET_CONTEXT_MGR		_IOW('b', 7, __s32)
-#define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
-#define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
-#define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
-#define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
-#define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
-#define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
-#define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
-#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
+enum {
+	BINDER_WRITE_READ			= _IOWR('b', 1, struct binder_write_read),
+	BINDER_SET_IDLE_TIMEOUT			= _IOW('b', 3, __s64),
+	BINDER_SET_MAX_THREADS			= _IOW('b', 5, __u32),
+	BINDER_SET_IDLE_PRIORITY		= _IOW('b', 6, __s32),
+	BINDER_SET_CONTEXT_MGR			= _IOW('b', 7, __s32),
+	BINDER_THREAD_EXIT			= _IOW('b', 8, __s32),
+	BINDER_VERSION				= _IOWR('b', 9, struct binder_version),
+	BINDER_GET_NODE_DEBUG_INFO		= _IOWR('b', 11, struct binder_node_debug_info),
+	BINDER_GET_NODE_INFO_FOR_REF		= _IOWR('b', 12, struct binder_node_info_for_ref),
+	BINDER_SET_CONTEXT_MGR_EXT		= _IOW('b', 13, struct flat_binder_object),
+	BINDER_FREEZE				= _IOW('b', 14, struct binder_freeze_info),
+	BINDER_GET_FROZEN_INFO			= _IOWR('b', 15, struct binder_frozen_status_info),
+	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	= _IOW('b', 16, __u32),
+};
 
 /*
  * NOTE: Two special error codes you should check for when calling

base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
2.36.1

