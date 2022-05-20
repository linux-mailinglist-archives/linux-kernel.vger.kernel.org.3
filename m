Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF46552EB78
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiETMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiETMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:02:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673D154B00
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:43 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 508183F210
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653048161;
        bh=oneXHGbxDyPUqhu0E+ANdS66+PnEgAp2RBrt57urwwg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TGgKAwCLHOpdmVkoI6EQdrf5obMRnBja+loSSRvdNi6ZKWkho4Ljx8jX2dteK9b3/
         XCW949/+CJGgpRtbznF+omdhTHXQfnJqhz14uo80NGV/1TOPJ+JH0dX2PbaR6If1yl
         ewJW9TBCQP+3xsp+AdTc/LVVL4pda+vJVVEMcnX8eFQFgJPay9CAKrwAotmnWVCXAZ
         piJy1vpfx2bqUlw3XZRAKjxaMM/cyB/oy/hpx+Oe6WGURQSf5gc5nBh7Bs55vqg4WE
         iX3O28eqDctDb0jxK4w5O/Fz8wcvUV7q2ifr5XeR33khNCd3qx2/0I7dfI7vXhSAQJ
         13bStg1wemssg==
Received: by mail-ed1-f72.google.com with SMTP id b14-20020a05640202ce00b0042aa312ff51so5537421edx.18
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oneXHGbxDyPUqhu0E+ANdS66+PnEgAp2RBrt57urwwg=;
        b=zqy0kiPC734cI9/DCny2+i/rR/fDyDJ8TFEva0kRQvtLRXED4sb6fTUOLKWTjX4+1h
         2Ekc3iR8uAORxGkqAfzNTheWUmgCltPOGVC0dhvHKNX1ZqAG+lnPzPv9htgtYwhnzD5m
         Gjr7HbX9BeLeof07DZOTG+jsldhuWsPQInDNM+I9x+hvURRBjvbvODMHTXsffZfXao35
         ryc5WuJ/1vxqCxa/ZqEYkOBsPBqZ5TqV3Q9UQwNGDQ3Rmvbhw4iB8xLpw518aRG86u19
         Yn/TtX0tMas6lB6zcd8wYwHKZfdrsrT4Z+2WM0Yd9Lx+5YmrWnXwRbKglXHW+PUMuDrG
         2nDA==
X-Gm-Message-State: AOAM5318AIpT9FXSGZGFD2FbPvR+0q862I8GNQ8l7wK4FwXHc3rI1Z5k
        DadzOlKlWny3MuIZCdWVjGY6jvW65TM1MaB6uL0z6EXXrIG0DG02nnX+aya5dgrclnOHGABpAgi
        US+WJpEMpX9CrrWsxwSVkdpjPK/cMfThRS6DAItwDOA==
X-Received: by 2002:a17:907:8a0e:b0:6f5:a48:e04e with SMTP id sc14-20020a1709078a0e00b006f50a48e04emr8604188ejc.228.1653048158769;
        Fri, 20 May 2022 05:02:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwl4iQHy4x3hKJIbjY6/BiMHJQQQ0n8VKaGxNo2KDCi0CpPKeZC0/C4aiAAVCxc047mxQGVA==
X-Received: by 2002:a17:907:8a0e:b0:6f5:a48:e04e with SMTP id sc14-20020a1709078a0e00b006f50a48e04emr8604167ejc.228.1653048158620;
        Fri, 20 May 2022 05:02:38 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id fg22-20020a1709069c5600b006feb002a620sm560042ejc.1.2022.05.20.05.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:02:38 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/3] riscv: Kconfig.erratas: Add comments
Date:   Fri, 20 May 2022 14:02:31 +0200
Message-Id: <20220520120232.148310-3-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520120232.148310-1-juergh@canonical.com>
References: <20220520120232.148310-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trailing comments to endmenu statements for better readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/riscv/Kconfig.erratas | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index 0aacd7052585..076005c5dad5 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -42,4 +42,4 @@ config ERRATA_SIFIVE_CIP_1200
 
 	  If you don't know what to do here, say "Y".
 
-endmenu
+endmenu # "CPU errata selection"
-- 
2.32.0

