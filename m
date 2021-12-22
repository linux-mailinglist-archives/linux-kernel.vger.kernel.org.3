Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931DA47CAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhLVBNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLVBNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:13:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA76C061574;
        Tue, 21 Dec 2021 17:13:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t123so794329pfc.13;
        Tue, 21 Dec 2021 17:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tuVnOiMraCwH10Uv8N7IHwNP9xedfBBpuE0UrBCKDE=;
        b=h/WakJ+6ykw780HcE+D18jLdSMBGs+iwIV8UIO16Fn5/S/P0gPx6DbBlgEpmm8YNDg
         IWtCFPEheqU/z5I2Cpm2dM+O3s3qfzdORm5xX9PHRQQOKdMKZyJw+vuvI7DJ4eTFRrSs
         NIr4TRqlbnu426cCSrrWy3n/0z9ue8vDADrmOww+ouU74vlOjhv6bErPoVceeRxXlm7Y
         xDw2VWS+frEA32pom/LAykXe/kDs/nfillUNTtIHmjH4UyFgH3cbeX7zwaDQzjYRSLoZ
         rOsF5E3l30xxp97/eMvoKrqfMlvNQ3727uKKHFh8UcuGlW2ajT+N8GR4kp0BOlXNzF74
         nJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3tuVnOiMraCwH10Uv8N7IHwNP9xedfBBpuE0UrBCKDE=;
        b=LsbH3Vn/KFHA0ZAMM1Pz49c/q8hW21z5OUqCIuL/6aDIDNYlMPtPA9w14axNMgxAv6
         IXQuAuRJETc+tTrCvX6LbTqZgmfNaA+5FIGhIILMinK2HAIEeLTBmEtuYao2EdIwGKlX
         Poo12m3Xij5jCJX3ydZic+vrzgsZiipDkayckL5y3+0OWz0w2HThwuthvCtozHNZaRqx
         y/WsLEyKV90a9+bnUYMkJuCGKx4KMV9DBDyRmvFZICGKv70AQyljU9ELCyUX0WRN+2P7
         yVRcIB99KBej5QqeiPpbqgEJZJPf8V3NEyv5EHh2qPFwVajhEDdpeMOwk4eBvatwbeVw
         dm6g==
X-Gm-Message-State: AOAM530AptH4HBU7SKYmxYIqFeW9UZXTA00+nqbkpGJoPs/27bevD71T
        sPyPXDnjl5zdEVhHUJnXtiA=
X-Google-Smtp-Source: ABdhPJyzsmoQ/NTUp3e/vm0A72wJblWVESub0GoYMNPwEVywO0vEzAKA43tppPZZ2Y5yZR2hRIh2nQ==
X-Received: by 2002:aa7:8153:0:b0:4a8:2c13:dab7 with SMTP id d19-20020aa78153000000b004a82c13dab7mr645957pfn.51.1640135590127;
        Tue, 21 Dec 2021 17:13:10 -0800 (PST)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id np1sm4015315pjb.22.2021.12.21.17.13.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 17:13:09 -0800 (PST)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     david@redhat.com, mst@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  virtio/virtio_mem: handle a possible NULL as a memcpy parameter
Date:   Wed, 22 Dec 2021 09:12:25 +0800
Message-Id: <20211222011225.40573-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a check for vm->sbm.sb_states before, and it should check
it here as well.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/virtio/virtio_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 96e5a8782769..b6b7c489c8b6 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -592,7 +592,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
 		return -ENOMEM;
 
 	mutex_lock(&vm->hotplug_mutex);
-	if (new_bitmap)
+	if (vm->sbm.sb_states)
 		memcpy(new_bitmap, vm->sbm.sb_states, old_pages * PAGE_SIZE);
 
 	old_bitmap = vm->sbm.sb_states;
-- 
2.27.0

