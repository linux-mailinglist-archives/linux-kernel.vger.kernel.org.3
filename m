Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F004EDFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiCaRwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCaRwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8784F1BD83B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648749014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JSuJ0KGHWnjDqGOnTVD3EjCwphEFh8GGq1J9g6xgbWs=;
        b=g8In2cES9QyiHx9jzhPy2Dkd5Mtm3vXSdUiXfgUu7SDcOLP59V9K9RhU+QXeavpCGPu54R
        dEiQXbsUynGEJkEGktX5lmNSeAaXOek/6cACIc5LLiFwKU4lZFDBh0OzI4B6VQMKhwaCys
        5uXHc4Y9mU3VDgJCTW54X5rHFQcPGa0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-DLa2QTeEMg-AguNyDoXB3g-1; Thu, 31 Mar 2022 13:50:13 -0400
X-MC-Unique: DLa2QTeEMg-AguNyDoXB3g-1
Received: by mail-qk1-f197.google.com with SMTP id v16-20020a376110000000b0067b2749e0fbso151450qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSuJ0KGHWnjDqGOnTVD3EjCwphEFh8GGq1J9g6xgbWs=;
        b=e8LJt0Ibtw5vkOwUN+y1WZoTB7P3SeqSQ9WVbI1wzNdtMu193arePz8r0rivR6/nWA
         7r0b7QwESJDpmEEhJkagVtcQgghHQY/cgUZ7+/5Sfyen12dTa8yF+CxXB1f0U8epiBl/
         WzF6alC4yTzy5u/DgfIAHExQKpPnWMrqGqLuyh0CSSIab/wT4SE9YBM1ybqqaxtwzBQA
         7A0v7Vwx9oNaoxT1Lmh5Eq+d1RqsBh5Iuql7s3mF52vOCfWLICj41eGMZKPt9pUCntFq
         u+RUS0aGBP/RjwMSn0Ibr+IncsAmNTMdsn6smCtQc4j2BhhL1p3CSREaaXuTJLIzSmeF
         sPQw==
X-Gm-Message-State: AOAM531YHp2sXglax63VF2sJHxvujZ8WLO0+1F1WP3QKfhWuWApOBnCf
        flgYPI4ot/k2CYY7sBP8+RDoK5YNeb42BXgk+TRhqyEQ1n27TXqtjfAq+VNSJXp3tOgO5V5Wq5q
        iUtnrcDH35nAMAL1lGiMyodp8
X-Received: by 2002:a37:410:0:b0:67d:ddd4:77d0 with SMTP id 16-20020a370410000000b0067dddd477d0mr4212815qke.620.1648749012214;
        Thu, 31 Mar 2022 10:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfbbQOxw08ZVlf+kgoUIlOJW7iE3h9Xol0V3vdyuqUNuuDJbnMAtg+wW27qkKe+0gSNQo08Q==
X-Received: by 2002:a37:410:0:b0:67d:ddd4:77d0 with SMTP id 16-20020a370410000000b0067dddd477d0mr4212803qke.620.1648749011992;
        Thu, 31 Mar 2022 10:50:11 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm13296341qkg.64.2022.03.31.10.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:50:11 -0700 (PDT)
From:   trix@redhat.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Bluetooth: btintel: fix btintel_download_firmware stub signature
Date:   Thu, 31 Mar 2022 10:49:59 -0700
Message-Id: <20220331174959.3421978-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

cppcheck returns this warning
btintel.c:1059]: (warning) Function 'btintel_download_firmware'
  argument order different: declaration
  'dev, fw, boot_param, ' definition 'hdev, ver, fw, boot_param'

By inspection, the stub version is missing
'struct intel_version *ver', so add it.

Fixes: ac0565462e33 ("Bluetooth: btintel: Check firmware version before download")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bluetooth/btintel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..66902866a5c1 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -281,6 +281,7 @@ static inline int btintel_read_boot_params(struct hci_dev *hdev,
 }
 
 static inline int btintel_download_firmware(struct hci_dev *dev,
+					    struct intel_version *ver,
 					    const struct firmware *fw,
 					    u32 *boot_param)
 {
-- 
2.26.3

