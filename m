Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6A4B7C31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbiBPBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:08:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiBPBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A1F540B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i14so807488wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1Q9KHfCC/OhWO4R3f8f7EViIH7aioyjrinMYnTE/2s=;
        b=OA8gW7q0Y5pG0pfTqJHJ53P5oP0r/70Jtl+5C7oIxwS1g9tvwMzrr3K+pe6Cq2wQ1U
         Zhzy+jyRnuFZmR5TkMeVWwtabDlcsTKo3NYkcCseAnTTMWu/9KyvcaiEJV43baTMGnnY
         USaS+khrDCDZyWx3UixIMO5uVn0V5/4C1HZRrbdlJ9//d48xROEC5sv/wyLUrEk5GSbx
         teAZEqHLjRT1Y2c+8p8p2z+KwwewS4yI1ACVbAtegQFE2p5JhdHCgidpg8K0i1AIanTb
         OM4Aiyu53c0RQtWf+Sw6M/eVMCt9ToFcB4ZJmC9dGGUgkVcp2HZsUob14etGXIINEvqB
         m1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1Q9KHfCC/OhWO4R3f8f7EViIH7aioyjrinMYnTE/2s=;
        b=kEx7Fv9uv21gGbr+oZWiKNo9oTEKM20IIIxf1OjhK5baE9VDMNLDtnlhckML2T/27R
         jv8QxB72JWEOAEjQeeQ7oT5mNNjkq3MMNyEvkM9Sht1z4DsYCKQAGbyeI5OVc5FU3+9V
         ++0y9yM5y+tycIreF4WHZSC8QIRXRsW3C7KLpcRbOqeoWtXasBCQ1sbZk3XOhPuHHTuv
         K5yBMOaEfmHdflAm5J2JCR+7MWQUs1YxoAx0fgjYTISKupg6E9ucQg9I7w/9oeyUSuIU
         PRdmBYdsqwi2J9rqEEF4D6RcdEsxZ3PcKqt6jh9pdOfkrLJ9R8NJE9iMTLgx3zfAa4fZ
         o6dg==
X-Gm-Message-State: AOAM531WWSG98kwSMygMuxpRgBJazQJ+L0LZZ02Azz36sB/R8favFsE6
        QRMqpCZ4X6Gd40eUnC7kOxDmig==
X-Google-Smtp-Source: ABdhPJyq9vxGVpr5c1MSes2nprSlGrtG5tJFX/Is6UdgrIgki5Bv6Ix3A+V8zW6hT6fzWdUMI1nJgA==
X-Received: by 2002:a5d:5705:0:b0:1e3:e023:36fc with SMTP id a5-20020a5d5705000000b001e3e02336fcmr336803wrv.613.1644973643305;
        Tue, 15 Feb 2022 17:07:23 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:22 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 14/15] staging: r8188eu: remove padapter param from aes_decipher function
Date:   Wed, 16 Feb 2022 01:07:08 +0000
Message-Id: <20220216010709.791-15-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove padapter parameter from aes_decipher function in
core/rtw_security.c, as I added it previously during debugging tweaks
and it is no longer required.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 7861dfa235c0..b73aea8a7fb5 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -1144,7 +1144,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-static int aes_decipher(struct adapter *padapter, u8 *key, uint hdrlen,
+static int aes_decipher(u8 *key, uint hdrlen,
 			u8 *pframe, uint plen)
 {
 	static u8	message[MAX_MSG_SIZE];
@@ -1365,7 +1365,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
 			length = precvframe->len - prxattrib->hdrlen - prxattrib->iv_len;
-			res = aes_decipher(padapter, prwskey, prxattrib->hdrlen, pframe, length);
+			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 		} else {
 			res = _FAIL;
 		}
-- 
2.34.1

