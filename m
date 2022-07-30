Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A719C585CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 02:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiG3X7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 19:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiG3X7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 19:59:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9AB13DF2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:59:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b6so4155020wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFfl3fvUkStQAla+HkThz8i6u3worW0NuOmmJQ7dxFw=;
        b=37z3F1S/xY9NRMXx+Dae4aV7GMpjcO73t8Jtw9OERy1UwzIbR9Hrqq8tmFBxWk+IeE
         GYcaTxDNGpJYcDKe54QZ9R+kSzm/RZLQzYkx30/wDuQptp9ebg78bj1HpAPWVnZF0CSG
         mvFmCNLwYkAaA2Q1RlV3cCdKbzoDV/ubv1+ZPcADJ0ACm95/Ds62H8pcNdh/vkySpy9T
         igIUBVVl0APo31QgqYAMbrhxf4tJEWoZtTcC+H8ZWr6NpAXGXy8HG/0rOTWn0SqXumPu
         RCJAtYngXCRY0jmhSybrqAMkQSbRI+S0LA14SKN0TkoTGTJWKQw8x94FnHGjSKy5yxyA
         B04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFfl3fvUkStQAla+HkThz8i6u3worW0NuOmmJQ7dxFw=;
        b=pUdT4+xpm6N/3Lo+wvj8KlsniO+zjz6BL3/EhlQCR+MbylUKQJkt235gmCJLZed9Yi
         8l3TvaDBZ+6gYIbi+B55zHlVj2ZzAa9dGavPUYnI9oaunZQptMyG4OIH6/kECMV06q71
         TTm8ZBm7wnklb4TqwJTYQeISGDUIcPDPWENxZ/m1Ktmkah7Ay3r8/XyXiDcglz+ivg9m
         AMsWSoj4ZJ9hX3v5i9/z9NbQJGnnqueiBRzhzHQvGqQj157xRNywsmoWY2iTDUnG6ooE
         YZegVWUEHqrv5XG9Vq6knke9aE06zeU5Somu+/6lR2fEjctPeIYSZ/d9c3DLmSzeIire
         GaJg==
X-Gm-Message-State: AJIora+3hTeaxFJ3/7w+iOvlKohjrOAbYEydGUVQU25MacnXBBqg+5lq
        0VDJErSsJJUNLJVOf+Ks5uc47g==
X-Google-Smtp-Source: AGRyM1vu7o/4YD4IwTcmD332Wl18Bit+6ay104U1SqYA3waYlygWwSrENiujo9W60UoBexOgnttAgA==
X-Received: by 2002:a05:600c:3549:b0:3a3:16af:d280 with SMTP id i9-20020a05600c354900b003a316afd280mr6665993wmq.142.1659225553964;
        Sat, 30 Jul 2022 16:59:13 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id g9-20020adff3c9000000b0021eed2414c9sm7453595wrp.40.2022.07.30.16.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 16:59:13 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        paskripkin@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: fix potential uninitialised variable use in rtw_pwrctrl.c
Date:   Sun, 31 Jul 2022 00:59:10 +0100
Message-Id: <20220730235910.1145-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.36.1
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

Set ret to 0 (success) before entering first if statement, thereby
assuring that even if the device is not associated and further checks
pass, we do not then end up returning the uninitialized value of ret.
This assignment is deliberately now directly before the if statement, in
order to keep it clear what is happening as opposed to having it as an
initialization at the start of the function like it was originally.

Also add a comment to make it clear this first if block is currently a
success path. As a side note, smatch does not trigger warnings for this
change, for me at least.

Within core/rtw_pwrctrl.c in the rtw_pwr_wakeup function, I previously
dropped the initialization of 'ret' (int ret = 0;) in favour of its
assignment which happens inside the first if block directly before its
corresponding goto. This was the cause of this bug, and was introduced
by: commit f3a76018dd55 ("staging: r8188eu: remove initializer from ret
in rtw_pwr_wakeup").

Fixes: f3a76018dd55 ("staging: r8188eu: remove initializer from ret in rtw_pwr_wakeup")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 75e655bae16a..10550bd2c16d 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -387,10 +387,10 @@ int rtw_pwr_wakeup(struct adapter *padapter)
 		msleep(10);
 
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
-	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		ret = 0;
+	/* Below goto is a success path taken for already linked devices */
+	ret = 0;
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		goto exit;
-	}
 
 	if (pwrpriv->rf_pwrstate == rf_off && ips_leave(padapter) == _FAIL) {
 		ret = -ENOMEM;
-- 
2.36.1

