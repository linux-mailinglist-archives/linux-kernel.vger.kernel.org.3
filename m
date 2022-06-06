Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8453F1D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiFFVoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiFFVo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF88148A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso13722272pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWErXY/21cRT+JuPcizRjGDN5I2BQSMNvqCbtDuuEgI=;
        b=I5APtot2v61wKkN0XCT4995ZIiul394ZNakXAWx3CnTxQvkSfrURRzUJ0YUHHBDmoN
         n7WES+tRmlehNiQ+3ho3huUDvxWLUQKDPTnFK3bHGNIBaYMyTK43rUlQCWrS8jBRXYqw
         asEC1jsCThymiE5h5B8duobPkjqKD79mgUEVqb3+uLy+sG21Xr8hCgblpLAIDX9GBdY+
         YnoLjc3K3sv/qGe2DmVNbu56MCjX9ZwGKXZc3UA8b6ez1d+JTPISyuuAZIt5r+pAMldH
         A3XSVAeQxTWsGtKRdSh1OHuMOvFPqiIUvWqLjyZT3XWfA2X2Q+VmkOMkXtoUx/+j9lcl
         C7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWErXY/21cRT+JuPcizRjGDN5I2BQSMNvqCbtDuuEgI=;
        b=f0SRtls/4NDolOUetszSG76QhkOTf4a85+kxMFUGjffxoXL/mzpbWvo70dQYBOoP8r
         DqFju8Yh6oOJhpn4xYbrvc24S1DPNL00VvbU3unLFLWXvN+qTFWfvVCukG9sYelyAsvH
         cMGVEsl74uJWA8U6XKmxPXjNdVxZWEy5ZEqJh0VY1f0DviesggN3ooCdqeN/2Euuy7VP
         yG6cGd9Pj+AcRbRkhTzFf8oOGH2iPKWafUl1aCWKoKjfsVhWNwqFIzEPsvuPPEGUdf6i
         WcFpUBGzg6gi6t6VNo+RppoeCqPwKpV64CDhKaEfrW8cMse9aHbItDc7lyenAfPGNmR6
         Dg7g==
X-Gm-Message-State: AOAM533ExJ3P73a3WV+DCiTjSfBqHXuzg3MAcnB0or6DNyiHFHhSQtbU
        c4oWHdtvAuxslgaEJJyIvC4=
X-Google-Smtp-Source: ABdhPJxxmkvlq3kb5ZvctnDvImOgaVYAMOt1gHJ3eNFjJyFulmHv+ybHJWXnTeDs5PmIyxjHCkv45Q==
X-Received: by 2002:a17:902:b282:b0:163:ffe6:2cf9 with SMTP id u2-20020a170902b28200b00163ffe62cf9mr26504023plr.76.1654551860779;
        Mon, 06 Jun 2022 14:44:20 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:20 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/7] mm: khugepaged: check THP flag in hugepage_vma_check()
Date:   Mon,  6 Jun 2022 14:44:08 -0700
Message-Id: <20220606214414.736109-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220606214414.736109-1-shy828301@gmail.com>
References: <20220606214414.736109-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the THP flag check in hugepage_vma_check() will fallthrough if
the flag is NEVER and VM_HUGEPAGE is set.  This is not a problem for now
since all the callers have the flag checked before or can't be invoked if
the flag is NEVER.

However, the following patch will call hugepage_vma_check() in more
places, for example, page fault, so this flag must be checked in
hugepge_vma_check().

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 671ac7800e53..84b9cf4b9be9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -458,6 +458,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
+	if (!khugepaged_enabled())
+		return false;
+
 	/* THP settings require madvise. */
 	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
 		return false;
-- 
2.26.3

