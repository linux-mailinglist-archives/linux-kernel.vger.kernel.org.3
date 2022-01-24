Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011D8498202
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiAXOYe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jan 2022 09:24:34 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:29581 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233777AbiAXOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:24:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-Kpi7E0tVN7-rWaTloQuw1g-1; Mon, 24 Jan 2022 09:24:26 -0500
X-MC-Unique: Kpi7E0tVN7-rWaTloQuw1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D9112E72;
        Mon, 24 Jan 2022 14:24:25 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F171A78A9A;
        Mon, 24 Jan 2022 14:24:23 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 1/8] rtla: Follow kernel version
Date:   Mon, 24 Jan 2022 15:24:04 +0100
Message-Id: <573eaf9fcbaf6693c9576b0cf2fe1007fce5a1d8.1643033113.git.bristot@kernel.org>
In-Reply-To: <cover.1643033113.git.bristot@kernel.org>
References: <cover.1643033113.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid having commits with new version, it is just easier to follow
kernel verison.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2d52ff0bff7d..3dd51d0b1c3b 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -1,5 +1,6 @@
 NAME	:=	rtla
-VERSION	:=	0.5
+# Follow the kernel version
+VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
 
 # From libtracefs:
 # Makefiles suck: This macro sets a default value of $(2) for the
@@ -85,6 +86,7 @@ clean: doc_clean
 
 tarball: clean
 	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
+	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
 	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
 	mkdir $(NAME)-$(VERSION)/Documentation/
 	cp -rp $(SRCTREE)/../../../Documentation/tools/rtla/* $(NAME)-$(VERSION)/Documentation/
-- 
2.34.1

