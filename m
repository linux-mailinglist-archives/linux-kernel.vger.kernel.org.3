Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97665565E4D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiGDURX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiGDURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:17:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF311A1C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 13:17:13 -0700 (PDT)
Received: from dslb-178-004-207-027.178.004.pools.vodafone-ip.de ([178.4.207.27] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o8SVG-00007Y-L2; Mon, 04 Jul 2022 22:17:06 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/6] staging: r8188eu: don't set pattrib->dst again
Date:   Mon,  4 Jul 2022 22:16:50 +0200
Message-Id: <20220704201654.195574-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704201654.195574-1-martin@kaiser.cx>
References: <20220704201654.195574-1-martin@kaiser.cx>
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

Do not set pattrib->dst again in ap2sta_data_frame. This function is
called by validate_recv_data_frame when the packet's ToDS==0 and
FromDS==1.

In this case, validate_recv_data_frame has already set pattrib->dst
to addr1.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 9c63319a7d48..ea81501b3286 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -704,7 +704,6 @@ static int ap2sta_data_frame(
 		}
 	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE) &&
 		   check_fwstate(pmlmepriv, _FW_LINKED)) {
-		memcpy(pattrib->dst, GetAddr1Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->src, GetAddr2Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
-- 
2.30.2

