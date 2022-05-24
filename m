Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC45323D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiEXHOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiEXHOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:14:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527DC5D5DF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:14:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t28so8018879pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRlOyFznhqcllB5R0D5wOECWdS1nzdOx8oGhDl9tP3I=;
        b=e10b0unVP47GYKpHeoWY60Db5sK3pGatfUwGHps+Me004JE+XQ5wgt4pHfqTY0Q4zU
         yguGhsmf1gqh1n29RHqLOW8rRvYlrZmToK/pRVG8c79mNZ/jo9PhBzypdgoow+L0WfrL
         I9NTBGOzqEvkU59WTaIvPczHJVJZe6J25I0R7+cKxXKAUZDAcP/SD+1228HF4MoK4+l9
         VDYuvLO3JuCtTqzWMSJMQip6LjGAWRgi1cacdJOUNZC0SCwwzh2fjp0gK+Icu3Y6z7fn
         udWDWZtQSVM2fOE7n2MyfM9pS/ytyGjJhC74EKgLtHpH5TuSO4dY0hJVRRnwpTb4sqjZ
         hteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRlOyFznhqcllB5R0D5wOECWdS1nzdOx8oGhDl9tP3I=;
        b=svB2U0zTyOsTfzVa+bBem2fZb+t5gojcNAw7FXlgZA32N2hgmq0Ny5Tbn1BjjAJfVL
         OMBda0MweCWh/X6hF7C5Ced/L7QcIb96RWqdw/SbIPqoSxBROaXgMU2qiV4TRgd5B/uJ
         ui+/zXtH6pUrpFZjp5ZggQVPzPlT7CyqxLe3bdtstZ8EhYiI71rEwTIdSNjLrmieu/0V
         QkczbmAW6giv2rgGSFhpj2CZy26HI/bPw45/Z36uOMjKpU0ERKK9aRPu2UM6O8J5qqzR
         AYMgXlpLecLd3q/yt9RZHU7cPDtvOSI/xUi5DtTyOEkGWeAqINIOqClGWDOPSYy43buV
         zPQA==
X-Gm-Message-State: AOAM533Z6Z28m/evNgI1H9ceE1FaKsjrGAxfcpzpCIpDTMNgoHGd2JVn
        uAvTLQL1ENzFRGzgXylXoLw=
X-Google-Smtp-Source: ABdhPJytRlr+IksNgpeuSKGSxDWVOSNwYOw84XYIQw8jPCJ2dU57bjALquJylUj+j/5CJllp5ajmYQ==
X-Received: by 2002:a63:1953:0:b0:3c6:e5e:9190 with SMTP id 19-20020a631953000000b003c60e5e9190mr23049687pgz.286.1653376470773;
        Tue, 24 May 2022 00:14:30 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001621c48d6c2sm4409018plg.221.2022.05.24.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:14:30 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-mm@kvack.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanchuanhua@oppo.com, zhangshiming@oppo.com, guojian@oppo.com,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Shaohua Li <shli@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] arm64: enable THP_SWAP for arm64
Date:   Tue, 24 May 2022 19:14:03 +1200
Message-Id: <20220524071403.128644-1-21cnbao@gmail.com>
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

From: Barry Song <v-songbaohua@oppo.com>

THP_SWAP has been proved to improve the swap throughput significantly
on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
splitting THP after swapped out").
As long as arm64 uses 4K page size, it is quite similar with x86_64
by having 2MB PMD THP. So we are going to get similar improvement.
For other page sizes such as 16KB and 64KB, PMD might be too large.
Negative side effects such as IO latency might be a problem. Thus,
we can only safely enable the counterpart of X86_64.

Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shaohua Li <shli@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d550f5acfaf3..8e3771c56fbf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,6 +98,7 @@ config ARM64
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
+	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
2.25.1

