Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19DC476D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhLPJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbhLPJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:22:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE3C061574;
        Thu, 16 Dec 2021 01:22:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t18so42884225wrg.11;
        Thu, 16 Dec 2021 01:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JzmZnw9w12jnhEnVgbRw3kRkLf6hu57Yrckak9H1oPM=;
        b=ZRmx1zNAZjDwnqSeqDGTIEnhGfUEdpS/Mo5/SNagjhmXA1BlXThj/bRtYhhiDfBX6L
         j4PpRuMGFir9Ue7Eump3JFHS3picyQv0Ua3br4dK4+NFyQ8avTtDErGqxrhAFo9vhh0l
         yyp/pvjn8i6lYUf3CkUfs9Q+BMvf5JI5aTe7O7qHC6UztVQYi8y1MagKSrK2ziBmqC1y
         VD+Ro47/0mbSfH7qeg9hIFmN3Bc8P+3OEoN5tfnqFFTxHBnpY4rq+4CUQW5RbeOVsnRQ
         MldK/E0gpV/bU97CWFlHYn2+nKrCUdIRISuClKaTDh2MqCHSXkWslYuAeGClEmJXQnn7
         7FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JzmZnw9w12jnhEnVgbRw3kRkLf6hu57Yrckak9H1oPM=;
        b=DnF4EJV1OS+f9k5eiXf6jNLLg4Vc779uKigaT7Y+5EkIS6MlPvsOUeMDrdXqn5Be0a
         6154MxwTR6zc0hDRInzdGAVtXT5XQLLNeKqJuCYWgZSd6oxMbziqSkSR8XMZmtNNecgI
         ru6aXFbSE1JnHRukgHplE0t0L93+5lWlCD860l3VL+W0vkTwX07Bx3ZsO0k3Zz4jPLGh
         05yUk25ffBalcHAp830MJRgNsfWlsRuWRLrg/Eq5YnPEvLVbnGgyx60znW8mn5ka96QU
         de+fFl9dxBQJpyrUm4s5wFKyQsSvqnEz0c5ckWRr0YzHyicAdZtWL5dRJoO3H+Zh75We
         iAiQ==
X-Gm-Message-State: AOAM532MZaGcmwVtxdJapNu0Ned/IgkcdrXy7uMHgA0q7fUYB6nubFea
        0Q5mpix5JLpWO9vdm0ECL1Yoj5W0yK0=
X-Google-Smtp-Source: ABdhPJwKtUkCsXljUJ9vO22KqT5+192jrHDhWPt397Y0gwY9TFqGZtsUJ61lgKspMWFMCtGOCFyDRQ==
X-Received: by 2002:a5d:6da1:: with SMTP id u1mr7504507wrs.535.1639646530903;
        Thu, 16 Dec 2021 01:22:10 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:267b:1200:18af:bb55:aabf:94a8])
        by smtp.gmail.com with ESMTPSA id y3sm2068981wrq.12.2021.12.16.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:22:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] HID: address kernel-doc warnings
Date:   Thu, 16 Dec 2021 10:21:57 +0100
Message-Id: <20211216092157.26912-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command ./scripts/kernel-doc -none include/linux/hid.h reports:

  include/linux/hid.h:818: warning: cannot understand function prototype: 'struct hid_ll_driver '
  include/linux/hid.h:1135: warning: expecting prototype for hid_may_wakeup(). Prototype was for hid_hw_may_wakeup() instead

Address those kernel-doc warnings.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/hid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3d83e7022f6c..7487b0586fe6 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -800,7 +800,7 @@ struct hid_driver {
 	container_of(pdrv, struct hid_driver, driver)
 
 /**
- * hid_ll_driver - low level driver callbacks
+ * struct hid_ll_driver - low level driver callbacks
  * @start: called on probe to start the device
  * @stop: called on remove
  * @open: called by input layer on open
@@ -1127,7 +1127,7 @@ static inline int hid_hw_idle(struct hid_device *hdev, int report, int idle,
 }
 
 /**
- * hid_may_wakeup - return if the hid device may act as a wakeup source during system-suspend
+ * hid_hw_may_wakeup - return if the hid device may act as a wakeup source during system-suspend
  *
  * @hdev: hid device
  */
-- 
2.17.1

