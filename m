Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7D482DCA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiACEqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiACEqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:46:08 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB89C061761;
        Sun,  2 Jan 2022 20:46:08 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so67733652wrb.0;
        Sun, 02 Jan 2022 20:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YH+nSv0WaPfnaUJDeP4PQ20tDiz1dZrKWyPmKVjipqQ=;
        b=YLNvRtuRf2C1YkcUFwODr6zgrxLaHlD38lbSdQehgN75lQCWy9aLegg0X179n2H9w3
         YwXVMrOLc/YPAgGZPlyS1sQPlLQusgODnUYLqjMVqzVwffHxUQMi31TKoQdddSP3J6qI
         MkVWC3LHhK6HUaWm5o0U4qt6GbxfZMCS3YRF/NGpKNYFPn8uMQO2KQ5J4tYMirOQvKay
         waWwyJVAPN9UIjkZARkiyyDhUsB3QJu1T3jx9HySw8/RrQ7rUyiTO9XugGHxFJ+033t6
         UaCIMq29qmAl7rp5DtDuLp7Jdtp6UaHQteIYoELGuwCuC02jTj2hGHdXBgkG87jdWTmu
         BY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YH+nSv0WaPfnaUJDeP4PQ20tDiz1dZrKWyPmKVjipqQ=;
        b=aEA0Ef27YflDXIied1kPTkO5r52hmxnky00NAiWBGklQjOh539GU7FEpZx0MVhZR9A
         XB1XQ8qCqKZW8eNinL8aR/6rUCv5KaT+42HqG9YV6jX4ZggvwzAAs687u7qtMjA717+V
         QG6CDE40qYrTmMpUiwKrTPzA+3uxGXDskLhzDJclqvYS4I8HVtXw156TgM9AiZSXiJKX
         D0WYg61rwEVq3R9ytKl9p5Xf6uFyDRaH7/gs53kfdzltzj0/7ioBkC/+ppNY+IMQkbOI
         ho7G7xrtmEX5vyiDbcl2ZKwfuPQDkScxHcEFOOHHIkdXEGC/81lqnac9xBUAcmaqmAoc
         /9wA==
X-Gm-Message-State: AOAM532PyZyS0HR5Mr3yRSF+FzIUhC3rKTV9TcfnIceC1GBm50MXJzzY
        Z8zNPXakJNhvQlLxdEJOtQA=
X-Google-Smtp-Source: ABdhPJycREqcPbnEXh6oDkCLI4Yikn4ophjDFdyDxtqBj8IPVd8jrVmVCi7bVsOZe+/OslgBL9Xk3Q==
X-Received: by 2002:a05:6000:15c6:: with SMTP id y6mr36098059wry.20.1641185165951;
        Sun, 02 Jan 2022 20:46:05 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id o10sm24638860wmq.31.2022.01.02.20.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:46:05 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/15] scripts: kernel-doc: Transform documentation into POD (2/15)
Date:   Mon,  3 Jan 2022 05:43:35 +0100
Message-Id: <20220103044338.506244-2-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103044338.506244-1-tomasz.warniello@gmail.com>
References: <20220103044338.506244-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 2) Add the SYNOPSIS section

Rst-only options are grouped around rst, the rest is arranged
as in the OPTIONS susections (yet to be translated into POD,
check at the end of the series).

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

