Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410A149EAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiA0S4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiA0S43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:56:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2EC061714;
        Thu, 27 Jan 2022 10:56:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r59so3813281pjg.4;
        Thu, 27 Jan 2022 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IitcHpxexEeeK4nrp3ByNY1yDn5cj29OgUtFySczhTw=;
        b=fa7zc/rDd3aBFao+quSyUNqbDWm6bTGg1m4U2ge4JR3ErWEYq0OIOlhR39TkA1eM5H
         2S8UzO8wA55ZzsBLO/pC/TYDhCDH+GywHxNiSz7jkpc+TeC9ehYXmBcQ0VnfETfsa58D
         hivrvvdFjyxxV2xlTbCPKGi4nMKXepxBEmwWgQqBRAGUxb0OWjaQ1WkcNim5JczTZAhZ
         a/Yq3dMdAZGmw0FOe7Qr8UzwMmD5KivPowAxZZnAfeP821mXSR8ak1tIGaivjesDwFus
         Yz5/ju9EVmry24BNT+wunCYy7xJ/En9Klcs044QdKHVYtje3XmI6+PpmVzY3A6KQKJw1
         ViTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IitcHpxexEeeK4nrp3ByNY1yDn5cj29OgUtFySczhTw=;
        b=J/LiVZtHKj7+lkgNRaniJArcyNwyeeEjVP9VpGSLOaw2xk4PxNVpuz5PWZk+gWGSVE
         35FV2Hj4/HSalwtnnouPBqrbeLfuJ4MWv9ci2Lo5kccMYRL+ysHxwrNjOk81uL2qrffY
         aaKPuhSljU14oewKtaLYtBBWPrLejmkQpBcp4DZw5M3RlO4OhEOYFZwLYq9bXa/Uwjaq
         K/Z1p5qFDURDjZuj++sL4Etc0OOAVj2dELwjMYFXEFkLSLMZ6VlKToAd6e3RYGdByEOL
         la7mnLPRlp0P04z9Qn2XBDZM8E1AYgkXwVevDpU9SdAQ2x7na6+ch3J+at+KwyOcEmwK
         KOxA==
X-Gm-Message-State: AOAM531RahlESMz3RG0G3QBSvTkoyjZT3kjgLx1K0cdwijt/DQPqez2j
        IR7wFt8KGCr8lpvreHmdsmk=
X-Google-Smtp-Source: ABdhPJx0hbzrGwPn48xF6CGrnKtcUaUxYpjtw2E+F0k9HUnNjm3tC2vvxUylPCyMvNuYLuwn6GM2bA==
X-Received: by 2002:a17:90b:102:: with SMTP id p2mr5623220pjz.84.1643309788252;
        Thu, 27 Jan 2022 10:56:28 -0800 (PST)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e15sm6409439pfv.59.2022.01.27.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 10:56:28 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH] spi: bcm-qspi: check for valid cs before applying chip select
Date:   Thu, 27 Jan 2022 13:53:59 -0500
Message-Id: <20220127185359.27322-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply only valid chip select value. This change fixes case where chip
select is set to initial value of '-1' during probe and  PM supend and
subsequent resume can try to use the value with undefined behaviour.
Also in case where gpio based chip select, the check in
bcm_qspi_chip_select() shall prevent undefined behaviour on resume.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index c9a769b8594b..86c76211b3d3 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -585,7 +585,7 @@ static void bcm_qspi_chip_select(struct bcm_qspi *qspi, int cs)
 	u32 rd = 0;
 	u32 wr = 0;
 
-	if (qspi->base[CHIP_SELECT]) {
+	if (cs >= 0 && qspi->base[CHIP_SELECT]) {
 		rd = bcm_qspi_read(qspi, CHIP_SELECT, 0);
 		wr = (rd & ~0xff) | (1 << cs);
 		if (rd == wr)
-- 
2.17.1

