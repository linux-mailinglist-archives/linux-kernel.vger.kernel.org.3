Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C0D577897
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiGQWUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiGQWUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:20:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D112D19
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy29so17172557ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=72PpzeaJZFk4PpQbNlACBTVQWjfaMdwWFINUxLmL75Y=;
        b=PpxwV+JtmMmW2wKyhWG92BDNXm/8w5yCz4CrvzNLbtVf2R1MWV87mUGGhT6KebFgGA
         zFDth2KIpoYgsPMaIx5lulyNBpRkfd7qwVkyQ808B0K5REfps3GBXdXPKJ2FSMI5piIG
         3iET1LCQ+3r+qxvOaoioPy1T8sIW/4ivf/7EM/hm8vnu6JY3ekogIkEUEB/AHSWmPrvQ
         fnDKZNQKvgACe3zyOUpAvxe7xPGV7Uk48lFG7JL5yH7e1YXaeQb2wDPnHz5UHAfKfzR3
         pvvOgWTHh2+R7hbTw0o7hwVFmCE9RV+YuSp6Qs0NHJOjSQrv7IugA8roAKaOOvssw1NV
         C2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=72PpzeaJZFk4PpQbNlACBTVQWjfaMdwWFINUxLmL75Y=;
        b=o5c297q4Vv8p7AdBDw1czQAO5ptUmeeINZz8r6/mCYLoSJKmf1/7i9+n3eI5h+ph+1
         a1eXj15qZWqdJbvnaRjsQQdi+weYKbcSPHIdhV4iL29bLbU4inlHE2IWKmTDfbSCCfmU
         7pyBWSFzWDbcaC9BuuGCGY0Z2JGcLTQ3e1x8mBUgTJQP+dyfBDiOjtRy7G6y4QxY4O8d
         XkxCGwkF/MSzPpgJ1jRF6aZlVixF7RQjj7RJupKPgS+p/VxmsFif3SQ6Dl/h9MkA0VvC
         fRsHqbIRfFSLuSou8I8fDjUeZvKIxQandPm7+hyNEXh/DghbEozyI/GY9wcrumfn4GoR
         KIZA==
X-Gm-Message-State: AJIora9J89AguSHq80llSS4oEDcvWlTUB8fna063sDvpfLKyAp3IbRH6
        D9TQCdiiXzXZv/fRPD+HfOz+GkcLarU=
X-Google-Smtp-Source: AGRyM1ulMDk311mJBEF/FWugiQ9TEy8LgpVIAZ+kowZ3keb6STiQARZyJ7+QQCUf8k4/Ys7OKFSEoQ==
X-Received: by 2002:a17:907:9627:b0:72b:6d22:4334 with SMTP id gb39-20020a170907962700b0072b6d224334mr22866780ejc.506.1658096431794;
        Sun, 17 Jul 2022 15:20:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402028c00b004355d27799fsm7327025edv.96.2022.07.17.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 15:20:31 -0700 (PDT)
Date:   Mon, 18 Jul 2022 00:20:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: vt6655: Replace MACvTransmit0 with function
 vt6655_mac_dma_ctl
Message-ID: <5d1723b082b7f2583dfa9e1590178380752cf647.1658094708.git.philipp.g.hortmann@gmail.com>
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c |  2 +-
 drivers/staging/vt6655/mac.h         | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 01ce1c90ab09..898e06958203 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1233,7 +1233,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (head_td->td_info->flags & TD_FLAGS_NETIF_SKB)
 		MACvTransmitAC0(priv->port_offset);
 	else
-		MACvTransmit0(priv->port_offset);
+		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_TXDMACTL0);
 
 	priv->iTDUsed[dma_idx]++;
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 129a6602f6f0..1e57663ff066 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,16 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvTransmit0(iobase)						\
-do {									\
-	unsigned long reg_value;					\
-	reg_value = ioread32(iobase + MAC_REG_TXDMACTL0);		\
-	if (reg_value & DMACTL_RUN)					\
-		iowrite32(DMACTL_WAKE, iobase + MAC_REG_TXDMACTL0);	\
-	else								\
-		iowrite32(DMACTL_RUN, iobase + MAC_REG_TXDMACTL0);	\
-} while (0)
-
 #define MACvTransmitAC0(iobase)					\
 do {									\
 	unsigned long reg_value;					\
-- 
2.37.1

