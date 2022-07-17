Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2ED577895
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiGQWU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiGQWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:20:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A99312754
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x91so13101273ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RWNQE77fh9ZO8FyPScCRUXIEK6xi6nY3gZ/2KBXr1no=;
        b=R9TG6huq1rSfwYmKo7BqWKnUxusQWrr5J/h+2zhgjGWtpnuR/HZ7U5l6l0xBIIWwNd
         JKGhlJzZs3Dtv71V7bDZ0+nqERZmPsw9EcTxYblyLDIlMfBtvasP/HPTFbnSxgSnD0BP
         k+y/VU+USR0GncQgEBgAawkeoEWaHUJwnIHswFCXD+02hQal3575PNC2daldOGJ0yKBM
         xxFKsl4/tHbo8IHrq0pCJChumk0iIoMjh+sgAmFqZC++aXLtl1hozWbC/SWfPXTO6NDg
         N2vhGsZKu63mMOWc5X6vBcFqBnU0MT8MESIYbUEUGqKRdXgyBhJsejWkj9Q3VrXTF0Va
         6qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWNQE77fh9ZO8FyPScCRUXIEK6xi6nY3gZ/2KBXr1no=;
        b=xoKhZb5/nZHG/aFflOM1UGRvfPq17+qnuBovGKi+3EOOqjA970iNe3Usd5L1pFZy1v
         MG58+CFvmsYH+v7dR2dsAUs/VRQsUVjGeGsxT3v6VSbhYtD8KFMwFntCBx1sObl4LsYN
         FoZWeYi4d2AESm1dx5SgMKShEzLY3AxZ1wGfqQyvmFiO3vMLSCmb2NrSbNl34jVKxzup
         DSA1ICmE+Qt3P8RsxUTn3UzFhpmEL4euMllA2Af5n6xaIkUZvHIImDcDcbTX2G4NTTT7
         XP14dIKu4h1KIThf/fOYxYCXo/2lcV+A+8Jm9sj3u87raTWKYTYMPP6E1dD2j8wJeqLw
         QOcw==
X-Gm-Message-State: AJIora/C1seohdUOfdtHbnphP2ume11vXsRxZnWB7DjhUq3l+J0MGkIE
        vo/Nx+wgEbuneuim48jGQBM=
X-Google-Smtp-Source: AGRyM1tTenj57kboVS6PEUTMQtPa+0+328zk9VkRUSrxA5Dk3CDE19uoT4xQv7SueFQnk3IYmkSvpg==
X-Received: by 2002:a05:6402:2812:b0:43a:9041:d5db with SMTP id h18-20020a056402281200b0043a9041d5dbmr33168956ede.208.1658096435979;
        Sun, 17 Jul 2022 15:20:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0072afb6d4d6fsm4883034eja.171.2022.07.17.15.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 15:20:35 -0700 (PDT)
Date:   Mon, 18 Jul 2022 00:20:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: vt6655: Replace MACvTransmitAC0 with function
 vt6655_mac_dma_ctl
Message-ID: <1e475fbda07a69b7b3cf53fd18bd0390e87ebfe2.1658094708.git.philipp.g.hortmann@gmail.com>
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
index 898e06958203..b2f3174f80df 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1231,7 +1231,7 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	wmb(); /* second memory barrier */
 
 	if (head_td->td_info->flags & TD_FLAGS_NETIF_SKB)
-		MACvTransmitAC0(priv->port_offset);
+		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_AC0DMACTL);
 	else
 		vt6655_mac_dma_ctl(priv->port_offset, MAC_REG_TXDMACTL0);
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 1e57663ff066..e2ef8c6ef7b7 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,16 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvTransmitAC0(iobase)					\
-do {									\
-	unsigned long reg_value;					\
-	reg_value = ioread32(iobase + MAC_REG_AC0DMACTL);		\
-	if (reg_value & DMACTL_RUN)					\
-		iowrite32(DMACTL_WAKE, iobase + MAC_REG_AC0DMACTL);	\
-	else								\
-		iowrite32(DMACTL_RUN, iobase + MAC_REG_AC0DMACTL);	\
-} while (0)
-
 #define MACvClearStckDS(iobase)					\
 do {									\
 	unsigned char byOrgValue;					\
-- 
2.37.1

