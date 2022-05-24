Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4899B53240A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiEXH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiEXH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:27:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9CA21276
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:02 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EDB033F1D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653377221;
        bh=FZJ29gR3RITTCNW7L3h9rL5l5X5VZ+qG2aniJR7EDIc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QM3zMHrpeLkclZR6XOgSacuk8ShWCjhoopd+gxfesNkErLGc3V1DHAxC+Vn/075ip
         u1qFoyGawEun/ar1VfwWsPMVl0YUynTGJV4P5uruiGoW/wDFBqautnqzubm/8GkKEP
         H1Zi9MdGjx51HA9YOs/eVaxG7A5tg/CCMwXJ71IvvlCRDuUiMT2EDS1tSpC6zaLYNA
         uFY+v8OSyxpKFSqZyRTcRdNirD7Y0mtLp1vYHPxTLjugRu6sKT+Fn09t8zDz7WBPoZ
         f7MNzZp9RGfasmLmrwe0gHGkkK9oUMQlMHZdvtnsCZ7IbJv1TaQmtSspggegl9N7GC
         Wgb4qOuG6byOg==
Received: by mail-ed1-f71.google.com with SMTP id g10-20020a056402180a00b0042ab515d6c5so12053930edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZJ29gR3RITTCNW7L3h9rL5l5X5VZ+qG2aniJR7EDIc=;
        b=y7vPBlJBfvWC49Dma6W8eZtObMe3KsAme7wOJFn279nEMFRXeStrMwmnbricw1j2HD
         psiEN0Jn4O3D9CWtzRkKxT+ZJBU0PdiXBuCiOmhtNSWj/YgnQq2DZ3339L0G/V1zdR4O
         QFrGN6YiOk89dcMbFA/SGi7sZisuKeIYhhNJbo9lP+oOqHrcwwbCdJi8mrBz0WacssKZ
         jbDkOnt2roHqM4gkWRmOujUdkGm3X44sNfqgdSS5bCJJFlKK9xgpG5G7YszQJPS7qdSb
         rVOrLL3S361h6ECOJZEt2UgKuRATbp2gGsg+1OB0qE6GHcYfvNBjDCNuy5BZhxKQFEom
         bKZw==
X-Gm-Message-State: AOAM531YdqSLEKlQY17WsIUJ+gak0hydSnzk2oLzR7cySl6YZi27/1Uh
        0LpEJLLwGVezkrAWCow2cMse8RBzYrnjBlmLqqdhQ+HxzUXu8klixa48BGt5ahTcptxZqG3aSgR
        G4FqivhrGCB9AVWYod72O0//saWp3IB+XJOL+2Fl0Cg==
X-Received: by 2002:a05:6402:11c7:b0:428:5fdc:80c5 with SMTP id j7-20020a05640211c700b004285fdc80c5mr27465547edw.332.1653377220808;
        Tue, 24 May 2022 00:27:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa6H1EqXzLXKi+lLTrxdQTXlf+LwLMdZLhjn6vZhDzCLbY7I1InithsB8YgoGh6Ptrk44U9A==
X-Received: by 2002:a05:6402:11c7:b0:428:5fdc:80c5 with SMTP id j7-20020a05640211c700b004285fdc80c5mr27465539edw.332.1653377220655;
        Tue, 24 May 2022 00:27:00 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b006f3ef214dd2sm6924353ejw.56.2022.05.24.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:27:00 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     ysato@users.sourceforge.jp, uclinux-h8-devel@lists.sourceforge.jp
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/2] h8300: Kconfig: Fix indentation
Date:   Tue, 24 May 2022 09:26:55 +0200
Message-Id: <20220524072656.20152-2-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220524072656.20152-1-juergh@canonical.com>
References: <20220524072656.20152-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/h8300/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index fe48c4f26cc8..0dc57672d93e 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config H8300
-        def_bool y
+	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
@@ -36,7 +36,7 @@ config NO_IOPORT_MAP
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config HZ
 	int
-- 
2.32.0

