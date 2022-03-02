Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326E34CA8FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiCBPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiCBPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:23:22 -0500
X-Greylist: delayed 1133 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 07:22:36 PST
Received: from ns6.inleed.net (mailout6.inleed.net [IPv6:2a0b:dc80:cafe:106::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DB136E05
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=samuelsjoberg.se; s=x; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xTC7NiZtkaPonWn5jFaFXV5sKCDXggznd8jr8HGYFbg=; b=pQ/dfaPcwq2koT+sFxBU7YNNVm
        D43Nih7Il16Oh+DY8W1O+rG5fvh8PuJMzuM1FlloCyrw/+Mcenv2aq3STlHGSW/dwaN5ozp01Dnec
        pAsnagL3DosrdXbLlCsESSZsP0nXghRrliBm4eMIr0Ow/DRj77cgloZjE4S1OpnlvZT5l6227w50I
        K6W0MOY4CRZF155xwFpg06dA/I2v3lSk45QwqLoJSduTWDp3V4/LvCqNRrP3wt/iRO0rBlNsm32GX
        Sm4IVrNkS+ac7zzHZMUH6FcizcbwzzPPFBH6NuiseOWYpq36gDNIBsWp0Qld+GJrgd/WoyNDfgOwX
        1yqSpRzQ==;
Received: from ua-85-224-113-194.bbcust.telenor.se ([85.224.113.194] helo=kernelws.localdomain)
        by ns6.inleed.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <samuelsjoberg@samuelsjoberg.se>)
        id 1nPQW2-007nAQ-Sn;
        Wed, 02 Mar 2022 16:03:46 +0100
Received: by kernelws.localdomain (Postfix, from userid 1000)
        id AE5305EFA1; Wed,  2 Mar 2022 16:03:35 +0100 (CET)
From:   =?UTF-8?q?Samuel=20Sj=C3=B6berg?= <info@samuelsjoberg.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        info@samuelsjoberg.se
Subject: [PATCH] staging: rts5208: fix Lines should not end with a '('.
Date:   Wed,  2 Mar 2022 16:03:28 +0100
Message-Id: <20220302150328.2722-1-info@samuelsjoberg.se>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@samuelsjoberg.se
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following check reported by checkpatch.pl:

CHECK: Lines should not end with a '('
                                        retval = ms_transfer_tpc(

Signed-off-by: Samuel Sjöberg <info@samuelsjoberg.se>
---
 drivers/staging/rts5208/ms.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 2a6fab5c117a..14449f8afad5 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -1749,11 +1749,10 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 				for (rty_cnt = 0; rty_cnt < MS_MAX_RETRY_COUNT;
 				     rty_cnt++) {
-					retval = ms_transfer_tpc(
-						chip,
-						MS_TM_NORMAL_WRITE,
-						WRITE_PAGE_DATA,
-						0, NO_WAIT_INT);
+					retval = ms_transfer_tpc(chip,
+								 MS_TM_NORMAL_WRITE,
+								 WRITE_PAGE_DATA,
+								 0, NO_WAIT_INT);
 					if (retval == STATUS_SUCCESS)
 						break;
 				}
-- 
2.35.1

