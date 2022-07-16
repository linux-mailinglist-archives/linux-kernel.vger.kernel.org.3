Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD27576C83
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiGPINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGPINT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:13:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93311CB11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 01:13:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s21so7500333pjq.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P8qGPqtLup1zCD2NBNT17hEogDJpB8QEo6UaLfvv0o=;
        b=Za/r1Bas6Hj9UBtwuo1lLNZ3ZyZMtKO+l1B9Y0JYO7wB6rPOvBrxmZC8IX8TnRNS8v
         x7lSB2226nubmuT3SYS5phSH95jSvUzuzbA8O1tKfLC/7Ia+WX4yzYZohO9nHYdKTlmr
         jNBrYKmTekEUUT1f8yXjZgliQfOZzLMhuKVuf552osnUwA5V8Hjd75t1e1GPfr3Cq6oX
         T0E1NQDefyIAZ04o8WgzQWtirp/wi27NY55bOxrxzvhyGpJwBzqMvV2i/TREbDeMT2rJ
         NWElPZqYguenrKXiJQfiarT56ACITUw3qfAju5hkp7b9cbME9MvNScQnIYV5Wx/5FJpT
         qsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P8qGPqtLup1zCD2NBNT17hEogDJpB8QEo6UaLfvv0o=;
        b=cCZtnxlw7Jmu35JtiB1lgWr3ZqZTYlYBDy5xPGdJqxVAeV531jgUrJNiOszZ4gj0pO
         p+WDiFfcrF6d5JEjXjAG5ltznrYMOC0jqPemq9MmmMnKRum4NoA7EvTwjSzGziiXwWVK
         Fjygs+0DuC5lXPIlPirf9v9yK8y1f1q+kEl1jc/koKHQRt4goCF8qrhOmiSnpf19w/a4
         oRqA76nn8AsshTWVuI0mWyWwMVUHhXHWy4K7tTk5KKwZWeaHxMPW+GOKorcLxijrShm/
         /TI2qG4wykogEHV4EKiZrM3bC2sGEf4wM0YAd904zvr7Dd3BYC1VMXE4YhwIgrR+KNje
         Lijw==
X-Gm-Message-State: AJIora86y6vBW3ivdsARJgwtA5T1mDaWFn+QPm06Zo+5sLPhb7VIF2Kq
        i7en+dibJwbEmGvOsCuzJg==
X-Google-Smtp-Source: AGRyM1tnZq+/bLJYqGjgFo6Lzwy5BZtlWW05MsVDzdFLwTY1up1XNNTabOhGYPk+qtDSvW9aUsFfJg==
X-Received: by 2002:a17:90a:7ac4:b0:1ef:a606:4974 with SMTP id b4-20020a17090a7ac400b001efa6064974mr27026041pjl.51.1657959197244;
        Sat, 16 Jul 2022 01:13:17 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id o62-20020a625a41000000b0052b4f4c6a8fsm645838pfb.209.2022.07.16.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 01:13:16 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     peter.senna@gmail.com, martin.donnelly@ge.com,
        martyn.welch@collabora.co.uk, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] drm/bridge: megachips: Fix a null pointer dereference bug
Date:   Sat, 16 Jul 2022 16:13:04 +0800
Message-Id: <20220716081304.2762135-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing the module we will get the following warning:

[   31.911505] i2c-core: driver [stdp2690-ge-b850v3-fw] unregistered
[   31.912484] general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
[   31.913338] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[   31.915280] RIP: 0010:drm_bridge_remove+0x97/0x130
[   31.921825] Call Trace:
[   31.922533]  stdp4028_ge_b850v3_fw_remove+0x34/0x60 [megachips_stdpxxxx_ge_b850v3_fw]
[   31.923139]  i2c_device_remove+0x181/0x1f0

The two bridges (stdp2690, stdp4028) do not probe at the same time, so
the driver does not call ge_b850v3_resgiter() when probing, causing the
driver to try to remove the object that has not been initialized.

Fix this by checking whether both the bridges are probed.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index cce98bf2a4e7..c68a4cdf4625 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -296,7 +296,9 @@ static void ge_b850v3_lvds_remove(void)
 	 * This check is to avoid both the drivers
 	 * removing the bridge in their remove() function
 	 */
-	if (!ge_b850v3_lvds_ptr)
+	if (!ge_b850v3_lvds_ptr ||
+		!ge_b850v3_lvds_ptr->stdp2690_i2c ||
+		!ge_b850v3_lvds_ptr->stdp4028_i2c)
 		goto out;
 
 	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
-- 
2.25.1

