Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B244D75B7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiCMOKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiCMOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1C6519C0A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647180531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aHlt3bx/6LYGuimvevPncXDwqXwsiWI/ZrNgqxl8liI=;
        b=deluJyY8nQynQ9hHpkyJkCZlagunIaYsvXZtPTrhzuLfuiFIub7dyZGXY5QTjHa20xHmzN
        b2kqiy1fvYXktSN11GVwMtcfQgr7NeRSpJ9nkcAB8jsqY3t6qR+t3x0yNJvWokEkjZWSRC
        P4zBsFE/4hJYqpPWgfrIaOvrJpAvCVc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-xINCUeAtNWK2m7j4SgHtuQ-1; Sun, 13 Mar 2022 10:08:50 -0400
X-MC-Unique: xINCUeAtNWK2m7j4SgHtuQ-1
Received: by mail-ot1-f71.google.com with SMTP id 92-20020a9d0de5000000b005b2731fb946so8092413ots.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHlt3bx/6LYGuimvevPncXDwqXwsiWI/ZrNgqxl8liI=;
        b=fMZzY37TA5evf5qDbQI4t3x7+Fn7eybmDWeIiDGynf0oer5HCXVf5cBbimKKWlKz4s
         KbVDC6VNO02mHiHCwOLnZ/wEXK/zP+QZ+I7rwUgXf96JsmymYuVLuypupHVQzoVlujNW
         05Qg4JWxiMa0yXPmPboUOUJfCfbT3+4kz+WxYRuc7eRuJdiiIt6k/Fb1WI+7RBXOKfxD
         Art2ehUGGkQIvg4cnnp/cmx6pqTcDiF24YZi++cClPHaZ8BbZryETmqNia+pRJpae198
         gJyx8DJ6SJb+oUOy4BuqDEjUZGnJMo66X5264G7Q6N7hNZf6J13mjb4tAPSGGTnTRJRK
         UrIQ==
X-Gm-Message-State: AOAM530HIIidyBHb44It7uQfjtJQ7lDkRCVOw4sXKlcVTVUuOTEgiurg
        f1Bq9vcSpZ7iYlF+ObjHCyGV6lIGCd+PBDni8COjEwVhMdgGjoqZ2Pgo2dIUIV6jzRwcUqyms7t
        sBgdlds+tzjW1IS9Rxt4Nsglh
X-Received: by 2002:aca:6548:0:b0:2d9:ce64:bead with SMTP id j8-20020aca6548000000b002d9ce64beadmr18328610oiw.109.1647180529140;
        Sun, 13 Mar 2022 07:08:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc8XSUz+AjUtGiKcs+f3Z4vpjgKBNiWmUQ8pnmOGRWYX3D48U8yyb2ePpbiLv1ij3UiCQ+pA==
X-Received: by 2002:aca:6548:0:b0:2d9:ce64:bead with SMTP id j8-20020aca6548000000b002d9ce64beadmr18328589oiw.109.1647180528560;
        Sun, 13 Mar 2022 07:08:48 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id k13-20020a54470d000000b002d9b7fa03e1sm6379441oik.12.2022.03.13.07.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 07:08:48 -0700 (PDT)
From:   trix@redhat.com
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] checkpatch: warn that small allocs should be combined
Date:   Sun, 13 Mar 2022 07:08:27 -0700
Message-Id: <20220313140827.1503359-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A memory allocation has overhead.  When a
small allocation is made the overhead dominates.
By combining the fixed sized small allocations
with others, the memory usage can be reduced
by eliminating the overhead of the small allocs.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e029987011..605d5278677fc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7076,6 +7076,12 @@ sub process {
 			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
 		}
 
+# check for small allocs
+		if ($line =~ /\b(?:kv|k|v)[zm]alloc\s*\(\s*(\d|sizeof\s*\([su](8|16|32)s*\))\s*,/) {
+			WARN("SMALL_ALLOC",
+			     "Small allocs should be combined\n" . $herecurr);
+		}
+
 # check for multiple semicolons
 		if ($line =~ /;\s*;\s*$/) {
 			if (WARN("ONE_SEMICOLON",
-- 
2.26.3

