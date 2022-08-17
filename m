Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35435596996
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiHQGcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQGch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:32:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75307962B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:32:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c39so1358117edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=O7B4wBks7f3hW7WkpQlC01sLwbVkWb1JQNhWXBvVpo4=;
        b=ildQPppwYAvHF58sp6qVBfuSOqFyw2GAlzItDHum6n33ZGyG5ULvX3jmcBG9ognmYv
         uvBSebwIkqpG4mAv2pGm9sbYTc2Oun/PHm+X2hWtg2tJUUNObKQUtU4O3kUTTzmt6EQY
         advDMaWHNCT3euDVccQSMEpSY/g0XCsLyfO+X5A1qPFPKazZzbHelzskJQCO5DABmWxp
         Z7MCnXymj6mKveALOdJNwdIPJU1XOyzcNwpecjlPWkg9UDMKlOWaekWjdo5gDR18Gtz1
         ROzOOsHsthV8gMAVJA6/umGW77xk2aIJy0I56MPC9LzBORo1+yy4yNUHGSxFizq8EaQb
         4BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=O7B4wBks7f3hW7WkpQlC01sLwbVkWb1JQNhWXBvVpo4=;
        b=zymAyVcnXxO+BL5pviC9Jg0z4y1FoWfKmMz2BAuB0ZwmqNWO34bncClr858uVOWdVh
         LvwtOEnhWOELFiiBPhbEVdcV7i0oZvmC0eZ3Q8x/+bzOOQB1Rbmb5tyPIlAqGkr0PP4F
         oPTtfesFvqJq9o4/UKAqBeWGJc9z6eHJzwDY2sx2mA8wLEz3B563TirqSJxMLdC0xk7j
         a5sEkavHZSqDImwW8wIZQ5tUP39+VpUkiYGJRj5ZNC/jprgGoA68/V6A24BnpFL+WuKb
         fh6yw5WMzuy+h4VYxKfguPzfyni1S/ZPFxgbtRTT6vFyHBWWbi5cT5O6/Xrd6uarm8zf
         cTpQ==
X-Gm-Message-State: ACgBeo3u1pL38VYUvTcNYuz5PRzwcOdIRYyX36cU8iT2Vvt/+Sqhsuty
        +20nfjuVqc44cvLoo90Bypc=
X-Google-Smtp-Source: AA6agR76MIqhwqeBmk2Kc2Fxz0g8cfosol3AvUZRr716ido7lRt9gAkkUyNBwmTABb9Nzd5llVucXg==
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id ez17-20020a056402451100b0043ba1828a0amr21819395edb.410.1660717955239;
        Tue, 16 Aug 2022 23:32:35 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b007307c4c8a5dsm6291669ejo.58.2022.08.16.23.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:32:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove rtw_endofpktfile()
Date:   Wed, 17 Aug 2022 08:32:23 +0200
Message-Id: <20220817063223.8140-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
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

The function rtw_endofpktfile() just checks for pkt_len == 0.
Remove rtw_endofpktfile() and merge the check into the caller to
improve readability and simplify the driver code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      |  2 +-
 drivers/staging/r8188eu/include/xmit_osdep.h |  1 -
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 11 -----------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 24401f3ae2a0..48631ef56114 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -970,7 +970,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 		frg_inx++;
 
-		if (bmcst || rtw_endofpktfile(&pktfile)) {
+		if (bmcst || pktfile.pkt_len == 0) {
 			pattrib->nr_frags = frg_inx;
 
 			pattrib->last_txcmdsz = pattrib->hdrlen + pattrib->iv_len + ((pattrib->nr_frags == 1) ? llc_sz : 0) +
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 00658681fef9..130dc06efe73 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -40,7 +40,6 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
 uint rtw_remainder_len(struct pkt_file *pfile);
 void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
 uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
-bool rtw_endofpktfile(struct pkt_file *pfile);
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
 void rtw_os_xmit_complete(struct adapter *padapter,
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 91a1e4e3219a..85ef27735b88 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -54,17 +54,6 @@ uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 	return len;
 }
 
-bool rtw_endofpktfile(struct pkt_file *pfile)
-{
-
-	if (pfile->pkt_len == 0) {
-
-		return true;
-	}
-
-	return false;
-}
-
 int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz)
 {
 	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
-- 
2.37.1

