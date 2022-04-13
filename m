Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECD4FFEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiDMTQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiDMTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CA21716FB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649877114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+QSw/ufRyN6/+ezAwZBDPPhNm6Hg19SNJxAw6AI4ros=;
        b=M+Ffl5HFoghVF5FzDcLb8Yf8Cb0etXfaJNNJFEtQvwY9xBDagzlmgxxpFf1rTu644FQ8h4
        wfPL2KeCAiHh+5oCoPyQ9shvDmbiOPzL2AUlRTpFYWFReC4fTBrBqfWhafKNo4Xl6MZpRP
        1RRZZpUCaAsP8SImg1/g9yvwe9jE+XY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-BQAu471YOCSmXUKscg7Z3w-1; Wed, 13 Apr 2022 15:11:50 -0400
X-MC-Unique: BQAu471YOCSmXUKscg7Z3w-1
Received: by mail-il1-f198.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so1733723ilg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QSw/ufRyN6/+ezAwZBDPPhNm6Hg19SNJxAw6AI4ros=;
        b=mVg01O3jsOeOeuLB6bhQ9yZEx3BCwvA7axU6FIPYrMLM47/T01GyFPDXe4B6Zc/nPB
         VOZCgDMMZ8YaVs0WkHOOg0Fr4/c52ckwOueEr3JKWMbJ4zgFwUOF1htKBZEBHadeFSLY
         XCrvI8ptvr90zuRox9Jj5VN3e4IYvc2aZn+ZtmONcCHIDHV9DFbnCpVb3UGZ8SsLjI2F
         nMsYz9O5DovHKuEbWCtrWqAOHgHDY4cIki4an5aWWy4+69U/wOdADN3ndCmrGcT585jX
         O7xhO7a8MfTEeoVIaOp7DKTHVaS/K4T2yI2y0MYnJRu/vS2l9bUcM2BLVyyDoX9VPmTX
         GYuA==
X-Gm-Message-State: AOAM533Wlk4l0yzcKkpbGwrkRTZYbAPbn3vVjQ53ebIJOnUKSvFkT3BK
        UBUip+aqkMyfYHwfXvw4bP1mmWRLcw7QjnwIxcyFAG0EcL8p7n5OIzPUmca7Bq46s4f1qvR6Igl
        Ehr2R4LaByGSjVCJkiuIsDNRP
X-Received: by 2002:a05:6638:481a:b0:326:6a2c:2396 with SMTP id cp26-20020a056638481a00b003266a2c2396mr1911995jab.122.1649877110286;
        Wed, 13 Apr 2022 12:11:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwihmTKTsBKEM8uRlTQTE9G8Q2zcvgmyT1yNLtqG/qXCjQd4VTDWCSV13OhoOS2+SRctMU8/Q==
X-Received: by 2002:a05:6638:481a:b0:326:6a2c:2396 with SMTP id cp26-20020a056638481a00b003266a2c2396mr1911987jab.122.1649877109997;
        Wed, 13 Apr 2022 12:11:49 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id z72-20020a6bc94b000000b006463c801381sm439896iof.48.2022.04.13.12.11.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Apr 2022 12:11:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm: Remove stub for non_swap_entry()
Date:   Wed, 13 Apr 2022 15:11:47 -0400
Message-Id: <20220413191147.66645-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

The stub for non_swap_entry() may not help much, because MAX_SWAPFILES has
already contained all the information to decide whether a swap entry is
real swap entry of pesudo ones (migrations, ...).

There can be some performance influences on non_swap_entry() with below
conditions all met:

  !CONFIG_MIGRATION && !CONFIG_MEMORY_FAILURE && !CONFIG_DEVICE_PRIVATE

But that's definitely not the major config most machines will use, at the
meantime it's already in a slow path of swap entry (being parsed from a
swap pte), so IMHO it shouldn't be a major issue.  Also according to the
analysis from Alistair, somehow the stub didn't do the job right [1].

To make the code cleaner, let's drop the stub.

[1] https://lore.kernel.org/lkml/8735ihbw6g.fsf@nvdebian.thelocal/

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Note: the uffd-wp shmem & hugetlbfs series will need this patch to make
sure swap entries work as expected with below config as spotted by
Alistair:

  !CONFIG_MIGRATION &&
  !CONFIG_MEMORY_FAILURE &&
  !CONFIG_DEVICE_PRIVATE &&
  CONFIG_PTE_MARKER

(PS: this config should mostly never gonna happen, though, afaict..)

Quoting the same thread [1] as above.

Please review, thanks.
---
 include/linux/swapops.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index fffbba0036f6..a291f210e7f8 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -493,18 +493,10 @@ static inline void num_poisoned_pages_inc(void)
 }
 #endif
 
-#if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
-    defined(CONFIG_DEVICE_PRIVATE)
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;
 }
-#else
-static inline int non_swap_entry(swp_entry_t entry)
-{
-	return 0;
-}
-#endif
 
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
-- 
2.32.0

