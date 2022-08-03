Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC384588F26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiHCPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbiHCPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:12:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0503A4AF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:12:45 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so15385920pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=dxKpudtpM9c04gsBALLT5GNJ4ez+VeuhMNxM61Y7Zys=;
        b=TlUkKbkwpzJsUZQMWGVpPpZ+n5EKDY68Z5Q48koM0MZ/0s82onEnukdVx8O037K9O4
         tPFkAD159kuoDvC0yngRjF0POp9zlUTXGgFOCHt8Gd7dvduyBaiyx2Hj7D0LWsVp0pkt
         hApAo7lBEXQda8i1Ed4XJBy6d13ZneFaijFw7ZW15sp5UnsX+6Xwrr7EGxvEo7Bc/k3i
         zvIn6tapOBjYzmqxjlj7XkQiqBaAqM55kMdtB3u9Hbvyh75X8Uxs4Fm9T4Be/QqfMrLk
         1ex5bWBzzp+9iTi4NLuio/uUjE45ou1ye/hUEcXH9x3KvZiHnDBiBdwvDWIrc5RehhxU
         MqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dxKpudtpM9c04gsBALLT5GNJ4ez+VeuhMNxM61Y7Zys=;
        b=BJR6rSJ1C/6m09lzmVLlMzLSJggUjRfV3axVWHtS1vVP3WvdEzzUosj4nWwxPiO8nB
         7NRuO8j6m3MKMqlHeN+H9du9x4KrtlidIHchbQLSPZuIQZRFWjtOdlPc2yjN0YcCo+Kc
         tr+FHfHUA5TXezG0OZ1sAHZW+/1tCr6rTUCNXEoLn7UEhKrcBAPsQAhSMdtZJxGXEp4P
         DdYSqp5ko9Xs1iylu5mPesTDGafkakLKbk3aN4ckqHQ8kCCo1LjneZm/AIyghUoU4ky6
         aWpDjBQ2M2uYNtbt8FAg6gKA3PVCn4wD/nv3Ii8U6Ny26T7dt6h6unhBZMoogGoaqSLH
         +fYg==
X-Gm-Message-State: AJIora8aB7GhcEefKV+49VlYZJynLcfo5XKXmN70aQgMEm+Ac9qBg0w1
        8KfFEv4n181cGLV1GP4M61o=
X-Google-Smtp-Source: AGRyM1uUuXwBDm/bVaj3vqKbwti9dLWNE6+XW69yeoBDMEc2GahmO9mpjYWsUtcGHrUjpMDSy7aMDg==
X-Received: by 2002:a63:d5:0:b0:41a:58f:929e with SMTP id 204-20020a6300d5000000b0041a058f929emr21171472pga.260.1659539564401;
        Wed, 03 Aug 2022 08:12:44 -0700 (PDT)
Received: from localhost.localdomain ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id mn19-20020a17090b189300b001f4f40763b1sm1750325pjb.29.2022.08.03.08.12.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Aug 2022 08:12:44 -0700 (PDT)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org, chenzhou10@huawei.com,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] arm64/kexec: Fix missing extra range for crashkres_low.
Date:   Thu,  4 Aug 2022 00:12:17 +0900
Message-Id: <20220803151217.75962-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.
Add one extra crash_mem range when crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..378aee04e7d4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -51,6 +51,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;

+	if (crashk_low_res.end)
+		nr_ranges++; /**< for exclusion of crashkernel=size,low region */
+
 	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
 	if (!cmem)
 		return -ENOMEM;
--
2.35.1
