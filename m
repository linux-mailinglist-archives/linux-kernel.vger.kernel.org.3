Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00A482DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiACEqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiACEqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:46:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95061C061761;
        Sun,  2 Jan 2022 20:46:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v7so67532578wrv.12;
        Sun, 02 Jan 2022 20:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfoQP6IIeVX0+JvHVXo2bmT75XClGvniJRKvlsvdbgs=;
        b=lxIA1+vUO/5BciOYgVa/zQb9ZKi5DAgBdTKeXt9xn/CjXvkO/r23UUxkBT2fmlt/ct
         QPRNIYMrPsSEOLRBETS5JSJ2rZkp8EFOSYJBKfKUoTaTgvOdGMRpuX1GWN6LW8NerHpL
         Gvp2UnQCGgKdvVKGTqCWYfbBxs1Az3njCyvp2MmE2l7Rn6WD7oScob8AMNX0X0pPQ/ek
         BBMkSIeBFdlwiamclY6UKSoNoyAM5IsxKAei8E3QwzPuo0yx2KUUQZDSARd7wk8LXCuR
         UcMPgetEsulB1rPe2AP4vLHl3GaJSPlKO0dQGnH59K9/diZJ2MEQvqd3wPAC8tW2LKiL
         mB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfoQP6IIeVX0+JvHVXo2bmT75XClGvniJRKvlsvdbgs=;
        b=m5tb/dwpcq3Nh012duB98R76YCYoaZUfZnKtv0tsEuO0G/QHXlCtA9xwx8Ucb9EPnv
         dVoLhglB8qzFTFojsjxSdelbCKFFRELB21UdIJfA4SkTdYusjKUamR2I/77VTs/CPBbj
         X3u1ARsKy38iFwVNNtwCwWGLv2qRGRdDOgFjSjVi42caP+v9F/Hwqh1FgSvaULqkyA2a
         UHEFy9oIiYPpPge962ISi3j9ftqrDLC4QKWC8wzebsCfcbMgatUfViACL1KOLlrVshIO
         WAtiYDcYoP+dWO8pBJVM64r3QlIBSTgiX6T1DqSSsnEhzwgH92zjv2aZP4HycIJM0/wT
         Rkmg==
X-Gm-Message-State: AOAM533SdUx5jxtT4tmASe3OAjOpKFPpXZ2pSU3LOjkU3v1vja025hqU
        JrNp0MDkPu/B5m5jnbB02m90xHuxyvdkHA==
X-Google-Smtp-Source: ABdhPJypAWYwEkkLV/PJEN5UXB4hgHjSXnZ+dGJ7R7uU2UNpYYhNJ3r9r0kQogI86eiVG+fdNgKMog==
X-Received: by 2002:a5d:698f:: with SMTP id g15mr38686333wru.256.1641185171253;
        Sun, 02 Jan 2022 20:46:11 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id o10sm24638860wmq.31.2022.01.02.20.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:46:10 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/15] scripts: kernel-doc: Transform documentation into POD (4/15)
Date:   Mon,  3 Jan 2022 05:43:37 +0100
Message-Id: <20220103044338.506244-4-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103044338.506244-1-tomasz.warniello@gmail.com>
References: <20220103044338.506244-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 4) Translate the DESCRIPTION section

Notes:
- an article addition
- paragraphing correction

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 9be526073b75..c58c812c74cb 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -41,6 +41,15 @@ kernel-doc - Print formatted kernel documentation to stdout
 
 Run `kernel-doc -h` for details.
 
+=head1 DESCRIPTION
+
+Read C language source or header FILEs, extract embedded documentation comments,
+and print formatted documentation to standard output.
+
+The documentation comments are identified by the "/**" opening comment mark.
+
+See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
+
 =cut
 
 # 18/01/2001 - 	Cleanups
@@ -72,12 +81,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Read C language source or header FILEs, extract embedded documentation comments,
-and print formatted documentation to standard output.
-
-The documentation comments are identified by "/**" opening comment mark. See
-Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
-
 Output format selection (mutually exclusive):
   -man			Output troff manual page format. This is the default.
   -rst			Output reStructuredText format.
-- 
2.30.2

