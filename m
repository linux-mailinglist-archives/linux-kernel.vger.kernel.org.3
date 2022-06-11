Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8AC547792
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiFKUtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiFKUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62EF5275D1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654980545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPW8MJZeU1cQQOGf+k4czGCcsVXXmPCDagh2Sq6V6IM=;
        b=FJPUZvy3Aor0WR0LFrB/t9Nf6ObSBd9RN4QFHgyKhonyJEXwYm6P0ofiISHHVs424lL809
        s/LZoG7vL+SdjJZUDel0ni9qRqWSQgVceW9QxiZy4BLJAHVWjt7++yZv7T/NPuVEYjNOqf
        E3730JpJFGTJwV/eQXL85kFLnrJ4DCQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-QYucmGZSMWiuAJgW-3hi_Q-1; Sat, 11 Jun 2022 16:49:04 -0400
X-MC-Unique: QYucmGZSMWiuAJgW-3hi_Q-1
Received: by mail-wm1-f69.google.com with SMTP id r8-20020a1c4408000000b0039c832fbd02so88484wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RPW8MJZeU1cQQOGf+k4czGCcsVXXmPCDagh2Sq6V6IM=;
        b=eL2KYKeo54LTV5LZzORy11V/kgfOpn+24Gd2zBHJSlGR8EtkTCEikJzvskduRd6F3L
         pGiLkJ+crFywqhP9fWMeSb8i+AE511w3bV7cpYSWn2vHBdo7A1lnr3S3uwohpQwQt+vI
         0C+eX/Q77kDCEiyOCF3QoW+VL4GGkCMg9nJhxQm3XAvJUSLmq6ec35dnAMCYi18OoaGC
         Vg4i3UuATIrAtf8pSkVSlPkFy966w1KGSVtvuBEf3cd1A8Jykol/CFahMYPE5pVovRTl
         MBPWl5yuL9QEGJSP3tcGqdnUBsWDD3n14UJkeKhUVB+EX+e/ghtvUZcZ67I/PrGChUPo
         UYNw==
X-Gm-Message-State: AOAM532KDhgoV975tw9dhBCZrXj3ZUxgqX7OMpmwS4fIYrzIEZEDNExy
        6XkmyK934U3RpNxVYWmFkhRC7WLGgbqZ0rr8pOXwRv8Mjznm5XOcyds1Jdtvo9dk8lfUrZ8T8g0
        yAHKYfg0LjSaWLmnN05Hs6dQ=
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr6365031wmh.154.1654980543005;
        Sat, 11 Jun 2022 13:49:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0/vf4dqScx5mIF462WlkjbnsS1YIOrSwAvq/DIjRGKMRoNpUKnWJeKabDZIF1OiI5YyM06w==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr6365019wmh.154.1654980542848;
        Sat, 11 Jun 2022 13:49:02 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id w17-20020a1cf611000000b0039c5a765388sm3518789wmc.28.2022.06.11.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 13:49:01 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        atomlin@atomlin.com
Subject: [RFC PATCH 2/3] x86/boot/e820: Make e820_type_to_string() external
Date:   Sat, 11 Jun 2022 21:48:58 +0100
Message-Id: <20220611204859.234975-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611204859.234975-1-atomlin@redhat.com>
References: <20220611204859.234975-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch allows e820_type_to_string() to be available for
external use, in preparation to enhance the error message
generated by arch_rmrr_sanity_check().

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/x86/include/asm/e820/api.h | 1 +
 arch/x86/kernel/e820.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index bf78daa08897..ceb301e591de 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -43,6 +43,7 @@ extern void e820__reallocate_tables(void);
 extern void e820__register_nosave_regions(unsigned long limit_pfn);
 
 extern int  e820__get_entry_type(u64 start, u64 end);
+const char *e820_type_to_string(struct e820_entry *entry);
 
 /*
  * Returns true iff the specified range [start,end) is completely contained inside
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 09b1c863a766..95b994cf80cd 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1071,7 +1071,7 @@ void __init e820__finish_early_params(void)
 	}
 }
 
-static const char *__init e820_type_to_string(struct e820_entry *entry)
+const char *__init e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
-- 
2.34.1

