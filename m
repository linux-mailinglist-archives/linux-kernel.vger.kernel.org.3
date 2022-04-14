Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE17500B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiDNKqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242405AbiDNKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808946EC77
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c6so5788093edn.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3gIVX2j+QmqthafxJMF0q4aG/MQAnfAXiq7/gIShys=;
        b=XovvZG/8sCJ8k9pCBYUJ+OHgqqdde5GmmeXkHwJihA7upLfxvh1jDTUiXVdTJdBEiM
         EJhO78fW/ewzLp554JAnUIaOjDb7usX0v7DyA77Sdret4zAliR1gVhqeQBFssBPuG2f1
         cRxz+VtIBj3v2woVJfjYNwEVg1zBmCniR9fbfROajydNbZgo89jpvZATvTsRuUJBnC84
         /TMCCVw8tb/zvMjBBjEdmVUA2LCRmxboea9G0iGDK65uIco0mDhdc8u0Bn30nItCgL2N
         BLcVgiC24zVGcpOiEkXQQMk3hlQMKOsJIN+VIvT/t+cr+hnICgy9MBClrfwgqlXk77qg
         XvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3gIVX2j+QmqthafxJMF0q4aG/MQAnfAXiq7/gIShys=;
        b=jQ02B5QHOLuYgvtCV9V7B9pHn6F+sLJhLt8RDDR7SUMyuDcTnGkvAEtxCn6ALKVDci
         dBpeOcDX2PCvqa8tj1Od5FFnoLg6bME9J4jBPrAeSGEZKtpX0RRC4oI3ydsPtjgjyICu
         1fS779wFl/AWAlEErjU2sLvqXqG9oMI/w9Z0qCt6jqeM1quZLVqmP35gmoBZOx1TWx4p
         Bx3iNa3KXmrAR/C0rgoqUx2hYkd4Mobz+lVYmdrQCuoc8KPa+fYeI9KypOMl+K7gEbUg
         g78wHYGFIt0B+q2lket+uyZEm92efNJwFw7omDi69p8qmpGxBRfUFBsxTTtF/4sFKJyQ
         TBfw==
X-Gm-Message-State: AOAM533OYS7nmAi6qkC7gJch0DXkFtMUadKeSg9P/IJQekoKruv9klRx
        jZKxlywcGao3twCbCItJ88I=
X-Google-Smtp-Source: ABdhPJxVyX5PxwakbXcEFYaxnu2B2+HCic+kNvRI1uhHPcpT1aWcCf5Cp8CfvubY2cTb78IH6B5NCg==
X-Received: by 2002:a05:6402:438d:b0:419:4550:d52b with SMTP id o13-20020a056402438d00b004194550d52bmr2219466edc.83.1649933033138;
        Thu, 14 Apr 2022 03:43:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v2 8/8] staging: r8188eu: check rt_firmware_hdr size at compile time
Date:   Thu, 14 Apr 2022 12:43:23 +0200
Message-Id: <20220414104323.6152-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414104323.6152-1-straube.linux@gmail.com>
References: <20220414104323.6152-1-straube.linux@gmail.com>
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

Check the size of struct rt_firmware_hdr at compile time since
we rely on the size to be 32 in rtl8188e_firmware_download().

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index c58bce1a1856..4417375a158d 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -34,6 +34,8 @@ struct rt_firmware_hdr {
 	__le32	rsvd5;
 };
 
+static_assert(sizeof(struct rt_firmware_hdr) == 32);
+
 static void fw_download_enable(struct adapter *padapter, bool enable)
 {
 	u8 tmp;
-- 
2.35.1

