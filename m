Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E2585BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiG3TVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiG3TVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:21:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF811A2D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:21:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id os14so13760953ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=uoHNcIjYvVZqJisWxXcOOSOxiOgF7GrC4J54f5gJBt0=;
        b=Qmk/bNckYvraHA1It20FdjHfRhkySURaZkEScXU9hi5lyg16rH4MHOQA70PN3MitxV
         yEgulGP06o+nEpBuKpw34g7j70Lb6yk48HbgPNSSS+SWQhQ3k1vSal3WI8DrDZz6WRir
         ++6XzMh+sxzmEWr4Aa2j4922Nak20vr0iiKF5mmexArgByS7pPQEnBAD0nPNpO3Rbi/0
         NdJJ5YNEkfGb0icfpX0BNyOw/6CmlpELcGRJOor8EnJZndA+5OtUb7eMqvQEhEVdxM4w
         +OrcAJ184YfCW1PTR72eptaCuu5tyrmECWLXdKMwfTW0KAJoOHM7l8LBK07x0HjQvI8U
         XJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=uoHNcIjYvVZqJisWxXcOOSOxiOgF7GrC4J54f5gJBt0=;
        b=69UBSmglZp/fQX06JwlJWO/vfSU23j10TIavyTcwjWWd46N0jhMK895XWo34O+E04H
         XJquyceT4JqYbE6DvUIRm1PHWUiloQFZJcpvsQH62PvfEB6ybWKcHeOooP8q5rXXZMny
         n1jvK3cuL5+gKFYDm4qXWw2UF5w7RRCkdV3XgvVQaMl2Ef3qn74II5/EohadtmP7O19U
         l36h6I6wG57+YhsEQFO4v4jx/zPXZYjJ1jdKtKgg5sCC46EaM1rhT1p9LbrrQ+MLtzGh
         QTrILyQ324pSfsz9cQEjNZLV0S4e2+kUydebrrnmhoIizNAHveSxJcCqgcEkm8gBIsTc
         dkIg==
X-Gm-Message-State: AJIora96VZqemYKRRkAq0aryoDSpRMQfsXPBHKzQF4LXMEFwkD3sFyoz
        NIHkTb5QWIvRraNjchsdSr8=
X-Google-Smtp-Source: AGRyM1ucG/gRuy6TcFDN4BHzu6BNmw9kD+voS1BGi4wDDQ/N0XbOhwY6/x9N8exRPo0+7o3AJ6AjPg==
X-Received: by 2002:a17:907:2d08:b0:72f:1dff:edf5 with SMTP id gs8-20020a1709072d0800b0072f1dffedf5mr6999117ejc.391.1659208869899;
        Sat, 30 Jul 2022 12:21:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b0043ca6fb7e7dsm4158626edx.68.2022.07.30.12.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 12:21:09 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:21:07 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: vt6655: Convert macro
 MACvDisableBarkerPreambleMd
Message-ID: <e5bc3828530d711496368a3bfed34e75fdb65887.1659192760.git.philipp.g.hortmann@gmail.com>
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

Convert macro MACvDisableBarkerPreambleMd to static function which calls
the common static function vt6655_mac_en_dis_bits_u32_reg. This saves
codelines and multiline macros are not liked by kernel community.
Function name is also changed to avoid CamelCase which is not accepted
by checkpatch.pl and to clean up namespace.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 7 ++++++-
 drivers/staging/vt6655/mac.h         | 8 --------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 5ca8a302011d..6efa79e8a651 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -243,6 +243,11 @@ static void vt6655_mac_en_barker_preamble_md(void __iomem *iobase)
 	vt6655_mac_en_dis_bits_u32_reg(iobase, ENABLE, ENCFG_BARKERPREAM);
 }
 
+static void vt6655_mac_dis_barker_preamble_md(void __iomem *iobase)
+{
+	vt6655_mac_en_dis_bits_u32_reg(iobase, DISABLE, ENCFG_BARKERPREAM);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
@@ -1481,7 +1486,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 			vt6655_mac_en_barker_preamble_md(priv->port_offset);
 			priv->preamble_type = true;
 		} else {
-			MACvDisableBarkerPreambleMd(priv->port_offset);
+			vt6655_mac_dis_barker_preamble_md(priv->port_offset);
 			priv->preamble_type = false;
 		}
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index fd95f49aa739..012388bf8d3b 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -546,14 +546,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvDisableBarkerPreambleMd(iobase)				\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvSetBBType(iobase, byTyp)					\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.37.1

