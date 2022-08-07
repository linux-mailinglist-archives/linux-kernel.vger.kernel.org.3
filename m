Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F0B58BC45
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiHGSOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiHGSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:14:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520A9583
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:13:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f22so8925832edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=VP/KKkIUNQwmK/Lbxdjw2+ts47zQFWqZhW4ZLZ9vpOc=;
        b=JkD41WlYO/1YezLjNDCVBFgaskAYKk3CyHrN/I0dDy7W00OfgfLekpYiKFLhkuKmod
         D7JqaZV20QKzGyte258FcETHbgz79KxFU8YotPYL8UdTCOtE6mC4FwGMS1Cw4PY8hxpu
         DpKYWdfBxFbgJojsBM6RZ4slxncdSh9ZSOlgoHsdbzFmk+Hgw89vjZRDnVjcoARiuKL7
         dTD/GE34LQpNKUC5YSoPI/boBBbLUrug6HpkSCTT+vt1J4+zalziIRkLcSTbZyN15z3q
         o184F3sbe5bPcYpH45a5r4jnNhVJBWbVdN17h7ZYIjWTh0+h0vGXQH3rMKFp5k85zNqZ
         fCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=VP/KKkIUNQwmK/Lbxdjw2+ts47zQFWqZhW4ZLZ9vpOc=;
        b=ZnM9ELsQNs/Yan4T7r4Qbe7S11FJeh2dFEdDmoHVHmilN9AgWa5yxr9Fi6Y9UI4ouV
         G5TCpOHs88SSJd5icXZkp9/S2SWE9mpRkm8tITF1Kqqip0vIDevJrh1JY7qVlSN9WDxk
         ZuW6EO+95vhyNp4Vy4XNUpnA8+7jce6Cr9sl5K2V8+iY8LWu55tECOkQzsKu2Lhlj1br
         XAdCck1igIx8q7/8BAW2cl5EJfhbocBzJfnmL+O8RUqGDcQ+k2kI6Pq0s7gRcRlcvPV6
         geCzlANbPREGS04iuN6xiCxirgnmcJN20KNaFb7l2iwXCCBbaDK6BldTFx9YvqkdYIvE
         aepw==
X-Gm-Message-State: ACgBeo0IIF0iNaju8mGbzwtROS49LDOb3tF1s4XPHnCZG5monbk/E1ZG
        VYMnPgXB9Id6o9t7KRBkdIM=
X-Google-Smtp-Source: AA6agR5NLfEBuWbhHw9Au5cYdfb0rpy5Ezpjl8QLqICxFOW3L6xzGfIiLo2RHCvjN6d2+p2CT6YC5w==
X-Received: by 2002:a05:6402:331d:b0:43d:9e2e:6966 with SMTP id e29-20020a056402331d00b0043d9e2e6966mr15470087eda.214.1659896033293;
        Sun, 07 Aug 2022 11:13:53 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b006fee98045cdsm4115660ejf.10.2022.08.07.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:13:53 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:13:51 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] staging: vt6655: Convert macro
 MACvEnableBarkerPreambleMd
Message-ID: <542b9f8c0b10aa3db143b22f7425ab5bddc5bffe.1659892671.git.philipp.g.hortmann@gmail.com>
References: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro MACvEnableBarkerPreambleMd to static function which calls
the common static function vt6655_mac_set_bits. This saves
codelines and multiline macros are not liked by kernel community.
Function name is also changed to avoid CamelCase which is not accepted
by checkpatch.pl and to clean up namespace.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Changed used function to vt6655_mac_set_bits
---
 drivers/staging/vt6655/device_main.c | 6 +++++-
 drivers/staging/vt6655/mac.h         | 8 --------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 96945fb8d536..46bd88ee4668 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -244,6 +244,10 @@ static void vt6655_mac_dis_protect_md(void __iomem *iobase)
 	vt6655_mac_clear_bits(iobase, ENCFG_PROTECTMD);
 }
 
+static void vt6655_mac_en_barker_preamble_md(void __iomem *iobase)
+{
+	vt6655_mac_set_bits(iobase, ENCFG_BARKERPREAM);
+}
 /*
  * Initialisation of MAC & BBP registers
  */
@@ -1479,7 +1483,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
 		if (conf->use_short_preamble) {
-			MACvEnableBarkerPreambleMd(priv->port_offset);
+			vt6655_mac_en_barker_preamble_md(priv->port_offset);
 			priv->preamble_type = true;
 		} else {
 			MACvDisableBarkerPreambleMd(priv->port_offset);
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index a7d6254fded0..3400ea15b673 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -543,14 +543,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvEnableBarkerPreambleMd(iobase)				\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue | ENCFG_BARKERPREAM;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvDisableBarkerPreambleMd(iobase)				\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.37.1

