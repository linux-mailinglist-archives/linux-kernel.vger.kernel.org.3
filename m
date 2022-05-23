Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE61B530EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiEWMRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiEWMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:16:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6241FA47;
        Mon, 23 May 2022 05:16:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q18so12913912pln.12;
        Mon, 23 May 2022 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=I35gK+3/rMobMUa6WtZILatwndiFCgq59tmP66n+7K8=;
        b=cXVHVfKpx+Vt168LwW6CMQzJ5dZEQBt4hMMScHvlZkVt7xohJMwPgM4hwwZztQs4b+
         4cL1yfWvPZWoOVPDxstdq9OxCD0hnCCVdlIFAA/hLWjV24XFx/oJThxjmdRETrwbgFI3
         XUpeMyg+nWAksUSbe9IiBg9gOf+CFxLt960nFylcavDGnH9NKAujZs86PMhkab0YcoLz
         hfUoFfyR/3HWe5tLN2l9ksc9Tq8IKri95ToF6AwZrDvi3MKBDm4jbNSLNDg+S18PMdXL
         Ok8VZL5MtufR1wPXmr/ZLQ1146XpRVfHwfk0prmEe3yT/qyq8SD7jrJsxqsvJbL8OBjn
         o04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I35gK+3/rMobMUa6WtZILatwndiFCgq59tmP66n+7K8=;
        b=NiS1YQVBn5WVD+Bmxu3Lq1Oid6322Eq+7j/Wqj1OvooWc3qVdl6/bMCjPdwhzQjQrj
         H885nYG8f0y0vUi6vvLIMetcOVs9GwkxIbrsqZB8fZ/cBPijwJ/HNG6SCFgJZGsFVDXA
         WvQbEJU3j3w1/XVOZEXyIikl/ANkEYBB7Bpczli/bP0eWh1wf1y3va/FylM55Q6ahdEe
         2CGs7r75fEafYyGXQCZpRSfczy4jTEm12G7asjXnoWtcfi1Ub8vKLqUTOx9jUlw00utX
         IH+IZzwyp7yNGPxuHSB5M9dfmIF8uJej/vY5tKe5e4bFEoZX87RyqW1qkqAg2SF5wgli
         il8A==
X-Gm-Message-State: AOAM5316Y07x5d+A29pkpMg+z6fMOIaD72r8GIBZFynw4RL4k4dDNBmJ
        aAp4vv++/VRLdyeq/08RtTw=
X-Google-Smtp-Source: ABdhPJxRMgAxwSoWz7ELaIo3auOcgY6owv5LDEGn5+M+pgiVjHZtbGI06Fbe9J1qNsy6RNKsyXXmtA==
X-Received: by 2002:a17:902:7781:b0:161:c85a:8fff with SMTP id o1-20020a170902778100b00161c85a8fffmr22725331pll.97.1653308213646;
        Mon, 23 May 2022 05:16:53 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b00161e50e2245sm5045009plx.178.2022.05.23.05.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:16:53 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] MIPS: bmips: Fix compiler warning observed on W=1 build
Date:   Mon, 23 May 2022 08:16:39 -0400
Message-Id: <20220523121639.16521-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function arch_sync_dma_for_cpu_all() was used but was
missing a prototype declaration.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/mips/bmips/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index c535f9cb75ec..33788668cbdb 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/types.h>
+#include <linux/dma-map-ops.h>
 #include <asm/bmips.h>
 #include <asm/io.h>
 

base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.17.1

