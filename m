Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7176E5A5F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiH3J3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiH3J3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:29:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA1DDA8A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:29:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso17329923pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8hn22DiKT6B2qAXWtehvZaaB/0iSzkXCb8vTs5kctVc=;
        b=XuvigDUjsTlew5QByyid0KyBITvNUqJn6IcfgWkQV7zAGAl3UMoMtTDzftEhlP45tn
         FMWBDAJQivrINusQeWrFv12BU/n9lkyS+L/PWPne5BKo+U6omVTBfU60EwAZjN/tx30i
         ULMBCCtdiOT/NlPnfEyCq+6pMn88BFC1a5Ke68UMctEY+82Ufuk35IiR4/pOHj+LY9E5
         BKA/MC97VPtvymxh4RApDtCRokkLv/HgiWyNT/pQVoGgbzCkEPngQYQxYORjY0ddFs6e
         lnPNT2gHKD5B3Z1xSYopZJOBWcFx+CF4GjeBxg23kJSZldS1qrGCX+RdUmQaFeuTLF5a
         0zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8hn22DiKT6B2qAXWtehvZaaB/0iSzkXCb8vTs5kctVc=;
        b=su3tKDqtvZfN4By6hBrwgGKu3WtbmqY2a6S1bWwfJ0iizQd9u3kZQkti6K6jdw74dg
         EKb86kXrM4LYv/nB+0c+vcAEC4UpaLZp2XCw2XRQ9OLejGj3lXYvCLrwapGM4JZU7u0T
         /P5P6znNHMqRPYRkfkqkGqbDnhMwqtmMD39gn+H6kPltYstE44VIwfNZAoK1zqdrECTF
         8uFkqi1Kn6u8zCLeHoQfPDPU3uS4xEJJVprn48hhIXGPJVHmh0d2K/fIHNZzEgO731D6
         UrGGOp0K3wVoOCOOMw8FODzpL7hSwHWKcz/o8jaHmaUq1hGvlwrZLZTKu0u5nUu6HdDL
         IgcQ==
X-Gm-Message-State: ACgBeo1bpqJ2ZhSv/mkonOiVGWSrXvXKMiM16WyP3ssUtRZcc1lqViQy
        zR5464xxnFQZ9Q6CXC08Yx8=
X-Google-Smtp-Source: AA6agR7gbfq0fmmwAEUpk3k1Mfq5iKb3ZA3FowaWJdaJ2BGUzjQPfWAwZs1PK7bMi0Wk9ZrJIY9mfg==
X-Received: by 2002:a17:90a:4042:b0:1fa:a752:9e1c with SMTP id k2-20020a17090a404200b001faa7529e1cmr22409877pjg.117.1661851751402;
        Tue, 30 Aug 2022 02:29:11 -0700 (PDT)
Received: from localhost.localdomain ([118.235.15.129])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fd7cde9990sm6485500pjz.0.2022.08.30.02.29.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Aug 2022 02:29:10 -0700 (PDT)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     bhe@redhat.com, will@kernel.org, nramas@linux.microsoft.com,
        thunder.leizhen@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] arm64/kexec: Fix missing extra range for crashkres_low.
Date:   Tue, 30 Aug 2022 18:28:39 +0900
Message-Id: <20220830092839.3197-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.

Add one more extra cmem range slot in case of crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..a11a6e14ba89 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	u64 i;
 	phys_addr_t start, end;
 
-	nr_ranges = 1; /* for exclusion of crashkernel region */
+	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
 
-- 
2.35.1

