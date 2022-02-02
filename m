Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC84A6B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 06:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbiBBFYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 00:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiBBFYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 00:24:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD40C061714;
        Tue,  1 Feb 2022 21:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6052616F4;
        Wed,  2 Feb 2022 05:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9698CC004E1;
        Wed,  2 Feb 2022 05:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643779472;
        bh=j0Se/qdEtuI552spXh1n3SW3Pdql6yIzAII1xQVtw7o=;
        h=Date:From:To:Cc:Subject:From;
        b=t2rqmqJXBCpb4sjddufoteghBZEXckpCHKs7F8Sk1UQVh15Qowdg59mh1/icCLHSz
         SYERpgR3GiTmmo12Umvnvc4xqgWBOhdU88ttWFhhyV6jYQX1KHHO8ESSuAmqFqbnjI
         Kv21c37z7X+M2EILGA+Wn+X2aNcKbJQheyxg8KR0mfVkaY1QKK2Xk8mrWUwe4b0ODm
         +n5rjjEUC+8mSjg+uwMOIh0fhD3kM2xROa5+VGQGs/euSCoXdjuXZGMp/svs4PZohC
         gQRQ9lHgoQpv8ha3hptkt6eKl5ssCeLo53RnWpPeS97pZ/Uaxh2aMi6BZ2gkdOiYFl
         GM2YBZdf7l7EQ==
Date:   Tue, 1 Feb 2022 23:31:36 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] staging: r8188eu: Fix out-of-bounds error in
 HT_caps_handler()
Message-ID: <20220202053136.GA238541@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following out-of-bounds error (caught with -Warray-bounds=2):

drivers/staging/r8188eu/core/rtw_wlan_util.c: In function ‘HT_caps_handler’:
drivers/staging/r8188eu/core/rtw_wlan_util.c:719:54: error: array subscript 2 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Werror=array-bounds]
  719 |                                             pIE->data[i] & 0x3);
      |                                             ~~~~~~~~~^~~
./include/linux/minmax.h:32:39: note: in definition of macro ‘__cmp_once’
   32 |                 typeof(y) unique_y = (y);               \
      |                                       ^
./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp’
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
drivers/staging/r8188eu/core/rtw_wlan_util.c:718:41: note: in expansion of macro ‘min’
  718 |                         max_AMPDU_len = min(pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x3,
      |                                         ^~~
In file included from drivers/staging/r8188eu/core/../include/drv_types.h:16,
                 from drivers/staging/r8188eu/core/rtw_wlan_util.c:7:
drivers/staging/r8188eu/core/../include/wlan_bssdef.h:64:13: note: while referencing ‘data’
   64 |         u8  data[1];
      |             ^~~~

by transforming one-element array into a flexible-array member in
struct ndis_802_11_var_ie

This is part of the ongoing efforts to globally enable -Warray-bounds.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Fix subject line.

 drivers/staging/r8188eu/include/wlan_bssdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index 99ca097b8edd..9d1c9e763287 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -61,7 +61,7 @@ struct ndis_802_11_fixed_ie {
 struct ndis_802_11_var_ie {
 	u8  ElementID;
 	u8  Length;
-	u8  data[1];
+	u8  data[];
 };
 
 /*
-- 
2.27.0

