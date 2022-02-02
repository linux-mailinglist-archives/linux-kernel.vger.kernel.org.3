Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11F4A6B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 06:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiBBFUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 00:20:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51486 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiBBFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 00:20:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 242E6B83009;
        Wed,  2 Feb 2022 05:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11094C004E1;
        Wed,  2 Feb 2022 05:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643779237;
        bh=+Ft2F5sVLRHh1Pp8pxHlA0yq0lccuM3N/YhAGhykIME=;
        h=Date:From:To:Cc:Subject:From;
        b=JFyHcFJ4V4CNFYHfgEGRKpfVGFlbHoOrQFHo48cbL463opA/mHP7hGlNJLVAy0Kbl
         6K/1/ox6yPyL/ubuniQ8q9ZXgrXxSa7YFbet9woC9sy7boZSQYURx7YwNxq+ljWv/y
         4wxTW5Skq2bJG+GM7A3tCV7unY6+w2ygRPCxv9ETkrXkG/hkOFy/YEDspglnDNbptB
         MUuhJcxOYAOdy1c1LcH+rIRXMDQe9MvI3cWffR66SmieOcbFQZ64Wu8ekkGOSeyIPx
         d4PngYy/4MaOshdlP/DH6Uc/63UvfG+46fr0S91g/E3cG66m/z47UC9mq23CqSmftq
         3/ohsts/pcy4w==
Date:   Tue, 1 Feb 2022 23:27:41 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: r8188eu: Fix out-of-bounds error in
Message-ID: <20220202052741.GA238470@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HT_caps_handler()
Reply-To: 

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

