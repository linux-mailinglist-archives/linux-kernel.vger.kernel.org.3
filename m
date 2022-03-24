Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADC74E61EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiCXKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349574AbiCXKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:47:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9123BF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:45:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id a5so3395780qvx.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8zhnrV08p17+f/+gNNScolaBaJcAcXfoOQXYyrrgDE=;
        b=Mm+O9C0xL0T+nNzNpEaD+PhIpQNXz5grexWao4VJhBqHPCGilN4AfkVRmcNRLJvDdI
         9cBFVqjXbu1R/AusGiRFtru5gW45YTSe6m8YdA8TPYsMdQ+Xs7PnfrS88McW8VD5Elyq
         QZfu/V3dGH1NBFWDtC2WBVpCu2/1Vc3aX4ikXxPjaEHu0okbc3GsuXBclZTELz1VfUqY
         +Ao8t0ipDti1gUauyJE/C9xSEPAz+GfvmnAQch3L4Knhtw3tsD64j6nLpCohWdbxq3XC
         jBnJuT2gaZPhEyyx12A+RPtG81cFmXQxYiM/5yjKKaRjgTwCVXP/KmyPdw0pGeUrOP1i
         7Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G8zhnrV08p17+f/+gNNScolaBaJcAcXfoOQXYyrrgDE=;
        b=kaUAzynxyq/Wrp3RtiGY3UfN6zGlh5+gHTfCkxOnu3B8gduR/15Frs4DPSH9iQM+6b
         H28UQflQT1Yl9RuUb/udguL4WdAJslhn2CLqB5kdDGz0wPN3rL2HG7dyuWA1pyTtD2s3
         mqyTkyNAefkpA1geBhgszi25tupZlJVerthPjHDfbqs7CGc96SOm4LPTpw2dprhUJLFS
         naXlktcZtQUymM9QmrrOMJSmficf599ZdbJbt/icOxKZfjjKosIymlM+70rw5Hry/t73
         RejE6fnYV9J2Q6u7EfmjObeZjHz22V6kOM/9nM7/n2qLC+0cm/eyw3/CmSJDt8+yEs0S
         7pYg==
X-Gm-Message-State: AOAM533URONnFyCM97CPmY94mHiHQfbO/dXAGHM3rpnhfMdXCZ5JZaJQ
        76ZJF5k66qK/pK+MecnZbe8=
X-Google-Smtp-Source: ABdhPJzaz6EJmZsgf1YNGCQp9DRhfTbLRVTapwTUq/OhC/AFGKr3c5tLAktQaeGMArKkjlo1RgQnTw==
X-Received: by 2002:a05:6214:268a:b0:440:ce23:7ee1 with SMTP id gm10-20020a056214268a00b00440ce237ee1mr3724244qvb.112.1648118730061;
        Thu, 24 Mar 2022 03:45:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f18-20020a05622a105200b002e1eb06ece3sm2102330qte.31.2022.03.24.03.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 03:45:29 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn,
        yang.shi@linux.alibaba.com, dave.hansen@linux.intel.com,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v3] mm/vmstat: add events for ksm cow
Date:   Thu, 24 Mar 2022 10:43:33 +0000
Message-Id: <20220324104332.2350482-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
get to know how much memory ksm saved by reading
/sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
of ksm cow, and this is important of some delay sensitive tasks.

So add ksm cow events to help users evaluate whether or how to use ksm.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
v2:
- fix compile error when CONFIG_KSM is not set
v3:
- delete KSM_COW_FAIL event
---
 include/linux/vm_event_item.h | 1 +
 mm/memory.c                   | 4 ++++
 mm/vmstat.c                   | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 16a0a4fd000b..d817ba541851 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -131,6 +131,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		SWAP_RA_HIT,
 #ifdef CONFIG_KSM
 		KSM_SWPIN_COPY,
+		COW_KSM,
 #endif
 #endif
 #ifdef CONFIG_X86
diff --git a/mm/memory.c b/mm/memory.c
index 4111f97c91a0..12925ceaf745 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3339,6 +3339,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+#ifdef CONFIG_KSM
+	if (PageKsm(vmf->page))
+		count_vm_event(COW_KSM);
+#endif
 	return wp_page_copy(vmf);
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d5cc8d739fac..710d71af2285 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1390,6 +1390,7 @@ const char * const vmstat_text[] = {
 	"swap_ra_hit",
 #ifdef CONFIG_KSM
 	"ksm_swpin_copy",
+	"cow_ksm",
 #endif
 #endif
 #ifdef CONFIG_X86
-- 
2.25.1

