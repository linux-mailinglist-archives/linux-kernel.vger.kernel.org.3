Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6BC565D79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGDSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiGDSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:21:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136D1146D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:21:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ay16so17992356ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9A6wPP/Y//CXYJtxQs8Hsds391x1hM4igQ2mocLqrek=;
        b=i4CLbmgl90VzwHTsq8uaP/EoCwoaD1hZ+YPpjMFwJ5TzaEBvx5+EQ55I9bbC3JuIbL
         5yJ4FDOJCd0nNEvE+ubbl3yCzJq0QHbF5dg4Lq1FrPowF6phIYfeNucqkThmlYSg55Yc
         L0frm+vXsKco7ji1abMH/pW+MHtmogDnEiUl5tjhW+WwUI5Ejo18X8hXD5cb85KPkaKL
         VuXlCItoDbmIAA60lNn1urGuyBrrqzTVii5gexpnSgzd9gSPBik27kAUJKLGx/+pFx14
         OghGaWFiDmMwYgWQEmjdOg8DY5+wFcr8bi07YPfMYH9ltlRSaP6DesE8A2h7a7jekKYl
         cPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9A6wPP/Y//CXYJtxQs8Hsds391x1hM4igQ2mocLqrek=;
        b=vIP71xVHnyr02IVJzstqPx+rek0ecHDCOBIirkKasn9onshaDNS2dFuOOPw3rgpmbF
         l3hzbim/YQbi+7WuyFyH7Htj+MpcXpCsQu1fMGf+c/3FjQEwZKZfWMfSrwHu2gRgUmlo
         PQkdhZLWZ7qnDlNSslgucygCqx02/pXeJoJrl1q/Fpi9cq+uEJMMDMu08Fyq5HV31rME
         zPwV8oeIRlW9a8ZFilfDsLitZB0hZjZOgnyKpFxWQC7unEYXU6DBHJyi7y+3aCEBfnMU
         /Ip6vc5J0tkJQkTfeA/m1dCgEtu2b5HaqAdBYvD4ENl43BWYF3iOhZtNWsOLtaPUWMIb
         csmw==
X-Gm-Message-State: AJIora8ARuYn1XludOVAmvlYBCz2SEV0hfVnL9ZnO1v4HbRInPpvYQ8v
        YYzdMFziJqW60ukG/i2ijBc=
X-Google-Smtp-Source: AGRyM1u+qh7py3nrb75GEAi2vvjJPq6SLI4xpY194/KWWXF7jJ9fqZIS/WUYA+6LTHTd7+1dAizoaw==
X-Received: by 2002:a17:906:3899:b0:715:9fb4:bd28 with SMTP id q25-20020a170906389900b007159fb4bd28mr29062978ejd.97.1656958866415;
        Mon, 04 Jul 2022 11:21:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id t13-20020a056402020d00b0043a71775903sm700493edv.39.2022.07.04.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:21:06 -0700 (PDT)
Date:   Mon, 4 Jul 2022 20:20:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: vt6655: Convert macro
 vt6655_mac_write_bssid_addr to function
Message-ID: <caecf7287d92c5d25ba0dfc16a24a6ce4aa67d55.1656835310.git.philipp.g.hortmann@gmail.com>
References: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro vt6655_mac_write_bssid_addr to static function.
checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index fdb653071918..025a53b493d3 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -122,6 +122,8 @@ static int  vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent);
 static void device_free_info(struct vnt_private *priv);
 static void device_print_info(struct vnt_private *priv);
 
+static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr);
+
 static int device_init_rd0_ring(struct vnt_private *priv);
 static int device_init_rd1_ring(struct vnt_private *priv);
 static int device_init_td0_ring(struct vnt_private *priv);
@@ -186,17 +188,17 @@ device_set_options(struct vnt_private *priv)
 	pr_debug(" byBBType= %d\n", (int)priv->byBBType);
 }
 
-#define vt6655_mac_write_bssid_addr(iobase, mac_addr)		\
-do {								\
-	iowrite8(1, iobase + MAC_REG_PAGE1SEL);			\
-	iowrite8(mac_addr[0], iobase + MAC_REG_BSSID0);		\
-	iowrite8(mac_addr[1], iobase + MAC_REG_BSSID0 + 1);	\
-	iowrite8(mac_addr[2], iobase + MAC_REG_BSSID0 + 2);	\
-	iowrite8(mac_addr[3], iobase + MAC_REG_BSSID0 + 3);	\
-	iowrite8(mac_addr[4], iobase + MAC_REG_BSSID0 + 4);	\
-	iowrite8(mac_addr[5], iobase + MAC_REG_BSSID0 + 5);	\
-	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
-} while (0)
+static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr)
+{
+	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
+	iowrite8(mac_addr[0], iobase + MAC_REG_BSSID0);
+	iowrite8(mac_addr[1], iobase + MAC_REG_BSSID0 + 1);
+	iowrite8(mac_addr[2], iobase + MAC_REG_BSSID0 + 2);
+	iowrite8(mac_addr[3], iobase + MAC_REG_BSSID0 + 3);
+	iowrite8(mac_addr[4], iobase + MAC_REG_BSSID0 + 4);
+	iowrite8(mac_addr[5], iobase + MAC_REG_BSSID0 + 5);
+	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
+}
 
 #define vt6655_mac_read_ether_addr(iobase, mac_addr)		\
 do {								\
-- 
2.36.1

