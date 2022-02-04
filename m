Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83ED4A9CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiBDQY0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 11:24:26 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:24538 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376527AbiBDQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:24:19 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-bJEF33FwNROuK4ms9RtL2w-1; Fri, 04 Feb 2022 11:24:15 -0500
X-MC-Unique: bJEF33FwNROuK4ms9RtL2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9568781CBD7;
        Fri,  4 Feb 2022 16:24:14 +0000 (UTC)
Received: from x1.com (unknown [10.22.33.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CADA7E91A;
        Fri,  4 Feb 2022 16:24:13 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 1/4] rtla: Follow kernel version
Date:   Fri,  4 Feb 2022 17:24:02 +0100
Message-Id: <9c2df0d1de65cea96c7d731fe64781a2bb90c5b3.1643990447.git.bristot@kernel.org>
In-Reply-To: <cover.1643990447.git.bristot@kernel.org>
References: <cover.1643990447.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid having commits with new version, it is just easier to follow
kernel version.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 7c39728d08de..5a1eda617992 100644
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

