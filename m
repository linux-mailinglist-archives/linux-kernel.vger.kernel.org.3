Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5C505CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbiDRQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346468AbiDRQxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2F0FD7E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48jjM5HXT45OIsfY3WrkDs8DADHlQHjvA+yMQTd4lCs=;
        b=jAYY3hjwxvUIpTHgCcI4+FeXnUDlVDzOGjHB3HwExhb531TM8n66KVNTS68BHHBhRSfBOp
        EtnLd3ZG+/qUR1PyDvaxcftMG2HDx4nP3SGOUNkJB5kkhc8pvydDul051dvwyWs3bubxYz
        IVtjn3/6bqDIHy3YGxP6rUaJJ+v+2Q4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-s54vGoitOzq5IX4NAHlpWA-1; Mon, 18 Apr 2022 12:50:59 -0400
X-MC-Unique: s54vGoitOzq5IX4NAHlpWA-1
Received: by mail-qk1-f200.google.com with SMTP id j24-20020a37ef18000000b0069eafae30b1so1254132qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48jjM5HXT45OIsfY3WrkDs8DADHlQHjvA+yMQTd4lCs=;
        b=gNpZF7WMSU4dIMoKA3DDbymvl7zTsypYHLwD3JF98IZcBCUJONG96IUMLI5YVXW/BH
         fu6UUCgseOXQ4wAeYl87glpaP5C6FK5YlxYUMU6m8iguBOUmo/02S2ZF8ssIcHs5Gry/
         OJ3Wkkz41FfrekLuFG5v5YyOrZixiMfBRO7HrzuFHWhrvXKLX6tE4ZiCtxH8fMMAQ0W1
         /DTnE/l+U8qhBWWdEJ12vtURiHDT9APJ2guzVbzlmE64Ygpzj1DqJekHECsT9BB6uau2
         xk6ONH37kLlZLM+q8Lm5bH+iKvLCYGLtuPk2ZwPgNPwhj6RwKPHtCwy/qeFFDNfCVTDU
         FeBw==
X-Gm-Message-State: AOAM530k0QAiz7jvEcDc/Z8jKyIgSx9lB3SpabqNxKjaQUT7L3GkmhjL
        erfrfr57V4SbOmJECK8ndnom33mSSzxzFtJbKQhPkKy/arLiInF5RfdwfBjnpBZog/FfHjYvDqo
        bJB21pDHqrKf3WPj6/CtQqiLt
X-Received: by 2002:a05:6214:21c2:b0:446:529d:fbee with SMTP id d2-20020a05621421c200b00446529dfbeemr5513839qvh.106.1650300658360;
        Mon, 18 Apr 2022 09:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbBZRur0h9SOohoqwsVBNU0gRxrL7hGLYqFSHnRwOPSyIvfl1mNSPBxw8wUo87pNKAl5lhfw==
X-Received: by 2002:a05:6214:21c2:b0:446:529d:fbee with SMTP id d2-20020a05621421c200b00446529dfbeemr5513831qvh.106.1650300658137;
        Mon, 18 Apr 2022 09:50:58 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:50:57 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 04/25] x86/retpoline: Add ANNOTATE_ENDBR for retpolines
Date:   Mon, 18 Apr 2022 09:50:23 -0700
Message-Id: <b6ec963dfd9301b6b1d74ef7758fcb0b540d6c6c.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The retpolines are exported, so they're referenced by ksymtab sections.
But they're never indirect-branched to, so add ANNOTATE_ENDBR.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/lib/retpoline.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 5f87bab4fb8d..b2b2366885a2 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -31,6 +31,7 @@
 	.align RETPOLINE_THUNK_SIZE
 SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
@@ -55,7 +56,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
-	ANNOTATE_NOENDBR // apply_retpolines
 
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
-- 
2.34.1

