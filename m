Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBF57A3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiGSPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbiGSPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:53:24 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDDB20180
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:53:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 5CEC44076251;
        Tue, 19 Jul 2022 15:53:14 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] staging: rtl8723bs: remove useless comparison in _rtw_reg_apply_flags()
Date:   Tue, 19 Jul 2022 18:53:09 +0300
Message-Id: <20220719155309.463286-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'ch' is initialized by an address
of field of ieee80211_supported_band structure, so it does
not make sense to compare 'ch' with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
---
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
index 5eef1d68c6f0..62fbf9e1b849 100644
--- a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
+++ b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
@@ -74,8 +74,7 @@ static void _rtw_reg_apply_flags(struct wiphy *wiphy)
 			for (j = 0; j < sband->n_channels; j++) {
 				ch = &sband->channels[j];
 
-				if (ch)
-					ch->flags = IEEE80211_CHAN_DISABLED;
+				ch->flags = IEEE80211_CHAN_DISABLED;
 			}
 		}
 	}
-- 
2.25.1

