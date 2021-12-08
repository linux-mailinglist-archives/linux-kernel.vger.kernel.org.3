Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63746D6EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhLHP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhLHP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:26:54 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60026C061D72
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:23:22 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so3166189wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uoeb8ZSnDE4o8Pfzcz/JRgpjIAPknsa+43VWqkDL6SE=;
        b=FLyX6GFGnWQE7qMZM26O1O1AIl75kaww4jWCqv4JML5oIxJznYt9gmaqoKEtOluEIA
         KivNJtKKcK5gQqfUIvhnbeRCcIGE4cfZuQ3Z1B5J5RHBhJLgW41frhBZiL+74d5zvtjQ
         YTXVsaTlKCICiUB8KMyDO8wp/JClMuGlKFewIBt3+94HtCTajeFbEV0YelIu3Iuj277W
         86JPh53Fj2k/kN6UXiqUCcD5vyQdWQhbDDtxGqMl6se8ENYkODZ7oT+K2FS4TsPAAsCZ
         Dcqr8eXGeTQyX4059KSQKZm1fFeKlvhLHrQgxl0ZG1j46Mv7NoPJjwwGbd0clsKGfsfc
         ufJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uoeb8ZSnDE4o8Pfzcz/JRgpjIAPknsa+43VWqkDL6SE=;
        b=elt5Jh0+30B9QWumT10vtVFkNe3Tr2yU+3EIoXP8HNryPo39IA7uGTRPGxxchzgjFI
         w3wi4JRjKgZNNurDtYSpThiYJtNfIUV5uj6u7Kadyk55d4EMU/zSfYC/mHM0ZGNcmSF+
         MqLGHgMZr4SBbevaslFy9qWwUWhofuscPvuY6b8Xq0zxkTcbRhs+hUUSC4Y5OAUtRNB4
         ilUfAFfUrCNUMAStMB0RqIjOS6fzdrsnkGIph4CQcK5fq6xp21cNZ2gWzxbmi69wX9tY
         mSnAsLQJNUIOZLHBJHrJwtNnzAI9e0F2G0kNu6fUB41G0X9oBPiXtwJGp0nt0yyasWYA
         xD9Q==
X-Gm-Message-State: AOAM532Sx1A64Ilz6vKwX+SnF9BhjXsFVOcPdS/YhFk91O4M2I4yrT4N
        OUDayfKiw8ygN5u95sjAmK8EBq6uf6J9
X-Google-Smtp-Source: ABdhPJzw6DIyY3LwITNb68nDRIYXL5b0dyrc0mUWTC50VbADX2UnqIrRkM3tCHlIcHHhMLL5CQqyW4AukkHv
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c718:14b8:982a:57d5])
 (user=qperret job=sendgmr) by 2002:a7b:cc94:: with SMTP id
 p20mr16347652wma.162.1638977000902; Wed, 08 Dec 2021 07:23:20 -0800 (PST)
Date:   Wed,  8 Dec 2021 15:22:59 +0000
In-Reply-To: <20211208152300.2478542-1-qperret@google.com>
Message-Id: <20211208152300.2478542-7-qperret@google.com>
Mime-Version: 1.0
References: <20211208152300.2478542-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 6/6] KVM: arm64: pkvm: Make kvm_host_owns_hyp_mappings()
 robust to VHE
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
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
index 605c104eb030..ea840fa223b5 100644
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
2.34.1.400.ga245620fadb-goog

