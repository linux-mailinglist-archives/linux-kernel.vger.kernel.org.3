Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D63578935
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiGRSHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiGRSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:07:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51C2E9DD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:07:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r2so17212435wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJkJMSkCdlF0gaFl/bz9jTDoXOI1h8lyvQbXCIuYLC8=;
        b=C8tWnTILf1YjNs3VRqs2iJpG0DCvNLMm0tdHYgZplGjo49Xb8boIEkUjfMPoTyRsB9
         w8dxn13zDk0vfYhmhSPrS65Hs/leAZs2FgJPm93GLgwguAZ/qbL9/Tp5ASnVAMqsoIr9
         VICJzkZTA8jaimDI7tdXZdjFV8lThbq5XeY/ZNNXufSwcXICAjKYXwkhukqEDg8IMdGv
         AA01nviygOtFh+HIFB8HeuzRtLMOk7eTDhxLwfpiXVYAMibeJjbPwV77cTIkwJyQZlBi
         4k2qecn6oiNweTbcakjCoebgnZZZpIGE8c7E8paWGuX7zrPNVABAnz3PahYIO78l4f5h
         AlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJkJMSkCdlF0gaFl/bz9jTDoXOI1h8lyvQbXCIuYLC8=;
        b=L+a4OwhUS17YfzNSy5hyWe6HmxF3deL/8WXn5MY8i69H5o/mFHXwbav9m27l/Q8Uc4
         l30HOihheKjeijuVYR7w8idYkP5B6IcIldhmvi7c3UV2lhU7E73mhueSr2nYSjaeUlmg
         ilB9ducalgqnEfFNC1XnwlAtQh5orZBoj0JQ/11t27ipvhaeCG+9wEpavUTTDGxeZm3J
         QnRgtilYlSGgEsKbi7Ds7rh1DzMoTR3j/eo0qbllurPB4/KijVg0pYBmNYSWBwIsm/dq
         YZmL+jzhfO3F47BtIeXtOiwz/iijzubetBLL7e4PBiiDz7EoPGi2vEyVlomQwF32wlS1
         UawQ==
X-Gm-Message-State: AJIora/V5jyGTxnko+MRSMA5pn3KN+hSkVQYD0Yfyk8/zdr/npAm5SUz
        vtZGEvhhw3D2yCtOxTR5ZoQpJajzgMr5C2EI
X-Google-Smtp-Source: AGRyM1s9VcZfyCL0yD51nC8+bn/oG5LkVuSnRR0IpEa5nYTlSMbY4m9+W1bAQh9hvOB93AAHa1J5qg==
X-Received: by 2002:adf:9d8d:0:b0:21d:e5c0:2d86 with SMTP id p13-20020adf9d8d000000b0021de5c02d86mr11854660wre.482.1658167655623;
        Mon, 18 Jul 2022 11:07:35 -0700 (PDT)
Received: from henark71.. ([109.76.114.24])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a2d0f0ccaesm20886888wmq.34.2022.07.18.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:07:35 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] riscv: cpufreq: enable cpu frequency scaling menu
Date:   Mon, 18 Jul 2022 19:07:14 +0100
Message-Id: <20220718180713.451507-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Due to a lack of support for frequency scaling on existing SoCs, the
frequency scaling kconfig menu was never enabled. Enable it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 205c1e2f539c..ef12ccb81801 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -643,6 +643,8 @@ menu "CPU Power Management"
 
 source "drivers/cpuidle/Kconfig"
 
+source "drivers/cpufreq/Kconfig"
+
 endmenu # "CPU Power Management"
 
 source "arch/riscv/kvm/Kconfig"
-- 
2.37.1

