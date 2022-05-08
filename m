Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA14151F0A1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiEHTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiEHTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:34:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E89EBB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:30:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m62so7307129wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DNNfm64Fzck7HZ+kpn5zl++XhRLhmj2A5Ac4BEuoyfs=;
        b=ZE0EGGr4/KNSvWhvZ1ZbwN0IFJmzqYiNKAguMnkGzX1LabvrpM8DZYkuuQdgFmb2GH
         v5emtNJZanTqvl/iQw4NSaeOwLwHqQWPSXMi73ouzZ8nS9FHQuaWvX07BTYQhp+EG3ls
         12XXfOe0UTl1e+lsGPHPkgrx4vCMMukCrm1OBuhbKHdskbyb9IKXI7d2qu6XYyGRpO2H
         G9rmtUMXCjB5rPj2Oju8C6ikTGU6yVb4Qe+dgmY3ZQEqdIdFRA38Jjlw1DXBq5M8FOY3
         HDCa5KVm9atX+WId8gc4kX/TPAYAPdSKvJBJw/G/7Fv/ZD6AZk87c8Gv9hk6s1S1Zsap
         vo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNNfm64Fzck7HZ+kpn5zl++XhRLhmj2A5Ac4BEuoyfs=;
        b=bspjNeR1jy/Khi3wSQ5plwyYa7Yr6cIJ/0FEKondjXt0fl9mDy4PV8+Zkfi6hIkkQ+
         EvHTsoyNhX0e16BF2Oy4Fz8OKB91FLaHejOlUFh5wwnOBFu/mgBPfnKV5a9NPH6ROcKA
         X+jrH8kuNy/jQ0IhSl76fPC+oeaXcTTjSErlcCRz2OHJzUmesR5LGNkTV6As6TONT9Mo
         mFzAtnvZxXF6ZhubmgmSamLuNfgiQMUrIb9w+EimVbsHbwloXZnHbWZZXC2ovPcQ+0AI
         I73+bfjmiwgeiKErp4RJeIakC1XoNZkvsHcXfYVSMnP127kukf/IstltePDvkbVrqfgM
         XqYw==
X-Gm-Message-State: AOAM532X3DhUzTEvkjytYn1HBYrqPu7MVuvbzV3fGqzdo4ZUX89tUiJi
        iHrsRa7rkgwFxunBwIcP981dDT/hdJoivQ==
X-Google-Smtp-Source: ABdhPJw81OhtuXuoKmMUWTfoMPYbMpZkHfdboo8+1XVbOeTdDB9P0ID9Oq8TTRY7tgRVpK0e6t/tgQ==
X-Received: by 2002:a7b:ce82:0:b0:394:2514:6f07 with SMTP id q2-20020a7bce82000000b0039425146f07mr12965709wmj.56.1652038200875;
        Sun, 08 May 2022 12:30:00 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f3ed42031f51b0dd5fb7060.dip0.t-ipconnect.de. [2003:c7:8f3e:d420:31f5:1b0d:d5fb:7060])
        by smtp.gmail.com with ESMTPSA id e10-20020adff34a000000b0020c7ec0fdf4sm10460160wrp.117.2022.05.08.12.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:30:00 -0700 (PDT)
Date:   Sun, 8 May 2022 21:29:58 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: vt6655: Replace MACvTransmitBCN with
 VNSvOutPortB
Message-ID: <698ce973d92065846a9db4339f017cd9e094706e.1651957741.git.philipp.g.hortmann@gmail.com>
References: <cover.1651957741.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651957741.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro MACvTransmitBCN with VNSvOutPortB and as it
was the only user, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h  | 3 ---
 drivers/staging/vt6655/rxtx.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3a32a0146c85..89fad233bbc6 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -651,9 +651,6 @@ do {									\
 		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_RUN); \
 } while (0)
 
-#define MACvTransmitBCN(iobase)					\
-	VNSvOutPortB(iobase + MAC_REG_BCNDMACTL, BEACON_READY)
-
 #define MACvClearStckDS(iobase)					\
 do {									\
 	unsigned char byOrgValue;					\
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 53506e242a96..14feff4f2e70 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1426,7 +1426,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 	/* Set auto Transmit on */
 	MACvRegBitsOn(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
 	/* Poll Transmit the adapter */
-	MACvTransmitBCN(priv->port_offset);
+	VNSvOutPortB(priv->port_offset + MAC_REG_BCNDMACTL, BEACON_READY);
 
 	return 0;
 }
-- 
2.25.1

