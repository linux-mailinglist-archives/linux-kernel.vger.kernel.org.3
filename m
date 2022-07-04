Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D856587F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiGDOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiGDOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:20:43 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCBBFF1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:20:42 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id b4so4509016vkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAimGb9Is5JImE4nmMqSqzepBpLcg7BYaug+pTNW7Ek=;
        b=hLeZI5XnlOVI8X5L1UsRnebsCf1j7iXTfxBBuxRT+gzb/yBxg87ImZU3389sdS5Pwe
         1Gjr/7jZc1u4U0+3J1tKXL2XshtUtJe6bNdRZ6wK94gsFhYAeqm0GoHnkMj6mkWFc+5q
         UN3HNPMRFJ/j5v07LNa0qGsLXa6MeGSZXL/+88XXOQ/rVEwfDlPltFyX4FsN+K+J4NYn
         hhUdZKoMebVLH8zr17dFM9LigBPzNnJZXBjbrrPnukqZUu9svNpUmk38z6ypobkV8zrU
         f20aFWSlvt9Da2JSHVLrcTiY2cSoraD9uILuP/PwsNtdK+T7f/5wo4H5CF64Mfj1hrxz
         dhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAimGb9Is5JImE4nmMqSqzepBpLcg7BYaug+pTNW7Ek=;
        b=XEd72G+0ZLzhlfUNRyumjkC/t0xeSF8YObBMiu50J1InhWOGr2RqOUpzxcpklL3Cpa
         DneVYBxXgn6CxJDoHmA0Uxo1dS0nEEoGJZ/HrjX+oHqjopuXKiifR3p/undqhMmxpIaK
         Ro+nu/IOB+QoxShoydYo1QRhbW3G9Ppu6XIUeF7qCROItfel/MuCMyMi0jMF51tXpm5V
         BRsCcm5Qorh76CfVmtETrR9Ra9yeX4GUrgAfQn/rHKCjrzgm/LTV8NWRR/T8DarD3T6b
         s09ojE4FydLjVmfIYg8poYJ5W3izPdm9fdNQGW6qh7Uxz51jVjJm6Npe1LxA5AOt+Bya
         YyNg==
X-Gm-Message-State: AJIora/vf5LOY7Pibd7YQk5BL4FETh/KuK7kT/mUguVPL+46NxNXJV7m
        tIwFv461EwUlBQL22vGMkU++/K39vzLAkNizNfcwW/0ukxV5QC055RYMsMqCTEVHfyHoFvX6TRb
        m+FwoHefRFMOuasQkCwfz2G+uGxm9HApjRWezdRk26NAEiM035GRmM79Kz0YNht3onvAuAfUU2t
        XdA7frWvjHcIcQUBO6
X-Google-Smtp-Source: AGRyM1vy7LDgVBkGg7LAYWrQ66F4nO8Kut0awFptJNvcDqPPNbBD2w0D+uVeNGJDv10T9MtT15G+Ew==
X-Received: by 2002:a1f:7249:0:b0:370:c589:aa80 with SMTP id n70-20020a1f7249000000b00370c589aa80mr10221768vkc.34.1656944441875;
        Mon, 04 Jul 2022 07:20:41 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id w41-20020a9f31ec000000b0038275916987sm1217904uad.14.2022.07.04.07.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 07:20:41 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is disabled by BIOS
Date:   Mon,  4 Jul 2022 11:20:34 -0300
Message-Id: <20220704142034.1511271-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the only way to check this is by greping the kernel logs,
which is inconvinient. This is currently checked for fwupd for
example.

I understand that cpuinfo is supposed to report every feature in the
cpu but since AMD is doing the same for sme/sev I think is good to
have this for Intel too.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/cpu/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..7311172aceaf 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -570,6 +570,8 @@ static void detect_tme(struct cpuinfo_x86 *c)

 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
+		if (mktme_status == MKTME_UNINITIALIZED)
+			clear_cpu_cap(c, X86_FEATURE_TME);
 		mktme_status = MKTME_DISABLED;
 		return;
 	}
--
2.30.2

