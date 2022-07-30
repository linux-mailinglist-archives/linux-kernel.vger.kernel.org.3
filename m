Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD27585BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiG3TVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbiG3TUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:20:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82B81707B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ez10so13701872ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=ScMzAp/iFdVUbCt1AUeqrEtgtq+mwTLWTpajmOZrSE8=;
        b=kw7apWRHd1qsweoWZOf4sEKh6YKInX3oUpMyjAwBaHeKrM1Hca5jZF+PLxj3xXb74n
         x5jTx6InS2xFdO3ySVIrIo0wLSP6/Pd0Ci/Yvs410KbNhqhigJR8uhsjAY3M5F5ihvEc
         bTiTO4e4KKHVQP4cxFX6h8o58skcYYaIFkF9ylKEOhiwSxoc1A+ax5tbFkY2lCYc7yM6
         H0cmXu8LUpnDo/E5ZgsALa8pxsY9DT5NlISsxRHe/gk/ol1rdp4ILAa++IjgnYQPqnyJ
         XQ7tKBB+5l92Iiu2OznIw8CgJZ1hFuvtNL4HXmfvP8/VLjwtBc53vknJuePxPC9DOMZZ
         TvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=ScMzAp/iFdVUbCt1AUeqrEtgtq+mwTLWTpajmOZrSE8=;
        b=pyh+0QSM+HeDkGOXh75pw9ZAbvH70gQy/xzzrd4dsVia2bNL0WNgVN7+24bLGqhtSn
         1A0xKH5qMZSzCs0Xo546vk20hsPZedtnQSwpSp0X8dhhDB3rwavfTNYZgTRAHCcW4y5u
         6oduk0oZP059s9aH4XRF/CwINcWmCzf13GYfPG0cjZHFJYcVgRTBuWeGuq2UGkktTAiV
         9yWBeyj1dY/Sxstvs62QasZlxu11fbQ1HlyDew2DIsqCtJvgluKPOBw8L5l7tXdkSntQ
         E8ZXERUe7ngqNy2FXuln7lGBoS5AnCqH9aNdSBHlZFYpc1QLCTOTNOgV4FAmIwOX0baH
         UB0Q==
X-Gm-Message-State: ACgBeo0LRnF1EHm6WDoxw0yk9OwxS7vNtKDBGi6bLBPuAQuOzgrRoyyd
        LUDx2i3+RYAG1zfg1ytsnXI=
X-Google-Smtp-Source: AA6agR6kzaM60NLPi6oOwYzcSDu+S7cv78/ZeLtg9RrjAAgYKfZK7PZRkNMt5HbUWF4ZhJtGzDuIpw==
X-Received: by 2002:a17:907:2c74:b0:730:61c8:d80a with SMTP id ib20-20020a1709072c7400b0073061c8d80amr1026445ejc.702.1659208851375;
        Sat, 30 Jul 2022 12:20:51 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id u1-20020a170906408100b0072fa1571c99sm3262462ejj.137.2022.07.30.12.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 12:20:51 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:20:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: vt6655: Convert macro MACvDisableProtectMD
Message-ID: <a04c74251d82a0f8eaa1e92990cb215465aae41f.1659192760.git.philipp.g.hortmann@gmail.com>
References: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro MACvDisableProtectMD to static function which calls the
common static function vt6655_mac_en_dis_bits_u32_reg. This saves
codelines and multiline macros are not liked by kernel community.
Function name is also changed to avoid CamelCase which is not accepted
by checkpatch.pl and to clean up namespace.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c |  7 ++++++-
 drivers/staging/vt6655/mac.h         | 10 +---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 7633602e47c1..c09d80effc3f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -233,6 +233,11 @@ static void vt6655_mac_en_protect_md(void __iomem *iobase)
 	vt6655_mac_en_dis_bits_u32_reg(iobase, ENABLE, ENCFG_PROTECTMD);
 }
 
+static void vt6655_mac_dis_protect_md(void __iomem *iobase)
+{
+	vt6655_mac_en_dis_bits_u32_reg(iobase, DISABLE, ENCFG_PROTECTMD);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
@@ -1480,7 +1485,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 		if (conf->use_cts_prot)
 			vt6655_mac_en_protect_md(priv->port_offset);
 		else
-			MACvDisableProtectMD(priv->port_offset);
+			vt6655_mac_dis_protect_md(priv->port_offset);
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 66e03e8173ea..3a9721624cff 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -12,7 +12,7 @@
  * Revision History:
  *      07-01-2003 Bryan YC Fan:  Re-write codes to support VT3253 spec.
  *      08-25-2003 Kyle Hsu:      Porting MAC functions from sim53.
- *      09-03-2003 Bryan YC Fan:  Add MACvDisableProtectMD & vt6655_mac_en_protect_md
+ *      09-03-2003 Bryan YC Fan:  Add vt6655_mac_dis_protect_md & vt6655_mac_en_protect_md
  */
 
 #ifndef __MAC_H__
@@ -546,14 +546,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvDisableProtectMD(iobase)					\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvEnableBarkerPreambleMd(iobase)				\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.37.1

