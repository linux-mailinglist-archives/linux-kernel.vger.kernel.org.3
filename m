Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15554C45CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiBYNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiBYNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:18:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB021BF91C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gb39so10862430ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJcYYM2DkPdVZwcYMzgAzMuG+6ZX8EDHi8dueGVr0ec=;
        b=P1f1iCu7yseQoCkbh7nwOz2DmY4PxbU8FDu7xI2lIyMnoc9uLvs0AVnssodgQEGoej
         QbhEz1CffETEBMi/2pj/Iuao1PUMD2u5KJnZf7OWMmEyJVRXcYVwGF1RpAdvEazcc0Yp
         qUq7b8wz007abCYLff0Qjcu0+qlK7IxL5jfChOK3C2kAFi5XK3SqRJoGxxV5cj4ztCco
         vKcTk0H+IFA0ShFnaI9nVRXbouR/b6tfzSGqkZMRPMceXDK7ihdiUuZknxShgJBPYCT7
         l5hmpIJR943m/H5635oPdZ0zTDf0pJs10KIrKQvOcj8eCFFa/5bqFdOWQlNE124RZgQ1
         Miig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qJcYYM2DkPdVZwcYMzgAzMuG+6ZX8EDHi8dueGVr0ec=;
        b=eCw6C5NJHJxSESXDcpIK0XDxMDGskfALFyCTsOPSepzA9CZCrRKHBqb/9OWlXpIv2k
         PFl2f8mvl/T6p6mZKd8TCZ++zX+xnGpW3llCSU2dE9dSLC3Z8t67DOOXf4gGPsUlejmU
         hAA5xck8NYJh+quc7XexbuqLILzwUrrev6k8wraHUkzmSTpgJ6w7U5obQTJqG2FnGwzQ
         BfitKoJ1+DyhjO4fj1FZL/qjB/akxw9lISCr8mnoWc+ZWWk2Aya3xHIq7qwjJum7kFIl
         jYn6q71Ll+HLvfgectV+rL1ruWLwFUN9p14ao7s+67NyxZ+GF0URpD71swyLE70LyWz0
         0sjg==
X-Gm-Message-State: AOAM532HH9UyGkR+ZZOpvj94l2xcjXqfq3oeLr6Q1H+P3KZpjyvk3Y9Q
        4KGOB3o1zdRG0z8usuTN2EGOAqnRr28+rw==
X-Google-Smtp-Source: ABdhPJzjaYu0PPKED3uWDxOL72JDadzM/0gRi+akN+loDvo2G/sZbUPlyQjTt0lTmtjrzQ2km/fs5g==
X-Received: by 2002:a17:907:369:b0:6cf:d106:acae with SMTP id rs9-20020a170907036900b006cfd106acaemr6067619ejb.456.1645795055582;
        Fri, 25 Feb 2022 05:17:35 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709062a5100b006d5c69301e4sm974864eje.202.2022.02.25.05.17.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:17:35 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/2] microblaze: Wire memblock_dump_all()
Date:   Fri, 25 Feb 2022 14:17:30 +0100
Message-Id: <6f480b6010068872f429df69c8894cc3f1f38f46.1645795048.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645795048.git.michal.simek@xilinx.com>
References: <cover.1645795048.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire memblock_dump_all() to be able to see the whole memblock allocation.
Dumps are enabled by passing memblock=debug via kernel command line.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 952f35b335b2..de0d8b03af21 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -263,6 +263,8 @@ asmlinkage void __init mmu_init(void)
 
 	/* CMA initialization */
 	dma_contiguous_reserve(memory_start + lowmem_size - 1);
+
+	memblock_dump_all();
 }
 
 void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
-- 
2.35.1

