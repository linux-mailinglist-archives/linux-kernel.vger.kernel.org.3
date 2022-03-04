Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F874CD3C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiCDLt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiCDLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:49:58 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0751B1DD1;
        Fri,  4 Mar 2022 03:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646394544;
        bh=AIDMXBc8l59dOY/mPpvQ/FWRUbozuV63c41/mFfvSC4=;
        h=From:To:Cc:Subject:Date;
        b=Iza5Lj9JE74WREUC+zbYWrNnApwfW5En6mpdwOknxeQIQCzYmGm1LrKYCnggqu2x/
         pRD+ioCJMUer0oQIw863j0Pat3S75g0lofWKw33p5Un0MT/4cB/kr5BDzAnxsyzDYI
         yyRll4hh2wNFBPykWMZOHZAETycNtJcAPWsNsavE=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id C3BA481B; Fri, 04 Mar 2022 19:48:59 +0800
X-QQ-mid: xmsmtpt1646394539tj8y1kb28
Message-ID: <tencent_E6A97F6B1009E6F65C230E070A9770612507@qq.com>
X-QQ-XMAILINFO: ODdZrkDuTlAgNeTh1j/G2NL1AHblXm8Qf0chvyulSFxRRsk53IVVHln3BhaP3j
         2x5HpnqX8bUwH3ycK+VgZkGcJTJhweMZum9+agjIf2ncDjQARXi4dawI+P27G8ZBH08KIEixBcYa
         EznLl8Wd2lAcMF5R85X/Ygw0VMWvlKg0B2PWlFfsN3kIFOHplJ5syzyxBnJ7dJtF6bzqrUnFqf1k
         XCAdRLu8WKnXOm+UidM9WcwlQCNO3m3RX26yZoeK3wMM93cLJddmnpAvYesw2Rocobulvp9qWHtv
         F2Bpr5Ot9E6acH8nyfpr81Y2B4agNTqwMfnosbK1Hmr5HiPE79Cvy8qE2giNb6053C3owoTXuOMo
         CIvh5LN14UalMBbz5WXVl1Xkp0yu1qcuGdftXuN6A7mF2mJwZwkKdZULfKgNLIQRKXFcB2dPagOG
         MwwaROLOGV+9Lu8XqgylvdetCC9Jwv2jD5Y1r2OKlBZN8z9JJoVj7PVZArvqT/yX9yCE64wq6Etw
         zfQQZEAIKDcnZJX9lNcvcuGxcnIflzVV92DdehSyldaWE4HeavEKx0KKMMpv4kR/stp84mt1iO9F
         aZ0v7rbODV6StlE0zLOZ187lY62L8hFrdKitagf9+GHsU4YoTa7LyNkeBGE5xCWI+226T+rJ9I/O
         3TYPHAoMrKIolhNM9ZbElkQB8YIHmSjod6Zwhk2OFQQ+1pNkvQ4qUk4Y1NKslU5BGR2yNGuq7i6K
         L2TQU0U1tGwN6ax0kO7IP27NpYtBEm5vpptYuk3dzzkKRCpn3hv+Ic9oiOoiDAw7SGY+FfMHNyvr
         Cfe+DfWs21W0nzdmkFT/sH5T0G7KXeVFtCB7B11sPjRlbuJnAc6sII+EW8HwoH6sPOR/bqTgcvKV
         P0NKBOV4v2sFGWxPmdEVkZmRlACLENcKpq+Mx+EMROy1lFWgi34ca4uxy2sZ6hcgqF0CkrJ+4p8s
         V5JyKPVHO01FhkM6AuUQ==
From:   xkernel.wang@foxmail.com
To:     laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] media: omap3isp: check the return of __ccp2_get_format()
Date:   Fri,  4 Mar 2022 19:48:18 +0800
X-OQ-MSGID: <20220304114819.5566-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

__ccp2_get_format() returns format structure or NULL on error.
So it is better to check the return value of it to prevent potential
wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/media/platform/omap3isp/ispccp2.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap3isp/ispccp2.c b/drivers/media/platform/omap3isp/ispccp2.c
index acb58b6..81881b1 100644
--- a/drivers/media/platform/omap3isp/ispccp2.c
+++ b/drivers/media/platform/omap3isp/ispccp2.c
@@ -675,8 +675,10 @@ static void ccp2_try_format(struct isp_ccp2_device *ccp2,
 		 */
 		format = __ccp2_get_format(ccp2, sd_state, CCP2_PAD_SINK,
 					   which);
-		memcpy(fmt, format, sizeof(*fmt));
-		fmt->code = MEDIA_BUS_FMT_SGRBG10_1X10;
+		if (format != NULL) {
+			memcpy(fmt, format, sizeof(*fmt));
+			fmt->code = MEDIA_BUS_FMT_SGRBG10_1X10;
+		}
 		break;
 	}
 
@@ -709,6 +711,9 @@ static int ccp2_enum_mbus_code(struct v4l2_subdev *sd,
 
 		format = __ccp2_get_format(ccp2, sd_state, CCP2_PAD_SINK,
 					   code->which);
+		if (format == NULL)
+			return -EINVAL;
+
 		code->code = format->code;
 	}
 
@@ -792,6 +797,9 @@ static int ccp2_set_format(struct v4l2_subdev *sd,
 	if (fmt->pad == CCP2_PAD_SINK) {
 		format = __ccp2_get_format(ccp2, sd_state, CCP2_PAD_SOURCE,
 					   fmt->which);
+		if (format == NULL)
+			return -EINVAL;
+
 		*format = fmt->format;
 		ccp2_try_format(ccp2, sd_state, CCP2_PAD_SOURCE, format,
 				fmt->which);
-- 
