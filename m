Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68125495723
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378291AbiAUAAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:00:11 -0500
Received: from ms.lwn.net ([45.79.88.28]:51164 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378241AbiAUAAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:00:09 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EF34B739;
        Fri, 21 Jan 2022 00:00:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EF34B739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642723209; bh=6QS9eIYAOg5uqt0s0/YFYoQv5skTUPZokkn4RpqMbgI=;
        h=From:To:Cc:Subject:Date:From;
        b=HHeLMVVCDeLFVVt3IheI8G5Eq1bkNTIQJPdv/TI65UQZmN+JQhpchuqQwJRjg+suw
         BE8x0DknRdDwZ6xUEsOJnsaSxJQRFlS2OAmnaBBiTwoZCNxhGUDAMqM+2LMhMLgsAR
         p2VpSR6b6atV3ALk+qBrnV9clOYU9P0kLIkRPWC000Pzy5OILG/xRsCJMIp7+UHo8g
         dkwFodmcFPvtob+Eeado9Bz5Z55Ha9B+mLZhG/0MjHQMJrFok0JbmRpKCh56Z6qzbo
         chfeD2NlyDS/F2wj2OZX+KN8rF5wI+BuPLZOIVvLgEQY02QRiwa3eEXvw1MIwcZLmT
         eWDjKRH8skz9g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH] docs: Hook the RTLA documents into the kernel docs build
Date:   Thu, 20 Jan 2022 17:00:33 -0700
Message-ID: <877dau555q.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTLA documents were added to Documentation/ but never hooked into the
rest of the docs build, leading to a bunch of warnings like:

  Documentation/tools/rtla/rtla-osnoise.rst: WARNING: document isn't included in any toctree

Add some basic glue to wire these documents into the build so that they are
available with the rest of the rendered docs.  No attempt has been made to
turn the RTLA docs into proper RST files rather than warmed-over man pages;
that is an exercise for the future.

Fixes: d40d48e1f1f2 ("rtla: Add Documentation")
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
I'm happy to see this follow the original via the tracing tree, or I can
send it Linusward myself once docs-next catches up with mainline.

 Documentation/index.rst            |  1 +
 Documentation/tools/index.rst      | 18 ++++++++++++++++++
 Documentation/tools/rtla/index.rst | 24 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 Documentation/tools/index.rst
 create mode 100644 Documentation/tools/rtla/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 2b4de3926858..b58692d687f6 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -166,6 +166,7 @@ to ReStructured Text format, or are simply too old.
 .. toctree::
    :maxdepth: 2
 
+   tools/index
    staging/index
    watch_queue
 
diff --git a/Documentation/tools/index.rst b/Documentation/tools/index.rst
new file mode 100644
index 000000000000..18f5f4583996
--- /dev/null
+++ b/Documentation/tools/index.rst
@@ -0,0 +1,18 @@
+============
+Kernel tools
+============
+
+This book covers user-space tools that are shipped with the kernel source;
+more additions are needed here:
+
+.. toctree::
+   :maxdepth: 1
+
+   rtla/index
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/tools/rtla/index.rst b/Documentation/tools/rtla/index.rst
new file mode 100644
index 000000000000..5938009bf4ae
--- /dev/null
+++ b/Documentation/tools/rtla/index.rst
@@ -0,0 +1,24 @@
+================================
+The realtime Linux analysis tool
+================================
+
+RTLA provides a set of tools for the analysis of the kernel's realtime
+behavior on specific hardware.
+
+.. toctree::
+   :maxdepth: 1
+
+   rtla
+   rtla-osnoise
+   rtla-osnoise-hist
+   rtla-osnoise-top
+   rtla-timerlat
+   rtla-timerlat-hist
+   rtla-timerlat-top
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.34.1

