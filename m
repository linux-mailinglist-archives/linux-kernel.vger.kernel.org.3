Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09AC5002B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiDMXjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiDMXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:39:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511637A8A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:37:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j129-20020a252387000000b00641e1faafecso1397612ybj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hqbBQ1UHiAq6yPD/obiExSsWr8OVHyutnWPxkOqwm04=;
        b=pnwR6pxxgtbYeabmZzhgM2ZshQQstKBSocvlMJmZJTGISffIT+RFpVMnoUY0Zp6Ro6
         U5AYha/gQhwgntfiPz0YqNMG2v/7xA0WH/A7DDSsCFsmku15fLCBLIicqedm9zrKqIQp
         xi2T4uN3QG8fM/HsxDqZ/ztQRIINFqBSx9VP1fza+21ig8jgrXHQQ9NdzI6MEom0I3nJ
         zSmg6g4yb+B6CskL1bHWSmPyMsJejE1MYVEYB4VqNXmryIpBsM8jqO/knvLo3V50y2eD
         4dyCzfFe/T9ee0ZmtPvh11lzHlXwvHn/mzdJe6UzKKZ+iStbQMSgO+QYikpsw5dN3tqq
         d8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hqbBQ1UHiAq6yPD/obiExSsWr8OVHyutnWPxkOqwm04=;
        b=YcrUfTqhyH84P3fSCRuSHG/VVjW6EMPWou6fl8lS6Sd8qqlR5IIMCAzYPxLKnwb7mF
         73gHptSii6M7r4fOsHlF4BdmNCTYE8nfiVg5iACvTOVKw+AFhA7rkQFZHoN3b8g7sYl8
         WfYzGLr76q89gmHMhqr+A1eBzrmaPPicNw6BI4MxMeOvX4EBeFpi1pj0imXgtEW7Y27t
         d2iikkkkxgXxIobyZmNna66yVCREVffWcKWb6c9bSOF0NUjjsuN9G3tDqSROILuJ6LwE
         tLZJIBhsvZLQNbe7+nF0xWbkpQZO2TFQoFYwzsROAHkVw9rulQo+IRyYwepmRs0WUc+8
         qylg==
X-Gm-Message-State: AOAM5300Si7mLmCxv5+W224YpPlHCbejp9oglKe9d8OXf3uMFiD6sLQ+
        4CRo2BIT3gr3/uKyzfAltgaPLPwIljtYSNd/Zw==
X-Google-Smtp-Source: ABdhPJxUDV78pXF6U+VJN3WT0aclE7Ili06Wq6L6F4dD2AGyBH5XHqrBMfcw3Z+OG9CqaKhQa7XUkbNnRvlu9tVl7w==
X-Received: from danielmentz2.mtv.corp.google.com ([2620:15c:211:201:10be:e406:e1e1:4b1d])
 (user=danielmentz job=sendgmr) by 2002:a05:6902:1202:b0:641:e3e1:8e2f with
 SMTP id s2-20020a056902120200b00641e3e18e2fmr1024911ybu.597.1649893037019;
 Wed, 13 Apr 2022 16:37:17 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:36:49 -0700
Message-Id: <20220413233649.1394087-1-danielmentz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH] kheaders: Have cpio unconditionally replace files
From:   Daniel Mentz <danielmentz@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For out-of-tree builds, this script invokes cpio twice to copy header
files from the srctree and subsequently from the objtree. According to a
comment in the script, there might be situations in which certain files
already exist in the destination directory when header files are copied
from the objtree:

"The second CPIO can complain if files already exist which can happen
with out of tree builds having stale headers in srctree. Just silence
CPIO for now."

GNU cpio might simply print a warning like "newer or same age version
exists", but toybox cpio exits with a non-zero exit code unless the
command line option "-u" is specified.

To improve compatibility with toybox cpio, add the command line option
"-u" to unconditionally replace existing files in the destination
directory.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 kernel/gen_kheaders.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 1966a749e0d9..0c78e64f747d 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -74,7 +74,7 @@ fi
 # of tree builds having stale headers in srctree. Just silence CPIO for now.
 for f in $dir_list;
 	do find "$f" -name "*.h";
-done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
+done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1
 
 # Remove comments except SDPX lines
 find $cpio_dir -type f -print0 |
-- 
2.36.0.rc0.470.gd361397f0d-goog

