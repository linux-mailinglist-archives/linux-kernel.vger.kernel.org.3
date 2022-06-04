Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5133753D84C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbiFDTb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbiFDTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79034F9D2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t21so935157qtw.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Shg77HnyMQRXbMxMOH7fDju/B6P367xm3FEJBtf2/5I=;
        b=ZHiSfBqPf0mmbm6Cwm8a5Stmx8hor2CW8L2no7YFJT+21lVu1KlVat/aaUe3DDYjH/
         y4u/TFZndKUExogSMANFNdRkkv5S1EAcSEHdbgHQVDsQUT/Ei7aDabv4lcnV/1CUHJIl
         CbSGFxkKVgXnqltp5pM4Ld1WfhRNwHyDq0FVChR4oMeLklKEqtCf9rFv4ko3NNv+vF9E
         Pz5Ggg0J0GrzUmaZhWcITVVjxszp2JyiHvsNw5NXivNPNOAYYRu6FSxvytF3c/1enH02
         akpVa+IoaPLG3KOtR63Vr9o0+hXnsRUh1/os5CusE6GXQrYUbv6SlnJIOEPh62PINNho
         yuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Shg77HnyMQRXbMxMOH7fDju/B6P367xm3FEJBtf2/5I=;
        b=bleMMShbgtvPHrqnChmxlnJ+zG3yDrybCqvMOStmHq+gmyLdxDf3dbHz8VHXgWoFUZ
         hDtdicrW6qdppkgnfw17u/OXEhyygtjbb7Ywkr/LmpEUqb3aNrzjrUV2yS5bbYI3XiSc
         zd+Z2ZyPIvGmWnRNPtpV4DUste8djri9v4J8wxbLlpoRegd2wMynSuhPjmK8v9DW4lE6
         djk6vQEfNgmVo7gtKMyvvoEEdw8R7bB0dKReilPUPRXuQZp4aYbYS+VwyHFEUnzv/hOj
         ibHUzisQXwkF/64iSftZLFnslffQCq61dAV7trtFr6/TobbskynEnDd+Q/ki7u//dBHr
         jTsA==
X-Gm-Message-State: AOAM530/voVDP3LfGwJGrkoQ2e1FdTeoYECKBSBpQHkMyXGPKeMBu7sg
        W6Zz8F1tk4qiy6WpuBG+0FKX5+uM6dLA
X-Google-Smtp-Source: ABdhPJyzxSOaiZXqgR7A3Pvq5x7fwHa5M9fdlhhr43aSTMgZOyRTaxT0Q4mwINIAHOZXvFKNHwLA8w==
X-Received: by 2002:ac8:578f:0:b0:2f9:317a:bd25 with SMTP id v15-20020ac8578f000000b002f9317abd25mr12802150qta.456.1654371069357;
        Sat, 04 Jun 2022 12:31:09 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:08 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 13/33] test_printf: Drop requirement that sprintf not write past nul
Date:   Sat,  4 Jun 2022 15:30:22 -0400
Message-Id: <20220604193042.1674951-14-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current test code checks that sprintf never writes past the
terminating nul. This is a rather strange requirement, completely
separate from writing past the end of the buffer, which of course we
can't do: writing anywhere to the buffer passed to snprintf, within size
of course, should be perfectly fine.

Since this check has no documentation as to where it comes from or what
depends on it, and it's getting in the way of further refactoring
(printf_spec handling is right now scattered massively throughout the
code, and we'd like to consolidate it) - delete it.

Also, many current pretty-printers building up their output on the
stack, and then copy it to the actual output buffer - by eliminating
this requirement we can kill those extra buffers.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/test_printf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index ff833870f5..a702dd5dc0 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -78,12 +78,6 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
-			bufsize, fmt);
-		return 1;
-	}
-
 	if (memcmp(test_buffer, expect, written)) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
 			bufsize, fmt, test_buffer, written, expect);
-- 
2.36.0

