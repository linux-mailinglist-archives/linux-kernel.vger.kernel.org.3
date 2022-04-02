Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F844F0209
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355277AbiDBNSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355333AbiDBNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AB4514D01D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648905369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/bNqj01PYPYrfBUFqkn6y8gBVFdLyZ2mPT7ZyJEILzc=;
        b=KnvkuAgGFT9d65Sed/+wMw9msWcALuc7bT7UXcqlSEf1wPJl922R34ECj1ID1a7Mwj4tEc
        m5STRGbCD9qBIQ4H30UsLvSqsNrU0yB2HvEf0XuYCNqtAsLA+/cy2mwoONSEDWnx0U8HFB
        vKd1aAjDXtiiCn/7WnA5DxsabJPyulE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-H4w0AlmKP1iPBFudSxkrlA-1; Sat, 02 Apr 2022 09:16:07 -0400
X-MC-Unique: H4w0AlmKP1iPBFudSxkrlA-1
Received: by mail-qt1-f197.google.com with SMTP id h11-20020ac87d4b000000b002e1c9a3ae51so4024216qtb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 06:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bNqj01PYPYrfBUFqkn6y8gBVFdLyZ2mPT7ZyJEILzc=;
        b=vQiyqQV2O+AiUfJm+MU1G8kBRv9Gl+qgMxWvgpicBk3STvqaw23TqEc0zqdwN1HfnA
         lTQihUJhMcwxbz5t0CCv8vJxf0Pvrl9wley4C53YribSMTXHjsg4QuuKTrwVK13ItDG4
         X9mTpb1De1Y+Bbe7Y3Es9xryaaLckbnY9ut6sV5ppgPWdJQsnpJ5FWxqxUZ3VuoAr8zA
         t9jA7YWSsHrr0pkG7bnS1mXUIAPM3AEstIVB4wqAX16Jla1qFC1QQhwOZTg+Aehpb5s3
         AMQ6FUnqz9F3nl9m0CIETDxQI4BU++XSsEyoR4/XBEWyBdetSGb0T+G1QHBlEZejV4Vr
         cp+A==
X-Gm-Message-State: AOAM531c0b1axhe4p5znlFVS3Crpf2l2afzI314HSnnfjkP51aaNk9LS
        evB7WdMcvfYXBiNDzAssVnTSoq5AAHePH9OFyZagKx7s96yICQwD+I4qvrTMt5VJimWzqGp5r+E
        kxrBQB/BNRjlnRhZemZOeTue3
X-Received: by 2002:a05:6214:1d0e:b0:441:4e6c:c7f with SMTP id e14-20020a0562141d0e00b004414e6c0c7fmr11653645qvd.78.1648905367335;
        Sat, 02 Apr 2022 06:16:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVznE0k9l0iCCjXjdbHfE/d0rsDri4V+m2CaMGJLMVMv82dD8YSmDIuzB8BIhgb57cTu/NTA==
X-Received: by 2002:a05:6214:1d0e:b0:441:4e6c:c7f with SMTP id e14-20020a0562141d0e00b004414e6c0c7fmr11653631qvd.78.1648905367164;
        Sat, 02 Apr 2022 06:16:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a147c00b0067e765e6c0asm2880735qkl.21.2022.04.02.06.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 06:16:06 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] lib: remove back_str initialization
Date:   Sat,  2 Apr 2022 09:15:46 -0400
Message-Id: <20220402131546.3383578-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang static analysis reports this false positive
glob.c:48:32: warning: Assigned value is garbage
  or undefined
  char const *back_pat = NULL, *back_str = back_str;
                                ^~~~~~~~   ~~~~~~~~

back_str is set after back_pat and it's use is
protected by the !back_pat check.  It is not
necessary to initialize back_str, so remove
the initialization.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 lib/glob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/glob.c b/lib/glob.c
index 85ecbda45cd8..15b73f490720 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -45,7 +45,7 @@ bool __pure glob_match(char const *pat, char const *str)
 	 * (no exception for /), it can be easily proved that there's
 	 * never a need to backtrack multiple levels.
 	 */
-	char const *back_pat = NULL, *back_str = back_str;
+	char const *back_pat = NULL, *back_str;
 
 	/*
 	 * Loop over each token (character or class) in pat, matching
-- 
2.27.0

