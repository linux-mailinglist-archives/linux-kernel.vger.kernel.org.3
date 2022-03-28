Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F34E9BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiC1QEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiC1QEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:04:42 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307F26ADF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:03:01 -0700 (PDT)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 22SG25YH026847;
        Tue, 29 Mar 2022 01:02:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 22SG25YH026847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648483325;
        bh=2QRUejRsaentUwOl3V/59a5+tfFrXkvzS7V5MubbfsA=;
        h=From:To:Cc:Subject:Date:From;
        b=OfiiSXrDe9iMd9KczldGueBDfAXMTeAnv3CsJzUZBs7bYW7mGdW9QHa1p0fXiM4Th
         bclnaZK+kiP6L406qOtnmTFJVfmiNmyGe09G/r6/E8oNyaD6Fq1elva9UiZ7DJWFCU
         KUMd9bQFDvtsV/xX4iZa46FK4FUsmXOc6LAsVz3Re7Ag/6Fn5ZPkJ7qVJyTVuwmjBp
         FubS6TouuKQew9+kE7WimP0F3rRTodOkwt4XFvzgQzUTVnlxk7nULIW6cShJu8CM3r
         mWSgLrL2vG9/IOxt1PpANQtlvFlTd2ehCDqLuqGCw0fXYarPOY9pioQagrDWE27UJ1
         /7UzvYjgQVrpQ==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] media: media.h: remove unneeded <stdint.h> inclusion
Date:   Tue, 29 Mar 2022 01:01:53 +0900
Message-Id: <20220328160153.169362-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b3b7a9f138b7 ("[media] media-device: Use u64 ints for pointers")
added this #include <stdint.h>, presumably in order to use uintptr_t.

Now that it is gone, we can compile this for userspace without <stdint.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/media.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 200fa8462b90..5754dce922a7 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -20,9 +20,6 @@
 #ifndef __LINUX_MEDIA_H
 #define __LINUX_MEDIA_H
 
-#ifndef __KERNEL__
-#include <stdint.h>
-#endif
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
-- 
2.32.0

