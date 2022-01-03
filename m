Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6A482DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiACE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiACE4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:56:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5665C061761;
        Sun,  2 Jan 2022 20:56:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w20so58667853wra.9;
        Sun, 02 Jan 2022 20:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vu6zfDJ9je5iHjAL1VRYcSbnda6OptpXR9ILklIi5i4=;
        b=EQFqNdfPXknGxZZ+NKqv4JMsxPVNxNuO6zPLLfl5Tf7vYETCU7QEt51L8Oe711dkOw
         rDgcoL6HCxKTXCXjwm2U1MKt7DXG8QK01dEtf3RPVaz2t30FAZv5pANtNNc+xTbKXeQL
         tHmmZzBeOMaLZ0ip/NAYq+McaZB5raMBU6WDNHLpGDul7tvF1LkwuQhNlKL0mMHYm0JA
         5uacZ9aisV9LVtxS1om5YqilkpODaN5HHlONJ5RzO0oh+SDxGoibRRJVV/BB+hpiopXu
         i84dS2tXbYF8JFSl+rgMJOEQANrbzVoP/p1v6KjqTPOZJtuo1PYbqpsoZayUxzkdeKpg
         tR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vu6zfDJ9je5iHjAL1VRYcSbnda6OptpXR9ILklIi5i4=;
        b=iChD+oQFvxwNWXUTxJt9CxqaIF/Y19WUfAH12s2VtEKGWT2u6xSdQx8f9nLS/ltCMk
         bBm+Ojf5cVILa6wDctK3ZEwOMTCkdEfZbSE4464TUGA2OTHi5QLDLfvDXn7NClaA3zOT
         zZjMvnQauh2Nu3fQ+9Za23iQ9fGYzPRRnIO7PJaRJKocqJ9i3LS2cyZKO6xWbzcQhl9B
         UwPeIwBb0wtTlv5/JJPekPhOjFbT7IwFi0F37p6D+NnvqFEtZhEPcovOR4VzR72kqr/v
         Wg/kxi8DXf3qzkvBGk5PQOxzA20f2f4zGp/dH8igY286P01I43213UlIs/Hott8SrS4i
         Wv5Q==
X-Gm-Message-State: AOAM533M1s7Oi+Sgpu7YlOOpM69IGR/0lBnP3zmEWikmfjNgBVSKEPTI
        O5A1R9OfzRZGN9UQxo2PzvpOyowv/JIsfQ==
X-Google-Smtp-Source: ABdhPJxtZnjrli3vPCfyUCRYGKtWryKUlLldRDeENlGsIdY3u1iy4ARxb6IbML7FY82mpJT759hfDQ==
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr37741849wrz.261.1641185759453;
        Sun, 02 Jan 2022 20:55:59 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id d5sm34189032wms.28.2022.01.02.20.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:55:59 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/15] scripts: kernel-doc: Transform documentation into POD (12/15)
Date:   Mon,  3 Jan 2022 05:55:44 +0100
Message-Id: <20220103045547.506783-2-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045547.506783-1-tomasz.warniello@gmail.com>
References: <20220103045547.506783-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 12) Archive the pre-git museum

Jonathan Corbet suggested in a reply to my version 1, that these records
can go, since that's what the git log is for. I don't agree.

The log begins at 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2. That's from
2005. One of those entries is indeed logged, so kudos for having me check
this. But not the older ones. Of course they can be found indirectly,
but then...

Why not just let them embellish the script tail?

As you can see, they don't even require any formatting there.

Are you sure you don't want them?

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8069d1d29841..51e813a84d8b 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -54,31 +54,10 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 
 # more perldoc at the end of the file
 
-# 18/01/2001 - 	Cleanups
-# 		Functions prototyped as foo(void) same as foo()
-# 		Stop eval'ing where we don't need to.
-# -- huggie@earth.li
-
-# 27/06/2001 -  Allowed whitespace after initial "/**" and
-#               allowed comments before function declarations.
-# -- Christian Kreibich <ck@whoop.org>
-
 # Still to do:
 # 	- add perldoc documentation
 # 	- Look more closely at some of the scarier bits :)
 
-# 26/05/2001 - 	Support for separate source and object trees.
-#		Return error code.
-# 		Keith Owens <kaos@ocs.com.au>
-
-# 23/09/2001 - Added support for typedefs, structs, enums and unions
-#              Support for Context section; can be terminated using empty line
-#              Small fixes (like spaces vs. \s in regex)
-# -- Tim Jansen <tim@tjansen.de>
-
-# 25/07/2012 - Added support for HTML5
-# -- Dan Luedtke <mail@danrl.de>
-
 ## init lots of data
 
 my $errors = 0;
@@ -2518,3 +2497,25 @@ Treat warnings as errors.
 =back
 
 =cut
+
+PRE-GIT MUSEUM
+
+Original formatting preserved for its historical value.
+
+# 18/01/2001 - 	Cleanups
+# 		Functions prototyped as foo(void) same as foo()
+# 		Stop eval'ing where we don't need to.
+# -- huggie@earth.li
+
+# 27/06/2001 -  Allowed whitespace after initial "/**" and
+#               allowed comments before function declarations.
+# -- Christian Kreibich <ck@whoop.org>
+
+# 26/05/2001 - 	Support for separate source and object trees.
+#		Return error code.
+# 		Keith Owens <kaos@ocs.com.au>
+
+# 23/09/2001 - Added support for typedefs, structs, enums and unions
+#              Support for Context section; can be terminated using empty line
+#              Small fixes (like spaces vs. \s in regex)
+# -- Tim Jansen <tim@tjansen.de>
-- 
2.30.2

