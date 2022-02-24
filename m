Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E144C33B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiBXR2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiBXR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:27:14 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D711C01
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:38 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 145-20020a630397000000b00373b72d65f5so1413485pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qK1DQfY/agZG+Ude+bPzbHAaaA6lFwTTxSo+9IjwCXY=;
        b=TPsbqKhxmc0T+PxetBwAhdG6CCG7ROWrKmUGN3BsssTeSIgoXUOQnngTK58e76sGaV
         3u/siqCCo3eM5DO0OYSsT4wYCrRT+O8kY+a4+AnYqBHGb0Rj5B7cI0Hp7dOYnMvbxAD8
         RoAw7AYWgYK31cWIx7Yp8Ht4bfU+zuvlAoRR0OqLqR3iivh7tqnsNUSy8KpcavPHrnPn
         cHFxdJp1nmX7PTiWQDXtuL0nBeCqePhweoxs03ebVOn+oECM3dk8KZwiP6X63bDShGe/
         UcGW8KmUCjDJRi9tzyMH1ow70Y2j+cGCEuvyTbgcVe9mx5/NjKgrxZVEBbSazCAcGvGj
         1GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qK1DQfY/agZG+Ude+bPzbHAaaA6lFwTTxSo+9IjwCXY=;
        b=ssCVKueuCKIc5aC67Viho5XXOanS/usjP+y1rt224u5tgK75EpxNf03LH/FHD+bqbC
         PdFxdvedVb2OIB0XhES/KMa6FA0lz6zc0czaQRHE+rJwPGCNRaDl3AKcdsl8aSznn1Zh
         pCrkmORbh+GeRu6NsIAhPFurwlHZu3aAVXxx7gZ02vD84+HpEgYuEnCWwUu8/RpcjLdr
         uuI4fuMViu6clmleUPT5ckibOgZgb3AxCas/vfmVYzGOLdBR1LLnbIJmmQVWx1K8QmBd
         BxrFo5x+eHZsdcu3y3etqlNjxrI3uWqeJM0TTsM2SIvU6K+0BYPlozFGPyz/4Z9HQgcW
         PgKg==
X-Gm-Message-State: AOAM530DXM/VAad4ZWJz3IWbcn64wsJCqemtXel+J4LGisKEwDJ2GDa6
        8/UXaANive7C5/coc35uhyKu20jDCIre
X-Google-Smtp-Source: ABdhPJwU+prJ7BpJEtXxJA5crkhbYqb6Kqs4m4pINVmy8BqVqC8ntCResa6F6puuaRPR78ifpJ3Lzgoe5HTq
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:248c:b0:4ce:1932:80dd with SMTP
 id c12-20020a056a00248c00b004ce193280ddmr3851504pfv.48.1645723597604; Thu, 24
 Feb 2022 09:26:37 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:25:59 +0000
In-Reply-To: <20220224172559.4170192-1-rananta@google.com>
Message-Id: <20220224172559.4170192-14-rananta@google.com>
Mime-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 13/13] selftests: KVM: aarch64: Add the bitmap firmware
 registers to get-reg-list
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the psuedo-firmware registers KVM_REG_ARM_STD_BMAP,
KVM_REG_ARM_STD_HYP_BMAP, and KVM_REG_ARM_VENDOR_HYP_BMAP to
the base_regs[] list.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index f769fc6cd927..42e613a7bb6a 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -686,6 +686,9 @@ static __u64 base_regs[] = {
 	KVM_REG_ARM_FW_REG(0),
 	KVM_REG_ARM_FW_REG(1),
 	KVM_REG_ARM_FW_REG(2),
+	KVM_REG_ARM_FW_BMAP_REG(0),	/* KVM_REG_ARM_STD_BMAP */
+	KVM_REG_ARM_FW_BMAP_REG(1),	/* KVM_REG_ARM_STD_HYP_BMAP */
+	KVM_REG_ARM_FW_BMAP_REG(2),	/* KVM_REG_ARM_VENDOR_HYP_BMAP */
 	ARM64_SYS_REG(3, 3, 14, 3, 1),	/* CNTV_CTL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 3, 2),	/* CNTV_CVAL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 0, 2),
-- 
2.35.1.473.g83b2b277ed-goog

