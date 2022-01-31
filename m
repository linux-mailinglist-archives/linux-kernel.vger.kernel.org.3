Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6F4A4481
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379610AbiAaLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:30:28 -0500
Received: from out0.migadu.com ([94.23.1.103]:53048 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239602AbiAaLUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:20:41 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laumann.xyz; s=key1;
        t=1643628038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JYDB1xSWY0WQHZmHLRS3w1xwDpScfvJzKuT7JY80/Ek=;
        b=iKFJRGlz2zomgwYB1L4Jc7x3tKNUjkI+C833pHGQFd0XCzX51U5/XBC4VJHR4gyGgj1ybI
        QMfbX/97K/4H3cIuvNuvhTRqGF7hcFKjkMHUXyQHwSGJhvDMPXKJrrLh7b3vVwF2IdgEWo
        vz2F7hxj294AYe7RKzvr3MjRUyeidUa5pTw9UszFxC4+4cJGGqXWqHHz6ukMw5Sv3ye50g
        NuVZ2K4f+E3HU+EZlqo4XZrJazCBFvZRCsTd8F8d0rRtwZ28basaJ+o/sPYWDJSV86gZlX
        LUXED4jhOQqRIsNe93azT8ZZZep+lffupkYRSKcWvkjZmF+qogCug6t2FnHm0A==
From:   Thomas Bracht Laumann Jespersen <t@laumann.xyz>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     masahiroy@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bracht Laumann Jespersen <t@laumann.xyz>
Subject: [PATCH] scripts/dtc: Call pkg-config POSIXly correct
Date:   Mon, 31 Jan 2022 12:20:28 +0100
Message-Id: <20220131112028.7907-1-t@laumann.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: laumann.xyz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running with POSIXLY_CORRECT=1 in the environment the scripts/dtc build
fails, because pkg-config doesn't output anything when the flags come
after the arguments.

Fixes: f8d8b46cd20e ("scripts/dtc: use pkg-config to include <yaml.h> in non-standard path")
Signed-off-by: Thomas Bracht Laumann Jespersen <t@laumann.xyz>
---
I'm aware that the full kernel doesn't build with POSIXLY_CORRECT set, but I
asked around and was told just to submit a patch.

This is based on the v5.17-rc2 tag, not sure if that's the right tree to work
from, I'll happily cherry-pick to another tree if desired.

 scripts/dtc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 95aaf7431bff..1cba78e1dce6 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -29,7 +29,7 @@ dtc-objs	+= yamltree.o
 # To include <yaml.h> installed in a non-default path
 HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
 # To link libyaml installed in a non-default path
-HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
+HOSTLDLIBS_dtc	:= $(shell pkg-config --libs yaml-0.1)
 endif
 
 # Generated files need one more search path to include headers in source tree
-- 
2.34.1

