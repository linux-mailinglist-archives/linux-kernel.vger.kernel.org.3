Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B51A4CB03F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbiCBUuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbiCBUtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4312E6540B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cx5so2866481pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5AE2uRsYYk+x02Y3HTY/LR7/duyX8373bf9eEbOiMhw=;
        b=VrC5/9ZfjKL0MIvIXSU975r5t328rIc0clW+nUjdfd8j3bKzwZxcRy1yQA3SLxLDOy
         sSp6lAe4/Fs2beIQiA3Inx/yAPLsKwikO0zqTE/ly1/Fn/c7D1I6PD1GJ7IRvJnN5ioJ
         93uMtqhrw0keVsXEjqLVU/0u5IwvtC2Kj6humVxy46R8v/V7sYJ5SkmTWQqE9CCqwea2
         HEIHI6qDZRLLEqDM1apSgyYRCVhZWRRBlwtBpLKwI8ZOb6qnW+uALOYxGEXVhja1sAP5
         VsrIKFlvobbwERFwZEWNoCcWeT5JLux7+Nhmb7EJx+AAJ5nUbsKYOCK7GezP6Q3vZnkM
         bBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AE2uRsYYk+x02Y3HTY/LR7/duyX8373bf9eEbOiMhw=;
        b=41XUU5JtU1tnHPKcqZCn255nELthiSKZlKyZF8bXaegnPKq0Kh9r3pU2GvODiXI+ws
         jlIQwIBr1DLrwypSZjGHl3YPSrLML/dHq+n9HWFgPx72CxTQFWnCz85wawUKcOsX49Lm
         D0bz4e+AEimap6LIuWYKiYms8qtdQzm9PcK3UEKtM9gZcyvQifqv5omMxNTNYoxBZbWe
         77ESG7P6xPPtIjDn7jlrpWLsTwxEl3gevOAU9qOU4VgZKPLgd2w+VnYDpkbiQRPWChXi
         gxn7xpUcHJwf58z2cEBVkb+wso9L5ErQGIN6VJq5L8ygYHa0B7jJ0i9VJoDb8dS6y1DN
         uTow==
X-Gm-Message-State: AOAM533lNpDlL/BYkmRQHGYyadgrwI+cGv+4Q7Me5v1/q9vy0xHhaYhW
        jxp2NAAMrCBEjG07bsO1akw=
X-Google-Smtp-Source: ABdhPJw0Vdrj8JQ8Hht/3yFHRDC5KV/68Nh0Lx0vUn1K4P96RrSMwULBxpz4qw7+dDDafwNxXmEuIA==
X-Received: by 2002:a17:903:2489:b0:14f:fe0b:554b with SMTP id p9-20020a170903248900b0014ffe0b554bmr32742239plw.113.1646254134788;
        Wed, 02 Mar 2022 12:48:54 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:54 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 16/16] staging: r8188eu: mark rtw_endofpktfile as bool
Date:   Thu,  3 Mar 2022 02:17:37 +0530
Message-Id: <20220302204737.49056-17-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
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

Mark rtw_endofpktfile as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/include/xmit_osdep.h | 2 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 3e778dff0..00658681f 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -40,7 +40,7 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
 uint rtw_remainder_len(struct pkt_file *pfile);
 void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
 uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
-int rtw_endofpktfile(struct pkt_file *pfile);
+bool rtw_endofpktfile(struct pkt_file *pfile);
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
 void rtw_os_xmit_complete(struct adapter *padapter,
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 717b980a8..a6012cffd 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -54,7 +54,7 @@ uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 	return len;
 }
 
-int rtw_endofpktfile(struct pkt_file *pfile)
+bool rtw_endofpktfile(struct pkt_file *pfile)
 {
 
 	if (pfile->pkt_len == 0) {
-- 
2.30.2

