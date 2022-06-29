Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668055F595
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiF2FKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiF2FKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:10:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59732ED68
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:10:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b125so11210148qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SiiOj/PwhT+v3pEPCBaXVm0umL83ljOsGtkaaONyX38=;
        b=SoQgt33RbNp6krm+CVGPYk4TKoGX0T4eHTQ6xeN0ayzLdyNNDLR6CU/9z5fxKr1Q9/
         gRp22ydmqdxYYfrnrhByhtosEgdHE1KP0M41NOSqhl+MbOI+K8UsKKg1+MoYaH3FG6H8
         KZ1I0mVrqqBwIYNLNcI2kEVZfj0dWA2dBfCxLoyY080OLB6YtOie5Mm2mfU83qwOaLkw
         mbTZzoW3fouJ4gkPQZ7PgV7J+AiBQJw1/ot+W/ro8Lv0oCSK+NxQPexMOulJEyltRa++
         3z5uKOpa5IniX2oQDBpkz3V4bapYdU0QAxJZD8V3Hpq++hpaZg44Of96CV7PiyaaU+yd
         wSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SiiOj/PwhT+v3pEPCBaXVm0umL83ljOsGtkaaONyX38=;
        b=UzsRp1KSjmP6MIgT6ZW9YmDB+eVYMgRjM07WAbiEO6U/2EbK4smNf2oatt/44B+/Ri
         4VxfBsCWWWdGtGkpMfuuRYVA3gcjLaaygrb/4co+8eBfbs0Z/lpclhDvcFkS65R/sctV
         MY9J5fmceKM3U4IVmQ1GVtNS6CdGuk3yUam4+FzXZvHkSfi43rCNTqtj5ocVUWVVDd3A
         IQgzKrMIJ1l22WEzwVELrXekalPFVNiJLshMBjf7GLA3mE+WgpdfksxS+ONDr2K7micq
         KD6LxmsGKjymbOkW3kg4kmUCaP8eX7YMJhtKNPdD95Rld0zyaP+gvvqdHRehkenJnsIT
         3k+w==
X-Gm-Message-State: AJIora/rYJyk4zbsNUNMyQlPSlTVlIYcLVLDevIqiCAlvSFJQBrxhXbo
        2KMD3OCePwPWnWWtOnt+vksURpBiT4P8PQ==
X-Google-Smtp-Source: AGRyM1vbeyWwBaZQjhwcgbRqXkkaF3VBbW43B9wNNO926emZMo7h3Dkg3i+GwhBIbTm3i2PTNCrbjw==
X-Received: by 2002:a05:620a:430a:b0:6a9:36d8:574e with SMTP id u10-20020a05620a430a00b006a936d8574emr817447qko.160.1656479437006;
        Tue, 28 Jun 2022 22:10:37 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id x2-20020ae9e902000000b006a6a6f148e6sm12277338qkf.17.2022.06.28.22.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 22:10:36 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     broonie@kernel.org, maz@kernel.org, bigeasy@linutronix.de,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] arm64/fpsimd: Remove duplicate SYS_SVCR read
Date:   Wed, 29 Jun 2022 13:10:23 +0800
Message-Id: <20220629051023.18173-1-schspa@gmail.com>
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

It seems to be a typo, remove the duplicate SYS_SVCR read.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 arch/arm64/kernel/fpsimd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index aecf3071efdd..dd63ffc3a2fa 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -445,7 +445,6 @@ static void fpsimd_save(void)
 
 	if (system_supports_sme()) {
 		u64 *svcr = last->svcr;
-		*svcr = read_sysreg_s(SYS_SVCR);
 
 		*svcr = read_sysreg_s(SYS_SVCR);
 
-- 
2.29.0

