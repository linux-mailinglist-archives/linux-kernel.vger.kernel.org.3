Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB1483A52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiADCAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiADCAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75466C061784;
        Mon,  3 Jan 2022 18:00:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r17so73017199wrc.3;
        Mon, 03 Jan 2022 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mi3lXLotPeA8OuZcUtL4/v/VSJqoUbLVNYdECb0ITQ=;
        b=B1/VG2Wvv78ikbvTlEp9y4WElUCB2staDTZ9bZmW2366mf3aGh6jHF/fCp+K6eoQJw
         Cy7UwsXnxFA5IaAzOWT6x7mfBMmFDppyemGojVNf+ud0WP4NWUBRng2rXM7fFDMmuOAQ
         R4LA4MoCICy8lVmLUBxuLLAeST3JeNhs4XsltpG78lJ1C5btE9obli2jS9H3y+e941uN
         1TcnvO0rp/vHgsJJuJO9fW+0O84aPObQIAbXq/aVaPPXya/ZedCqSlPzCrROjWemTUht
         XZDUbK08Nu3Fl42bUMWtvo5yi6U5MLO6glGDeFGrk7XGKZMmHh2zMxXz8Ofae8MqsDJ1
         19Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mi3lXLotPeA8OuZcUtL4/v/VSJqoUbLVNYdECb0ITQ=;
        b=d8JaMMJfOSNBq8mjK12XZ4Xpd+JOB0iXABudFhOVU8DyMizmjFyVhDoPkSCjlL5QcY
         QBAWHF5ncMH7+J323GkARFZ4UERMLb69HV6cfHT4iAnOr3NmSMGkihGYx3DTebOmF+lM
         meWogFnNivD99tzRq7Ccqqgk9mnk1vhi0e7jmPCuDHyh/aCvk8O+6wLZuvlHoFo0rLH/
         KVtdEL6qa/brnQtUdUpZoBbZTNON6Mb8Osq1+HXdCCr+5hKf94uivnuFIsNBatk+VULv
         1t6mfw2M/SpQTs9JjpqeHKXmDHcUB6rgbGJKf5rDi46Q4V9K6bO9n59+g47B3v/4tkXd
         3wDg==
X-Gm-Message-State: AOAM530DgN1mW1uMuW3QZYrQ7sdA4uc6cdVC8bhu/gTztlt0b1MNKV4w
        WVwGY0NyxnFXnurqVuwO7U/PRAx0jUo66w==
X-Google-Smtp-Source: ABdhPJwV1uQFBq1uFtsfRCSzedoy7vXBSw473zSo0ewjA1+ntu5aU2rOlXbZnkgwt7810aFZY4ZSwg==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr38309662wrw.388.1641261601132;
        Mon, 03 Jan 2022 18:00:01 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:00 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] scripts: kernel-doc: Add the SYNOPSIS section
Date:   Tue,  4 Jan 2022 02:59:33 +0100
Message-Id: <20220104015946.529524-3-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rst-only options are grouped around rst, the rest is arranged
as in the OPTIONS susections (yet to be translated into POD,
check at the end of the series).

* Transform documentation into POD (2/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 46d3e779bf5d..c8fbf1d3d5aa 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -20,6 +20,25 @@ use strict;
 
 kernel-doc - Print formatted kernel documentation to stdout
 
+=head1 SYNOPSIS
+
+ kernel-doc [-h] [-v] [-Werror]
+   [ -man |
+     -rst [-sphinx-version VERSION] [-enable-lineno] |
+     -none
+   ]
+   [
+     -export |
+     -internal |
+     [-function NAME] ... |
+     [-nosymbol NAME] ...
+   ]
+   [-no-doc-sections]
+   [-export-file FILE] ...
+   FILE ...
+
+Run `kernel-doc -h` for details.
+
 =cut
 
 # 18/01/2001 - 	Cleanups
-- 
2.30.2

