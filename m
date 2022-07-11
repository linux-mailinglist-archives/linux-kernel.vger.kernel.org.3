Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4E570E46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiGKX2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGKX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:28:12 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D48876C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:28:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c15-20020a170902d48f00b0016c01db365cso4623720plg.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=DOykPfZhOOv0A0SN4H+uKTFYCJTV7QKNGrNlJuhxp84=;
        b=DhjR00I2EIl9ur7w4+92haoVAvaSmx6M50NPQsvNeU4+2tdO//RaVDVPR9uhkYpuHI
         g3FZM3me5poAWnd3bHGWSsGgmUrWdgd1C7lYar8J4jADipoGzXBNot27/DEM/yjiGRtA
         korePGbE9xdv0s0COoYaVOJFTrzIPmVsxTcmPoKSEx5L/40neFymhoWoaEFrBup7lThU
         FO70qtZLjWU4939rLwfGJQll0oW/NIs3apt4Xm+GBbDIyyIM5IQsankaVpEobaf+uF+t
         FuHOYgKiNCxGBSf21EuO3EB7Ey+Ps2nDX+IZEq0AIwzi3HLmsmK7Fs27nUIq+tf/IBWQ
         tvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=DOykPfZhOOv0A0SN4H+uKTFYCJTV7QKNGrNlJuhxp84=;
        b=5R6h13BtyQg/WTwR70G/rfw36aKEmNR7EbtzHZEQ/g4+Uu7CugY0c5vnKesrxVbN7j
         CQs4/aUdMkU4neLwXhv1um9ISp9WBGAdL5EfhR4hisHJ2uu4rnnMA8niBi9lqL1NFwCT
         /fZknbLVxTZRJOeJcnJSdgyQ/Dj9BZaSU8DaNV53xM0P8X4wAK5J9L+9epQ0YWufpdjN
         H1WzbAW+0Jx2wRhm9i0JVM8ObnaPoq+VZ1tlg8kJL6cBliaZpYu8KDKR8W0Lk4Mb33P8
         pQxxwPGptE9/Tsrjia74qoEvvsVt42ibDubEvt/HWUWH8q76hzc6uBZXxMKH1VMRLZez
         7xuw==
X-Gm-Message-State: AJIora/9zrqrosG6F26XeIo4NWRDSvvGxFo/cuA/o6+lQ76JlaVH4LRD
        BdNPGMeM9WU9bz5oN2j6yzOQ/0qz2uI=
X-Google-Smtp-Source: AGRyM1vDkuLDhPZPzDb+e7RX9GzZoroE4ub/CuME1ey11DpIJVbkNuemy4Wcx9+RbAEgfHM7hxMRV9bWBg4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b598:b0:168:f664:f1cb with SMTP id
 a24-20020a170902b59800b00168f664f1cbmr21014227pls.26.1657582090526; Mon, 11
 Jul 2022 16:28:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 11 Jul 2022 23:27:47 +0000
Message-Id: <20220711232750.1092012-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH 0/3] KVM: x86: Fix fault-related bugs in LTR/LLDT emulation
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
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

Patch 1 fixes a bug found by syzkaller where KVM attempts to set the
TSS.busy bit during LTR before checking that the new TSS.base is valid.

Patch 2 fixes a bug found by inspection (when reading the APM to verify
the non-canonical logic is correct) where KVM doesn't provide the correct
error code if the new TSS.base is non-canonical.

Patch 3 makes the "dangling userspace I/O" WARN_ON two separate WARN_ON_ONCE
so that a KVM bug doesn't spam the kernel log (keeping the WARN is desirable
specifically to detect these types of bugs).

Sean Christopherson (3):
  KVM: x86: Mark TSS busy during LTR emulation _after_ all fault checks
  KVM: x86: Set error code to segment selector on LLDT/LTR non-canonical
    #GP
  KVM: x86: WARN only once if KVM leaves a dangling userspace I/O
    request

 arch/x86/kvm/emulate.c | 23 +++++++++++------------
 arch/x86/kvm/x86.c     |  6 ++++--
 2 files changed, 15 insertions(+), 14 deletions(-)


base-commit: b9b71f43683ae9d76b0989249607bbe8c9eb6c5c
-- 
2.37.0.144.g8ac04bfd2-goog

