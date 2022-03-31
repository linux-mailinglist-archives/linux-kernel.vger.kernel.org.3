Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244A94EE366
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbiCaVoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiCaVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:43:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA623193C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lr4so1939744ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tl+abEk2PyVrmhO7p7RNjL4a5VH5DFSlOT0dssPwTU=;
        b=VKJB8zPnr2cnSo7lDUdwKt/ugZRsj7PJU+d1bk7ugxrm/pFrVlRwlX1ClE+Nd8nrDh
         iVz5vHZnPXad9WnpC/iP+r5Y0Dljw/BGW+92gGuTScIZt7ca9H5HGudWFc9OHkvIV1di
         m2h2di+fwiWHgboGzpOjG0UsVi4N4oHQlWxXOsVQ0JLKCOMFWhfdmDipxQBhiXBboegu
         kTgz+Rlvd2BtwRxlBCcdQqJCQzC06vMhxAhOKkFX6id4aG/3i45mXyrWaaW4mpLbcvtg
         iWN/eOszBpY0c/njC90H8g+hKnqLhYyeBoi8EE75H1Ve0vRR9wVMYC4yDdk2nrRGrrpe
         MX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tl+abEk2PyVrmhO7p7RNjL4a5VH5DFSlOT0dssPwTU=;
        b=yjNmo2EAaj8e3DuzHzA0+BEPSt/TZReIDUT0vceiSeUzztxtFR0lBfiFBSFx/UF4cK
         jIp3j6pgg9MKK1hi+TVg9VDtmkHRBQjgBxVNsXx3pvDBx8yKCiTAvDeddnYjiqTtXSCG
         jUYqm0HMbLsjqwEtxo2aK/0xDnLe8pid0W86P356MutAakUoGLQnzlBj4mlCp2QHlTBi
         jUuUY6X0b65y79kY/+45RTHpnCDQuRqYVtwkaEJhNqg9g0bwF9ZJlFfPiAKKy7Z4sJkb
         M8w6KCT6tMYNAVokG0Hpsd0510DkRs2zEZB26tbOEEqvzcqzR2/NEVvtO4vP5AlzBWY2
         9Ehw==
X-Gm-Message-State: AOAM5326Xnnq9EqY8U2Yw9Yo5v2zH8Ffhu1xw9XNK/RtVkninbxtzjBT
        6F+2cdFJsu3miYKuS26eAE8=
X-Google-Smtp-Source: ABdhPJxD34qnPE8PvQJDXHTCK74/miGsHi2m+v0+QcWvXA0i9oEf8Xv8c9Azy3RhyZHWin1GJlAC0g==
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr6376283ejc.249.1648762925545;
        Thu, 31 Mar 2022 14:42:05 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id dn4-20020a17090794c400b006dbec4f4acbsm244387ejc.6.2022.03.31.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:42:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: remove 5 GHz channels from ch_freq_map
Date:   Thu, 31 Mar 2022 23:41:45 +0200
Message-Id: <20220331214146.15161-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331214146.15161-1-straube.linux@gmail.com>
References: <20220331214146.15161-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Realtek documentation the chips this driver supports
are 2.4 GHz only chips. Frequencies for 5 GHz channels can be removed
from the ch_freq_map array.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_rf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_rf.c b/drivers/staging/rtl8723bs/core/rtw_rf.c
index 96eb8ca38003..7e4bf42fd1ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_rf.c
+++ b/drivers/staging/rtl8723bs/core/rtw_rf.c
@@ -18,22 +18,6 @@ static struct ch_freq ch_freq_map[] = {
 	{1, 2412}, {2, 2417}, {3, 2422}, {4, 2427}, {5, 2432},
 	{6, 2437}, {7, 2442}, {8, 2447}, {9, 2452}, {10, 2457},
 	{11, 2462}, {12, 2467}, {13, 2472}, {14, 2484},
-	/*  UNII */
-	{36, 5180}, {40, 5200}, {44, 5220}, {48, 5240}, {52, 5260},
-	{56, 5280}, {60, 5300}, {64, 5320}, {149, 5745}, {153, 5765},
-	{157, 5785}, {161, 5805}, {165, 5825}, {167, 5835}, {169, 5845},
-	{171, 5855}, {173, 5865},
-	/* HiperLAN2 */
-	{100, 5500}, {104, 5520}, {108, 5540}, {112, 5560}, {116, 5580},
-	{120, 5600}, {124, 5620}, {128, 5640}, {132, 5660}, {136, 5680},
-	{140, 5700},
-	/* Japan MMAC */
-	{34, 5170}, {38, 5190}, {42, 5210}, {46, 5230},
-	/*  Japan */
-	{184, 4920}, {188, 4940}, {192, 4960}, {196, 4980},
-	{208, 5040},/* Japan, means J08 */
-	{212, 5060},/* Japan, means J12 */
-	{216, 5080},/* Japan, means J16 */
 };
 
 u32 rtw_ch2freq(u32 channel)
-- 
2.35.1

