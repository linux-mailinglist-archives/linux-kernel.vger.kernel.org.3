Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1E5650BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiGDJ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiGDJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:27:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A47DD128;
        Mon,  4 Jul 2022 02:27:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q9so12557505wrd.8;
        Mon, 04 Jul 2022 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8ajViNQRBuqUSn02uQYgcqcIAiyCQZm2aY6tb0Jvxow=;
        b=FwV11uqFxCK4IkZ4zVZiQ64I4Ggdzep3kIDUZ2+1HDpOAhUlfzAYQJUacB1phfkN2X
         B2HQRkjXpwoAcuKnts64swRREXrVL4xJrJZ9WYfFyoHRvfGx3SOlMfDHIoShfgM86eoE
         AD6c8Vs5c95BaGGO/di2Xh5BNHGRZ6t1xKrPqwmbwreDxwQt9H7npJMcxNlxe16qrIxR
         bSGh6dmLpgE6CclNjxAIPWG2Vn4Kr0YDJAPJw/xemQN/PnikqQrEvbPdL20O9C3DsSfV
         41Y2ic/yf0dFgLd1K0r+o0E7pB2FuYAm4jbyeIXVo3hBUk4RtoVVAoJQ15c+5E4BZzlQ
         V8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ajViNQRBuqUSn02uQYgcqcIAiyCQZm2aY6tb0Jvxow=;
        b=MUlUWW5CCZ9rqhjSlUQy3F2aXFll7xiGI2x43XFtSpT3P3CPRG+eI+pSUSkMFD+8jb
         02+PhlGUc9ggxuOGvVUspjOGynkzvmJbpOBc5ecNu6b815O4WvV5/2NzdIMefZsTBTwo
         16LEo+CzdVB1IaoGEiHPGLe8mcUvPpoaogBh+CXbYRZyPcu3khxIRg3N8msV87yq8DOS
         MM2UO5PXwBGuF7DwEVtL+bq4VwtaT+4+YQZuPEDnZtvi+e5887m5owklL6bYS6uiZLF8
         7FaOWRQohlzYpXnYIiB+ftmipVqUmhnyjYNFfQju3M5ehGuBfJD+s4DLcPMSjkpE1iBB
         lxlA==
X-Gm-Message-State: AJIora9SeE/6plgSCpIWjgIZ5Kng3z6JR9kdbVAf/7N8JHwdAC7bh504
        XFj3RZQNBB3qjeqKE1UHc0E=
X-Google-Smtp-Source: AGRyM1toxERE0aCr4bhk9/9ushPcgnzqZmqbDSrQk4jk+lQaqJhem9chTZej0sQW5e9RrOi3uvfEsw==
X-Received: by 2002:a5d:47c7:0:b0:21d:12f8:e0be with SMTP id o7-20020a5d47c7000000b0021d12f8e0bemr26419284wrc.432.1656926834593;
        Mon, 04 Jul 2022 02:27:14 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id d10-20020adff2ca000000b0021a38089e99sm29618815wrp.57.2022.07.04.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:27:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] secretmem: drop unneeded initialization in secretmem_file_create()
Date:   Mon,  4 Jul 2022 11:26:05 +0200
Message-Id: <20220704092605.19604-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unneeded initialization of the local variable file in function
secretmem_file_create().

No functional change and no change in the resulting object code.

This unneeded initialization was already introduced with the introduction
of secretmem in commit 1507f51255c9 ("mm: introduce memfd_secret system
call to create "secret" memory areas"). This minor code-stylistic issue
was discovered as a dead store with clang-analyzer.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mike, please ack.

Andrew, please pick this minor stylistic clean-up patch. Thanks.

 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 7584aab54d20..46b431d62761 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -171,7 +171,7 @@ static struct vfsmount *secretmem_mnt;
 
 static struct file *secretmem_file_create(unsigned long flags)
 {
-	struct file *file = ERR_PTR(-ENOMEM);
+	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
 	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
-- 
2.17.1

