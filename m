Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7994B4F0811
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiDCG1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 02:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiDCG1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:27:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B4369C8;
        Sat,  2 Apr 2022 23:25:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so50461pjy.5;
        Sat, 02 Apr 2022 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ln+ipvTDeyqH22NPT0mkIhLM/Lhh8eFnXKg/BK4KII=;
        b=PesS8Gv/q/M/zbWHp/BYGzM5SC5p+Eec8q+PL2AG+1t+kuOOYKv5ueafawve4YshBL
         aJ7hnxNPL5rNlBlPIGSf/eJie5s3VW3BvZkWmJ7O1/g1weRm/9FfHvy7AYDIoNUlZJpQ
         f9Fnx7LOGhi2b3YrDWVK38zv/ePEkUS3I+5PabhOWeJ2KnkoIRgGNjFi+G+IizWInAl/
         6RHJRFWK0L6oLABhhjrlWo65tvNzcqPr9u0xjYJx+WO+NoQmAb2tKK+FdYmOktLgazU3
         szbFJXzXZyIEx1jwHiHuywFkzeCABiz+s6z3uwvBesm5D9pP9XK9gP9YZBfCvm9hDS47
         evMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ln+ipvTDeyqH22NPT0mkIhLM/Lhh8eFnXKg/BK4KII=;
        b=JKcFiGBL+ltTK76mulH2k0d7njcDPtiw/kOyUAUfS52mOTYZNxVfYcUvW30+md1iIR
         eNmEBda1IUVVlBVr18GbOH/5AdHe7J4DCtU5kzDJM6EAoqOnWVwoqqxm2AjVPNd2GOHr
         pA3kSZV0KcG+33EvMPDz39rB6sHaUt2EOW5JwFVcz2B0yLo5/2j5xh1i01+C5mwRtZUm
         aKRYhYbCIk4flRGbkVnKvFWVNWwnMUgVSyp1yfGGdB07S3bf/020jGVvm5WGbloDoxpK
         VFukgrbWBMd5fWaPIKDKQzMte7CGskn0aFpjpfYUJD7o178+EgH7hO4B1oNaA/4PY0i8
         zXzA==
X-Gm-Message-State: AOAM530XRncjjeOT7WtYLd7poC6zDhIxrfYvbr1Klq9AuutK7Sy0RN/n
        5zx7WJ81a2X9twxd5W+uu8xYCzRhaYs=
X-Google-Smtp-Source: ABdhPJyP+oDLt5zblk1Nq5q5/xQsQ6hoHiRTswQIjsOtXphu0rQxE8hQzi43TIUdgoC3PttbflEPGw==
X-Received: by 2002:a17:902:bd46:b0:154:b936:d1df with SMTP id b6-20020a170902bd4600b00154b936d1dfmr17850493plx.73.1648967107184;
        Sat, 02 Apr 2022 23:25:07 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm7731471pfv.48.2022.04.02.23.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 23:25:06 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, knsathya@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] Revert "ACPI: processor: idle: Only flush cache on entering C3"
Date:   Sun,  3 Apr 2022 15:23:22 +0900
Message-Id: <20220403062322.3168-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 87ebbb8c612b1214f227ebb8f25442c6d163e802.

ACPI processor power states can be transitioned in two distinct
situations: 1. when CPU goes idle and 2. before CPU goes offline
("playing dead") to suspend or hibernate. Case 1 is handled by
acpi_idle_enter or acpi_idle_enter_s2idle. Case 2 is handled by
acpi_idle_play_dead.

It is necessary to flush CPU caches in case 2 even if it is not
required to transit ACPI processor power states as CPU will go
offline soon. However, the reverted commit incorrectly removed CPU
cache flushing in such a condition. In fact, it made resuming from
suspend-to-RAM occasionally fail on Lenovo ThinkPad C13 Yoga.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 drivers/acpi/processor_idle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f8e9fa82cb9b..05b3985a1984 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -570,8 +570,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
-	if (cx->type == ACPI_STATE_C3)
-		ACPI_FLUSH_CPU_CACHE();
+	ACPI_FLUSH_CPU_CACHE();
 
 	while (1) {
 
-- 
2.35.1

