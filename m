Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22235048AD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiDQR5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiDQR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B04265D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i27so23510615ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEwI6Q2gOou7SmTI/FqsvAk6CZ0LfOMwOSJ78RsRzQU=;
        b=f1hqZGQ45cLUIX4T7+k+y5bWOaM56L8Ky5XIxmSLUcfM6j44rehlQN4I2SnvpjLWLn
         2C8Em2U1LMqmE4jiJohYaTusIMNYtwaQ7QCKZWAmQL82bH8ivAQuc9Bdh5jQAUNkrCxX
         ICQtx8aUKxBU29PvM9tzLb+VK4AViNQsNNnGl1vl+i4mxiYPn3uZUpSW3giLxZcrUnje
         4PbzUYmdnS3jBGc+Az7+gBPtZOpvWeDA55kxUyCIQLXFZlRfKyyxgzG6Co/ifuPRVrOn
         3Cu8PUTOuyDCsiydm15MK74Azo38PYXun3l996GX/YYXle7jFmHDbPW4kVbuEFBePY3D
         vJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEwI6Q2gOou7SmTI/FqsvAk6CZ0LfOMwOSJ78RsRzQU=;
        b=RnK9hvj5E4RSy5xPnjPAYuhs+PA1uXUZhNKyvZBSxEkOuN4Fb7e8NF8u3PGuVzAhWn
         8t3hjEk+KxKb/k4ueMOmuYH5h1/d/j0Gh2sTvb7ekq+gfG80L7u4Z0QqoSG8JfXZOzpi
         rsw5fPSfuKvwA62agQrVYZ1L3kKI9+vrZWRyqkVlsQxyTpX/Npa8tou/HzjzuQ/RS5n0
         Pj8Gc/9abmlBQ0ZXsOIyyxEd/72Ekn7Jegjnq26ewh+ZZP9vQ6fu3qQORxs9Rg/mMHnZ
         gVoPSiAAw3HTPNu35fZcOxlM5S/Q0tEZ/g79yzOAxknDGVUXUY3Ij2GNm+Aq7llOcm8H
         WzIQ==
X-Gm-Message-State: AOAM533nzemt7kQeafMxqIdsfb64h0+n0H6AriGxFSg+l1eqeYuuSDC9
        ooHTq8nVqHw65nUs63Row+w=
X-Google-Smtp-Source: ABdhPJwE+VrcsnQ6WcjEACvgNW7r1oitmbIaM/2BJUEx5VgdhGMNEDE/7GOxvqEOyRIv5koX3YI3dw==
X-Received: by 2002:a17:906:16cc:b0:6ce:e607:ff02 with SMTP id t12-20020a17090616cc00b006cee607ff02mr6117957ejd.418.1650218091437;
        Sun, 17 Apr 2022 10:54:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 5/8] staging: r8188eu: use sizeof instead of hardcoded firmware header size
Date:   Sun, 17 Apr 2022 19:54:38 +0200
Message-Id: <20220417175441.13830-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417175441.13830-1-straube.linux@gmail.com>
References: <20220417175441.13830-1-straube.linux@gmail.com>
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

Use sizeof() instead of hardcoding the firmware header size and add
a compile time check to ensure struct rt_firmware_hdr has the correct
size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v4:
- no changes

v3:
- added the compile time size check from patch 8/8 of v2

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index a80cc7fa3a53..42b36505cf8b 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -39,6 +39,8 @@ struct rt_firmware_hdr {
 	__le32	rsvd5;
 };
 
+static_assert(sizeof(struct rt_firmware_hdr) == 32);
+
 static void fw_download_enable(struct adapter *padapter, bool enable)
 {
 	u8 tmp;
@@ -268,9 +270,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
-		/*  Shift 32 bytes for FW header */
-		fw_data = fw_data + 32;
-		fw_size = fw_size - 32;
+		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
+		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
 	}
 
 	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
-- 
2.35.1

