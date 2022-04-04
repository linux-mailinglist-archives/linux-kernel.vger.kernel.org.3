Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8263C4F158C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbiDDNLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345530AbiDDNLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:11:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6446575
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:09:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k23so1866646wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bMiTlc9QLjxR82LwL/Ue57DBVVVkCRSusboB2YZExg=;
        b=dtExrfUweqJrOVONHzBJcZYWG/Mps2ZJ6xSorF50/4N7iFlhhdDySKK0CMVydLmkbx
         TyFf4bPYDThs+WfcBfgDIAjMlHiqdu88yIkZXIVa+qLZruqtQ23sWzpIZi+cmsOccMCW
         V1M/EYZC8cCeolq5Sjy3iU5eCZ89ePGYDUWOAla7tWKiY+Xe2EgN/V8Dx9kU7HtMoSzr
         82yF8XdJ+n1y3ZdOwA/HPvUoT7RVZi5v/IcjKWMWMiOnb4a5jHO8Ae4xodRm+4b/HCaJ
         +X2P/23icqleHpUeng5idAu82fXGj4TCSam3KGWbddKdzezpAQ44FAv+iUbtdXxOTN/r
         pONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bMiTlc9QLjxR82LwL/Ue57DBVVVkCRSusboB2YZExg=;
        b=rNoqv1UZGvzoV/6b7oQ/mE8EUx+n5wCSI1JJmMJPznTf3J3MdSWf5/Azkci36MTw8E
         B7Rfce+A32kZJIIeVhn/N/h5DFFeZhJkMXydAd8vqzDzyzydTKwlZWI1vA/Kvutl2Ecu
         EH5u22N9vCWGVK9fTgHwfvY+uhrdZOZB1hxGMSOwsreOTAQ7FObcz57lK/QoXi9m03JF
         Qf/kbhGa6abG84Delt3kZ83R9NZFGGlLQPgwBSIytJ7dBYHMgo4NCOqPRvYJQe60/YbZ
         wOEtaf6XJ5ry8l2Ar0WtnzCaB8xhbSsog/mt0HPHY049lNHugl9ueVxj8O4I6WyPrLSj
         kHtA==
X-Gm-Message-State: AOAM530VgKlOPTkM4XdLzTxx6WJufywHzxL5BL7D9dOh7uehtZupGQKv
        Nq+2ueBwRl+mvUfV0gkS9YI=
X-Google-Smtp-Source: ABdhPJy7dpXV27Zlj7E5jGVLlqXHlveLKVS7wQ3+PXf6NPT9cWgZsZASQtsvdDRjxosA4SOnqN3+mw==
X-Received: by 2002:a05:6000:1ac9:b0:205:8461:5664 with SMTP id i9-20020a0560001ac900b0020584615664mr16979675wry.123.1649077756336;
        Mon, 04 Apr 2022 06:09:16 -0700 (PDT)
Received: from BHD6QPUW.conti.de ([62.4.90.5])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm17424898wmc.22.2022.04.04.06.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:09:15 -0700 (PDT)
From:   wafgo01@gmail.com
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH] Makefile: riscv: Remove duplicated -O binary objcopy flags
Date:   Mon,  4 Apr 2022 15:08:35 +0200
Message-Id: <20220404130835.108828-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wadim Mueller <wafgo01@gmail.com>

In arch/riscv/Makefile the OBJCOPYFLAGS are already set to -O binary
so the duplicated flags for Image and xipImage generation can be
removed from arch/riscv/boot/Makefile.

The fact that the flags are indeed duplicated can be checked in
.Image.cmd which specifies -O binary twice

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 arch/riscv/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index becd0621071c..c000a1fc8c56 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -16,8 +16,8 @@
 
 KCOV_INSTRUMENT := n
 
-OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
-OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+OBJCOPYFLAGS_Image :=-R .note -R .note.gnu.build-id -R .comment -S
+OBJCOPYFLAGS_xipImage :=-R .note -R .note.gnu.build-id -R .comment -S
 
 targets := Image Image.* loader loader.o loader.lds loader.bin
 targets := Image Image.* loader loader.o loader.lds loader.bin xipImage
-- 
2.29.3

