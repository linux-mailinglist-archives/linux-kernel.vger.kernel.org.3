Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F54BB56E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiBRJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:23:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiBRJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:23:31 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7A2C12E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:23:14 -0800 (PST)
Received: from dslb-178-004-174-047.178.004.pools.vodafone-ip.de ([178.4.174.47] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nKzTo-0005Qj-Nr; Fri, 18 Feb 2022 10:23:08 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH RFC] staging: r8188eu: comment about the chip's packet format
Date:   Fri, 18 Feb 2022 10:22:53 +0100
Message-Id: <20220218092252.853807-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structs phy_rx_agc_info and phy_status_rpt define parts of the
header data that the r8188eu chipset sends to this driver via usb.

Add a comment to clarify that we cannot modify the content of these
structures and remove seemingly unused fields.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

Dear all,

I experimented with "cleaning up" these structures and related code before
discovering that their content comes from usb packets we receive from the
r8188eu chipset.

Would it make sense to add a word of warning to prevent others from
repeating this exercise?

Thanks,
Martin

 drivers/staging/r8188eu/include/odm_HWConfig.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index b37962edb2ed..35a562372a1a 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -14,6 +14,13 @@
 
 /*  structure and define */
 
+/*
+ * Attention: struct phy_status_rpt and struct phy_rx_agc_info describe
+ * data structures that this driver receives from the r8188eu chip via usb.
+ * Do not change the content of these structures, do not remove seemingly
+ * unused entries.
+ */
+
 struct phy_rx_agc_info {
 	#ifdef __LITTLE_ENDIAN
 		u8	gain:7, trsw:1;
-- 
2.30.2

