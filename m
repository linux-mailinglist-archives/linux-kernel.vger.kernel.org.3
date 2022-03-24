Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEFC4E6AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355583AbiCXXEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346914AbiCXXEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:04:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0FFF7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:03:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g3so6299272plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMvhdr5s5WrgumtaNdWQbyj33UK7W2QqfjxCJ/3aGYk=;
        b=B4PyAMh6nh8BnnbQ5pTiIm31wvcDFYWx8MrJe+KDqNok8KtFSF7cvwMJsC+Yf/Mv1S
         REBIhMlkhul+fvw4q8Fmwn+uS6vTr6GdXXmc2rlmMrQsUSCdWuuhXmB2MYUshXIKGRfn
         u7b/MxOve0W1Q30WiFSkbbcR8xFPPHmWBjPRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMvhdr5s5WrgumtaNdWQbyj33UK7W2QqfjxCJ/3aGYk=;
        b=2c3trXeJ77K8KUpw45f9VMMsnSFhKh4ZBYrH39jddNSLr5Xa14S23AB+gIiXIwZjf0
         9ehSYBySH4mEupwPFxWUeyo4Yew4FvvmhXieRGYKypYvTF9bOW5Zy2mdA2jGwFUdidQ6
         B5Zvy4C3MxzgPtiqa2s2VXEs3AeMhD/7Hwlndvy3vqrbPLDdhxlpPNmWE/Bk0cw6qDT7
         ETQRdQRCARzUMCeXQm9qMIRx9QMRqOMWCNj/WJIKdGTQjaB6oIjNEEYnHJKLmr0lqdfg
         4iGjrY9qe3msWlCOI+//Vefer+cAwID8cbjh3EOF9Y+ttZzmYizMTXraTf7OuGYqU4n7
         WZmw==
X-Gm-Message-State: AOAM532LlEsws5sgQUnZg+cgixliqGImpMZKLg5P9bisMY9AVIv1z1e0
        urhdmcp3EZF+Ru3LNsHiOwqv8g==
X-Google-Smtp-Source: ABdhPJwwZQaCh8732ayq9h1KcwgHuiW3U5joe6p6NZlsbHeLVVN9FEoQzg1WyJLM3CFvDW1MH6WhlA==
X-Received: by 2002:a17:903:2281:b0:154:50ab:72c6 with SMTP id b1-20020a170903228100b0015450ab72c6mr8561496plh.51.1648162981432;
        Thu, 24 Mar 2022 16:03:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f31-20020a631f1f000000b003742e45f7d7sm3396910pgf.32.2022.03.24.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:03:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] usercopy: Disable CONFIG_HARDENED_USERCOPY_PAGESPAN
Date:   Thu, 24 Mar 2022 16:02:55 -0700
Message-Id: <20220324230255.1362706-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; h=from:subject; bh=PUZTtyyCrWHooXV+1D56zBK+JGmXV2w8OK9mWJkic1o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiPPifqrb8DGM0yMdn4qdqf5YZZ5M6arJpjHvKdYP0 68rSuGCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYjz4nwAKCRCJcvTf3G3AJsJdD/ 0VG373KYR4CtvABh6/5RvvcCU/J/+J03t5++F/c8LUVj4YVDbs5qyM1pesLe6sBNWHVWve5N0XA4Ui RItvFmbvE6PjlIrgvTh7+jIVY7mS6a6iwI1JClduzRpsKCC5TpRzVW+ZLzX//UR0eEkhWCmrOK1yKE SzIj++sUoHzbcTTtDCHLqCsW2n2GqF/2JCTrW1TO74ygik7rzNj8vpgs267kecQxhdkIUiAU3d/B/7 IWditq6YKNOipe+Dd9Oh+XU2sjyA3waUsLeFe3gIiwKlWbnVCD5ol9G7/R1QDp0vFkMmk3MjPu+CnN yHLgykLyqTpMeMXrue6cDQOll/2I5pK6l4/8gSylBweNRF3oZr90kZjZCAtmuBgaF+adHp/vepufIJ dHdDjR+Qb7TTfmFxSQEVSp9s6R6OxtpKx2bPGkUaK/FG2S9hJEBg3Aqov+LcpDVqx1bwFZ/UCo19so GN2mVjXcI4yL0wWX2MI2O3Z4ce87olcv9BLny/JRWBodif4Bkv9AYQSfESdD5itJEAyU5oIon4kl1m YiF0EiiXqFj7qvfQbPaXEdSFTCVH8MR1rDlc1VrbofkytHh5jCxsolMZViiQK4GauDrS8ujk8yAqZy 43zvKwuqkdzEyfYMviYJ+LuqsRi6rNhNKX9gN6xv0WvVz4m5u1Kv6yIaL3FA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HARDENED_USERCOPY_PAGESPAN has been mostly broken for a while,
and it has become hard to ignore with some recent scsi changes[1].
While there is a more complete series to replace it with better checks[2],
it should have more soak time in -next. Instead, disable the config now,
with the expectation that it will be fully replaced in the next kernel
release.

[1] https://lore.kernel.org/lkml/20220324064846.GA12961@lst.de/
[2] https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index 0b847f435beb..88a0bc8c592b 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -166,7 +166,7 @@ config HARDENED_USERCOPY
 config HARDENED_USERCOPY_PAGESPAN
 	bool "Refuse to copy allocations that span multiple pages"
 	depends on HARDENED_USERCOPY
-	depends on EXPERT
+	depends on BROKEN
 	help
 	  When a multi-page allocation is done without __GFP_COMP,
 	  hardened usercopy will reject attempts to copy it. There are,
-- 
2.32.0

