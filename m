Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337B6584892
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiG1XMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiG1XMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:12:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78384D146
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:11:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so4037777wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jCCnZiaJb8QNm0YMMVTlHWHS8f4fktdY50PNwReg/Bo=;
        b=4qgcuoNhTzh1uX7xzytI6lBy4YQbvnypm6XzWt897AYOi1bKInizpFIvE97yxu3fzD
         MnB2ZXlfyT/znkyc0HmMEd7QRmFrRcMavcRgFTdWDuG5BvEZUYMEpCrUQCA8QfUGWyqu
         1g6PoCJWkl2E4XvcU3KQWi3n/KmLYl/W3eOpnDMi1bHUr8zgHIF9jhuyNfI5HcavsDGR
         swVaSluoookE2Yg8InSQedW1aEv8EcQcTg9/j6IXTpPSJYeVq2rWBZR73ZKstBR8VkKK
         i107apydqEgI4OnjMIUUdnA4/jhFsJvdVIcxcZaiqhTeXpGjQXaKRki68PF8Vxsq4sQt
         V0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCCnZiaJb8QNm0YMMVTlHWHS8f4fktdY50PNwReg/Bo=;
        b=0+VdjFucBCLNyyODktc8D5JjHzc2FMIgHNM5Mki77+hlCvt0Iu/fJVV/iEnfNhfmrJ
         8GdQ0866PGtorUyhV3PU+HUHJhAciMlHlSFTkgrFpVMsi7SeRKWj+4ETrtw3L5KyyMoK
         mi+vWKKgwm80XmPDEvZI4hb1gftgwoMpF5XQeY4Wo8J/XIr1c6G4pF7KYkowLcQYq5L5
         44oQZdnaKj3XSBonal9asSUTVrityVSmwptj+gwLpWhN4W9Z/ifQm277mmO8tR1kdIBD
         nZ4RfjqBbeGyUwzktG4eEQbl5iOh3/KHcq5O7H2CM+/zfHIQo3nb8mkzdGzD4u/Vgo4Y
         1voA==
X-Gm-Message-State: ACgBeo18i5v9DOutIaPJHdtwMTUXS5xolzWy7c3RtpAZ+UuPAENkVsFv
        55u7/aMGJxfbXaZYWZP4DsWVDA==
X-Google-Smtp-Source: AA6agR6x6e6SwyzVVGvqX1um4Ya0xhrWibkZzps8P7wvHfc2bLMEH7ExKE55xQmuKi3lraWLVy6D9w==
X-Received: by 2002:a05:6000:1f08:b0:21f:bbe:252c with SMTP id bv8-20020a0560001f0800b0021f0bbe252cmr640136wrb.340.1659049915436;
        Thu, 28 Jul 2022 16:11:55 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2089419wrh.17.2022.07.28.16.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:11:55 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: r8188eu: remove initializer from ret in rtw_pwr_wakeup
Date:   Fri, 29 Jul 2022 00:11:49 +0100
Message-Id: <20220728231150.972-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220728231150.972-1-phil@philpotter.co.uk>
References: <20220728231150.972-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the success initializer from the ret variable in rtw_pwr_wakeup,
as we set it later anyway in the success path, and also set on failure.
This makes the function appear cleaner and more consistent.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 8b1c50668dfe..75e655bae16a 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -381,7 +381,7 @@ int rtw_pwr_wakeup(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
 	unsigned long deny_time;
-	int ret = 0;
+	int ret;
 
 	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
 		msleep(10);
-- 
2.36.1

