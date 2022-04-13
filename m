Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C1500290
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiDMXW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbiDMXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 280D02B27C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24h2UVDbRHHVLlC2Pwg8j1khR625cr4JBFHOIM2d6fU=;
        b=SVx6tXpXAviF25xAbjOlP01Cr1jab8gNbKx4a3U+c3PuaWn2AV86tEQDOHTmw0STopsX7h
        DodlmUQIDPPSuFLGLe2e/7ZqzriWwGW6ef7jXhwuynoN3R0jXNFHhae+oi4Z2jLjVgV3lr
        cKH3/lsprSRKzb2n2PVW94GYKtPnGco=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-CRRz5NAoNNmPhrbepL1uQg-1; Wed, 13 Apr 2022 19:20:05 -0400
X-MC-Unique: CRRz5NAoNNmPhrbepL1uQg-1
Received: by mail-qv1-f72.google.com with SMTP id dd5-20020ad45805000000b004461b16d4caso1742036qvb.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24h2UVDbRHHVLlC2Pwg8j1khR625cr4JBFHOIM2d6fU=;
        b=3aqBRxLtktGkDUlMBCcDDF+ElaMaCILqCBYWuzH72jxVRgDEVAo1YnxVuOi66iktsE
         /TWXdJ+G6FRjBTE0R6v03c2d6HKBY6X2fTAV+Q8Ein8xJQM/fcfGWbid/TMzkiWV2csU
         898AF9tTeEAMsvvDg9hq3zpSbYEtA2SfeyO0Z73tDA9jgaZ2FVltSAuw8KSRq92WsGfT
         LqJ/S1L1DNLpnMlFfVa/5FqMSai2cCMZdJqohT6AjavPkbA07mUe+igKMzqnZIZhSr7O
         RSQPeLHhWjUw/A6wmT40WCsrMjcZ4Tezl6zytjl/BfA1EuFg5XJ3yeUfdYvWhYNTgTzH
         PGGQ==
X-Gm-Message-State: AOAM532ZyMt8dRPWqNZcW4GNxXVo/fPvt9UseP+YXpzyfwXDhnvWXEfk
        Pxog7sdOBgMua0sLtIkRu93JJMyz64Gosa8GjAqED7wJ2Yda/5JxAckDIbY6D1lpFHObsKtgD/+
        4mbR8NseXiGF2yf11QOrLio1A
X-Received: by 2002:a05:620a:40ca:b0:69c:59d7:9d06 with SMTP id g10-20020a05620a40ca00b0069c59d79d06mr3516482qko.0.1649892005096;
        Wed, 13 Apr 2022 16:20:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2yYZiDbxv+G1x1q/PriByATvG+RzT0FBcaPyy0T6nN5oKkjW9Z07oFx7eymFaduJSzROiqA==
X-Received: by 2002:a05:620a:40ca:b0:69c:59d7:9d06 with SMTP id g10-20020a05620a40ca00b0069c59d79d06mr3516469qko.0.1649892004876;
        Wed, 13 Apr 2022 16:20:04 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:04 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 05/18] objtool: Use offstr() to print address of missing ENDBR
Date:   Wed, 13 Apr 2022 16:19:40 -0700
Message-Id: <28a9b87970329e70c59c575a240fb9390c2e24f9.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7a1a02dacb77..b27c2ce5d79e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3219,9 +3219,8 @@ validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
 static void warn_noendbr(const char *msg, struct section *sec, unsigned long offset,
 			 struct instruction *dest)
 {
-	WARN_FUNC("%srelocation to !ENDBR: %s+0x%lx", sec, offset, msg,
-		  dest->func ? dest->func->name : dest->sec->name,
-		  dest->func ? dest->offset - dest->func->offset : dest->offset);
+	WARN_FUNC("%srelocation to !ENDBR: %s", sec, offset, msg,
+		  offstr(dest->sec, dest->offset, false));
 }
 
 static void validate_ibt_dest(struct objtool_file *file, struct instruction *insn,
-- 
2.34.1

