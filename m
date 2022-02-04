Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2C4AA43E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378087AbiBDXXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358955AbiBDXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:23:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3E1DFBFFAE;
        Fri,  4 Feb 2022 15:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3416CE248E;
        Fri,  4 Feb 2022 23:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8397C004E1;
        Fri,  4 Feb 2022 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016984;
        bh=9P1b74WtVzZInz8h2Map/kXphQdxYtNWHMeXnkSUnm0=;
        h=Date:From:To:Cc:Subject:From;
        b=YZIno/g6yKC7ttomeryazCn7gfeS0G3OE31leh3kiR4qRitJ4eYSj+t6TfZBVP3uV
         CJeCakEVpYoB0U/xLCLrNWgxcrJHkgscx8kWPNb786I9wb9QtY7bHgb1cZtPIRQlTW
         teKdLC6f+k3bVs+iLyhU9nGsMMNtBYCRvL9NP2VkznuZ8L/qDy3Psuqop7WiTkMVAO
         uHwbJa5T0LY2bFtGukyGtgAmKuiHVsQLBb0KtgqGAHKDkK6qbYJIxBz1ymWoIIXGvW
         hynF2rX0TqpztGx17DVpX4yQbVOkxaFYIw0WSAn0h9TVMSY0ti2fuYYetyRY6dvoKB
         KjdkqgVA5fZTg==
Date:   Fri, 4 Feb 2022 17:30:15 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: wlan-ng: Replace one-element arrays with
 flexible-array members
Message-ID: <20220204233015.GA454979@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

This issue was found with the help of Coccinelle and audited and fixed,
manually.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/wlan-ng/p80211mgmt.h  | 8 ++++----
 drivers/staging/wlan-ng/p80211types.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index 1ef30d3f3159..d6fe52de2c8f 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -229,14 +229,14 @@ struct wlan_ie {
 struct wlan_ie_ssid {
 	u8 eid;
 	u8 len;
-	u8 ssid[1];		/* may be zero, ptrs may overlap */
+	u8 ssid[];		/* may be zero, ptrs may overlap */
 } __packed;
 
 /*-- Supported Rates  -----------------------------*/
 struct wlan_ie_supp_rates {
 	u8 eid;
 	u8 len;
-	u8 rates[1];		/* had better be at LEAST one! */
+	u8 rates[];		/* had better be at LEAST one! */
 } __packed;
 
 /*-- FH Parameter Set  ----------------------------*/
@@ -274,7 +274,7 @@ struct wlan_ie_tim {
 	u8 dtim_cnt;
 	u8 dtim_period;
 	u8 bitmap_ctl;
-	u8 virt_bm[1];
+	u8 virt_bm[];
 } __packed;
 
 /*-- IBSS Parameter Set ---------------------------*/
@@ -288,7 +288,7 @@ struct wlan_ie_ibss_parms {
 struct wlan_ie_challenge {
 	u8 eid;
 	u8 len;
-	u8 challenge[1];
+	u8 challenge[];
 } __packed;
 
 /*-------------------------------------------------*/
diff --git a/drivers/staging/wlan-ng/p80211types.h b/drivers/staging/wlan-ng/p80211types.h
index 6486612a8f31..b2ffd09881b0 100644
--- a/drivers/staging/wlan-ng/p80211types.h
+++ b/drivers/staging/wlan-ng/p80211types.h
@@ -234,7 +234,7 @@ struct p80211pstr32 {
 /* MAC address array */
 struct p80211macarray {
 	u32 cnt;
-	u8 data[1][MAXLEN_PSTR6];
+	u8 data[][MAXLEN_PSTR6];
 } __packed;
 
 /* prototype template */
-- 
2.27.0

