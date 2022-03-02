Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845EE4CB03D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbiCBUuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiCBUtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EFA2797
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s1so2597473plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUuNPBTu2xyBBzs25ZLnDDMUBtJR+9Kg5LOaf5JKL4g=;
        b=FXiOHgND48ZfHthNYy+QQZ+gOusHf4rgw2u0t+lAZ7qhcDNfumkzzBoPzraPDtom0G
         s5R2yBaGBfn2wAx9+qRjH0dQtJRzHOFAhYOQaeZjIsTAzpU7M1yjwI59mFhyZoOyQ98i
         R0sfoBA9n1yFVaBillL3gQ+mOp5Np7JC4vu7ptBjjzWVHYXaFrRBOV/VaaNksh2/6KFi
         bKUYXtOVMpLZL7YYlrTOdeCUkYUttcJnrCR9dyT4cQU3KPVEUrO69rSv76bX/NC7ZFaK
         bOzZ9yg+9kf0Bmh1ho3YSbEwgbzVNTl5O1zeVSB8opMr0gDHDfIgpRhp9dnsfAdaFJTZ
         vUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUuNPBTu2xyBBzs25ZLnDDMUBtJR+9Kg5LOaf5JKL4g=;
        b=s+n9LYjJGf9vBPoybN9nPn/M+8pkoJxxFJ63MemBMfKQmWCnsq4+EbdXaHgG4t5Vyi
         BrfdEEfwJi7es0hMMfozoG+xEGrCMZnYapigja5Wp3X2BJ9qO/olrRO8M5AfIciPLSRN
         Wf8a8oTYQGIkl0+1gavONHJ22xkDnkITmJz5RHa5JHwePCuXAu10uWIyP9RCnVak0d/L
         /LG8GnA+aLF+BJB3/E+1gmaBXxeQQOCLXDvUetfsPyvJecU/o8b/u5ZR590j+AQjyYZr
         /6DspIpj7+TaghUho+RkgbXOnMnwlobPgvIbZTMxOy/yJRowMBAa95JTBABWybefhXRH
         8+ug==
X-Gm-Message-State: AOAM530Y7R3sq7/SCQhZVnrf88bXvLjev10nkdVni92WsNCafTxBrByv
        mob4+CDyF3kvlNtw7Ecx0CU=
X-Google-Smtp-Source: ABdhPJzwmDdaEnAFlyf7GNjr3zk4DxljBpBpdOebEFf/wd5QpDhDPpWFwXTYJYg2TX2TWUdERr+jqg==
X-Received: by 2002:a17:90a:7d17:b0:1bd:6972:f942 with SMTP id g23-20020a17090a7d1700b001bd6972f942mr1689696pjl.160.1646254130255;
        Wed, 02 Mar 2022 12:48:50 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:49 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 15/16] staging: r8188eu: mark IsFrameTypeCtrl as bool
Date:   Thu,  3 Mar 2022 02:17:36 +0530
Message-Id: <20220302204737.49056-16-makvihas@gmail.com>
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

Mark IsFrameTypeCtrl as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index df3331b13..c1c9bae58 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -372,7 +372,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 	return sa;
 }
 
-static inline int IsFrameTypeCtrl(unsigned char *pframe)
+static inline bool IsFrameTypeCtrl(unsigned char *pframe)
 {
 	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
 		return true;
-- 
2.30.2

