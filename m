Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9628569282
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiGFTTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiGFTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:19:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B19C24F31
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:19:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r6so9062926edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b3xI5Sdxx+oPP9Cm0s9efA+PjQvj55zpgOhExBt9UZU=;
        b=ZWB4xSJTQz2819wLKio/sgPqqe1uZo29vUXUVuo6pfQ3LAVjvGPT1wTk5O7QJXtOGF
         MFtjucIVZiBEa8I3M4O3KteoiopsqNiv6ESIl8QNzuXEsdd3ChQvdK5s+1m5zNlhHazM
         iRil826AoE/kg0pJkmTRNK1jL5cKbG4hrY2TtduIB3575JsG3gx4suwwiTnw9h0lQlw2
         HyjrXXF+aFI5oIIbFv5b/fQNpCLy1rPNEEPS4537+0N8cJKOm9xoj8TEf/eaAVrLfNfV
         pyC8A2n+BFEcpCrLIrHGM+9AQStU5tRW9UnyfsbgOFizFIL36r9gSv3LZHtvu5cquT+4
         R+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b3xI5Sdxx+oPP9Cm0s9efA+PjQvj55zpgOhExBt9UZU=;
        b=dXqhFq4C+cm/rdNb1y8pYaVBZFo0g7HgUbb/WVM82pc1FsT6fUdkF7QjckCKA9L3R2
         6cCthLCr9p46vxK/s2Pf/jIYDnUZlOhkjS78cQSlnQ0scU9utym9BmJa+5h5Boyizyqf
         gqAAw4gh1ZqT8qmxpSN5IwdrjBCYqQTRbaB0GD9N4H1mrbTTlJxkooK8q7TncoP8dfFZ
         w92r0CqWDtgC5fuSY+qI/9Ju9AHLRNTT+IaSOQk/y661G6bM1FNbeF2w4zwgylqHMZSP
         kXCMkYAa1u5HcoqNruUtagJ2DltOVQ1FDzen6U3Y0pGPtEnb2QbZaFM2TT+V92VzAfLa
         vasQ==
X-Gm-Message-State: AJIora9u6CR/E6NqQxtosjKoTXCSsg5M8oJf0O6Tnzt0rdQ8CRw4u2d4
        jP5MpMrTt72nJ/UfF/V/Q6o=
X-Google-Smtp-Source: AGRyM1vwxmN1F5Vsnn9AkPToj1MRroLZerGW2AKZ/nyuY4r6+WmJpRoWGdB8aJyDHL5dePDbw3T4hw==
X-Received: by 2002:a05:6402:26d5:b0:435:aba2:9495 with SMTP id x21-20020a05640226d500b00435aba29495mr56764527edd.133.1657135151240;
        Wed, 06 Jul 2022 12:19:11 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id q4-20020a1709064cc400b006fec4ee28d0sm17625657ejt.189.2022.07.06.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:19:10 -0700 (PDT)
Date:   Wed, 6 Jul 2022 21:19:06 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6655: Use loop in vt6655_mac_read_ether_addr
Message-ID: <f233c8a007d75a8adcc99a07c582b75bdc1985db.1657134099.git.philipp.g.hortmann@gmail.com>
References: <cover.1657134099.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657134099.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use loop in vt6655_mac_read_ether_addr to avoid multiple
similar statements.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Code for testing:
	for (int i = 0; i < 6; i++){
		mac_addr[i] = ioread8(iobase + MAC_REG_PAR0 + i);
		printk("i = %i\n", i);
	}
Log:
[ 3608.011168] i = 0
[ 3608.011170] i = 1
[ 3608.011172] i = 2
[ 3608.011174] i = 3
[ 3608.011176] i = 4
[ 3608.011178] i = 5
---
 drivers/staging/vt6655/device_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 099f0b95417a..19840dddb4bf 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -200,12 +200,8 @@ static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr
 static void vt6655_mac_read_ether_addr(void __iomem *iobase, u8 *mac_addr)
 {
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
-	mac_addr[0] = ioread8(iobase + MAC_REG_PAR0);
-	mac_addr[1] = ioread8(iobase + MAC_REG_PAR0 + 1);
-	mac_addr[2] = ioread8(iobase + MAC_REG_PAR0 + 2);
-	mac_addr[3] = ioread8(iobase + MAC_REG_PAR0 + 3);
-	mac_addr[4] = ioread8(iobase + MAC_REG_PAR0 + 4);
-	mac_addr[5] = ioread8(iobase + MAC_REG_PAR0 + 5);
+	for (int i = 0; i < 6; i++)
+		mac_addr[i] = ioread8(iobase + MAC_REG_PAR0 + i);
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
 }
 
-- 
2.37.0

