Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9720C465385
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351686AbhLARHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbhLARHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:07:40 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35670C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:19 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso12561633wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=To0SNnHVfI+H6lAX6lBPI0gbbL9kvAmYwmWxoThbEmQ=;
        b=c3N+Hsz63lDc/AuLe7OwcJn+QlFGAiiPAK/v+uveeQj4J/xIMFLUVreGUkLB/OhWe7
         xxQExo5sN2tjJX/K0t22Pyedrge8bHw8PQX9ioa+ZyPcJXTNVTqwnzaN4wJmEAY0G3WF
         qePOIM36BNZrzbzHLF499Ie9giwIeOEhK0DjLg4A4aO0pyneUPX9V3J3QAgZhnAalmGq
         GgU2j5rGVQ+/ywMfsyzLjUCf/yIn9JUsfAZrM4tEXfekoTu7F7CPl0GECKg5acnJo0gD
         ldlS2SRcWRjiOuZ7JvgkDuWdek0FI/pSl01nLYU8GyAhvbnuRN8Ufpu4D57DZce5aeNr
         wU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=To0SNnHVfI+H6lAX6lBPI0gbbL9kvAmYwmWxoThbEmQ=;
        b=tDIFw+TGe0HEYCk4bGMTZ2M8J4rRfuRzz0ZCU5YLqaOblq2QQAcGz/LV0PDKCYO49+
         /ndkO48Cp1omBn7ECzlCgVZk7gYQl3xSxyWrHQQadPsBlJdKoCYbyOA1QXVd1KCoIt9h
         MldigF+iZl/v//GUSth7Kc4yBdu13EqeRTsxBHbfLTAiaSuJotQobe2o1r+mrWIn4UM9
         9B7vWxI13SEqr7LULHzkIImHma7/NWZfAgm7cfTuh3PKyknWl48MhdLLpDA/nCgZsqBs
         boPxjHlXwkwZdCqDrrXoOFLHqIkjwFpxqDIbuwbfuvrxnBsIrRzvCmOlH6bzTl240oBT
         EMZw==
X-Gm-Message-State: AOAM532lgzYY/dEgM1hflzzZdMBXqnTNipUDy9m+OUyPibc1Z4jScVFx
        mscf6Wm2+Cs38IIoxSQ5XXyx8vKhizl6
X-Google-Smtp-Source: ABdhPJyFcaB2RvMSztkS941w8QnL4bS9fgV6ZFzqQ3PoBgP+qzxkDtb1aqs2DI+obM4eDv5SPs/p5zCTtLuI
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:198f:: with SMTP id
 t15mr8655534wmq.94.1638378257676; Wed, 01 Dec 2021 09:04:17 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:03:55 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-2-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 01/15] KVM: arm64: Check if running in VHE from kvm_host_owns_hyp_mappings()
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvm_host_owns_hyp_mappings() function should return true if and only
if the host kernel is responsible for creating the hypervisor stage-1
mappings. That is only possible in standard non-VHE mode, or during boot
in protected nVHE mode. But either way, non of this makes sense in VHE,
so make sure to catch this case as well, hence making the function
return sensible values in any context (VHE or not).

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 326cdfec74a1..f8f1096a297f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -239,6 +239,9 @@ void free_hyp_pgds(void)
 
 static bool kvm_host_owns_hyp_mappings(void)
 {
+	if (is_kernel_in_hyp_mode())
+		return false;
+
 	if (static_branch_likely(&kvm_protected_mode_initialized))
 		return false;
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

