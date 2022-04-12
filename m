Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACA4FCD21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbiDLDgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiDLDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:36:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8000862F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:34:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w7so16290973pfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W91zGX6dxqFiUGCVRFx8D5Y3JbxYlKOB4mae7fFQFkw=;
        b=M4te89kKfRRP3IQZ+pPD/ZCR1cnLVFC58CmRISFXb9dlt/pJ6VBLmDYjCon0jTPgjU
         Z4H4AsJu0vsD5WUQJnFbemzZ8RnhHf0TNWVlzPi5gYTziqMZrHW5Sh/Gzpa3AOAI92jv
         gZJ6IbZVLzNh+jSooGBtrEn5s6W+sN7BP36/GBwc4w/tLacbiaGX25Q/RbN/skMVrAjP
         TaAxYGesrh37wLZv5Ta660NiltkYnscgilGcfakHvwh3+nQ7g+a396yokCe8T7QTNdIC
         dorMgE6D7xsuwMo/53FiakaMVx4GrwFXb8RZO3qQGzkNJGo+sgQVIv1NEtyuDjja+Zal
         kL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W91zGX6dxqFiUGCVRFx8D5Y3JbxYlKOB4mae7fFQFkw=;
        b=SILdDXQnAKTPXQHUeiIJkejiMViE2iw4BprPdpxd+K4fFW0WCEC4N1a7b5Z+wHSLKv
         tYm0iYNifG5Xa5ldS7U8coXldYWTVE60fHE4ZUGe/SS1hFb/ovsZUc0sucjVnrbVk+mo
         vH+nq/SIMTzmRTx48jM/WupMpXbco/Rg2vzr9Y3xfoNXSy6826hbQbjWaQTX2Z5ctLXd
         wylPRzuUIq5o3fXJb2YdTqEJkltC3MkrXcXxqJE3h7Vn7ko5Fi/lK3kZ60LGYzguty22
         0yhz1XrXcBuYG1+DsE6NeXn3n/viBUrWXKKfbES9l3LMm81V2/IP/umWiRN5PqHL8Rgl
         54Jw==
X-Gm-Message-State: AOAM531ZyAiaQw7iNThYM84OBNxxkNOATNSt63a2kNz0vszg8cJLIXno
        u8UjlOgdpZROSeHmCWr7FwXOnA==
X-Google-Smtp-Source: ABdhPJyNrYndvPxD87g8DNwkXldbNmo7CJejXuvSm48T9zQr26C0WvdTw2yhxfYNDDyTHGcLu5llBw==
X-Received: by 2002:a05:6a00:1956:b0:505:c8d2:d610 with SMTP id s22-20020a056a00195600b00505c8d2d610mr7105171pfk.71.1649734471975;
        Mon, 11 Apr 2022 20:34:31 -0700 (PDT)
Received: from localhost.localdomain ([122.182.197.47])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a890a00b001cb14240c4csm1178441pjn.1.2022.04.11.20.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 20:34:31 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH] RISC-V: mm: Fix set_satp_mode() for platform not having Sv57
Date:   Tue, 12 Apr 2022 09:03:35 +0530
Message-Id: <20220412033335.1384230-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

When Sv57 is not available the satp.MODE test in set_satp_mode() will
fail and lead to pgdir re-programming for Sv48. The pgdir re-programming
will fail as well due to pre-existing pgdir entry used for Sv57 and as
a result kernel fails to boot on RISC-V platform not having Sv57.

To fix above issue, we should clear the pgdir memory in set_satp_mode()
before re-programming.

Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
Reported-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9535bea8688c..b0793dc0c291 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -718,6 +718,7 @@ static __init void set_satp_mode(void)
 		if (!check_l4) {
 			disable_pgtable_l5();
 			check_l4 = true;
+			memset(early_pg_dir, 0, PAGE_SIZE);
 			goto retry;
 		}
 		disable_pgtable_l4();
-- 
2.25.1

