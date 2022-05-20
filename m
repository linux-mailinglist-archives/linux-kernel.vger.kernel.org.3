Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3341352F57E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353825AbiETWKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353796AbiETWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:09:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078719592A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:09:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so1540278wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXIataNBxQzsiHab2Zt90bviLe04cA23imKlve17OxQ=;
        b=kuJgYj5jPU9tZUpCMxOtSXfcrr7x4eWnvsbtT6Hd4x+edQlyh/Xj0CYwmwjo0R653Z
         ToFH++1DUvVUy1z9rdtLZ/ZkJpOO/FsY3pds8cjiagSlPyLgfbssMAlfHiIZ9JOc+i6M
         eKUPowmfoKNUydOQNeG1D4eo0RAM9qOVMeT/W3GdzTSWRi26GC/WFvWyBJEcsnRYlg4d
         LMXq+D8+xivu0cge/UlNO+dK4GsNtqJLovaDtu1Mp3PGxsIrfirJtDRPQeMUo+0+FdmY
         MatczTr+x4hbeuGecMVS1CyxRX+YiEmbb0VKBgGr6000akc8xUJAgKkN8iW88vDaefZ5
         LOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXIataNBxQzsiHab2Zt90bviLe04cA23imKlve17OxQ=;
        b=pn860W6AnpPumqnqKwKysTHiiocSMtyuxVPYAk6dG3t4Z4TsGi6VGT67Nb4UeeANZS
         N5En7JWyN/nZOHyfO/RK+8buMLuzeurkS0hb5VnlshkSsWqwFniegGCc99FITiN3e9eA
         kH8DSTEpuqbdvlsXsliURK83usvUPjpY0sPSlJMGMhycMwLVgXiOZOdCcMl6Mv/FeEp2
         znfTMbukvHNvs0jZfpv3t3sQs7lNOyvZ6NPJdWjhW5fbYJr/AKr0yKqv0Eu9U6f49gSr
         DvQKbOH1J76BXdbG6mnStNCUidfkH3nQpLC/mjKB0WHhEae82OXxEN/KoDRbVqTXxNyG
         PA8Q==
X-Gm-Message-State: AOAM531gOO8nJvMezmy2l6JuUIC+E1VafoCSUtAfNx+hXsfMUyYhXXEh
        uYI/VSTC12y++C5kVfF9zZXW8A==
X-Google-Smtp-Source: ABdhPJxr/aIMYpp6YAQxg9nkLfWM7p6UafKUTFg7cnGAsHEUpSbFOyCr2rFdAEtDXeelrbyfwKkVfg==
X-Received: by 2002:a05:6000:1a8e:b0:20c:be8c:10a4 with SMTP id f14-20020a0560001a8e00b0020cbe8c10a4mr9633223wry.437.1653084595472;
        Fri, 20 May 2022 15:09:55 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600c4e0300b003973d425a7fsm1677206wmq.41.2022.05.20.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:09:54 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: convert pr_info_once call in core/rtw_fw.c
Date:   Fri, 20 May 2022 23:09:53 +0100
Message-Id: <20220520220953.11840-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pr_info_once call in core/rtw_fw.c to a dev_info_once call, as
ultimately, this results in the printing of the driver name anyway
(r8188eu) which is equally clear and removes the need for the "R8188EU: "
part of the format string.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 0451e5177644..87dc0e97652a 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -259,9 +259,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
-		pr_info_once("R8188EU: Firmware Version %d, SubVersion %d, Signature 0x%x\n",
-			     le16_to_cpu(fwhdr->version), fwhdr->subversion,
-			     le16_to_cpu(fwhdr->signature));
+		dev_info_once(device, "Firmware Version %d, SubVersion %d, Signature 0x%x\n",
+			      le16_to_cpu(fwhdr->version), fwhdr->subversion,
+			      le16_to_cpu(fwhdr->signature));
 
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
 		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
-- 
2.35.3

