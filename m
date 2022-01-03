Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E5482DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiACEvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiACEvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:51:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B24C061761;
        Sun,  2 Jan 2022 20:51:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l4so20769206wmq.3;
        Sun, 02 Jan 2022 20:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syYX0Fpy5OXOo2MDxFjng6bqlRBDjxlj7DNA3X6EjBM=;
        b=YcfqQpxmNsQwDPQAiT9C+lhTXJbOqd38MFt0smjsTmtEFuBREWD33w8dQYQ1vYV3/3
         5tZnJellHRWj7VIBntO6eR5mZyJpKjxSTdBq+j5eq19V4F5CgOl3RtzZaMIDXQdPn5zt
         fZd5qAYncOnRC7Oa1DSHfbJtbsfEOePheOnIjY7IZWmquZYbl+DRHxIxbGwq/vwUGwCZ
         oDVvaj2Ief9sVxY8XQjd+ac6fG22e7cAo9JUPLuDT1cGty2bN/nyM3Gn1SKIUcAV5IgP
         l2cgPXnn2wxZrlu0OPnfEnTkeHbOA23r2VwOdH764LbhU9A+T7t0IpAsYb/zkzmmob9I
         qfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syYX0Fpy5OXOo2MDxFjng6bqlRBDjxlj7DNA3X6EjBM=;
        b=Yq2frNxXrx0w/Il6zVGhQlElN6suKyMzFz78aZlWWm88GTTb2q9SP5dIYKlYKS7xA4
         vzWo5QOTaycmUjpG+RQzs/zRqc8lmKDdkaU2e3P57Ah4659g5Kda2vsGIszS4oR0421h
         bkhLV4UT2OAanj0tGGqYrtzUQffVOETU1I7qndur9bBgpGgyI1xSyN8oL14j9WJsKDZ6
         n8rDAsUVEi5WEho+FEHVDkpmQ9cHPPISSuX5NLL92WNqLRZI5+vViiOaGNk01qr+Mg12
         FEfhMBFGIlF5VhITJicOu9NA+VuuUHDR5aldSq28DQZvWpIrPlUqMyCZJ4EHKu6u2UBz
         vuYA==
X-Gm-Message-State: AOAM530uVlzoyA8zhD074HYk9WVg66WDqp3gAtb20Rz6GU+6tRgTqHM8
        IS9F6ohbZSMsRvgmanY/wU7QQ5eaXeHbTg==
X-Google-Smtp-Source: ABdhPJz4+X5ozYEIz8Hh5hAc0004tNLk9XEhcAd6w8Kuq7So/mZcKC/k/zot1jbjk6HDpGDnf3cw5Q==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr38016454wmg.62.1641185464264;
        Sun, 02 Jan 2022 20:51:04 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id r7sm32819090wrt.77.2022.01.02.20.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:51:03 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] scripts: kernel-doc: Transform documentation into POD (6/15)
Date:   Mon,  3 Jan 2022 05:50:47 +0100
Message-Id: <20220103045051.506526-1-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 6) Translate the "Output format selection modifier" subsection
        of OPTIONS

This section is renamed to "Output format modifiers" to make it simple.

To make it even more simple, a subsection is added:
"reStructuredText only".

Other notes:
- paragraphing correction
- article correction

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 896c4775102d..d1a4d98726b3 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,13 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output format selection modifier (affects only ReST output):
-
-  -sphinx-version	Use the ReST C domain dialect compatible with an
-			specific Sphinx Version.
-			If not specified, kernel-doc will auto-detect using
-			the sphinx-build version found on PATH.
-
 Output selection (mutually exclusive):
   -export		Only output documentation for symbols that have been
 			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
@@ -2583,4 +2576,19 @@ Do not output documentation, only warnings.
 
 =back
 
+=head2 Output format modifiers
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -sphinx-version VERSION
+
+Use the ReST C domain dialect compatible with a specific Sphinx Version.
+
+If not specified, kernel-doc will auto-detect using the sphinx-build version
+found on PATH.
+
+=back
+
 =cut
-- 
2.30.2

