Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8785A9131
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiIAHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiIAHsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:48:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73912D50E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:46:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x80so12054679pgx.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=v+aLW6XSZxp9QimTfsr5QzeEYxLaT3pFWzo7n2FYHsg=;
        b=Sjc4P9vtTICGifkH/YlHUrvW6OqfseM+FUoA8uWncagd1YTJp0Kgr4uTUIbN9ylss7
         eQXw9QMRS0E2AWBdLonQ9moT7U9gFzLZBm++KmQZ37P904d7Sp+eQVaVaFQ8BZRNBaDT
         krAmrWoTEI0qUA5b/WAN9ijYM1xXjw7uDvrlP+PGqJ9cRZ7X1IWM6K3dtNuWFRs2AThH
         MNu0s2f3t2XwprPZcROE56ggj7q3uSI2f2rjvBVmc5Xs8234YsqLnV+9y9yun4j3bklv
         e2zygYkUqqE9JmxutNE0rTL5r8/HzvRl0CELOu2JKlWBskZIydTaXZ6rGaUxpEWTilHo
         b6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=v+aLW6XSZxp9QimTfsr5QzeEYxLaT3pFWzo7n2FYHsg=;
        b=QJJss8JwlKjEhI8mUQjLl6tciJOLfZDXElamBY6gTfyBowbngmySDb+sdqJH/OkgUT
         cQtstXW2KsAZlAY1y3IehirUZ38dggNbyQ6mG2JsPxJhQRVA4K5OaXmMqJ08RZm4JH8B
         sT+7u0pHoKgNUmo3qxsmUUletCLTUw9EJeGbIcG1ML868ssAeYutqG6pjDnLBx5fO6IB
         85hYInYdiD8kL7CTqzBeJTnYvueG6A6tSJgsPaGIsmGdjni0zSXiArsHSa1IMnZf+ZXu
         UUPanDn27e1mLY55cHpgilSq5oxaHuWkaYuCGkfEtuiZu35CffApPliAI7/oMLq9gsZp
         RrUg==
X-Gm-Message-State: ACgBeo1FTrzpTL6qmK2hcJ5ibC9pCGMlopnxEEPNUSHEzK4i/mJAeWjx
        wUBrAtf7WBAxxxj4Fob6Xi8=
X-Google-Smtp-Source: AA6agR610XS+pdZVYOD8grBauRiJL+ULVLoy8BvDYGZJcvsyMHlC68ot6TWwzHzgvhHPp0QvhAfWFw==
X-Received: by 2002:a65:6bc4:0:b0:3c2:2f7c:cc74 with SMTP id e4-20020a656bc4000000b003c22f7ccc74mr24864261pgw.307.1662018408485;
        Thu, 01 Sep 2022 00:46:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709027b9200b001728ac8af94sm12920079pll.248.2022.09.01.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:46:48 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     maz@kernel.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, qperret@google.com,
        gankulkarni@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] KVM: arm64: Remove the unneeded result variable
Date:   Thu,  1 Sep 2022 07:46:43 +0000
Message-Id: <20220901074643.313329-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value kvm_pgtable_walk() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/arm64/kvm/hyp/pgtable.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 2cb3867eb7c2..a5fa05e34de9 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -925,7 +925,6 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 				 void *mc, u8 owner_id)
 {
-	int ret;
 	struct stage2_map_data map_data = {
 		.phys		= KVM_PHYS_INVALID,
 		.mmu		= pgt->mmu,
@@ -945,8 +944,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	if (owner_id > KVM_MAX_OWNER_ID)
 		return -EINVAL;
 
-	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
-	return ret;
+	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
 static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
-- 
2.25.1
