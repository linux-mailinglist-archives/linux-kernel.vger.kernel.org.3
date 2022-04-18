Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68C7505CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiDRQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346448AbiDRQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F764D7E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFMZBcKeNEtIudKn1NS45Ib5lceaaa4pYmyAHupkw94=;
        b=RyJOAic0E+rAH89oUoKIq32M11fo+hUY2rueyw6SlunpNA8bhB6+YSYDSR5Xi7A6j2hbX7
        8WsGcMiA5K6ap9LuboFEFQKrn1GGBC75wH8nbABw7iWKOz81qHTXfnUAXjgXX4eRxVLhWP
        hI2/m2ZuqAK9R5lwr+XjI0cqp5z894k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-GhEKWKr7MbuzRKe-cAa6-Q-1; Mon, 18 Apr 2022 12:50:57 -0400
X-MC-Unique: GhEKWKr7MbuzRKe-cAa6-Q-1
Received: by mail-qk1-f200.google.com with SMTP id i2-20020a05620a248200b0067b51fa1269so10726462qkn.19
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFMZBcKeNEtIudKn1NS45Ib5lceaaa4pYmyAHupkw94=;
        b=UEKxDIx1eSGIf3VOoLm+HRZjj5aLBH8YEnvoDU3RHlr6jOpe9B/fKLBicBnydKz2zy
         Fv+hVuQPrB2UNmi+nNNoJbjFlBLNg8KxPGpuH2ZW8vCEhKDiTL+PTICFHKf0CUN/FQ0f
         0pPOMqQnbq1tMuPAafEY2olvATbXx9MXcOP3xJoN/uaXorp1y5rz3qOGhfMj9heM5euc
         cHEIy8z9tvs63f6Z5rWjJJq2NHcqKgl3d8kw8YxZnOmxKSADN4WPMbsxUll2wl+vp4J9
         qJFKTpqZu4+LNQAIdSIBWtei5Y/pw87pt0wxJcZF+ZyTQJ//Zxs4HATPoltPFRoRbeUh
         /tdA==
X-Gm-Message-State: AOAM532n4psaGJkIky6E7txSnyqAdzNWwaVZMVSph4m+mpkFNLC0ffDV
        6YOwp6LsvPkLZIoDuZFaNh61Mt4x18f7qhAZkvmAzHNpstph4iqMTM5QSIdhX8UDxsDIssi9cnt
        eOTHMVs4LHtzni7RSZ3AecobC
X-Received: by 2002:a37:a8c2:0:b0:69e:a2cc:4c98 with SMTP id r185-20020a37a8c2000000b0069ea2cc4c98mr2839990qke.498.1650300656843;
        Mon, 18 Apr 2022 09:50:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl17qN6rHIZYjeLx+PeVfsalj8j7kBxkVuqNIqN0MLchaHBr3kU+kyEb43YUMUGijybavP6Q==
X-Received: by 2002:a37:a8c2:0:b0:69e:a2cc:4c98 with SMTP id r185-20020a37a8c2000000b0069ea2cc4c98mr2839978qke.498.1650300656632;
        Mon, 18 Apr 2022 09:50:56 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:50:56 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 03/25] x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
Date:   Mon, 18 Apr 2022 09:50:22 -0700
Message-Id: <1b5b54aad7d81241dabe5e0c9b40dea64b540b00.1650300597.git.jpoimboe@redhat.com>
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

The static call trampoline is never indirect-branched to, but is
referenced by the static call key.  Add ANNOTATE_NOENDBR.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/static_call.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 2455d721503e..2d8dacd02643 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -26,6 +26,7 @@
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
+	    ANNOTATE_NOENDBR						\
 	    insns "						\n"	\
 	    ".byte 0x53, 0x43, 0x54				\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
-- 
2.34.1

