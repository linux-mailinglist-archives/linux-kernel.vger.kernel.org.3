Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5D53A273
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352008AbiFAKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351987AbiFAKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:18:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F360DB8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:18:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s12so1413862plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7dWKsKXVLyYxufaqMHmnSiJsklMHxWTZtI+y/xbc3U=;
        b=CRI3NJvX5iv8mODPg6gnmSyPT7OpQJZY+0Pmsp+Ep7dS0fgj21da8aMTWjSpu/3FDc
         rnGTZZ0BZNoFET4ZbgJrIiybm+q4pjasWzmgc/7VvTOJk++bf7XrHEg385TZhicZTGfY
         hW96BQxbCYFaZeWGW0e+w37yrPY4WL2gKXk95Z8a8X0+opIRhjT0rIE+MO//KgHeWObF
         k8YcJSnGxBxbSRghCtzOAk791yW73LBk8yRufJRKkoeMn4C2nYhXmrJopxOyQXC1PyKG
         XeKGolqD7MpXEsE5HyKTTKkMnD6gDH4wLJx82FxlRh09bGbzRFcmLVYUwBtr2y+rVTGO
         rQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7dWKsKXVLyYxufaqMHmnSiJsklMHxWTZtI+y/xbc3U=;
        b=qo3zhLOqD7b0esPof0Mv7w2kWAVsjObHQ9BT+Tszk/uWFgTO0QkOYl7AUTxfVOYNLj
         xCEBGwR/1x8uwR2VoxlOpKMZQk2g2oZhegW8bNYlh7UBYiwq24rdnSC4c/0K9p8cLAQF
         QMKhYVTIBmy+Uoe9gvJ91cRRbmNHx4zHf+fp7GR3lYBW90daVqgsoOo1q0UqxYbaacrI
         ynAnictDgL1l/vXugO6713MHrZZN+hyoLwrNo7Uwl7YbPjMfMdAdDtKIMGwD3synfBoP
         /aNqv1LL/9XOErvZ8qcvrvnZXjNVlXy79QLbrHLqfQ06m9O8HqPUZeHBmWfoUhksao4P
         nieA==
X-Gm-Message-State: AOAM530zj/8hxFeDZixFFyzVyGmMuXQlMqq1pRcDOmBJvXbROixPnKHt
        c73f0StTftVvOV5Z5cDNP9M=
X-Google-Smtp-Source: ABdhPJy+IJsCQ40cLPK9+IrBtx2000hr4AaKN9bTBVYtA76B1jP6U8C63hstKHJ04Dc8MlEynVo7Mw==
X-Received: by 2002:a17:90b:314e:b0:1dc:d143:a15d with SMTP id ip14-20020a17090b314e00b001dcd143a15dmr33428629pjb.111.1654078705441;
        Wed, 01 Jun 2022 03:18:25 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090ad31000b001e2afd35791sm1051648pju.18.2022.06.01.03.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:18:25 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     yesshedi@gmail.com, pv-drivers@vmware.com, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH v4] x86/vmware: use BIT() macro for shifting
Date:   Wed,  1 Jun 2022 15:48:20 +0530
Message-Id: <20220601101820.535031-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
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

From: Shreenidhi Shedi <sshedi@vmware.com>

Using BIT() macro improves readability & it uses unsigned long for
shifting which is an added advantage.

Kernel builds with -fno-strict-overflow CFLAG hence shifting a signed
integer by 31 bits is not an issue in this case.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933f4..02039ec35 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -476,8 +476,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
-	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
+	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
+		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
 }

 #ifdef CONFIG_AMD_MEM_ENCRYPT
--
2.36.1

