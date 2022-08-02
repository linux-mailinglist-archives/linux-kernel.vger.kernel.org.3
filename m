Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D000587509
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiHBBZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiHBBZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:25:29 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4A94DFCB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:25:26 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 430581E80D46;
        Tue,  2 Aug 2022 09:24:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f-8E1Qt2Fo4p; Tue,  2 Aug 2022 09:24:41 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 74B651E80D12;
        Tue,  2 Aug 2022 09:24:41 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     gregkh@linuxfoundation.org, sevinj.aghayeva@gmail.com,
        hdegoede@redhat.com, fabioaiuto83@gmail.com, duoming@zju.edu.cn,
        keescook@chromium.org
Cc:     straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] staging/rtl8723bs/core: remove inactive initialization
Date:   Tue,  2 Aug 2022 09:25:13 +0800
Message-Id: <20220802012513.2824-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation address of the psta pointer variable is first performed
in the function, no initialization assignment is required, and no
invalid pointer will appear.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f2242cf2dfb4..6498fd17e1d3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2521,7 +2521,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 {
 	u8 issued;
 	int priority;
-	struct sta_info *psta = NULL;
+	struct sta_info *psta;
 	struct ht_priv *phtpriv;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	s32 bmcst = IS_MCAST(pattrib->ra);
-- 
2.18.2

