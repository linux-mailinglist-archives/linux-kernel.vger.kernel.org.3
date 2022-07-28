Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DBD584380
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiG1Ps4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiG1Psx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:48:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D868DC6;
        Thu, 28 Jul 2022 08:48:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id oy13so3879992ejb.1;
        Thu, 28 Jul 2022 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fS/nZXfCzoIrkQnCoo3AKoB3vg26TXpmf/4Iq1CbbwA=;
        b=qm2EcCBR991c2JvJChOIEBo0CCTasClYUTAC7rsN7XM/brmFbkyXwOAp/UZgfFEkb9
         kmRFp7OVyj+i3jUgqmczpBDoy9vPFhekvgo5LDnpBWFHevl++AWAobHHoH6aj8K/iVv+
         ZIshjVVuZspA7sw8fStOeJCBP3yxVZtotoVbQQEaE78ZG/VfAiE82qwmPRphV3Kn9oO6
         5X4ELVI2EZM3LpzY9sxchscM4X+I0AnU3unGsk1B/XXuWl6Z8WrrzMooh1v58g+GByK6
         jclZDzsvinObSQjkf9juoUQbxeAPW93crtzenM1PSBbH8Im0fT4CxcNrPb6ktolikz46
         u2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fS/nZXfCzoIrkQnCoo3AKoB3vg26TXpmf/4Iq1CbbwA=;
        b=Gd/0hGVr7uBNHRCstuSMskoJLfxW5kzs/Yk9XE9SE7lkgQtH4XvdcXnVEeyy3ENKbn
         SMP+tZzGeusHy3Jq9R3P4enR3q/it4Yy0c0TdRdgET31g/agJE0QBnMzIc5E/a3Ic2uA
         ZdeLvyJ2a4RMoNDTrie9MT4OW7Gb/vYyr6uAwBPeWYILJkyXXgqGc8w2FvdW1Ittrqod
         hZZSgtYcnK0mUDpSLSrw3a3kHZRZwbFOtRXPpmb3oH+xJZunWKpSHeGyF7Jn5iOwoGSg
         hj4zKPsHXOoeUSix0Vx0xM5y1cCuuybqwRiOkX3JXZ1D5ZpYKojA18JlUmJnYyOoJybe
         dVMA==
X-Gm-Message-State: AJIora/zkS9XarAOwbEzrrI504MlLopVEqEmlPuRXvs+a52QwfIbMsvu
        QHriWrSPJg1trLeY2swYpQU=
X-Google-Smtp-Source: AGRyM1scjNpjULkYvj++SP7LnLCjwsybIrA/ytTOCPe33lIKTJlhZ0FoG/cXzLKpwDDflEHTKsNAdw==
X-Received: by 2002:a17:906:84e8:b0:72e:2f3c:6784 with SMTP id zp8-20020a17090684e800b0072e2f3c6784mr21733685ejb.390.1659023331426;
        Thu, 28 Jul 2022 08:48:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:48:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 1/7] highmem: Remove unneeded spaces in kmap_local_page() kdocs
Date:   Thu, 28 Jul 2022 17:48:38 +0200
Message-Id: <20220728154844.10874-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728154844.10874-1-fmdefrancesco@gmail.com>
References: <20220728154844.10874-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kdocs of kmap_local_page(), the description of @page starts after
several unnecessary spaces.

Therefore, remove those spaces.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 158a3a2907dc..accd286a6af5 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -60,7 +60,7 @@ static inline void kmap_flush_unused(void);
 
 /**
  * kmap_local_page - Map a page for temporary usage
- * @page:	Pointer to the page to be mapped
+ * @page: Pointer to the page to be mapped
  *
  * Returns: The virtual address of the mapping
  *
-- 
2.37.1

