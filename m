Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCE5324AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiEXH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiEXH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:58:57 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72888AE58
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:55 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 669113F1D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653379134;
        bh=zcVJY5VJphDpNHGQJdr7krO+G4yUvRFeyOLNl4XgZg4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jHEw073zFs2JkAvVw8nFV6U4rk19NYEv8VyxjIEFduqjM0ZTzOWpJak198xFaJDxM
         dKBk3aXL5insnTaL9qiZaZMevTGGXfqzo39TmWvCl9LCGGVbaQ3pmdMJ1pDmKBzq2B
         1cLgay6Cryrt61oLbxyxHpzFjpE8MUA95DKXTAyTHi4Y7VjdT6rP4d3VlqoNBu1hcL
         AQ9g63M0o44aLRR5qcR0K/hBBE9WbjyEEFZnvn/5fZpxrerXNFPyRYG7mTi1EvfOFY
         5xE+CVEmyQcTqvfAPvhyzNgeruCBNc1ZwmOdDeRoGQYYKTsvfUkBZubruWcaSqyeFk
         gsr8JugLdS+BQ==
Received: by mail-ej1-f72.google.com with SMTP id oz9-20020a1709077d8900b006f3d9488090so7336041ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcVJY5VJphDpNHGQJdr7krO+G4yUvRFeyOLNl4XgZg4=;
        b=3ty0yeUawW+T86IBRIrpKKUYTFwM1/EE49apm/7jnxxia4Cxc2oFlUFe1he+4liJgf
         t+uF0nnvOmzTydiXTpXJN5+2nDz8iZGhTdEZcN+xWN//opOVdpRXDXAmr3cvpf7UA8UQ
         YuO6XMgFal068SxL9gnDcDOgATwAeLH3sq86wgYua5/aDxWawkrm1Kj0qNNxlqhPskGo
         +yrixOSFmYyb9XO0nJ0pzYlzMMSycPipuhyNqYre8xYCpKwVo3Yo3XMsbcbi/gPbiH7e
         ra0KVf/HHKT8EZYGyPFhxAeDwbbGCynaufXtcrq1uRhWz89VJ+L1qFvY1Oy87QHDio2y
         nmlg==
X-Gm-Message-State: AOAM531S60llNc2lOxDP+pF5Zau8AkPW+M1Itg0T6tTl455jR7hZVs3C
        +gPCPg+zYRsV7h4Y2b9MSWx/+yA/nU1/XMMAfJ4ks3L5+aAP8KFWKhwiHgAyvo14PwJDrlhbrUh
        2J0jH3TnYdAKUSaJJcKx4n/EO67SkGDrDYreexQHDOw==
X-Received: by 2002:a05:6402:4242:b0:42b:3266:a7e1 with SMTP id g2-20020a056402424200b0042b3266a7e1mr19713749edb.53.1653379134283;
        Tue, 24 May 2022 00:58:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb/n8XljY2RL9lLzdV+QEAjPgvOA5lXrC4/3YOgrecB5i7dd5q5uw41OWN3TUdwYfISYw33w==
X-Received: by 2002:a05:6402:4242:b0:42b:3266:a7e1 with SMTP id g2-20020a056402424200b0042b3266a7e1mr19713742edb.53.1653379134142;
        Tue, 24 May 2022 00:58:54 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0042abf2affebsm9142442edv.67.2022.05.24.00.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:58:53 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 3/3] m68k: Kconfig.machine: Add endif comment
Date:   Tue, 24 May 2022 09:58:48 +0200
Message-Id: <20220524075848.21684-4-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220524075848.21684-1-juergh@canonical.com>
References: <20220524075848.21684-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing trailing endif comment.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/m68k/Kconfig.machine | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index eeab4f3e6c19..623b6d89f51f 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -474,4 +474,4 @@ config ROMKERNEL
 
 endchoice
 
-endif
+endif # !MMU || COLDFIRE
-- 
2.32.0

