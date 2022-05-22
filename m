Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96BB5305A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350709AbiEVTt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiEVTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:49:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAC33A5E2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so2650860ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MLW54pUDQeelw1+w5KQ4Wc3ocZ3VALhByO07hnMjaHs=;
        b=Nn+PAzEcVQe8/826opqMJc389ynDSlB4yWocPjyJI5pwzuUHszrXBRxhs0+oiqu2Lu
         b/9ccX5jnZbBBklK4mWPI9Ln1YnjOU9Gjc9sCYUSSSGv12A8/Wr0BpyHVI1F3acCd6YN
         vz5muMIhD6P89g+nXnr09+bFZxZ3zoxq5qXXRNTo+VFRYsw7PO1GdbGUbS0GxolGqB16
         SSJj7kZPA8qAbLkG9KAOC1w/UKxRiWC/g24snx4mV+DD1uJw/bAvg+upG1E+hCxX8Gop
         1HdrsDm8pbVc2ovw1faM/m9oBSNZqOw3nUU5Rhu+Z1C0P8o35TTZQD1+zoyaAQLDQKoW
         l4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MLW54pUDQeelw1+w5KQ4Wc3ocZ3VALhByO07hnMjaHs=;
        b=Ul0SoR5eILmUsHblRxploh1oICZSspwcQgoYlEhPfn9LxnHlQCw0K5RHGiO/62hVCp
         cVjWeABGrtJoSi7dyRZM1pKQ0g94T9945YQiy2oU4+hopaedrdleOyii6xtrzw7O1D+I
         wMFdXNebrl8bML680XPF8pfL3qruo9z2GhLYt/5cEebv3dPG5eaBYcLaCoKD8yYv1FVc
         yKicTbfJODb3HSDa/a5Z/2To1pPBxGT0tSzH6lUClget6Nj9/xX5oGqwdbOZzmoK4JVn
         rr+sCiqLEgW5YGesO/KDBCrO3cwtJd6bwadiuxTXflNP+qbRp6Kn0HXEP6Csgg+dwemK
         yZ1A==
X-Gm-Message-State: AOAM533TwJor5UxRotl1aSmvL6r259xkBIivQUMfRZaTH5hK77oMl7/V
        6XDXN1wU5OQgX9jd5qtE/rk=
X-Google-Smtp-Source: ABdhPJwA4HcJDgqFzMHMJ3RV9hG9NTHYfNGhNfMFaMFUIdABxVnvg06BGdOiO9GDbMrkjMBKwWJZcg==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr16228737ejn.278.1653248971392;
        Sun, 22 May 2022 12:49:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id wc6-20020a170907124600b006fec8e8eff6sm1217645ejb.176.2022.05.22.12.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:49:31 -0700 (PDT)
Date:   Sun, 22 May 2022 21:49:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: vt6655: Add missing BE support on 2x iowrite32
Message-ID: <974ef7a9244e7caeafd8c176c7b53a6de3c20219.1653203927.git.philipp.g.hortmann@gmail.com>
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

Add missing big-endian support when using two times iowrite32
to write 64 Bit.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Code for testing:
dev_info(&priv->pcid->dev, "CARDbUpdateTSF little endian before con.: 0x%016llx", qwTSFOffset);
qwTSFOffset =  le64_to_cpu(qwTSFOffset);
dev_info(&priv->pcid->dev, "CARDbUpdateTSF little endian after con. : 0x%016llx", qwTSFOffset);
dev_info(&priv->pcid->dev, "CARDbUpdateTSF big endian:                0x%016llx", be64_to_cpu(qwTSFOffset));

Log
vt6655 0000:01:05.0: CARDbUpdateTSF little endian before con.: 0xff ff ff ff fd b7 d5 fc
vt6655 0000:01:05.0: CARDbUpdateTSF little endian after con. : 0xff ff ff ff fd b7 d5 fc
vt6655 0000:01:05.0: CARDbUpdateTSF big endian:                0xfc d5 b7 fd ff ff ff ff
---
 drivers/staging/vt6655/card.c        | 4 ++++
 drivers/staging/vt6655/device_main.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 7a4a8b3f164e..abc74a5633c7 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -293,6 +293,7 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
+		qwTSFOffset =  le64_to_cpu(qwTSFOffset);
 		iowrite32((u32)qwTSFOffset, priv->port_offset + MAC_REG_TSFOFST);
 		iowrite32((u32)(qwTSFOffset >> 32), priv->port_offset + MAC_REG_TSFOFST + 4);
 		MACvRegBitsOn(priv->port_offset, MAC_REG_TFTCTL,
@@ -327,6 +328,7 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 	iowrite16(wBeaconInterval, priv->port_offset + MAC_REG_BI);
 	priv->wBeaconInterval = wBeaconInterval;
 	/* Set NextTBTT */
+	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
 	iowrite32((u32)qwNextTBTT, priv->port_offset + MAC_REG_NEXTTBTT);
 	iowrite32((u32)(qwNextTBTT >> 32), priv->port_offset + MAC_REG_NEXTTBTT + 4);
 	MACvRegBitsOn(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
@@ -795,6 +797,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
+	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
 	iowrite32((u32)qwNextTBTT, iobase + MAC_REG_NEXTTBTT);
 	iowrite32((u32)(qwNextTBTT >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
@@ -821,6 +824,7 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 
 	qwTSF = CARDqGetNextTBTT(qwTSF, wBeaconInterval);
 	/* Set NextTBTT */
+	qwTSF =  le64_to_cpu(qwTSF);
 	iowrite32((u32)qwTSF, iobase + MAC_REG_NEXTTBTT);
 	iowrite32((u32)(qwTSF >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index c32c0328b602..204994692c90 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1529,6 +1529,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			} else {
 				MACvSelectPage1(priv->port_offset);
 
+				multicast =  le64_to_cpu(multicast);
 				iowrite32((u32)multicast, priv->port_offset +  MAC_REG_MAR0);
 				iowrite32((u32)(multicast >> 32),
 					  priv->port_offset + MAC_REG_MAR0 + 4);
-- 
2.25.1

