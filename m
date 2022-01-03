Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A423482DDC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiACEvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiACEvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:51:07 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24800C061761;
        Sun,  2 Jan 2022 20:51:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso17731417wmf.3;
        Sun, 02 Jan 2022 20:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WziIORtcu1ixmyUuFsOxZjMh6fj5KLgl3inLlioeuQg=;
        b=cu9OGb/9eo47wQDxRq3PD8Llngit205Utyebr5rVMT+mWn3P1zYFOyX9SI/yk7BeTs
         PKMr/bX+FBCC9/n/yyDRmsi3LC2fs1CC2+aDE9tIBz5DJpKQSLJBnSM/tuVYkYGbcP2+
         B8Srgz7ZjXW51i1UtS1Vu7vMwF5PfG7Kj+9D5x5CKzwqA331+PGmsMYVwKJ/qte3pPZ7
         hEFODGtrY5Atqhg2T3yONs486P7WtLquLUsOnCeeWfQ1Yz0D9+Ubx0RrUhdAm+ZzfVG1
         VOalMpVMCPr/iSJC3kL0PDIOhAw+5jF7xBdM2wt6LOv0deRJNBv8+rMtBZXzQ6AOjvoR
         549w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WziIORtcu1ixmyUuFsOxZjMh6fj5KLgl3inLlioeuQg=;
        b=qur41pRAJFfj2+WsDdgj1KEZgf2+XLsdMAi+C52UtuViKHHNMj606dDpKLvJ/EQVcI
         nOImRk5Q7ljmPKy/m4fp453OhUTAsw9891keXRRJriSyD+b2kv6fQxiSr7DrzHREdORp
         COm7e3Xq7k0dARudGKaNyIBXo58ALf6wjfjBT7WfSdw0YIJrPeGfbVGO3XgargxMejeN
         cFhsoaLPbueQZUHLpQE5oVWPvcvXPrL10bDomuPHXZGeKL0VeiG+tf44feMBXWXnu1Pc
         UJRwcg3A/E5qdq9O8jO/NYaNwJJhGjEXzSqGiVF1svzo6/rrd7zhreOE4DQiRPdSbdsy
         rTig==
X-Gm-Message-State: AOAM531ouT+NrirYiQboAx5rW5HLO38Q5TeeG82RGOtuIvSbLa1nMffm
        SzBVFpTJwbtfJ1C9pamVERs=
X-Google-Smtp-Source: ABdhPJxRm3LhJeUjnU62xpAreas0yY8/fNxeXgofzCxRrxxAJEGRx8sPe+8PTLU+PrSo6wTBKjhc6w==
X-Received: by 2002:a05:600c:2304:: with SMTP id 4mr37344474wmo.71.1641185465775;
        Sun, 02 Jan 2022 20:51:05 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id r7sm32819090wrt.77.2022.01.02.20.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:51:05 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/15] scripts: kernel-doc: Transform documentation into POD (8/15)
Date:   Mon,  3 Jan 2022 05:50:49 +0100
Message-Id: <20220103045051.506526-3-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045051.506526-1-tomasz.warniello@gmail.com>
References: <20220103045051.506526-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 8) Translate the "Output selection modifiers" subsection of OPTIONS

A subsection "reStructuredText only" is added for -enable-lineno.

Other notes:
- paragraphing correction

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 7d95213c11b8..fa1270272b3c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,14 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output selection modifiers:
-  -no-doc-sections	Do not output DOC: sections.
-  -enable-lineno        Enable output of #define LINENO lines. Only works with
-                        reStructuredText format.
-  -export-file FILE     Specify an additional FILE in which to look for
-                        EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(). To be used with
-                        -export or -internal. May be specified multiple times.
-
 Other parameters:
   -v			Verbose output, more warnings and other information.
   -h			Print this help.
@@ -2607,4 +2599,33 @@ May be specified multiple times.
 
 =back
 
+=head2 Output selection modifiers:
+
+=over 8
+
+=item -no-doc-sections
+
+Do not output DOC: sections.
+
+=item -export-file FILE
+
+Specify an additional FILE in which to look for EXPORT_SYMBOL() and
+EXPORT_SYMBOL_GPL().
+
+To be used with -export or -internal.
+
+May be specified multiple times.
+
+=back
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -enable-lineno
+
+Enable output of #define LINENO lines.
+
+=back
+
 =cut
-- 
2.30.2

