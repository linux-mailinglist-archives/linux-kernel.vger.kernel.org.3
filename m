Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E0356CF78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGJO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiGJO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:28:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9918465F4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:28:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c13so2477811pla.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6ZV3koDu5LQcC6SxS/8lxYec7GbAece89S8C2Dtw9E=;
        b=j7X9DUrx9YiONkpf87mV/OuXUQ188nb56/tQ+4P6Kp2r4kYDiKaTfEAnusIBJ6ht5O
         T2AphCO7KznydVdND/nmerqq4I7FBjydbNuucmtuKz+5TdNVuNGodnK6fYQs8wyfAdzv
         SVRJDrDbY/WUp0HXR5I1dd0+oI85hTTRDXEsQenEftyiw1fY4dRzstScAb7yPEBRJoRr
         ++hPS1LiQi9C4kQ7i2jdHZmvYkwD4ToDRXxd5cH2Pxhl1HG0S7Eg69+Ix3vxg1LwU0vp
         s7hMZSdsbjFVGaT/Lciop5GRJG9PyMMNjkbKJP8yMe1A+x86MILy3y+UoTUs+Ue+od7G
         qnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6ZV3koDu5LQcC6SxS/8lxYec7GbAece89S8C2Dtw9E=;
        b=utp/1ao4y46eOKwmJwqCIXqFkBCcTnOZIdk+Q4y9QnTWEje/cBczzADqfP1H5v8Wri
         tO8K1IyrmxB0gRg9f+pDBskqEkANmidUimhjR5SSVRBXfITKUJ4hnLTMroc/29ogk6BF
         iSnMadV+oAjthletogUTPsO5OXfD+4UA+O15Jog5K4ORkgdt6znSVSdCibB6FVJShdVu
         K9zEuwv+87WP0rxhMAFBR3T2zZWpAVT+Nj0k7XLHHj7keF+qe3s5ag5XCbpIKgFQfKa0
         tjg8Ov4v/AtMMp67lklIY3N81NChLbNDVapXGSzASMPSYiyhhG+eL3ve58+amwhWO6Hv
         PPDA==
X-Gm-Message-State: AJIora9xmP2sNHtOREeAJi6srNi3fHZujHnUuFBnTP719VGR/bwKB6Rv
        FbHA31/d37KbUxY1l988okE=
X-Google-Smtp-Source: AGRyM1sZ9f+huO/77/vh3cmRje8uZA3Z2BOu+0ZBJw1HnTrdKLjEt8u+Z+J41KiLyN38tNl2f1J0eA==
X-Received: by 2002:a17:90b:3e86:b0:1ec:f7e8:e4e4 with SMTP id rj6-20020a17090b3e8600b001ecf7e8e4e4mr12066272pjb.218.1657463324073;
        Sun, 10 Jul 2022 07:28:44 -0700 (PDT)
Received: from localhost.localdomain ([101.12.54.120])
        by smtp.gmail.com with ESMTPSA id u28-20020a63471c000000b0040c644e82efsm2508555pga.43.2022.07.10.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 07:28:43 -0700 (PDT)
From:   Yu-Jen Chang <arthurchang09@gmail.com>
To:     andy@kernel.org, akinobu.mita@gmail.com
Cc:     jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
        Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 2/2] lib/string.c: Optimize memchr()
Date:   Sun, 10 Jul 2022 22:28:22 +0800
Message-Id: <20220710142822.52539-3-arthurchang09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710142822.52539-1-arthurchang09@gmail.com>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original version of memchr() is implemented with the byte-wise
comparing technique, which does not fully use 64-bits or 32-bits
registers in CPU. We use word-wide comparing so that 8 characters
can be compared at the same time on CPU. This code is base on
David Laight's implementation.

We create two files to measure the performance. The first file
contains on average 10 characters ahead the target character.
The second file contains at least 1000 characters ahead the
target character. Our implementation of “memchr()” is slightly
better in the first test and nearly 4x faster than the orginal
implementation in the second test.

Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
---
 lib/string.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 80469e6c3..8ca965431 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -905,21 +905,35 @@ EXPORT_SYMBOL(strnstr);
 #ifndef __HAVE_ARCH_MEMCHR
 /**
  * memchr - Find a character in an area of memory.
- * @s: The memory area
+ * @p: The memory area
  * @c: The byte to search for
- * @n: The size of the area.
+ * @length: The size of the area.
  *
  * returns the address of the first occurrence of @c, or %NULL
  * if @c is not found
  */
-void *memchr(const void *s, int c, size_t n)
+void *memchr(const void *p, int c, unsigned long length)
 {
-	const unsigned char *p = s;
-	while (n-- != 0) {
-        	if ((unsigned char)c == *p++) {
-			return (void *)(p - 1);
+	u64 mask, val;
+	const void *end = p + length;
+
+	c &= 0xff;
+	if (p <= end - 8) {
+		mask = c;
+		MEMCHR_MASK_GEN(mask);
+
+		for (; p <= end - 8; p += 8) {
+			val = *(u64 *)p ^ mask;
+			if ((val + 0xfefefefefefefeffu) &
+			    (~val & 0x8080808080808080u))
+				break;
 		}
 	}
+
+	for (; p < end; p++)
+		if (*(unsigned char *)p == c)
+			return (void *)p;
+
 	return NULL;
 }
 EXPORT_SYMBOL(memchr);
-- 
2.25.1

