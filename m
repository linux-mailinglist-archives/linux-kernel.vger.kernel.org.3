Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F961520257
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbiEIQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbiEIQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:30:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF01FC2FB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:26:13 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i12-20020a17090a64cc00b001dccafbd493so6434501pjm.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=24ZXTLzrcb04Vr94e2BinqljFa5PLSd+pPp++TfBpV4=;
        b=P2MUNiyZ52zkfiPjcTS8SbrOv+J4pIHeiuXQFaZnESg+NLVcCU4AR/+fuZgpSBJHvE
         rej/pBP0q29OlurWs27cZq38903lkbwzGDQrWMriEBwcQEe3UtVPAayTBp96OwiKgap+
         LxnYhTuP4ZWRpIebRHdev99As+Py+mvlCVMd3D2qN5Qmpq8aghskctCe/hfEfC249O+L
         3n0gWT+eovPuEaB24iPZEmL9XqbtVwLE//FTCfavnJqsLwR6eOuJ/ZgMEPsWRJFbX9I8
         dfcd2f2RR2knl9FJNgaSc9pfkr2xrKpX4HOJPcQnVcrbmwKGZvCTvtme2vs6Y1WphhFs
         dGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=24ZXTLzrcb04Vr94e2BinqljFa5PLSd+pPp++TfBpV4=;
        b=1i6Le++w7DZOmpiduqndEaS6ICDFM+cDnEjf9F29xiHHfPJaJpFaRkQ9GH4IG7lDDJ
         qjUrA8Ae4vrf9FvUzI4ANPmrCWK6JmXc9qpIO1hi3sztEQVFO47Umk5w058lkDzWHb1M
         URLEKzlthizyIYGxxbGCtSRSzHiVbd2KH40vNkUpWaK+ZeDaMVntJRlyYWyH0nCSfz/J
         qWVMTJRTYU08VAEo+PKXmNI60VnXZ9ghh0RiKzr8fuU0c1Afb1IAaQttQEPPSAdeEwFo
         obpDVAXvmVw8ylKJbskvNlt/VYRYMSvd6yiEPduBTUvqsG/tLiN8fu+RB3P9Lue/tVTo
         IPvQ==
X-Gm-Message-State: AOAM530FtiGaYxvPTtiHlX4sV/brdnqi1JmWar8De1rJxZ9snRBBiRAq
        PtXTt3k0K57OtHXls79NDT1lsza3gBE=
X-Google-Smtp-Source: ABdhPJw1MOqIa/OCx3HluxWiZNUBlyVCmiV5/bxnPcSifyQh0atyvanFNrvtWw7hQl7rFciI7mrRmNlka6M=
X-Received: from oupton3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a17:902:e94e:b0:15b:22a7:f593 with SMTP id
 b14-20020a170902e94e00b0015b22a7f593mr17113726pll.148.1652113573120; Mon, 09
 May 2022 09:26:13 -0700 (PDT)
Date:   Mon,  9 May 2022 16:25:57 +0000
Message-Id: <20220509162559.2387784-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 0/2] KVM: arm64: Minor pKVM cleanups
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com, tabba@google.com,
        qperret@google.com, will@kernel.org,
        Oliver Upton <oupton@google.com>
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

I was reading through some of the pKVM stuff to get an idea of how it
handles feature registers and spotted a few minor nits.

Applies cleanly to 5.18-rc5.

Oliver Upton (2):
  KVM: arm64: pkvm: Drop unnecessary FP/SIMD trap handler
  KVM: arm64: pkvm: Don't mask already zeroed FEAT_SVE

 arch/arm64/kvm/hyp/nvhe/switch.c   | 19 +------------------
 arch/arm64/kvm/hyp/nvhe/sys_regs.c |  3 ---
 2 files changed, 1 insertion(+), 21 deletions(-)

-- 
2.36.0.512.ge40c2bad7a-goog

