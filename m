Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3D4EAB72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiC2Kj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiC2Kjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:39:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB49C1C92
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o10so34230660ejd.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rdVFsRva52GcMtl178td/PU4MqSDMZsE8jDt+0zP9I=;
        b=UVJtGaPxt8BpoHJbuk1xXngqHQZsl7Uf5d2uNeQRlI4atTKdtaP2hzE54PZ8ATZ/al
         XTg31u4URUThaXpbxGQGUt9TNFM120i4GjKGljxmYB10vakEECv6huo30obtck3pB78N
         JDYEhAuCnncHfkBxtOZVQ1vX8P8LQLE6BJXiSXBg3aDSZLiuZ8E+vJ7kRtUu1h6LYwlV
         ukvlOzxQtAM8HaEWSRXyWMeGQ0Q5npGLIC274y3iuQkv4UbyDu9NVQo/qfXLqsOfXy64
         5A4XyMgsNq9byNU8JEHc+WEPJA+j1UK/1UWHpyR4NddKSJ35jQgtt68yhLHM53CaDSYm
         xALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rdVFsRva52GcMtl178td/PU4MqSDMZsE8jDt+0zP9I=;
        b=HxnMkGuUruYD9mBCQNoYFTD5M5h6EZNwfGIPSKefQ08azoFvIc5eFVfzPGU4AvptF5
         vACP4UREdCLp68LaENRJnNhd9AHkWoGKWZtNzUhJga0HG4qudoP/M6tCh3922IK7C+BX
         QixpvB7wUpnht9xBvhD8RnIDoszaDJKoIjY109zFqS9FmwCQY9qQp159RWIlDJwYD1gk
         a57e8AVAZ+YS1EPXKZkveYQIfuCnGILeHFsV7Ojy/QPuA9nnXrfemYAEQg6mq+pfKK+w
         P7lrzdYoxnzBs+kehzoXrlyScak3D3hTwBTOFz1zjTMBZ3549Wqr8RnOIufloHlD2DEq
         0czg==
X-Gm-Message-State: AOAM532yiiqNAGRVsWAUg7j0NahaYJsjUo4t2HRvPfGU/fGwgxhx2KRk
        f6vrTU6qqIgowAKBFpNzmdo=
X-Google-Smtp-Source: ABdhPJzBrJIN6iNc35BhKt3rDrOUXzyyI1OqD8DooHxlSo8WlTK2A+JWyzxTwcLCtIaZVO3gK6Atdw==
X-Received: by 2002:a17:907:6d0b:b0:6df:e54c:ad1d with SMTP id sa11-20020a1709076d0b00b006dfe54cad1dmr34438013ejc.734.1648550287768;
        Tue, 29 Mar 2022 03:38:07 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id qw39-20020a1709066a2700b006e03017d60csm7058151ejc.54.2022.03.29.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:38:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: refactor rtw_inc_and_chk_continual_urb_error()
Date:   Tue, 29 Mar 2022 12:37:54 +0200
Message-Id: <20220329103756.6740-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329103756.6740-1-straube.linux@gmail.com>
References: <20220329103756.6740-1-straube.linux@gmail.com>
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

Refactor rtw_inc_and_chk_continual_urb_error(). Return directly
instead of using a return variable and initialize the variable 'value'
at declaration. This shortens the code and improves readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/usb_ops.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 3416c8baceb6..cfcf6f84d2cf 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -27,13 +27,12 @@
  */
 static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 {
-	int ret = false;
-	int value;
-	value = atomic_inc_return(&dvobj->continual_urb_error);
+	int value = atomic_inc_return(&dvobj->continual_urb_error);
+
 	if (value > MAX_CONTINUAL_URB_ERR)
-		ret = true;
+		return true;
 
-	return ret;
+	return false;
 }
 
 /*
-- 
2.35.1

