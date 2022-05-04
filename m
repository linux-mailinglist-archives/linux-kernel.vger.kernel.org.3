Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77151AF8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378329AbiEDUpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378322AbiEDUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:45:29 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096E51315
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:41:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8C531407625A;
        Wed,  4 May 2022 20:41:51 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86: add strlcat() to compressed kernel
Date:   Wed,  4 May 2022 23:41:22 +0300
Message-Id: <20220504204123.22967-2-baskov@ispras.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504204123.22967-1-baskov@ispras.ru>
References: <20220504204123.22967-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcat() simplifies the code of command line
concatenation and reduces the probability of mistakes.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1eaa3229..b0635539b6f6 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -40,6 +40,21 @@ static void *____memcpy(void *dest, const void *src, size_t n)
 }
 #endif
 
+size_t strlcat(char *dest, const char *src, size_t count)
+{
+	size_t dsize = strlen(dest);
+	size_t len = strlen(src);
+	size_t res = dsize + len;
+
+	dest += dsize;
+	count -= dsize;
+	if (len >= count)
+		len = count-1;
+	memcpy(dest, src, len);
+	dest[len] = 0;
+	return res;
+}
+
 void *memset(void *s, int c, size_t n)
 {
 	int i;
-- 
2.36.0

