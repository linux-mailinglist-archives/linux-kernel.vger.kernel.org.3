Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882F505CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiDRQyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbiDRQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF93A326E6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zvi0HZ5G+8+6iQXet7yWC1URq0baxNRF0cauqcyCwY0=;
        b=JodsQ2lsNZtKwyK5zhR50knRcOFFceANsrfs9cgeoBw5gzmJmNe11+J8RsXhBgTtUeY4EF
        SIusWnN8F2tqFvyQFGO+Os1u40Z8GFrXdAVO+U1XvkImDi7Hp0mJauX3B5EUPGY31HE18+
        fuJGnwF0cgJC2i7Evyro+ydB4E0sIyM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-TJbgYh_jMfGULual1HzXOA-1; Mon, 18 Apr 2022 12:51:26 -0400
X-MC-Unique: TJbgYh_jMfGULual1HzXOA-1
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso12548251qvb.15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvi0HZ5G+8+6iQXet7yWC1URq0baxNRF0cauqcyCwY0=;
        b=5bPqyw8fEptI6iNR2tnIewJD8Mck8lMesKpfeDmdVd5T6IZJ9IHxizHw2vaG7+KOd/
         uZ7cZ9B2u8Qcv4wxMLmQhqdQK44QKnEG0cMTjmSdi1SwCsleLeA2Fq4d5QprO7rDRGLS
         UVR7eccdI7bCWhbkRn8mF/3wdqjWyWYV8aZ10dcEUraRO9J/aDkBM/1zeXgdjX9HKiul
         TaJfS3KrL2DaNmHB1F42G81j9+Tr1mm05gwvCYtwcUG06FIliMDb29NxyscJCWhNqPie
         kKxtGd+hAqaPdMGKcJrWHL0ANPijdmWcf26iLoyF78cbncIsQrNmuqBrje9ldqyQ2Ymm
         6OHw==
X-Gm-Message-State: AOAM533SDSArNlcxN7GdjNpviY7y01LlTeLtKm8/2STYneefx7WTXK0s
        vLoaaiLFZa8+ohsGPx0IL3KQ8ysST4lWZFzXZFLqL1s4r9j87Rn7qhge8ipj4mmzX7OScvEiS3X
        iv+foudYKpgDOV9zEa/tTDZxy
X-Received: by 2002:a05:6214:23ce:b0:443:8505:14bb with SMTP id hr14-20020a05621423ce00b00443850514bbmr8499309qvb.25.1650300686343;
        Mon, 18 Apr 2022 09:51:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZWK9bjOKc9EubcgN4tKUXNN85UhS/aJi2MibvLsXgUNe9zHfgn4PHpOdR3a4YDndtamD6Gw==
X-Received: by 2002:a05:6214:23ce:b0:443:8505:14bb with SMTP id hr14-20020a05621423ce00b00443850514bbmr8499295qvb.25.1650300686112;
        Mon, 18 Apr 2022 09:51:26 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:25 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 22/25] objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
Date:   Mon, 18 Apr 2022 09:50:41 -0700
Message-Id: <173f07e2d6d1afc0874aed975a61783207c6a531.1650300597.git.jpoimboe@redhat.com>
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

CONFIG_VMLINUX_VALIDATION is just the validation of the "noinstr" rules.
That name is a misnomer, because now objtool actually does vmlinux
validation for other reasons.

Rename CONFIG_VMLINUX_VALIDATION to CONFIG_NOINSTR_VALIDATION.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/instrumentation.h | 6 +++---
 lib/Kconfig.debug               | 2 +-
 scripts/link-vmlinux.sh         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 9111a3704072..bc7babe91b2e 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_INSTRUMENTATION_H
 #define __LINUX_INSTRUMENTATION_H
 
-#ifdef CONFIG_VMLINUX_VALIDATION
+#ifdef CONFIG_NOINSTR_VALIDATION
 
 #include <linux/stringify.h>
 
@@ -53,9 +53,9 @@
 		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
-#else /* !CONFIG_VMLINUX_VALIDATION */
+#else /* !CONFIG_NOINSTR_VALIDATION */
 # define instrumentation_begin()	do { } while(0)
 # define instrumentation_end()		do { } while(0)
-#endif /* CONFIG_VMLINUX_VALIDATION */
+#endif /* CONFIG_NOINSTR_VALIDATION */
 
 #endif /* __LINUX_INSTRUMENTATION_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7d2bbc3e558e..73359d6cd9a2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -500,7 +500,7 @@ config STACK_VALIDATION
 	  For more information, see
 	  tools/objtool/Documentation/stack-validation.txt.
 
-config VMLINUX_VALIDATION
+config NOINSTR_VALIDATION
 	bool
 	depends on HAVE_OBJTOOL && DEBUG_ENTRY
 	select OBJTOOL
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 90c9c4c05d95..fce4f41816cd 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -160,7 +160,7 @@ objtool_link()
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
-	if is_enabled CONFIG_VMLINUX_VALIDATION; then
+	if is_enabled CONFIG_NOINSTR_VALIDATION; then
 		objtoolopt="${objtoolopt} --noinstr"
 	fi
 
-- 
2.34.1

