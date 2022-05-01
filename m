Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF151674D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352661AbiEATQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351162AbiEATP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:15:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0A3B286
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:12:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so14519256edu.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fPAKDdmXBdJMtKsOYAMIgR2qPey6myfkQrqj9b4T7kQ=;
        b=mquq9QDLG4YQOQw2YK+tNZ2CxsDVKs3CmJhirS48PnPHpp38tJ0nAO/MIqZSdSui91
         6i5LHa/1z8+17KK9I3vtIn9xbWcl1QobgNjyK1oQMbhAJ3s+i2oJ7eg3zRSyIVsC6dbe
         1sjDsWDM5Bb3Jjv/b1NgU76wlZLdR0E7Pxz/xTafM0eGhdTtAvqXePltZ+GUVEpkUv5c
         h3z/Ic1/FcfXR8ry9H+38muP0OVNSU7tixPCkb7ufDrNB+ZiiMY8lTBBvuqkzepM3fV5
         TZuffIg9iBV1Lh2koMDFCFBScJxfIOHBHL9QdzjuBAaXaZwNz8D3E1gp3yT/S7N9psph
         eXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fPAKDdmXBdJMtKsOYAMIgR2qPey6myfkQrqj9b4T7kQ=;
        b=3CpXF8M7JTzkK/sMd7BN7StyZeZNrY8TKp2kJkEWEuqq9IvOgYdBlXWD+0KE9cDNVa
         rF3H6EtnUOHnFCnN9iuyPrKv0SrFX3vmRDsjsDVg9EisAYJjDT7KNartryPcK4HWHgy5
         Xp6gXSRNlPvG6zSqFZVlrSx9PGiI/gmrGjTabA0uE2Rp/StxZyuXGkA2Cg0mXwON4KUL
         jM2XU0AOEMZ6c5Y54p0/vZps/zhGVfwzrhGP43Gh5Tdun13VhgsNFiLqkmWR5w7q/qJJ
         QJzhyDwBiRhQz6HM55fk8PSH6lyZxY2R7p17dzyPq9ZPrN2f58xscnqtfxaEwl14jvVF
         JwpA==
X-Gm-Message-State: AOAM531iWbZplvSBEo2SiX8g5obyxs7VHmIBOUWouyBV3sqPEhCeGHKX
        hQ6OmwLTk7tcbmQ9DAmJuaw=
X-Google-Smtp-Source: ABdhPJxaCrSAlgVDTRM9GNIuugZBy6CEehr31k/z44uPq8PcEaHBQ1LTDi8j/KGg1Glqfh/ocGQs4w==
X-Received: by 2002:a05:6402:27c9:b0:427:ba7f:6288 with SMTP id c9-20020a05640227c900b00427ba7f6288mr4332277ede.416.1651432351503;
        Sun, 01 May 2022 12:12:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b006f3ef214e34sm2833206ejc.154.2022.05.01.12.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:12:31 -0700 (PDT)
Date:   Sun, 1 May 2022 21:12:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v5 2/2] staging: vt6655: Added missing BE support in
 CARDbGetCurrentTSF
Message-ID: <25c80e3eb889ef2e530f26b4a97a9f5fe88e01ab.1651431640.git.philipp.g.hortmann@gmail.com>
References: <cover.1651431640.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651431640.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing big-endian support in CARDbGetCurrentTSF.

Reported-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Replaced #ifdef __BIG_ENDIAN with le64_to_cpu()
          Updated below example

Code for testing:
low = ioread32(iobase + MAC_REG_TSFCNTR);
high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
*pqwCurrTSF = le64_to_cpu(low + ((u64)high << 32));
dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF little endian: 0x%016llx", *pqwCurrTSF);
dev_info(&priv->pcid->dev, "CARDbGetCurrentTSF big-endian:    0x%016llx", be64_to_cpu(low + ((u64)high << 32)));

Log of the microsecond counter:
vt6655 0000:01:05.0: CARDbGetCurrentTSF little endian: 0x00 00 00 03 6a ce 0d 7d
vt6655 0000:01:05.0: CARDbGetCurrentTSF big-endian:    0x7d 0d ce 6a 03 00 00 00
vt6655 0000:01:05.0: CARDbGetCurrentTSF little endian: 0x00 00 00 03 6a ce 0d 89
vt6655 0000:01:05.0: CARDbGetCurrentTSF big-endian:    0x89 0d ce 6a 03 00 00 00
---
 drivers/staging/vt6655/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 0dd13e475d6b..431890e6b8d2 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -756,7 +756,7 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 		return false;
 	low = ioread32(iobase + MAC_REG_TSFCNTR);
 	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
-	*pqwCurrTSF = low + ((u64)high << 32);
+	*pqwCurrTSF = le64_to_cpu(low + ((u64)high << 32));
 
 	return true;
 }
-- 
2.25.1

