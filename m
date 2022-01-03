Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2150483759
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiACTFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiACTFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:05:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2DC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:05:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w16so139477543edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtxUgEy7NEgEomcwsEW1jZEfxdyk0qPiG0NwmIluPmU=;
        b=o7tThIhsSZBjw92QvpXSkgH5Yv/fa5lXC160n5TvxSnoHflYTjgDNhf+ARscocaJgu
         al3VupjzVKnmGRCERtOFzF2gxwchMP5+EmTpPBxEInkyRAbiD8vKoxjoK0Fd0xj3IieA
         JW7WCBLvqDx2i1kEdfq9YLYxEYkCUBnmyzlT0r4DAO1K2N+K1YBrkqQfsWF9dbWzzOqY
         z72nBex/1dYPqBWt7KbY1ahxTeblYqDZBSxdMwBF6yT1EBAvkmLltXOautW4IFi8wwgz
         531I3NZ+VpDqoRrWS8iFZrSdlzeK+gWjQ2SEPDC8VQOv9ff52rwUN5qbxm6hfShw3o3s
         k8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtxUgEy7NEgEomcwsEW1jZEfxdyk0qPiG0NwmIluPmU=;
        b=XQQnbfC4H3O7JetsdQmO0AIse/RCQr7C60AWyPSqWa62Fkvs4FJze+RKsX5SuLuNiR
         dLsMdEEljTLSQDH/4WW/DKDeAFw1DzKJBHSm1YEYdMJY5OpnQbEi4ubd7NpRMi+tFz1F
         PaXr/D/WbPSqrq95vW/OFqusfBXb55Qz0+B8PhP0rQBdS2xdpHtDGFI6JHrsRonsZaFV
         K7qmyjFuhC3bNqOAWgZi0Xl5cJqvWyI4TG8Fst2L/Y7cUDrZ9Q/Biysp8l7M0Bn9iPTm
         J8all44pCY6vbondXlCNmQ71bPOCENTcpJ2kFjheCBIazuontHmt/uyKOaO7CQGlTdv4
         0bng==
X-Gm-Message-State: AOAM5325/+MWWMujy6KlNciJTTlbYNqyqtTF6DBKxppRb6AY2S5bg4Wb
        Uo3kxAKlIq51D9qvWOVle2I=
X-Google-Smtp-Source: ABdhPJzpMEsIJ4iHkEAujgjtMEtiyGDUYQSgkODd8qs36XHacJG+2/vpGolvQ62/0KWrWht4U8pqCg==
X-Received: by 2002:a17:907:3e9a:: with SMTP id hs26mr36821167ejc.408.1641236719095;
        Mon, 03 Jan 2022 11:05:19 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:05:18 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/56] staging: r8188eu: add parenthesis to macro SetToDs
Date:   Mon,  3 Jan 2022 20:01:36 +0100
Message-Id: <20220103190326.363960-2-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose in parenthesis complex macro SetToDs

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 7cbc7015e90f..f16e9f44babe 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -164,7 +164,7 @@ enum WIFI_REG_DOMAIN {
 #define _ORDER_		BIT(15)
 
 #define SetToDs(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_)
+	(*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_))
 
 #define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
 
-- 
2.25.1

