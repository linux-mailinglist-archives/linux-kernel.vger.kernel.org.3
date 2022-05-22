Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389975305A6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350365AbiEVTto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350485AbiEVTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:49:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664839BAB
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so24739876ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rlKCcc3Cfz4SOeHsE7kOSMH+pFkJNujvAhxMEYVEh9Q=;
        b=q5kfaCelUWQv/xUP6MeweT3/24WiJmRTKt/7UVHBd/KoXUBH0lWbJyL3MhV5okLzvt
         1/zuRxuqRBzMhckB/NVMQtoKsSygQW4edvm9kWQDpGIKCaUIZB9LxV7kf4jVARhgYYm9
         IzTHX0SrZ+9VA4OushDVjyo2egmUUiGX4aaTM9U8lD3T7V3LjrNXmPJSi3oB/LnUdmEE
         BVhI7M3yZSWlnXEtRLPWIC5D8AGu7suf1wLhnyEdUuKS9qAi6kWjcbfDNxqCJRcDTalk
         EAko7lf8V3MktQ0v2Q7KXmXF6LdnTCrBd7GnZlOmwmiHCdx6oHbXTwg7XuUGCKrvJMRU
         iodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rlKCcc3Cfz4SOeHsE7kOSMH+pFkJNujvAhxMEYVEh9Q=;
        b=i949qjWvSgTgSDJhsPUwQRV5xAdX2KZWm2ZVe9aT5uL5T6Er5DXgUWVgWibu+lld0Q
         Uy7VAPExV3R29Q/WOZFCbXZ0alGHARo2oCMRgyGPkqKdadBxJgQ072Cp/aaHtq1wj98w
         fp8/gb1eVd1M8PlII7Jd6A0Wfpmti0oxIl3qEkc9Y780gZDlQo/0GQBlV6RVZmjo9EPX
         uNjllRVLCRqeggy+CKl0uBWBtmIVWQcYlAA5PZfYlTZnUc6f28j2bYZqjTXPwcvgSu86
         i9yoIWqaxjPOvb4fumThrOzyoVIpcJCvwdaiGDFdb0oNYW7cmjE3nQX5qAqVTleZxOKZ
         wzHQ==
X-Gm-Message-State: AOAM530HnaZjaMkydNU3x0oDMZBhpzyLQHctkDKi8Y7f4ZqzkfaEjs/Z
        6MTyxJE3+uQxaBaMzziicgo=
X-Google-Smtp-Source: ABdhPJwolWOlDnZJcYlv0xEnTvnCXYVex1x24AP9SRExVk/EPWOzIPbGvT2MSXjWhrfsrLZBLHQUxA==
X-Received: by 2002:a17:907:3e0f:b0:6f4:5cfd:e6bb with SMTP id hp15-20020a1709073e0f00b006f45cfde6bbmr17338557ejc.38.1653248961901;
        Sun, 22 May 2022 12:49:21 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id my9-20020a1709065a4900b006fe8d8c54a7sm4984540ejc.87.2022.05.22.12.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:49:21 -0700 (PDT)
Date:   Sun, 22 May 2022 21:49:19 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: vt6655: Replace MACvRx1PerPktMode with
 VNSvOutPortD
Message-ID: <9cb643b9554e33f5be7a2babefbed5eccca14625.1653203927.git.philipp.g.hortmann@gmail.com>
References: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1653203927.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvRx1PerPktMode with VNSvOutPortD and as it
was the only user, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c | 2 +-
 drivers/staging/vt6655/mac.h  | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index e907dfd58d1f..57ed2120dbc1 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -453,7 +453,7 @@ void CARDvSafeResetRx(struct vnt_private *priv)
 
 	/* set perPkt mode */
 	VNSvOutPortD(priv->port_offset + MAC_REG_RXDMACTL0, RX_PERPKT);
-	MACvRx1PerPktMode(priv->port_offset);
+	VNSvOutPortD(priv->port_offset + MAC_REG_RXDMACTL1, RX_PERPKT);
 	/* set MAC RD pointer */
 	MACvSetCurrRx0DescAddr(priv, priv->rd0_pool_dma);
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 161130084936..b68e21c62d2b 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -589,9 +589,6 @@ do {								\
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL);			\
 } while (0)
 
-#define MACvRx1PerPktMode(iobase)					\
-	VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, RX_PERPKT)
-
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
-- 
2.25.1

