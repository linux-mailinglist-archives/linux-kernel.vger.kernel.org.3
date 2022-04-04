Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7D4F1652
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354088AbiDDNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiDDNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:45:38 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861E2ADB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:43:42 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 2FC033339B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:43:42 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bMzene0IVXvvJbMzenhTto; Mon, 04 Apr 2022 08:43:42 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7PYozm/ATicWotchWm5FupK5vVZvpTu0fQKaRndvMaM=; b=EffaQC0MOfAY86zFzzRHDkeLEl
        kfmkvMmiN3U/fipvE5s1H3DirlUH0Kt5HNjjK/rXrEzmnW7II81NUvKHUN7845KYedKZBQnMbJKr7
        WD/0oYlvLJ7fQhMqbEL5DDEjKpWNFJ/t/ORPoFNhcc7GX2tuayszFP97cZx/Az52G9TXz2PVhJVmy
        pqmjfkBauQPUX/pcKrEPUyjy+HbetZu64TkR6dX1n8WRd+CUiJyNJ3cLZDY+sJuw6hX9iIaMRkEpe
        +Z3HY/grDa7lIoCYlClk1mf6WK4jBMZkVpETpG2283cTSWHAWC0qZbHipgR53WycGn7t35yPyZdrr
        S4FwOdlw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57844 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbMzd-000dg4-Jh; Mon, 04 Apr 2022 13:43:41 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3] staging: r8188eu: Fix PPPoE tag insertion on little endian systems
Date:   Mon,  4 Apr 2022 06:43:38 -0700
Message-Id: <20220404134338.3276991-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbMzd-000dg4-Jh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57844
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __nat25_add_pppoe_tag(), the tag length is read from the tag data
structure. The value is kept in network format, but read as raw value.
With -Warray-bounds, this results in the following gcc error/warning
when building the driver on alpha.

In function '__nat25_add_pppoe_tag',
    inlined from 'nat25_db_handle' at
	drivers/staging/r8188eu/core/rtw_br_ext.c:479:11:
arch/alpha/include/asm/string.h:22:16: error:
	'__builtin_memcpy' forming offset [40, 2051] is out of the bounds
	[0, 40] of object 'tag_buf' with type 'unsigned char[40]'

Add the missing be16_to_cpu() to fix the compile error. It should be
noted, however, that this fix means that the code did probably not work
on any little endian systems and/or that the driver has other endiannes
related issues. A build with C=1 suggests that this is indeed the case.
This patch does not attempt to fix any of those other issues.

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Cc: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: alpha is little endian, not big endian. Change wording of subject
    and commit message accordingly.
v2: Use be16_to_cpu().
    Add comment to patch description suggesting that the driver may have
    other endianness related problems.

 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index d68611ef22f8..f056204c0fdb 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len)
 		return -1;
 
-- 
2.35.1

