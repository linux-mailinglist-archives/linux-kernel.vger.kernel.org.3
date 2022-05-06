Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6373A51D735
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391606AbiEFMFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbiEFMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:05:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945D1D30F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:01:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id i17so7183395pla.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 05:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i9PJvhEX8P9EwLto+E+6JAbwn0v8MnYujSttxKDDDe0=;
        b=lksT/n19/JYsn93CnYdttA/s6P7bMZJpP+Ms209BI2CObc+AMkQUlT6IubqMu1Mahp
         O8nRm01qDnsw8e1hE+kYJW6jLabXrejT8hGuB9BWDMm+x1QX9rmAulxyWM3O047U6X4t
         mjDRY4NnhMooqkdMRULWbQnVaHGlvSF+wooVC1frMAzJ9ou4UQ4uEKtdG36GKAptCFEx
         KLcwmJcoNIN4rbNWlMJLTbSB+zINy9WGFSEpYjnAk2dODhQCljiii+pFFgAMINIIrbam
         Bhly8p9NLnSHX1pA8yHLAppMyHH49XGBRqxTfYZr58rLfLH7/gyW3BRRH6N2/ok4VFAw
         XPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9PJvhEX8P9EwLto+E+6JAbwn0v8MnYujSttxKDDDe0=;
        b=qCqpX130Zzs1n4NXamfkQ5Z78gAub09/MBSxVcwl70vCqjOpXlu8RvmO0+hpG6ozxT
         i/o1za2dkgHT0kExU91gNxaRIfwiBbnpU3TU3Dv2UPyXDK44ZGMESa9j++oM64n0TrKZ
         B5MdZ74sGtGa1ZViPbR7fSi8EvgOL1giLleqKDdNc8avLsOaA+1q2TYJsg/sGdJWxyyZ
         zmqUaNEq8nGEC25rvK41MBtqt/P8tSSS7WNVgwg1j6byLqUbMxUvxF8HgqU+bH26fTE8
         8/3aLgSyEABSbHZG7IIc1l8wwXxnuJZl5C/nHMzFemSf7iR6146yGtwFTcjZR/lvXnU1
         dwoQ==
X-Gm-Message-State: AOAM532tbXk5ov68t+l60BC09VG7cklnwR4ZdttBmKEHi1K/P/7AUGA4
        BjyqUs2pnTBKwRJsB64qQONclqo2HIw=
X-Google-Smtp-Source: ABdhPJwdf1n78F/MCPW8uBDH56G1BwkHvo3AmYJjlhLXlgtLLi3HlnNHA2E1gJPWALUl/vmWJMJpSg==
X-Received: by 2002:a17:902:e808:b0:15e:b27b:9302 with SMTP id u8-20020a170902e80800b0015eb27b9302mr3326522plg.54.1651838511019;
        Fri, 06 May 2022 05:01:51 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id q27-20020a056a0002bb00b0050dc76281ebsm3169785pfs.197.2022.05.06.05.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 05:01:50 -0700 (PDT)
Date:   Fri, 6 May 2022 20:01:44 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] staging: rtl8712: add error handler in
 r8712_usbctrl_vendorreq()
Message-ID: <e33ea53d36c422fbe7eabec5bd9eecb0ebce1bc5.1651833575.git.wanngchenng@gmail.com>
References: <cover.1651833575.git.wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651833575.git.wanngchenng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'status' returned from usb_control_msg() is not equal to 'len',
that usb_control_msg() is on partial failure, r8712_usbctrl_vendorreq()
will treat partial reads as success.

Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
---
 drivers/staging/rtl8712/usb_ops_linux.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index f984a5ab2c6f..b2181e1e2d38 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -495,14 +495,21 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
 	}
 	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
 				 pIo_buf, len, 500);
-	if (status > 0) {  /* Success this control transfer. */
-		if (requesttype == 0x01) {
-			/* For Control read transfer, we have to copy the read
-			 * data from pIo_buf to pdata.
-			 */
-			memcpy(pdata, pIo_buf,  status);
-		}
+	if (status < 0)
+		goto free;
+	if (status != len) {
+		status = -EREMOTEIO;
+		goto free;
+	}
+	/* Success this control transfer. */
+	if (requesttype == 0x01) {
+		/* For Control read transfer, we have to copy the read
+		 * data from pIo_buf to pdata.
+		 */
+		memcpy(pdata, pIo_buf, status);
 	}
+
+free:
 	kfree(palloc_buf);
 	return status;
 }
-- 
2.33.1

