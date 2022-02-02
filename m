Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF54A6C06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbiBBHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:02:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49598 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiBBHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:02:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4A561725;
        Wed,  2 Feb 2022 07:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E623AC004E1;
        Wed,  2 Feb 2022 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643785322;
        bh=1Q7jHDq8Ep5G9c1wiZDgu8/YIoEi3BDZpHF88CwnPCw=;
        h=Date:From:To:Cc:Subject:From;
        b=ZFG/mYt5wvg0M4Hxk9AhiEFaWy9tEksm76vxSYmw7j9mTetnmD4sfp5ZwDsfkcmY+
         Ss0J5lrYZanq+jovoF72FR/QfYJ2aEJ9sdAHlbR37D0Bzlt/yOWzPgqOX9WELMnfxx
         aRcZIF5zQ1ewRyjFoOKqISlIzjlycticar01ZwwIcng4k30Klr7/Dd3YlR4owXyWht
         PmUSTsc4xr+Bh2uPVxCHVXW99USJFfYZSCvQcPmPRKxJCP/dnZHUp02wyF9Jf2zghD
         c561zoOZEjJ5RhEN8sryC9YmyksgIDZ0tz40mzTuaKbaSVeer4sDzBpTGj3IZ1sOi6
         t7hV5vR17D3XQ==
Date:   Wed, 2 Feb 2022 01:09:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] staging: r8188eu: Silence out-of-bounds warning in
 HT_caps_handler()
Message-ID: <20220202070906.GA274379@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence the following out-of-bounds warning (caught with -Warray-bounds=2):

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

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Change subject line and changelog text.
 - Add RB tag.

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

