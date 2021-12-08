Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF646D6DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhLHP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhLHP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:26:36 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13692C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:23:04 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so484022wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NpInubJayz+E5mMCFoPp/JkXWEPD0KY636+dH77jYzY=;
        b=sWT6qvXqOmH7K7TXoOYGiA18Nh0gUdABfkX0uCHIJnxMTOg1e7wyB7JBMjFKfulgoN
         j0hlSiM2TirUjxIKZ2sFR26qfAb4TcBGFwIi1EkJFbo7D/AiMhZq1uR4Uzyvs+83bCvz
         J4uKu5WJyFesIQZuevk7j0nX//st7s0ZsVzTjeXzpQ7XBCw3x02W+TQ/NuutfRLmJKe9
         lAlUGHspE6Gof3g6LS239KTXVUKSHq5AhtF0VbLmSaVTU9nyAydFCmE8Ujs9+SkQ/0dT
         Rm1/flPLSH03muMPVkRTsHLJ/u8sHWXd0uDICLfyrgrmGwsORDrow2R1fwL/eeRBy+Ve
         d6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NpInubJayz+E5mMCFoPp/JkXWEPD0KY636+dH77jYzY=;
        b=CWKBXBcMri4hqJpcu7sVHnB5ZnrwklLzUSF1gey9mc979P3hNBgZSMn6VcJZhBkoaO
         tS5dmi6802uIgkXSBihfq0trkzYwB6YRGQsgyJRsyQdVWO97gEV6sj6CUcVO+gq+6bbU
         4SrCbZLXy/uo64tqLvyGmQQQsdZ90kysU6RXRvx+rqU4zJIVm+DLOwTOmlBfPx0DHjzZ
         NVc8pZR9A2tnPONtk80hYhfpx7yubnpjnAm548Na8vdLnwxD8pr2TlZJV7zycOYF62HZ
         JPXxQRsvSP+rWmp11IRUHF3+/yNhBQFwILIGhNQ6rzQ/Im+2oJoJA7bhdin5RNXhD3pC
         RD1Q==
X-Gm-Message-State: AOAM532vvQzDXi0VDK+nw9tomMKP9E1uoNjogIzmQWlM1StmQ22ZVvQL
        nZ4YbUx/54ahXNoPEXyLOu3zzRFhZKXm
X-Google-Smtp-Source: ABdhPJw2Q7y7Jx3kkG65Al++LQjZ/5cO1Syp+7Mi+yj+MVYxM7EetMdMtJVWeVSbFWR53AYbWIsx0Mc0l9C0
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c718:14b8:982a:57d5])
 (user=qperret job=sendgmr) by 2002:a05:6000:23a:: with SMTP id
 l26mr59842390wrz.215.1638976982501; Wed, 08 Dec 2021 07:23:02 -0800 (PST)
Date:   Wed,  8 Dec 2021 15:22:53 +0000
Message-Id: <20211208152300.2478542-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 0/6] KVM: arm64: Miscellaneous pkvm fixes
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

Hi all,

This series is a collection of various fixes and cleanups for KVM/arm64
when running in nVHE protected mode. The first two patches are real
fixes/improvements, the following two are minor cleanups, and the last
two help satisfy my paranoia so they're certainly optional.

Cheers!
Quentin

Quentin Perret (6):
  KVM: arm64: pkvm: Fix hyp_pool max order
  KVM: arm64: pkvm: Disable GICv2 support
  KVM: arm64: Make the hyp memory pool static
  KVM: arm64: Make __io_map_base static
  KVM: arm64: pkvm: Stub io map functions
  KVM: arm64: pkvm: Make kvm_host_owns_hyp_mappings() robust to VHE

 arch/arm64/kvm/hyp/include/nvhe/mm.h | 2 --
 arch/arm64/kvm/hyp/nvhe/mm.c         | 3 ++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c | 2 +-
 arch/arm64/kvm/hyp/nvhe/setup.c      | 2 +-
 arch/arm64/kvm/mmu.c                 | 9 +++++++++
 arch/arm64/kvm/vgic/vgic-v2.c        | 5 +++++
 arch/arm64/kvm/vgic/vgic-v3.c        | 2 +-
 7 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

