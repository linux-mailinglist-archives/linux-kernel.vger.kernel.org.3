Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5994953C376
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiFCDy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiFCDy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:54:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E2D3137B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:54:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y187so6324160pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 20:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixm9po8hHhuybaWeKy+DsLdABD8VQEU/2biNYLl9X48=;
        b=JvK+ZO+UqjC5x3zZ24bDid7p3s9W56KNURdN+MOP2hkSWBJNmfAqaKaXGxaGGrVfDR
         TQ6jEzDDpNXhDrPtrk3t7P7bGX+FE3oPgWStb1NU2xSDZ1R+vWo1L8PWyaUfn2b9F9qv
         t2AH1GmBliPyDfIe+zkRzY5rDmYw37HNeOP1rOLDVCaI1ddxxwJmR+c2jMoaOiqQfASk
         egtJ4QlysqnZzkAVSyKf0ZpoG8F3XJVfi1oSejt+fSJrFWXPe9v0L7jQNgCSAkz1W3l6
         SrDXHLMPNuLmf20zRj6HIgD/B+SgmB7A31UbB/VwH7Zg1lBQofcvWKMtjHARUDLcQHSl
         DfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixm9po8hHhuybaWeKy+DsLdABD8VQEU/2biNYLl9X48=;
        b=oVjIiyFbvnvpL1PC1nvoDRC4CCJi2hA9f8CON3ROQpTc04+7fzz4Y/WHlRQYfp9j25
         vnqLU/JljTEIN/T4/qgZpOi89sbw6Hj/dLL06iqaISk5SPaP0C2HRS4ItsC/nk36l1iw
         6C5ewmoJZ7rj9nSlB7tOHWPuvIMfz7yQ3+vM2a7HRFSVs4A8y0HPZBLxZD7ZEORNdGuT
         ci/0qhk//u2nQBWElFczZHZfH3Lj+QTRtZ+scoKPLngaUUQrrUKBXxtWQmE6uBtdx3+w
         G9Q1/has0gvCup6ebysQqD4uFMog+mvI3NNLAfzbEuUQHiFQyAxAR6hKqzFYMnGZj7og
         I+NQ==
X-Gm-Message-State: AOAM530Pr1pNZfPQnYZd+cMeBk3YbJoqtMp41jy+V0YSS++nI9olQW39
        ahBPhOtNVeVe3rP3vSEPhmY6trl6hyi33w==
X-Google-Smtp-Source: ABdhPJz/DiL0xThxIVZwuDcs/w/1pOoA6JsosoT3BWml4IECbGTF4BcekRPpYsrqVs4NY2Ofew5tTg==
X-Received: by 2002:a63:e443:0:b0:3f5:e5b3:437f with SMTP id i3-20020a63e443000000b003f5e5b3437fmr7155601pgk.423.1654228463082;
        Thu, 02 Jun 2022 20:54:23 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016168e90f2csm4148863pld.208.2022.06.02.20.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:54:22 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v2 0/4] mm: kmemleak: store objects allocated with physical address separately and check when scan
Date:   Fri,  3 Jun 2022 11:54:11 +0800
Message-Id: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
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

The kmemleak_*_phys() interface uses "min_low_pfn" and
"max_low_pfn" to check address. But on some architectures,
kmemleak_*_phys() is called before those two variables
initialized. The following steps will be taken:

1) Add OBJECT_PHYS flag and rbtree for the objects allocated
   with physical address
2) Store physical address in objects if allocated with OBJECT_PHYS
3) Check the boundary when scan instead of in kmemleak_*_phys()

This patch set will solve:
https://lore.kernel.org/r/20220527032504.30341-1-yee.lee@mediatek.com
https://lore.kernel.org/r/9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com

v1: https://lore.kernel.org/r/20220531150823.1004101-1-patrick.wang.shcn@gmail.com

v1->v2:
 - add rbtree for the objects allocated with physical address
 - store physical address in objects if allocated with OBJECT_PHYS
 - check the upper object boundary as well and avoid duplicate check

Patrick Wang (4):
  mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical
    address
  mm: kmemleak: add rbtree for objects allocated with physical address
  mm: kmemleak: handle address stored in object based on its type
  mm: kmemleak: kmemleak_*_phys() set address type and check PA when
    scan

 mm/kmemleak.c | 193 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 123 insertions(+), 70 deletions(-)

-- 
2.25.1

