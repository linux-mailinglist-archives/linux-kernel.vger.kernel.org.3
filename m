Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5138562007
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiF3QMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiF3QMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:12:32 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F223120B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:12:31 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id q4so30412274qvq.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIeZ7ZUFR8uUdavug06JIRw9ETH7oXgy29YJGJmtVOc=;
        b=b+M1vpvBViKPkT7LE/wlsBdInOEtZXiDskB4CB2QW8+u5WsEPZF0c1RMTs2h9V3xZs
         pfIZKzeFDEP6J/hbU1K0tq5ZovFpcUV+u9+O56dor8++DCNgfXqQc4mnBtSZkGHlVOqh
         VR/SMgpXHDLtwHmihcb2288zkxNweUUqu76i4ke3qQmQiZLoSYWT/3waOCXJ975kQNp3
         G3CDLaQJl45OvtgT5ElISQgnBF3OmbgRogKE2McTxZxpwjXnJHP331Wy5fVKUBr5gVla
         BADiWcfdnke7tA6xZ3LEGvCAhLh7sb3mtZuJrN+DQ7NMpx5pg3HH8d6AkU+v2ZRj9iHr
         CSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HIeZ7ZUFR8uUdavug06JIRw9ETH7oXgy29YJGJmtVOc=;
        b=ERdn/Mzx4uKUhhJ04Ycq2k+UCVH0ATzI1F5Op41qFWbN6NeEU6sHqJH6vuPh46H5lx
         L4b/wyFszMLVxaIPcaMZEYHrJM6qMgsbPdvM07HP9OQiFyBtzQ6BPiq14aTIHqs9j50T
         NSKQsSXQgdzoLyxw7XCCiYX1DhMwPXHdSuWXOKM+saW6XMlAnRh+g9+AKx2bGD14fqhC
         B0eteJLGZCZ+GujvpVQf38etSIv91ruAlCX8p+gCNp/cf46Q3EzGZb5mda2drIJy6QP4
         mwyOQGulOvT1MxVZG0mt+/vZmjQJh5/Sm4kmB9X3erHOjCiKCMEb7hgQ7BzSolOBisvR
         +ESg==
X-Gm-Message-State: AJIora+zGmN3gf5oisTdiYxXE2A4MQ+VEpq11x2KtAYHf+1FdBjQcOIq
        i6ZViPZQAU+dZ2DrUUKhsYE=
X-Google-Smtp-Source: AGRyM1tAaGFAfiUdUktuJ8iBabBFgwZixm+u5RXS89XZXpvo6BcLDkTfSf7S7wxlSX5pUf+1WfdSsQ==
X-Received: by 2002:ac8:5c0c:0:b0:31b:b39b:12b0 with SMTP id i12-20020ac85c0c000000b0031bb39b12b0mr8264577qti.4.1656605550844;
        Thu, 30 Jun 2022 09:12:30 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a24ce00b006af59e9ddeasm6623151qkn.18.2022.06.30.09.12.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 09:12:30 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] KVM: arm64: Fix 64 bit mmio handle
Date:   Fri,  1 Jul 2022 00:12:20 +0800
Message-Id: <20220630161220.53449-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
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

If the len is 8 bytes, we can't get the correct sign extend for
be system.

Fix the mask type len and the comparison of length.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 arch/arm64/kvm/mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index 3dd38a151d2a6..0692f8b18f35c 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -81,8 +81,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len)
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
 {
 	unsigned long data;
+	unsigned long mask;
 	unsigned int len;
-	int mask;
 
 	/* Detect an already handled MMIO return */
 	if (unlikely(!vcpu->mmio_needed))
@@ -97,7 +97,7 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
 		data = kvm_mmio_read_buf(run->mmio.data, len);
 
 		if (kvm_vcpu_dabt_issext(vcpu) &&
-		    len < sizeof(unsigned long)) {
+		    len <= sizeof(unsigned long)) {
 			mask = 1U << ((len * 8) - 1);
 			data = (data ^ mask) - mask;
 		}
-- 
2.37.0

