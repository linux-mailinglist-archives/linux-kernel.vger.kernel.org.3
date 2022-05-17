Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D031529F65
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiEQK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbiEQK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1B11CA;
        Tue, 17 May 2022 03:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 668F86156A;
        Tue, 17 May 2022 10:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051A2C385B8;
        Tue, 17 May 2022 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652783313;
        bh=H2A/jFCSJ+xqg/vLvKvV+fIaM4AAIUyg7v6zsd4rM1w=;
        h=From:To:Cc:Subject:Date:From;
        b=MVec5s8SsX0DJYpVL/N/V8VBrlI5FY37E7huj+UgAVGxd0+S32Uua80uV1J/sy0k4
         nMmyjfLihqiqdR68b1JgghbEyVamhtq5bGfZDnmfvKKmhciUD6OnZ0VyULnZKNE03o
         zo/brvn3lTXUTtJ3LQimulPHSHbIAtWP9beMemKEKeJqQ4Qv6U7a1Nq4hdGS2lyJ+H
         BWW3Pa0l+PZR6a4rFX8h0VC5dB3u+gIOg9eLXGq+qYizGBKJ2+DaPY53BcNdk5hXAq
         dd01Qshgfe5JU2CH6XQ9ViU+AQjzMkoz9wv/8iYyNXodhoVbFR1XNuHMn32HqPdZP1
         KZ+qjzVsmUIbA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v2] binder: convert `BINDER_*` ioctl `#define`s into an `enum`
Date:   Tue, 17 May 2022 12:28:13 +0200
Message-Id: <20220517102813.10310-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Link: https://lore.kernel.org/lkml/YoIK2l6xbQMPGZHy@kroah.com/
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
v2:
  - Rebased on top of Greg's char-misc-next.
  - Added Link tag for future reference.

v1: https://lore.kernel.org/lkml/20220516100401.7639-1-ojeda@kernel.org/

 include/uapi/linux/android/binder.h | 30 +++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index e6ee8cae303b..a4c3e750168a 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -251,20 +251,22 @@ struct binder_extended_error {
 	__s32	param;
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
-#define BINDER_GET_EXTENDED_ERROR	_IOWR('b', 17, struct binder_extended_error)
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
+	BINDER_GET_EXTENDED_ERROR		= _IOWR('b', 17, struct binder_extended_error),
+};
 
 /*
  * NOTE: Two special error codes you should check for when calling

base-commit: 33a1c6618677fe33f8e84cb7bedc45abbce89a50
-- 
2.36.1

