Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4757B52EB76
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348962AbiETMDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbiETMCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:02:53 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275C415E48E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:44 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 156763F213
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653048162;
        bh=inh+fWbIr/Bd67tkllRc1lC2WFfhluEbQ0iFzzDcLrU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s9DCpMa7+W0aG582djOY0dvYB3T+is522cwUkgo+1mVOV9/tYcanLXw00plsdJ7Yr
         8Jr7ThyQzoXOu9pQVY+IKwc8EbnnvOiWQ3pIydtH7duNr6eUd5X7Js7WPIi81h7yAf
         GzyWGCQh5GuopAqNefq75xGuTn+X3zNqcRDKFR9rtMVKx662DLFZvtAau7n2UBYha6
         YtKvg77pgtI3FOyP8qmcEbqoNzEFjNpzCSTsRpGrzZCjmlhYPwMHLRN3Oy2QJK2++a
         g2xnIVBkg9E58cDi1/ZNZvQgNjIqloneUdQnfDDoS/E8dBnC/obwEvn0uYfF6kvl8i
         kddcjoOs/1MIw==
Received: by mail-ed1-f71.google.com with SMTP id g10-20020a056402180a00b0042ab515d6c5so5484692edy.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inh+fWbIr/Bd67tkllRc1lC2WFfhluEbQ0iFzzDcLrU=;
        b=rGLN5SOf22Su1v8sfopbOKknFJO4yA+FX5TkJix6e9BnrHRueDPdec0R9sgpXy8tJ5
         gLgFkoDv3GCDnJwnYCMJcORx19cw/neamzQOdcsvfOvET5td2D6n6clR1WyYG8rcGchn
         hKIYkENYa7U3tan7Pguh07qoRMXjUEwBrOpIizbpWTYqyFdMV9pq7Tb3SwaJCzKpYdp1
         nc29kxGXN5vmr/xhQ4egZ+hc/mtkFiBOd5EMu+xbAlUmMAVBLUgUufFwQY82PO9SlCYv
         TgFngFraVohJPzyb8QywDqJhsndm0/wXDYDt/TwbtDzUoFBihj3AjFTPlbwTwwrU/B38
         KT0w==
X-Gm-Message-State: AOAM532y5zncrSlDekm6oYzyl7/ZZoViap/tYMI9lgh5uylm4RA276du
        +X6Yx859VrNmYakegoE0vhwqECPxIXEOECpSpblYttTq+RVqRlTFmx4X+iQOiJ7LEQ172WHkOEt
        ijAVS6AWsj4BmhBpusA48cE8gtB53mvujvx0YgXLLKQ==
X-Received: by 2002:a17:907:6287:b0:6e1:6ac:c769 with SMTP id nd7-20020a170907628700b006e106acc769mr8584226ejc.388.1653048160115;
        Fri, 20 May 2022 05:02:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLo7j6dIaDOh3PNDbQKIoRVWD3XVgyw32vGanJTzDPhngStWix2JFCu4iM6l3wsA+bjA2SFw==
X-Received: by 2002:a17:907:6287:b0:6e1:6ac:c769 with SMTP id nd7-20020a170907628700b006e106acc769mr8584173ejc.388.1653048159593;
        Fri, 20 May 2022 05:02:39 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id fg22-20020a1709069c5600b006feb002a620sm560042ejc.1.2022.05.20.05.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:02:39 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 3/3] riscv: Kconfig.socs: Add comments
Date:   Fri, 20 May 2022 14:02:32 +0200
Message-Id: <20220520120232.148310-4-juergh@canonical.com>
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

Add trailing comments to endif and endmenu statements for better
readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/riscv/Kconfig.socs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index f6ef358d8a2c..c831609db249 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -79,6 +79,6 @@ config SOC_CANAAN_K210_DTB_SOURCE
 	  for the DTS file that will be used to produce the DTB linked into the
 	  kernel.
 
-endif
+endif # SOC_CANAAN
 
-endmenu
+endmenu # "SoC selection"
-- 
2.32.0

