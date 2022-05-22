Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98410530584
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350386AbiEVTtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350257AbiEVTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:49:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7638D94
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f9so24841952ejc.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HFVukygACe6EUdSdvL43yBPTzSujU+tWVdTau6xPeDA=;
        b=LdfwdIcjabMdR4vnA1Wix0Iuglxk8n0yUqLAnxGW8p5jYB0mk7ATKmLD/JcpxGmLzJ
         wNZbrBZ4TRS7S2052kV+b6+fvazOY+Xw0dgpg2lAbBZMQ4ejmt4AxM5Db283gPIeBqVI
         Pre4cYyZnP/NYSTo3qiA/NaHL0kdvKe1p1VpgOtQSUGp2aos+Vy7UVuRf/tgQO+YV70S
         SJs4Pbg0FQebmWWN4VjQyNO/h3TrjpLAkuRn2PhbRzK5EOkHRNcbHh7TR+6dyLIu12XN
         qkj6sTMiVfqvh8DccQPz/RqSHS6q8C06+ukB2N/wT3wAPOePfBUr1nyqKohCCy5YE77M
         GAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HFVukygACe6EUdSdvL43yBPTzSujU+tWVdTau6xPeDA=;
        b=7fHpgZ7KkQaKQ+kWwVwQIyHgSb4KX0Zt7C2J6Lqw7Mlj9nGtys12LOAZ8QhDy61/1c
         nE/Qdz0Z0rShZdTrc7ghNcN2CWiNX9hY1ESOaS7S6w3xdEkSn/+nyf2Nc0lNQ1PO2FQ8
         n4V2TSIjFYbJjC4jguxBqrihZ0qF+THZtjiQ+mYTnGx9GWuAC/LZcRS1gl0XBD5Lg4Rp
         cSgQsX4llzW3BinEAPctpXtzqr8Qum6XjiYAiV0d865BuEYiWF0Q7KF20NP7rT8kd6Hz
         Sj0wUk+SH3flsoKsjQZs+g3GZmx5LLCvozqQuIMMJ050juKgp2MHtGYLDjRtGMXmX+LO
         EvNw==
X-Gm-Message-State: AOAM530PoVMootI/79mMqF8+/GGrlSXURc/dueccx2nhPUWKDW4+tMsF
        RjtamyZI3J4VDlW9q3RNZiQ=
X-Google-Smtp-Source: ABdhPJwML15aoNxYXzWXSWz/IgfhUL/W32v2njx4R/N3yEy6Xu2tQJLqWUXT9Dt4GB0tUe8/jnAu2w==
X-Received: by 2002:a17:906:ece3:b0:6f3:da10:138a with SMTP id qt3-20020a170906ece300b006f3da10138amr17138973ejb.438.1653248937218;
        Sun, 22 May 2022 12:48:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935774.dip0.t-ipconnect.de. [87.147.87.116])
        by smtp.gmail.com with ESMTPSA id q1-20020aa7d441000000b0042aae0a4699sm7375630edr.60.2022.05.22.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 12:48:56 -0700 (PDT)
Date:   Sun, 22 May 2022 21:48:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: vt6655: Replace MACvWriteISR with VNSvOutPortD
Message-ID: <80cd68a83807209230a898ab0260188adfad4158.1653203927.git.philipp.g.hortmann@gmail.com>
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

Replace macro MACvWriteISR with VNSvOutPortD and as it
was the only user, it can now be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 2 +-
 drivers/staging/vt6655/mac.h         | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 5f28d9ea4232..41bc87d80ad8 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1055,7 +1055,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	 * update ISR counter
 	 */
 	while (isr && priv->vif) {
-		MACvWriteISR(priv->port_offset, isr);
+		VNSvOutPortD(priv->port_offset + MAC_REG_ISR, isr);
 
 		if (isr & ISR_FETALERR) {
 			pr_debug(" ISR_FETALERR\n");
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index ebadf527a911..42b216897218 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -648,9 +648,6 @@ do {									\
 	iowrite8(byOrgValue, iobase + MAC_REG_STICKHW);			\
 } while (0)
 
-#define MACvWriteISR(iobase, dwValue)				\
-	VNSvOutPortD(iobase + MAC_REG_ISR, dwValue)
-
 #define MACvIntEnable(iobase, dwMask)				\
 	VNSvOutPortD(iobase + MAC_REG_IMR, dwMask)
 
-- 
2.25.1

