Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300EA52F4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353633AbiETVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353618AbiETVQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180AA186FC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x143so8709296pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWTSuBzkkT6cGFJIErCii42a5cTy6mj6tu0MEYBpYuw=;
        b=iGY0yXmtNOFzXqS3vyE8ZWNBhizNBWAbJa2rbH/Vkpzz7T3dDYF9Ol/pbh9S0aT/QO
         XAqSSTx79FNGM4luPdcTV/Iog4IgdOeHuLsBRaztYmtCMFvj43q1Ue3PA3TBcvLNo5/b
         vrpVPdbVgaIWH2tZoEFXRgwC8mh2vx6y6OO60N5j6CIvFX1tPqUnOEKRfunPOQr3b0qx
         FYZjBYPOpKz0LwrsaPFfj7T6567Q+Uik2rhKsrGy8XHJ9+2YtpcJW74Hzu54nURexFHm
         Bw55LeG5STs7fGwFdmdV3yvrAj0nfoJXzQgEZ/nVABaILAVfFB7HsmDEHYaYhfUATFlZ
         oyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWTSuBzkkT6cGFJIErCii42a5cTy6mj6tu0MEYBpYuw=;
        b=ZFOYBj7dNFeE/tETuNZ33SLQjztWoNrQbiRgaTzqBrqDxPn9uiCXkBieKYgNCoScWV
         fcnZRcXq2t9mMKK7FrcFS2l+XZzc2unQ5vGvQaBMjij//0XTZjCrJEfbgPLlvWZy4H05
         tguX0W8q3jzc/545OQXVbVmM6z89vR0xJ1dtqS+IG6FQKo4Rpv+JhTAcNN9wOB8TsHXc
         iQ0Lng2SSduDBWpcDgqlZkrMi50dJjDr0OkUSKh6I1phI0RK38VOQw8JlWC2S//louym
         mq5uN4NroUyu75BknRAjRrTipU2NTN1cIVnQRCX/TuIHAIkQtHDJ8wN/6kAxSaTl0cZK
         uexg==
X-Gm-Message-State: AOAM532Of6l1LbE6zfvJuITQRrRn5bq6lrz3kMlgd9KcERheVJWZK+tx
        9hW8GqaAP4dh3LOkritVnkQ=
X-Google-Smtp-Source: ABdhPJzR7VPOsIaHO4OZTJQpRymr7nffns8nLDPr1XGwHxgbnuzrVAXgs8g9ePKP8oLouCW6W3jqvA==
X-Received: by 2002:a05:6a00:1c76:b0:510:8b76:93b5 with SMTP id s54-20020a056a001c7600b005108b7693b5mr12027301pfw.44.1653081376489;
        Fri, 20 May 2022 14:16:16 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:15 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mm: khugepaged: remove the redundant anon vma check
Date:   Fri, 20 May 2022 14:16:01 -0700
Message-Id: <20220520211605.51473-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220520211605.51473-1-shy828301@gmail.com>
References: <20220520211605.51473-1-shy828301@gmail.com>
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

The hugepage_vma_check() already checked it, so remove the redundant
check.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5bdb30a76f05..4fe1dd3d8ef4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -966,9 +966,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
-	/* Anon VMA expected */
-	if (!vma->anon_vma || !vma_is_anonymous(vma))
-		return SCAN_VMA_CHECK;
 	return 0;
 }
 
-- 
2.26.3

