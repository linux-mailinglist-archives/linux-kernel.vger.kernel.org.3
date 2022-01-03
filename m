Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F11482DD8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiACEvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiACEvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:51:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B58C061784;
        Sun,  2 Jan 2022 20:51:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so17714555wme.4;
        Sun, 02 Jan 2022 20:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6n1xKN820g41S94G5epF+kbtQ8WMSJslq+CKR3ZFuIo=;
        b=PxqbZYdUwCCPZ3o+FChaVMNd3sxAIhLZpRncM5xsiiHBxUC5FgUMzdoBHXky0m3FLP
         D/bXJpHtsWacTboVdy4bSbU04vQ20rC80AzNMh5er/tY7TlbQiV3/9vV1nHjOlt8ezxl
         UVXqqylsjsQoV9DSKxPllLgSn9ivCRxX9xcWHcg3u0wYHox6ugoyMvOsCVd63UCDJzo6
         5a9Fsfx7LChX8JjWKyaXDqOqrBc3amE/epIhobRoyU5O7iVfK0IxMPUW9DDnofvu/9el
         NDEDwqz2VJ/Kd0u3LXEMBlt0iWL5AasDDtg7qveb2jcrTZmhh5RdjrQ7k91XlPRU9IQN
         bxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6n1xKN820g41S94G5epF+kbtQ8WMSJslq+CKR3ZFuIo=;
        b=eYLNmIw8JHL6+fhqs6MDXo7pwF7Ds6JDURIe2pm7b1e57hMXJY1NmBgEU8dDaZ9c3C
         Oqkd57IBwVeGLLGkl0bDTQ2V+iP6XyINQXUoBr1IV/tkG7y+bVs97AtC9pP35otvAj2j
         HYgL0pczuekpV1kxEjAMstffpR2AVFZIgu0/cWaJsSWjfzNwnMfR+kOaRWrOE9GImGeV
         XiHcigARSWMt0X7AP+OvmHQWNzOHUwgjnfdWDxQLOh+xAk1a94ZjG6/71KzAJbjQ//2u
         z6jZkfLT131J3STWmYMSRk+jp8xFVWMoWUSjxA1ms88nOxTUKf4SNfBVx0YdZQ9O+BzQ
         FRWg==
X-Gm-Message-State: AOAM531Esel8H6CukaEWk6RzXB0ErryDw80Nys9+acmcWRJ/qms5nOcE
        v3pP0K6ITIhTY1Dsd61CN4E=
X-Google-Smtp-Source: ABdhPJyU7pwWKk7LyiDYoE7Z6Ff1W1H1fobvd+TwYrbquxsum+SQyCG3glFs1T5+YxEcqTrgxBxT8A==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr18781316wmd.115.1641185464987;
        Sun, 02 Jan 2022 20:51:04 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id r7sm32819090wrt.77.2022.01.02.20.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:51:04 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/15] scripts: kernel-doc: Transform documentation into POD (7/15)
Date:   Mon,  3 Jan 2022 05:50:48 +0100
Message-Id: <20220103045051.506526-2-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045051.506526-1-tomasz.warniello@gmail.com>
References: <20220103045051.506526-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 7) Translate the "Output selection" subsection of OPTIONS

The plurals in -function and -nosymbol are corrected to singulars.
That's how the script works now. I think this describes the syntax better.
The plurar suggests multiple FILE arguments might be possible. So this
seems more coherent.

Other notes:
- paragraphing correction
- article correction

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d1a4d98726b3..7d95213c11b8 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,19 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output selection (mutually exclusive):
-  -export		Only output documentation for symbols that have been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -internal		Only output documentation for symbols that have NOT been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -function NAME	Only output documentation for the given function(s)
-			or DOC: section title(s). All other functions and DOC:
-			sections are ignored. May be specified multiple times.
-  -nosymbol NAME	Exclude the specified symbols from the output
-		        documentation. May be specified multiple times.
-
 Output selection modifiers:
   -no-doc-sections	Do not output DOC: sections.
   -enable-lineno        Enable output of #define LINENO lines. Only works with
@@ -2591,4 +2578,33 @@ found on PATH.
 
 =back
 
+=head2 Output selection (mutually exclusive):
+
+=over 8
+
+=item -export
+
+Only output documentation for the symbols that have been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -internal
+
+Only output documentation for the symbols that have NOT been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -function NAME
+
+Only output documentation for the given function or DOC: section title.
+All other functions and DOC: sections are ignored.
+
+May be specified multiple times.
+
+=item -nosymbol NAME
+
+Exclude the specified symbol from the output documentation.
+
+May be specified multiple times.
+
+=back
+
 =cut
-- 
2.30.2

