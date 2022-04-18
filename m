Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA56505CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbiDRQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346501AbiDRQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CF2232EF3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxjNN+ra2AhCANWxkWyISdn+Fo3V4/vBPneJRjlR5i0=;
        b=Z1SEElzmm4oAEMzx3yEP4Hz4TnfbiJYezc59JGFm19pcKIz1AYeXbvKehNk2yazaLdwZgJ
        2mP/tIdqgb2HP/yoCl+FgCBhnxKGKZxPBEInArxdKT0ptPvlQOxhygyqegiEMK7AAnNVdi
        mfSiz/uV0FSZXCx7jT5lPhqfSPjX3dE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-Bx8aq9S-OfeV2QedTR9epQ-1; Mon, 18 Apr 2022 12:51:28 -0400
X-MC-Unique: Bx8aq9S-OfeV2QedTR9epQ-1
Received: by mail-qt1-f197.google.com with SMTP id m3-20020ac86883000000b002ed8d29a300so8827198qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxjNN+ra2AhCANWxkWyISdn+Fo3V4/vBPneJRjlR5i0=;
        b=F/JHv7XN6YpGGQwhTnimKIt9CjC+QNObNzB289zi0lXTFLzX8KqPf72528QZmmpwoD
         jggDHjFk3OSVDAQyr4KH8nBo2EBpB3q2lIsrINvEjbIFccDfHjjX8vIXtYTxqyTklNwg
         9bHzTH+7e9/5glIGVzJy5uitmISQubPxunYppsBydX68C5xG5yDJCLEkH22bkiaKgkUL
         KKqQI1T+a1X4LkX19B1OxaTuVS8oCEgp0bNeKAzvZyrbItM+XhVZKn72EHntMfRoZffE
         zghct8cUihCPd7k8O+Xp5euoK5SOaUoS0ATSY0p3Chs4L4Ridbaivr60r8ZXxBgS4bOJ
         g0Jg==
X-Gm-Message-State: AOAM5307Kursr76GEIbc1JAyzC4ZzYLkQ7AspDp0x8NK0JqFM2UcdZ3V
        t3Sxg7LEAkGoWbMCYvx/Kny3WTOxJFer7FQ49a4UKeoqAdTDJfS64r7fb0q3qX41XmKOaBHkbDr
        yUj+a5f8zRQ4rZIuGM3Uh9mrI
X-Received: by 2002:ac8:7441:0:b0:2f1:d1d4:e4cc with SMTP id h1-20020ac87441000000b002f1d1d4e4ccmr7783520qtr.14.1650300687962;
        Mon, 18 Apr 2022 09:51:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbMfrsVNOVFQpjjNwLQZ4lN8sU2K+zEnFfnoqBjmhgiVmeevwMGEvg1zKOZ7NvA4Ais+ckJg==
X-Received: by 2002:ac8:7441:0:b0:2f1:d1d4:e4cc with SMTP id h1-20020ac87441000000b002f1d1d4e4ccmr7783510qtr.14.1650300687764;
        Mon, 18 Apr 2022 09:51:27 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:27 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 23/25] objtool: Add HAVE_NOINSTR_VALIDATION
Date:   Mon, 18 Apr 2022 09:50:42 -0700
Message-Id: <488e94f69db4df154499bc098573d90e5db1c826.1650300597.git.jpoimboe@redhat.com>
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

Remove CONFIG_NOINSTR_VALIDATION's dependency on HAVE_OBJTOOL, since
other arches might want to implement objtool without it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig      | 3 +++
 arch/x86/Kconfig  | 1 +
 lib/Kconfig.debug | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6ba6e34db0ea..1e19da774e55 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1038,6 +1038,9 @@ config HAVE_JUMP_LABEL_HACK
 config HAVE_NOINSTR_HACK
 	bool
 
+config HAVE_NOINSTR_VALIDATION
+	bool
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cc7cca041745..c8f560802bf2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -233,6 +233,7 @@ config X86
 	select HAVE_MOVE_PUD
 	select HAVE_NOINSTR_HACK		if HAVE_OBJTOOL
 	select HAVE_NMI
+	select HAVE_NOINSTR_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_OBJTOOL			if X86_64
 	select HAVE_OPTPROBES
 	select HAVE_PCSPKR_PLATFORM
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 73359d6cd9a2..55b9acb2f524 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -502,7 +502,7 @@ config STACK_VALIDATION
 
 config NOINSTR_VALIDATION
 	bool
-	depends on HAVE_OBJTOOL && DEBUG_ENTRY
+	depends on HAVE_NOINSTR_VALIDATION && DEBUG_ENTRY
 	select OBJTOOL
 	default y
 
-- 
2.34.1

