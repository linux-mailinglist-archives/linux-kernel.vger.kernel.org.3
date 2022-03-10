Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C34D522A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbiCJSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245654AbiCJSzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:55:23 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4162192C81
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:54:21 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so14151955ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fhARwSk59a5Uz7mUXe+CSmtNlnGMtOE8WUL+HBpEL8s=;
        b=gJEiZ5pbFpu+Q5+e+mj4H5b3YtUTfxZmHD8SIR5M/zWqCaq5N8hA0lxcB7vaAh1pWQ
         QVzybmLIeF6C6jI/Q5TeraMf2FkGBPD+5nGloD3CYUWKX94gU2pguKxdb15cChgH8oJG
         0Z/IPEbvneAkEm/Itlec/wVgMC9tAAKdO3Xq8ovwd2a3NsmUnWbmJPzhhiNTXXbDvABI
         Y8j8+/8B3Mfwq4EHl+ZhzZk28250Vrnnz2TdfSCH1Ht0hZLKAkyJ7hXLALXg8eJ78w3z
         NgJ2zXW1y1+5rOy1xrz5eQvswO0KC9eQOJo1lqCQdFrKaG0jP13+BxnSvCJJTwVQDppI
         pGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fhARwSk59a5Uz7mUXe+CSmtNlnGMtOE8WUL+HBpEL8s=;
        b=JTklnFgfGEVogLIyY6fkF+t44QyiI1av5svD7SmUNNx59EXSrWNqncnWsLIaayjeA/
         bbUAjgpYxRp/uWM0cLP6O56OPhkvy+E6cqqA78H4dei8GoIS581WsbUMNE/MmYzLjuAM
         N6KvSB8LvjCal95g0fMoiJSF4unafis786YZGfLd9Q71T0+wKEnM+IZN3yOKIzsM2/a5
         yLp5PD69P6+aSIQ4CGUSXWOrMFhIdqw7TPHWbmgjVMEa4tx5omuG+7tzmg5ZZ6aNC38+
         Ehizc5EnIEXW4iwxXjV9N2h3HkvpRTR7HNpToAopy7dD9EzBgMWCLrCmOOqQl0iob51D
         M/3g==
X-Gm-Message-State: AOAM533pTYnHe5tzjxPXzgnvgmu0aCCwEFxs+AROmBPzTR2NkHk0jbXm
        dzSL3RnHn2FhC7m5thjV6Zg=
X-Google-Smtp-Source: ABdhPJyTgmOIZm0kPkXY5GYaUgp/MS1/PJK7T0oGeoWhD3+zELUe1ZiOjcyrrogDqAz69SM9xEfsHQ==
X-Received: by 2002:a17:906:4e8a:b0:6da:a1df:98fe with SMTP id v10-20020a1709064e8a00b006daa1df98femr5477651eju.66.1646938460527;
        Thu, 10 Mar 2022 10:54:20 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090608c700b006cef23cf158sm2087174eje.175.2022.03.10.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:54:20 -0800 (PST)
Date:   Thu, 10 Mar 2022 19:54:17 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: vt6656: Remove unused rf_type in baseband.c
Message-ID: <77dcff8602084484532fcbd734aafd138087c5ee.1646935331.git.philipp.g.hortmann@gmail.com>
References: <cover.1646935331.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646935331.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rf_type that supports 5GHz band.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index 1e1c5a7d8968..c04fd052e467 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -255,23 +255,18 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);
 
 	if ((priv->rf_type == RF_AL2230) ||
-	    (priv->rf_type == RF_AL2230S) ||
-	    (priv->rf_type == RF_AIROHA7230)) {
+	    (priv->rf_type == RF_AL2230S)) {
 		priv->bb_rx_conf = vnt_vt3184_al2230[10];
 		length = sizeof(vnt_vt3184_al2230);
 		addr = vnt_vt3184_al2230;
 
-		if (priv->rf_type == RF_AIROHA7230)
-			addr[0xd7] = 0x06;
-
 		priv->bb_vga[0] = 0x1c;
 		priv->bb_vga[1] = 0x10;
 		priv->bb_vga[2] = 0x0;
 		priv->bb_vga[3] = 0x0;
 
 	} else if ((priv->rf_type == RF_VT3226) ||
-		   (priv->rf_type == RF_VT3226D0) ||
-		   (priv->rf_type == RF_VT3342A0)) {
+		   (priv->rf_type == RF_VT3226D0)) {
 		priv->bb_rx_conf = vnt_vt3184_vt3226d0[10];
 		length = sizeof(vnt_vt3184_vt3226d0);
 		c_addr = vnt_vt3184_vt3226d0;
@@ -305,7 +300,6 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		goto end;
 
 	if ((priv->rf_type == RF_VT3226) ||
-	    (priv->rf_type == RF_VT3342A0) ||
 	    (priv->rf_type == RF_VT3226D0)) {
 		data = (priv->rf_type == RF_VT3226D0) ? 0x11 : 0x23;
 
@@ -446,7 +440,6 @@ int vnt_update_pre_ed_threshold(struct vnt_private *priv, int scanning)
 	switch (priv->rf_type) {
 	case RF_AL2230:
 	case RF_AL2230S:
-	case RF_AIROHA7230:
 		threshold = al2230_vnt_threshold;
 		length = ARRAY_SIZE(al2230_vnt_threshold);
 		break;
@@ -456,11 +449,6 @@ int vnt_update_pre_ed_threshold(struct vnt_private *priv, int scanning)
 		threshold = vt3226_vnt_threshold;
 		length = ARRAY_SIZE(vt3226_vnt_threshold);
 		break;
-
-	case RF_VT3342A0:
-		threshold = vt3342_vnt_threshold;
-		length = ARRAY_SIZE(vt3342_vnt_threshold);
-		break;
 	}
 
 	if (!threshold)
-- 
2.25.1

