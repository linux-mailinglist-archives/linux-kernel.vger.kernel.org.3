Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D89482DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiACE4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiACE4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:56:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2BBC061761;
        Sun,  2 Jan 2022 20:56:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e5so20378309wmq.1;
        Sun, 02 Jan 2022 20:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uySqD+BbuGPxJEvLMDFi72+7B/Vqjn0woCJ8EBS7dew=;
        b=ESt6xXMRu+M5z/Nozi7Ksvj/BDBRHF2Z0IgxbXgW3G27xYmFeTl5uz6VSyP/i4jvXU
         SpqzvPtGKngIVFFXzypALBkhJ4cmHd3yJwQv1oozHrjCPMtb4jF0dme3/Pl1VN6m0N96
         QQNh3IcZpOywyFM6HxEGxSnPZOPbm6jRfcL01dnM9rSX5/8uSg2lXEKbmYHD67+s70B+
         beaGU1wE7HvzJZTPQ5kawlwbWZ77nY4JA0gLRql2Uf9s6YojE/0ttH92Xt/xLW+mAZOa
         wXecc9zbIAG/HKPW3b/0cHG21KnIPHnh/2t2QgP4V139RMe0TxiTzvYm9uHAL/NA5mnM
         67pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uySqD+BbuGPxJEvLMDFi72+7B/Vqjn0woCJ8EBS7dew=;
        b=nEntEnLmzzoW7MdHX+NLJedSlgWYizR6b+1hGzDlTi8k9JlvYovs6Vtflf5bB1uC4C
         M7sgrRAuMiBRJaKaoL0n7UjYm/bz2HVQEuiBXEUeKntH71J5XisQAUTe+vvSps57TaMS
         3mz/zrbB78drPa92FdHWd/9HTz7UYENNT4fGEe/iFFB8REFsfJTR/2/3sjEeKWKknn3s
         w6IfaWW0tCWD9P2wNlxw9W0R6Bnv+0eX/66pBwntWE9Xnd9o0W8oiwMuIFS2hFhl8fic
         wpfkXr7Q+gJDu7H5D9ECGqc9XjN8cmwvzSemO2f5TzFKcoS4svIbRk1j1+2KdNpGven5
         fWjw==
X-Gm-Message-State: AOAM5320Ax7bO3TA3YehSIfjo6zxyceJom4DGc4EmdDegzLOkDkI/KrN
        isNIfNOflXL83HqpwoTQcRCotbQT/ms6ZQ==
X-Google-Smtp-Source: ABdhPJxKgR1LH5ePObO3Ky0QDF6VpQgHWLD/jN+ZChaleKBIshEqPC+M2rj2zzGTFPvS92PIOvNJRA==
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr36005881wmf.48.1641185761131;
        Sun, 02 Jan 2022 20:56:01 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id d5sm34189032wms.28.2022.01.02.20.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:56:00 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/15] scripts: kernel-doc: Transform documentation into POD (14/15)
Date:   Mon,  3 Jan 2022 05:55:46 +0100
Message-Id: <20220103045547.506783-4-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045547.506783-1-tomasz.warniello@gmail.com>
References: <20220103045547.506783-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 14) Refresh the copyright lines

I'm not sure, why these notices need to stay at the top, but that's what
Jonathat Corbet replied to my version 1.

Anyways, I've cleaned them up a little. Looks good?

My name's included as the refreshing force of this venerable script.

See step 1 for the series details.

(Still not sure about this tag line, so please correct, let me know, etc.)

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index eb56770b96c5..c588e7a08c77 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -4,14 +4,16 @@
 use warnings;
 use strict;
 
-## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
-## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
-## Copyright (C) 2001  Simon Huggins                             ##
-## Copyright (C) 2005-2012  Randy Dunlap                         ##
-## Copyright (C) 2012  Dan Luedtke                               ##
-## 								 ##
-## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
-## Copyright (c) 2000 MontaVista Software, Inc.			 ##
+# Copyright (C) 1998 Michael Zucchi, All Rights Reserved
+# Copyright (C) 2000, 1 Tim Waugh <twaugh@redhat.com>
+# Copyright (C) 2001 Simon Huggins
+# Copyright (C) 2005-2012  Randy Dunlap
+# Copyright (C) 2012 Dan Luedtke
+#
+# #define enhancements by Armin Kuster <akuster@mvista.com>
+# Copyright (C) 2000 MontaVista Software, Inc.
+#
+# Copyright (C) 2022 Tomasz Warniełło (POD)
 
 use Pod::Usage qw/pod2usage/;
 
-- 
2.30.2

