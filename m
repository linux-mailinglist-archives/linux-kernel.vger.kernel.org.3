Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41943556DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiFVVhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiFVVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A476935DD2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655933830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghHac7UV1N6vPGfjk7ojRXZFbMUyEtSeJQo5S/wAoOg=;
        b=YRCpHorWcD1kefTMslBVEa8A/M7umsaxfZ5hCP746xr4zzujlNPUdvl1xdbwO8Zzy8f9x6
        i6mwrOuYAgsHnUCrQhy+VWbOYJnSFriO+vba/tR/zSnYCQTNSJAsQh59G562sRWnfANjCH
        /vwigs6EeOy3kx+XDLclBKFWkpJsnx0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-a6x3Oaf1PSWCcNRITVpL1Q-1; Wed, 22 Jun 2022 17:37:09 -0400
X-MC-Unique: a6x3Oaf1PSWCcNRITVpL1Q-1
Received: by mail-io1-f70.google.com with SMTP id n20-20020a6b7214000000b00669cae33d00so9835558ioc.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghHac7UV1N6vPGfjk7ojRXZFbMUyEtSeJQo5S/wAoOg=;
        b=KNqzNFDvpaiucvWICGOt/oPWoUeJWcUKXDC1N+1wVfLyTvRLPR9M/A0FuYps4xF3Bh
         YTQrMig/MpWVbY5iGWntRhq9RyRGub7kCXVtjfNYJ/qAuPG5ekLc1wCb9HVLcwHYWGef
         nLkkDewsLy1nMJWtz+cSb1bRcE5kQbgvO8PlHqjpd14H+ax2jiw241Iy4MHZgUrgGarr
         VeuyKsQWeF366Wv/nJZ7RAg80kQGJMhsjshHQiJ9fo9qSsw7JA2z6U4pmzivot1j+it5
         MF//8RiAY2w/N7U+4F8P9y2m2BADt1uIi0pqP7tw/9RsWIthcJc/T5VSlJdmNQCQ3XIi
         bXAA==
X-Gm-Message-State: AJIora92hjClm7TNH3jvUHTs8HEI6UJWoePmG+5cbZZqo3Bun4CJBysN
        Xmgd1PQrkbry786YtZ2qSqoDXXaagvMBmWq5CpEEPHfujCR0dQM96170At12JoPcP2xaNTgsZ4I
        DshugzciP1TC7w1Ooy7FNgXsb
X-Received: by 2002:a05:6638:3802:b0:32e:3d9a:9817 with SMTP id i2-20020a056638380200b0032e3d9a9817mr3381399jav.206.1655933828963;
        Wed, 22 Jun 2022 14:37:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sef3p8Uu7ssABriH3qblNDoH/AkpKRoJmrO09ZGEgP+PL9or7LCLMx+soJFip3k0p/jz0afA==
X-Received: by 2002:a05:6638:3802:b0:32e:3d9a:9817 with SMTP id i2-20020a056638380200b0032e3d9a9817mr3381390jav.206.1655933828779;
        Wed, 22 Jun 2022 14:37:08 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g7-20020a0566380c4700b00339d892cc89sm1510446jal.83.2022.06.22.14.37.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 14:37:07 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 3/4] kvm: Add new pfn error KVM_PFN_ERR_INTR
Date:   Wed, 22 Jun 2022 17:36:55 -0400
Message-Id: <20220622213656.81546-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622213656.81546-1-peterx@redhat.com>
References: <20220622213656.81546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one new PFN error type to show when we cannot finish fetching the PFN
due to interruptions.  For example, by receiving a generic signal.

This prepares KVM to be able to respond to SIGUSR1 (for QEMU that's the
SIGIPI) even during e.g. handling an userfaultfd page fault.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b646b6fcaec6..4f84a442f67f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -96,6 +96,7 @@
 #define KVM_PFN_ERR_FAULT	(KVM_PFN_ERR_MASK)
 #define KVM_PFN_ERR_HWPOISON	(KVM_PFN_ERR_MASK + 1)
 #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
+#define KVM_PFN_ERR_INTR	(KVM_PFN_ERR_MASK + 3)
 
 /*
  * error pfns indicate that the gfn is in slot but faild to
@@ -106,6 +107,16 @@ static inline bool is_error_pfn(kvm_pfn_t pfn)
 	return !!(pfn & KVM_PFN_ERR_MASK);
 }
 
+/*
+ * When KVM_PFN_ERR_INTR is returned, it means we're interrupted during
+ * fetching the PFN (e.g. a signal might have arrived), so we may want to
+ * retry at some later point and kick the userspace to handle the signal.
+ */
+static inline bool is_intr_pfn(kvm_pfn_t pfn)
+{
+	return pfn == KVM_PFN_ERR_INTR;
+}
+
 /*
  * error_noslot pfns indicate that the gfn can not be
  * translated to pfn - it is not in slot or failed to
-- 
2.32.0

