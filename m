Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EEF483A68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiADCAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiADCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE0C0617A0;
        Mon,  3 Jan 2022 18:00:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o3so14842685wrh.10;
        Mon, 03 Jan 2022 18:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ar26/c+kIZBFJb+XnQqNFZG/AVeErXaJRatHs0lNH6o=;
        b=hQnfUOWNahCdKeWzQ+6ERxXar+t2wmfvf12x7AAfzGg+Uudxo3/oScc9J/keEquxCe
         Y03x44quqPabgOQSlC2vwK660gqVr6Jlmp+DU66bey/n599HTvB/BzbsyeomqUZbSs6w
         dpOd9j0OLpKd2PmSoKjxzGPr0LK+3Cg8DJLDGEjpLcmhcKAXlDd50Jd9lVfQ5lQq12ml
         KuolUTF3mNBKKQnNj4PcqSEa9hwNdFS4d3Y1dZ37iRdOWi+1IdYdFtWXaQTL2Jb8H3pI
         2he3ppcztMYVhiYIHSyZip4kT+jLi2cZ5DM8zjVZbR+uAl/9k20avTj09B2bE5Vv85L5
         PGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ar26/c+kIZBFJb+XnQqNFZG/AVeErXaJRatHs0lNH6o=;
        b=CJN8yERpwCYSqGMrsEF0Tjx80HeP+qNdKlrC9TGxOZj0k6VWaUX55Lb5ixNQ/Kwpx7
         N0v+tJelV1s+7IxNvba4yPBCgVrdmRpYTY5KVyOVmszRo+OgCz06L8/uyCJcAD6lXtoe
         DWdd+W89vY3+UJs9h4gSpyh3aU39u1xMIS43KA2Vont+c9zOlctnigAugSzcnN/DcCYb
         1jztpL0OAf8TbLifYpoq94Suh2C3Vm8fMkg4pt9TKSAf9AcuBu0KThDvViQuhuXc/VRt
         3tTpnt/VbDlprSeI26RGuEaJF6iWvMEZy1sqbSy9ECsHwuCx+FHeMsup0y+1u/eY6Ik9
         N+FQ==
X-Gm-Message-State: AOAM5336797jk3PNuVJLvMnPbK20U1eANmoeb32tja9c9nd1bpeQbrZg
        VZhJpy5sGMV+o7OlFGV0KFg=
X-Google-Smtp-Source: ABdhPJyLl5FmLAj4nJx99t3oXtH8nAHyoSwJLjkxd140QLtb9HwsvoxPzIXit5Sz/TeaqN3iFMVoWA==
X-Received: by 2002:a5d:608c:: with SMTP id w12mr39780774wrt.384.1641261609806;
        Mon, 03 Jan 2022 18:00:09 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:09 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/15] scripts: kernel-doc: Archive the pre-git museum
Date:   Tue,  4 Jan 2022 02:59:43 +0100
Message-Id: <20220104015946.529524-13-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet suggested in a reply to my version 1, that these records
can go, since that's what the git log is for. I don't agree.

The log begins at 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2. That's from
2005. One of those entries is indeed logged, so kudos for having me check
this. But not the older ones. Of course they can be found indirectly,
but then...

Why not just let them embellish the script tail?

As you can see, they don't even require any formatting there.

Are you sure you don't want them?

* Transform documentation into POD (12/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 493c024744b0..0be723f6e3a2 100755
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

