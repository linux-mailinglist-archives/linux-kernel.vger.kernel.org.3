Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C059AF79
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHTSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiHTSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA56C31DF1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j21so8868712ejs.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=s0gG/Y/1ndpD2o1oxGib08M1iLWS4DAsSTix2vBGTk8=;
        b=M2RXBrxGosxefZjApl+IioG6a4nCIvHduh8TOb3I3CAhWA5L5dzlxxunsIHupAKtlK
         xSHNHS1FSH0OBvucqIvx0os9WtHmyVC9osOAPgHQ6xH4NWXs6KEZ+UoAwxJ1+BmmW4Iq
         wMNqqHD9978+9kVhDtrgEzfRT5TJfuMCiSaGixY2YGVawAI7z/PG+9JTWdsINeeizgCf
         5bOnmpBG5qqJf4MuqNLDePGwvwgFj8qUj/4NSM1TLyMaz6CGBP9C11Ht8KbgK4ESQkAX
         thKa944IIf0bxhCIRQKhDogeV1JTCApDBHHDUP3GLTl5DRVYnGmfPyJNVkPb3qjOb3M7
         muAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=s0gG/Y/1ndpD2o1oxGib08M1iLWS4DAsSTix2vBGTk8=;
        b=d48FUcyMQZrR4V3oNACyS0lUT94yR8c+BocQbxbuqyyz9mQJZryTqLvDXkHX37huVm
         dL9bG3skX0fL4dDENh8sBB6mtA4dlr7Nqyi+7Iwx/eXbmsBKgeIEvafFINn1Yz7VCHWD
         fpnShKQxCdc23yrLM1tL7TOf8M1LV+Etd/+E7eUhyPjlk4I6d59ql6fsxZGFMFPykPrN
         sbQ+p0tRT/emFe4UgpW6g8ZroeSBh4Ku2o7SlozRhd+8jZQoe89pzTTNXP6I5XR6hP/i
         /pdsqxzp58E8R3MAZZcAUcOTOUcrkilItovF+UPnA/ph/yJTSiH1Hyxw51dCnU24vFvO
         k2/A==
X-Gm-Message-State: ACgBeo0GKP4kz3Rj5JzG7epk0yXMOImFGxICheiZWIvYRZe7ZXpb5f6A
        4VSDFqPOdeKfQTZqqjXnHVM=
X-Google-Smtp-Source: AA6agR4bSIwh1Gf2i4Zy7jyo/bQXpTCoLOr3MSn19rbIti5YB1LQUFIxTIflcmokDYeJqqz0lZIg4g==
X-Received: by 2002:a17:906:7955:b0:73c:20e7:86cb with SMTP id l21-20020a170906795500b0073c20e786cbmr7545875ejo.527.1661019402457;
        Sat, 20 Aug 2022 11:16:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/19] staging: r8188eu: rename _rtw_open_pktfile()
Date:   Sat, 20 Aug 2022 20:16:13 +0200
Message-Id: <20220820181623.12497-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to prefix the function name of _rtw_open_pktfile()
with an underscore. Rename it to rtw_open_pktfile().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 6cf583fd9890..caacf35485dd 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -402,7 +402,7 @@ u8	qos_acm(u8 acm_mask, u8 priority)
 	return change_priority;
 }
 
-static void _rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
+static void rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
 {
 	if (!pktptr) {
 		pr_err("8188eu: pktptr is NULL\n");
@@ -427,7 +427,7 @@ static void set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 	struct iphdr ip_hdr;
 	s32 user_prio = 0;
 
-	_rtw_open_pktfile(ppktfile->pkt, ppktfile);
+	rtw_open_pktfile(ppktfile->pkt, ppktfile);
 	_rtw_pktfile_read(ppktfile, (unsigned char *)&etherhdr, ETH_HLEN);
 
 	/*  get user_prio from IP hdr */
@@ -461,7 +461,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 
 
-	_rtw_open_pktfile(pkt, &pktfile);
+	rtw_open_pktfile(pkt, &pktfile);
 	_rtw_pktfile_read(&pktfile, (u8 *)&etherhdr, ETH_HLEN);
 
 	pattrib->ether_type = ntohs(etherhdr.h_proto);
@@ -940,7 +940,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		goto exit;
 	}
 
-	_rtw_open_pktfile(pkt, &pktfile);
+	rtw_open_pktfile(pkt, &pktfile);
 	_rtw_pktfile_read(&pktfile, NULL, pattrib->pkt_hdrlen);
 
 	frg_inx = 0;
-- 
2.37.2

