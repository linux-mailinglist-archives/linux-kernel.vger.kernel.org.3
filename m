Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703B74DC36B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiCQJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCQJ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:58:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56B1DB89B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:57:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t14so2272759pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aqd13vjNDpVx0WeTfC9/qLR5OLkiQQEKuiIIW/XENXw=;
        b=lQPxXa9D3nukURQD+NxAM991DrHSXuJKdXqDl6wDcZhDjLc4mrPLQxFu88Wy9h+PO3
         lRccAKtIJA85/JGVLzDzhoKrn6aYXRU5viXeL2dZDwqnDgAYoYMBU3/UByTGUGiwott/
         vCRZB67M7YB3A1Hd3l+MLe2cnTP/7jdr8ywdvESSyfJj2KsM264OaANcVTmAYZa/d0B9
         NEKmkOK9Qh8GWPoohGNDsV0u1qbKz7y05RiohvN0pCoMKahYDQ+CPQVVcXFXD5afQbvw
         DGYBXByfYUyseE1ilosVST8ojrxHOuvcwRBk6ld5CQ8XpitDx2iLQ9P3A79vf9OZbqnR
         Znhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aqd13vjNDpVx0WeTfC9/qLR5OLkiQQEKuiIIW/XENXw=;
        b=Mi/diE6P5VK64iSBwN7MQAKuasTOihiBrhvESvpeUFkFmC8VTglxjSZtSA6v6fbtIX
         EHqKYAfwfqMEdaJYPZQ6cyIH//yeM9MHl6ymogiIoU3LOI+uIatmkPZXP4N72eFgclji
         Z++TBWxI6oJ1zoksHpY0VTq66kr07iJl7jeBgXPS3qJUmEprGV2l/IYrBTTXMX9rjBCA
         vsGawScobuaVBFrbOkvL0CRg9idSPOYhN0+NDItwn0kDMUm3JsFc4b+mdcNbIMg8AY7k
         eoG8u82RET42/IV6ak5ikA5CdmiBV7RWiRhbC4AqQE87YFCnfNx7ZXO8DahXWXVDttMz
         2RGA==
X-Gm-Message-State: AOAM5334c3G78rhXzhzifquOKBBEtmZ/Mrqv5bxJn2r2kIW0MEw+EN3+
        k+WR9x3vs+eTc2rOuQNCL2EY6qTqcdKbGA==
X-Google-Smtp-Source: ABdhPJwYLg8qhLOD4aUNfAdMiE4c+p3yk2zQOGuvfgGlfdzybwxZDDWdJxG2PpCehb7cVcRGRfo0Aw==
X-Received: by 2002:a05:6a00:319e:b0:4f6:dedb:6c52 with SMTP id bj30-20020a056a00319e00b004f6dedb6c52mr3892672pfb.31.1647511031049;
        Thu, 17 Mar 2022 02:57:11 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:c47:388f:1ca6:c00c])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm6199541pfm.207.2022.03.17.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 02:57:09 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix DTC warning unit_address_format
Date:   Thu, 17 Mar 2022 02:56:57 -0700
Message-Id: <20220317095657.2331492-1-jcmvbkbc@gmail.com>
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

DTC issues the following warnings when building xtfpga device trees:

 /soc/flash@00000000/partition@0x0: unit name should not have leading "0x"
 /soc/flash@00000000/partition@0x6000000: unit name should not have leading "0x"
 /soc/flash@00000000/partition@0x6800000: unit name should not have leading "0x"
 /soc/flash@00000000/partition@0x7fe0000: unit name should not have leading "0x"

Drop leading 0x from flash partition unit names.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi | 8 ++++----
 arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi  | 8 ++++----
 arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi   | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi b/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi
index 9bf8bad1dd18..c33932568aa7 100644
--- a/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi
+++ b/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi
@@ -8,19 +8,19 @@ flash: flash@00000000 {
 			reg = <0x00000000 0x08000000>;
 			bank-width = <2>;
 			device-width = <2>;
-			partition@0x0 {
+			partition@0 {
 				label = "data";
 				reg = <0x00000000 0x06000000>;
 			};
-			partition@0x6000000 {
+			partition@6000000 {
 				label = "boot loader area";
 				reg = <0x06000000 0x00800000>;
 			};
-			partition@0x6800000 {
+			partition@6800000 {
 				label = "kernel image";
 				reg = <0x06800000 0x017e0000>;
 			};
-			partition@0x7fe0000 {
+			partition@7fe0000 {
 				label = "boot environment";
 				reg = <0x07fe0000 0x00020000>;
 			};
diff --git a/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi b/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi
index 40c2f81f7cb6..7bde2ab2d6fb 100644
--- a/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi
+++ b/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi
@@ -8,19 +8,19 @@ flash: flash@08000000 {
 			reg = <0x08000000 0x01000000>;
 			bank-width = <2>;
 			device-width = <2>;
-			partition@0x0 {
+			partition@0 {
 				label = "boot loader area";
 				reg = <0x00000000 0x00400000>;
 			};
-			partition@0x400000 {
+			partition@400000 {
 				label = "kernel image";
 				reg = <0x00400000 0x00600000>;
 			};
-			partition@0xa00000 {
+			partition@a00000 {
 				label = "data";
 				reg = <0x00a00000 0x005e0000>;
 			};
-			partition@0xfe0000 {
+			partition@fe0000 {
 				label = "boot environment";
 				reg = <0x00fe0000 0x00020000>;
 			};
diff --git a/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi b/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi
index fb8d3a9f33c2..0655b868749a 100644
--- a/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi
+++ b/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi
@@ -8,11 +8,11 @@ flash: flash@08000000 {
 			reg = <0x08000000 0x00400000>;
 			bank-width = <2>;
 			device-width = <2>;
-			partition@0x0 {
+			partition@0 {
 				label = "boot loader area";
 				reg = <0x00000000 0x003f0000>;
 			};
-			partition@0x3f0000 {
+			partition@3f0000 {
 				label = "boot environment";
 				reg = <0x003f0000 0x00010000>;
 			};
-- 
2.30.2

