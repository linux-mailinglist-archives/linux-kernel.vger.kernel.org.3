Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E184F8407
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbiDGPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245209AbiDGPuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:50:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E989C55B4;
        Thu,  7 Apr 2022 08:48:34 -0700 (PDT)
Date:   Thu, 07 Apr 2022 15:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649346513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSV1Y0A1YFqBZyGZ5+k6dqhl1M9bVriVuqUTvC59O9s=;
        b=HUBqG69MDoi41D91M1gJ5qTtImY+x37B2lO1PGinJW4hinxdcw0un00ARcUVJJpKUMqWjK
        pHjlm3xC0p2sgskZeK8MyisRh96/7meRRZdFdayS8f/FUlO1tRdBOkmi9Ht4Jtte/xosDu
        zy+esjLDuHxtIqtNUw3uzVOdpEZOo0UYDf5q7mhIT/jn6K70nb3jSYNDsRFaUjs74i6Gtq
        eNSUGtQ3mzc35J2v9O1aqDfh8kBNQuaws3XBDh9TdQtJuY98RIgXoAmhlKOrtewNzIhCB0
        iCntTHL1SbIZTH6vIsWjl+NiW/IrXS/bAZ8jadzrmK5iUbk7M3Y3+RiMJzDdag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649346513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSV1Y0A1YFqBZyGZ5+k6dqhl1M9bVriVuqUTvC59O9s=;
        b=lbWlV1rpOXTdno6LIjCxmr5P8DUda65y6kKUoPUacA7OM/5FK+EW1NTz84++kjxvAji9vb
        KXvg1GQzSsBDhrBA==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update NMI Handler for UV5
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220406195149.228164-2-steve.wahl@hpe.com>
References: <20220406195149.228164-2-steve.wahl@hpe.com>
MIME-Version: 1.0
Message-ID: <164934651199.389.15893962455606491477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     d812f7c475c6a4dcfff02a85fbfd7a9c87e6a094
Gitweb:        https://git.kernel.org/tip/d812f7c475c6a4dcfff02a85fbfd7a9c87e6a094
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Wed, 06 Apr 2022 14:51:47 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 17:23:20 +02:00

x86/platform/uv: Update NMI Handler for UV5

Update NMI handler for UV5 hardware. A platform register changed, and
UV5 only uses one of the two NMI methods used on previous hardware.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220406195149.228164-2-steve.wahl@hpe.com
---
 arch/x86/platform/uv/uv_nmi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 1e9ff28..61ec3be 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -244,8 +244,10 @@ static inline bool uv_nmi_action_is(const char *action)
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
+	bool new_nmi_method_only = false;
+
 	/* First determine arch specific MMRs to handshake with BIOS */
-	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
+	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {	/* UV2,3,4 setup */
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
@@ -255,26 +257,25 @@ static void uv_nmi_setup_mmrs(void)
 		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
 		uvh_nmi_mmrx_req_shift = 62;
 
-	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) {
+	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) { /* UV5+ setup */
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
 		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
 
-		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
-		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
-		uvh_nmi_mmrx_req_shift = 62;
+		new_nmi_method_only = true;		/* Newer nmi always valid on UV5+ */
+		uvh_nmi_mmrx_req = 0;			/* no request bit to clear */
 
 	} else {
-		pr_err("UV:%s:cannot find EVENT_OCCURRED*_EXTIO_INT0\n",
-			__func__);
+		pr_err("UV:%s:NMI support not available on this system\n", __func__);
 		return;
 	}
 
 	/* Then find out if new NMI is supported */
-	if (likely(uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
-		uv_write_local_mmr(uvh_nmi_mmrx_req,
-					1UL << uvh_nmi_mmrx_req_shift);
+	if (new_nmi_method_only || uv_read_local_mmr(uvh_nmi_mmrx_supported)) {
+		if (uvh_nmi_mmrx_req)
+			uv_write_local_mmr(uvh_nmi_mmrx_req,
+						1UL << uvh_nmi_mmrx_req_shift);
 		nmi_mmr = uvh_nmi_mmrx;
 		nmi_mmr_clear = uvh_nmi_mmrx_clear;
 		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
