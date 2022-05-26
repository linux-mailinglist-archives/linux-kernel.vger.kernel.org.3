Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99A3534B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbiEZISZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346686AbiEZISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:18:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955148305
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:18:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y189so1099113pfy.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHMg2tAJOCenEiVm0R3x4NJY3ZvV5XmmBxrfAtuHiRM=;
        b=KnBx9YtN4b+GHS/KrRRe1SpvKu6kRXIFzBpZd7W9JnOP9J8tVct8iNortVjqqF14aA
         7Y7r5AcJR6yBjtzcjVkTOsdqQHuPcA64ml6RkKoanCxSAnp+OL7/goCls8BaRmHAnXy6
         5say0/yA7Q9/ccwhzw8oQP9Kyeiv4TnPFeSIrn6TtI9cF3ZyHFP5sKzx56q0h5NzjFh2
         2KTAVj7P2agyaO4zzY30snaN0dFpM/zUBo5uxyWcNrFiXn7G4dLNeQ6xVj+mq3gl1DW4
         GgGiSn+DDC0eJDqPITF/TY4ucOzgVACUNMoQxJhXhqICIOkjsNGh0UKGmmaHsBZX3ETe
         ZsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHMg2tAJOCenEiVm0R3x4NJY3ZvV5XmmBxrfAtuHiRM=;
        b=tE0rn9bkx7YGxLSsTKY5iXUDleHzT4SECQbbdYv8MCtohs7PCwCs7yxx+fk9E/7tyo
         /CjGYhDNxgUrWRT0j6RQJB8DZikkrNTmI5epXdUcmzKtrAnk8pVOX+44KxWOqi0SqNhi
         fq7Z5ludT5z1ZedcWZD6G42xODkd2L++kFHH+42AxSt5W58TULaUiPA2iv5IXcaWiYuS
         PbY555kOxGSGuq5JgRZH9G89tEB7oXowpiYi9wUEwdcf7gradXCU2FbzFpqgGl+yImbu
         +gG+S2uyGr3cBJfjY1pqDerY2YVkPjLONB4MXYRi8M0yuNqc6cw8YrgGUax26VsE57yI
         8eRQ==
X-Gm-Message-State: AOAM532xSw+fa+ax5v+6XB3ujavy0MBol/ynHmjCr7J8/ibQWhyAjDUn
        BHEqVhbky8RdEJDoQDk7UgM=
X-Google-Smtp-Source: ABdhPJwa3Ta0ib9PrN7P+QnvubHC3BGs+cfN2XyBZuN/FssHGW+YpSwHz7QhClmqcA8h5g9+B09wPg==
X-Received: by 2002:a65:5188:0:b0:3fa:6081:7393 with SMTP id h8-20020a655188000000b003fa60817393mr15297881pgq.72.1653553083916;
        Thu, 26 May 2022 01:18:03 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u2-20020a17090ae00200b001dcf9fe5cddsm827824pjy.38.2022.05.26.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:18:03 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: integrator: Fix refcount leak in intcp_init_of
Date:   Thu, 26 May 2022 12:17:56 +0400
Message-Id: <20220526081756.32998-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: df36680f1a71 ("ARM: integrator: core module registers from compatible strings")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-integrator/integrator_cp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index b7eb4038798b..bb301ca8c7e1 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -126,6 +126,7 @@ static void __init intcp_init_of(void)
 		return;
 
 	intcp_con_base = of_iomap(cpcon, 0);
+	of_node_put(cpcon);
 	if (!intcp_con_base)
 		return;
 
-- 
2.25.1

