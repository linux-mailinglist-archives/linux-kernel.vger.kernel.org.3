Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160D24DEA90
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbiCSUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbiCSUPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:15:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ECABF3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:13:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso13259960pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ybhg95yFOnZ8Gx7hYH/STPgOcRSYtoONIdcVwWBj9xs=;
        b=KMIQAg5HKfIs/DbNm1nEdvkBhAsJ8bnTP0O9YF7ErhQMpZTB3Ff3xrXpDPkTm2CwCo
         a+7aoSvdZaVT24b9O8STb4KUjtrTT6pI50AU+8AYh5rVgh83awi0b4FzkuHuLJh7XCqP
         c7quHdx/EFQfwt7nlndBIK4oe8lOpEoigu4wCIcF04x9i09cH1VgJSHl07Wn56Y7VBEp
         1RhCXGWPRWoorfIADecIBdorgIVfZDW9ZvR71tG7vLGNHtBWZxD3luisSA+iRmWwIPvT
         ZdEozZqnOAIfJOhuSt5yKbF0Ji8mcs82z0Ciq7APkX5MUdCPZNvKDWf42ds/OCeSwD6p
         sR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ybhg95yFOnZ8Gx7hYH/STPgOcRSYtoONIdcVwWBj9xs=;
        b=3q7S+vbKGgAuqCX6jHKGmvre6L8xhbIdjQ62w5yCzxkMMGyuqqjuKM+WMmCxTQwLSA
         NEc85pE6jQqOtgp1mHJqMQFN3dRXWhInsugC/mpETfoF2In1OXUWEPn4B5hvuuDhn74A
         +nHHaDJ7iduNdFqZViyggEKGn3s/WC+OrAFs8Wo2LEvky26KyKwCKvhPPPziwsgWwMRX
         tqM2J/V6f3ZdlGVpAO0ynxcRE+JS4ixKBjxfN16P/KhnccHJWCiJ8Ny+ORAjWMgL1D7e
         DHQhqSsGQcvGLO7cwD0RMex5eZHI2688+TIhFsZ3r6rcuwMsmTUsc9y82x6NV7n/s/cc
         BNbw==
X-Gm-Message-State: AOAM5336oy0cO5REyOxXQkgsxM0IZB0CISkwiZPyoniqhdn1mKk9ZpQQ
        YsMLACbq7ZobZ7svYdjcze0=
X-Google-Smtp-Source: ABdhPJxNnO+eafhYL2t5d69XBdzY0Xucmf1hFod5sePQL8o7hwpjKKSsuf+rrm256mbCa7fsgowP6A==
X-Received: by 2002:a17:903:2312:b0:154:22f3:23df with SMTP id d18-20020a170903231200b0015422f323dfmr5577566plh.82.1647720827985;
        Sat, 19 Mar 2022 13:13:47 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:951a:ad0c:e44c:ff47])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm13722621pfx.81.2022.03.19.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:13:47 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: enable plugin support
Date:   Sat, 19 Mar 2022 13:13:28 -0700
Message-Id: <20220319201328.3006869-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler plugins can be built starting with xtensa gcc 12. Enable plugin
support for xtensa when gcc-12 or newer is used.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index a02c3388f521..ad91836ce7a8 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -34,6 +34,7 @@ config XTENSA
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
+	select HAVE_GCC_PLUGINS if GCC_VERSION >= 120000
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_PCI
-- 
2.30.2

