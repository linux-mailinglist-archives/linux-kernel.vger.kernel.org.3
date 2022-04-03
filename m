Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D14F0979
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358038AbiDCMka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiDCMk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:40:27 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.146.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A512BC91
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:38:32 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 01304AA0F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:38:32 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id azT5nKsvhRnrrazT5nPSj5; Sun, 03 Apr 2022 07:36:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CYOWZgHjZ+R9GBciJmXVJ6KuHCf+mXuaB0YT+N2ma3o=; b=IY4EDNfee5a4+olnuCoiU/tDYn
        ckCHxny/SYfc/Z53UlZLknsrnrNdVNEuj3wQ7Kf0RRWdVhnrsvzyGf0Z3lQ4WOtwjkN8QkbiO2lOz
        /IUu33ELx5GRSj4T0JggjxBjXHP64DJx/JQiIsSsOQjLsHlfFOA41Cxr5PeRgRgeH8i58g47ZMrO/
        9Y7O8V2PrPdgpJL8HvX4fZUZDSxMx2+C3RzbQgWpcAyd5G4js7PRc1E484bGJ6Cx+7ulGqvzNFsU4
        H7oaAHClu6iBzPs1+bmNxrRPC7zJbb/2RW4OZ+3Hoxy5ssXCJS63Qy86+hCvunxtWr8btTNDGB5He
        L/H3UPfg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57820 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nazT4-001y5E-TV; Sun, 03 Apr 2022 12:36:31 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] staging: r8188eu: Fix PPPoE tag insertion on big endian systems
Date:   Sun,  3 Apr 2022 05:36:28 -0700
Message-Id: <20220403123628.3113382-1-linux@roeck-us.net>
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
X-Exim-ID: 1nazT4-001y5E-TV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57820
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __nat25_add_pppoe_tag(), the tag length is read from the tag data
structure. The value is kept in network format, but read as raw value.
With -Warray-bounds, this results in the following gcc error/warning
when building the driver on a big endian system such as alpha.

In function '__nat25_add_pppoe_tag',
    inlined from 'nat25_db_handle' at
	drivers/staging/r8188eu/core/rtw_br_ext.c:479:11:
arch/alpha/include/asm/string.h:22:16: error:
	'__builtin_memcpy' forming offset [40, 2051] is out of the bounds
	[0, 40] of object 'tag_buf' with type 'unsigned char[40]'

Add the missing be16_to_cpu() to fix the compile error. It should be
noted, however, that this fix means that the code did probably not work
on little endian systems and/or that the driver has other endiannes related
issues. A build with C=1 suggests that this is indeed the case. This patch
does not attempt to fix any of those issues.

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Cc: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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

