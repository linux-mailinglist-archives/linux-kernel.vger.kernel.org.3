Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6244A86A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbiBCOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:36:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351445AbiBCOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6VJokSHsxPkfQMrVgiQDizkBiRMjzQ+sHIs7SD0nGIk=;
        b=KpUzOcyxzIJZRNkXTEFE01tbQQPE2xFcOYcUt5GNnNjY/3xO2LDJwIr5th+oezdU2+OJrA
        EEZFwd+tkexa9PaMhF/jvsw5B77nEqLwlT94bw6DatXW3i/MeJnt1MI1DD5cvkdn3zIbG3
        oXZ1IvVrbMYXzSJ0LDbQ1JTwZjo2hPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-vBG71VSYM-W7fbjWzrH9pA-1; Thu, 03 Feb 2022 09:33:56 -0500
X-MC-Unique: vBG71VSYM-W7fbjWzrH9pA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00A6F1091DA0;
        Thu,  3 Feb 2022 14:33:54 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 650947D4D0;
        Thu,  3 Feb 2022 14:33:51 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 12/12] Input: docs: add more details on the use of BTN_TOOL
Date:   Thu,  3 Feb 2022 15:32:26 +0100
Message-Id: <20220203143226.4023622-13-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HID core stack used to be very relaxed considering the BTN_TOOL_*
usage. With the recent commits, we should now enforce to have only one
tool at a time, meaning that we can now express that requirement in the
docs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- changed to explain that switching tool in one EV_SYN report
  is not nice for userspace
---
 Documentation/input/event-codes.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index b24ae7d292cc..8741d390b184 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -137,7 +137,11 @@ A few EV_KEY codes have special meanings:
     code should be set to a value of 1. When the tool is no longer interacting
     with the input device, the BTN_TOOL_<name> code should be reset to 0. All
     trackpads, tablets, and touchscreens should use at least one BTN_TOOL_<name>
-    code when events are generated.
+    code when events are generated. Likewise all trackpads, tablets, and
+    touchscreens should export only one BTN_TOOL_<name> at a time. To not break
+    existing userspace, it is recommended to not switch tool in one EV_SYN frame
+    but first emitting the old BTN_TOOL_<name> at 0, then emit one SYN_REPORT
+    and then set the new BTN_TOOL_<name> at 1.
 
 * BTN_TOUCH:
 
-- 
2.33.1

