Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9059665E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiHQAg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiHQAgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD258D3ED
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660696582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTwL0O3UlpIIc32A0xilckqyKglNDPBffWl5+tmKDhQ=;
        b=C0p03NakmFceQ6cSVLRUBMTu7w9lmT2cZSP6FjNFZIpl/LG363I8yChl7OR/0x9HJww74l
        T3pFrCMp8NwyV83BNMiInVcAf8yvfkeUr+b0w2UBSVkCFckzQoEzwz/MkKq85L1E2ACpcD
        oKeQixM2jNvqxnyUthZUXxbfY4eOVe8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-CBPFjjdfN-Kx71pxerRdew-1; Tue, 16 Aug 2022 20:36:21 -0400
X-MC-Unique: CBPFjjdfN-Kx71pxerRdew-1
Received: by mail-qt1-f198.google.com with SMTP id b10-20020a05622a020a00b003437e336ca7so8844087qtx.16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BTwL0O3UlpIIc32A0xilckqyKglNDPBffWl5+tmKDhQ=;
        b=4Ww1iB9hKA75/peXPooyrcV1aWtk18kHYii69EnUEcSIfkjA+WWcxTZmMATYgEv/Ge
         nAsXKuWDupyJa/R3RyH14zi6TVMPmuUjW7x+DuUM4zymD5iwsHXcOGMCdjR4KTnjc9kZ
         mLPblvydQLdhqW97CDDbxwYz6w6QDrcShk7NsYJZ/i7ABY30wOR5z81n94HUMJ1fizXj
         V4xX65YjRdvcKMkaXjUtpEp+9te1+wVTHjU8GeoZgp1MKqoVyXr5h+5LN7q/ph9fezxE
         THjwRWP0MBHukyB5rPESfZQevcXm1v1fP76i3fw1SfmlizHVT21f6ua7MNVZ1E29xlE6
         +5TQ==
X-Gm-Message-State: ACgBeo2Jdy93QdV9T0VTpPHdLSpOpeNN6tmcbC6inr8HgNVR19BeTGcr
        9iydeQQ/H4kXsEXFlzgjH1dEJlqQHLhOFiBqcqvbi7Ry0bFX711R8Xf2iU026LSDFcoezo+gbS/
        LQxk6Toa3zfc0BNlFDHphBkEGm4OaNCtGxU+X8bRQ12QeAeoG1uuFM/DUdRWu8tafIfvyd5BYeQ
        ==
X-Received: by 2002:ad4:4ead:0:b0:474:7bba:9865 with SMTP id ed13-20020ad44ead000000b004747bba9865mr20428368qvb.58.1660696580503;
        Tue, 16 Aug 2022 17:36:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4UUHOe8O6QFGIYvp/9K2vK0n6Fp6ajMCcyZcBb9hv+otrDbdfVJjGZcpSZ0cwahduBZbENsw==
X-Received: by 2002:ad4:4ead:0:b0:474:7bba:9865 with SMTP id ed13-20020ad44ead000000b004747bba9865mr20428347qvb.58.1660696580285;
        Tue, 16 Aug 2022 17:36:20 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id c13-20020ac87dcd000000b0034358bfc3c8sm12007175qte.67.2022.08.16.17.36.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Aug 2022 17:36:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 3/3] kvm/x86: Allow to respond to generic signals during slow page faults
Date:   Tue, 16 Aug 2022 20:36:14 -0400
Message-Id: <20220817003614.58900-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817003614.58900-1-peterx@redhat.com>
References: <20220817003614.58900-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable x86 slow page faults to be able to respond to non-fatal signals.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 23dc46da2f18..4a7d387a762a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4177,7 +4177,12 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 	}
 
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, NULL,
+	/*
+	 * Allow gup to bail on pending non-fatal signals when it's also allowed
+	 * to wait for IO.  Note, gup always bails if it is unable to quickly
+	 * get a page and a fatal signal, i.e. SIGKILL, is pending.
+	 */
+	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, true, NULL,
 					  fault->write, &fault->map_writable,
 					  &fault->hva);
 	return RET_PF_CONTINUE;
-- 
2.32.0

