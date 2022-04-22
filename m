Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41BA50B42A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446054AbiDVJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiDVJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:36:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3689527EE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:33:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y129so5417447qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xbbjiZS8IMvesATR7m3IJgMWlJJ++cnKlBqL7PtE/I=;
        b=n7kmRouItCvMnCGn6VeOCe2T+bA1ptgIMVX71sn+XusUp7H0uZbo1pW5riTC2DxdLC
         bpBYIP8FzAx5VzLIgG8/kY0VbsQe3k7KRW9Gj45OHWpd88Y5GSpvJVwA/bGBNTDl4TTI
         RmKa5X2mUYqXB78ErZpCCpu7dBtCjBLjivhwCtZJmCTPdFebYhWQEtPu9tZ/7mblW/D2
         uJeUlst4D6hgXxzaUNpMTcNeikWAP+7BvACNOzQ2nA0OFCjgiwwVVWGi52xVtv2iJhlj
         XieyXScIBMMdiqgXdIbKN4379kCRd1a+guzeR5HdeRKeomWGmXvQspBkteULPBD9ECl8
         l8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xbbjiZS8IMvesATR7m3IJgMWlJJ++cnKlBqL7PtE/I=;
        b=VPhSij2kbIg9xq5UsTyx8TcPMUReOKheVmszBWVfe8yJHus65pZSUugfRa4vn9iqfh
         +YUqDy36fC3Zpy2EoZkVV1/XinC/S4dL3apDpGKWwiUgElTpVHt4Kn1hdbsJOL+249jv
         GgtDUa1KOaSTajweK3rasLupgUjHz0cgjG1DiyBYJYcyL7qp8jSFpmvWdBt3iQ1w/T/P
         TDTZOMrFlMYARIMDK0mLLSH0SAKlpnyKdZD2xJJunuG87sz/0xS48xCtDoRIq0EXVh/M
         KyRppQpY6ZEiAMIU0Ibtg1tbw6c8vsjLjDH0XyqYG3P+n9Niem9IFMG0TOiRQMnObeiW
         HcAw==
X-Gm-Message-State: AOAM532++FHYHkpeLtV+HRgpe+uK27zdPFMDnQHWg6qwxf6ScZVY8mGl
        0dpeKisCUjAc0UmAMbsd5m8=
X-Google-Smtp-Source: ABdhPJxDccAT2Zd8xDVtpcRKTH5g1sNeZ1fwrl9KbrT1B10LwO0eIjROMwJYlGpRQzF591ZbCsFoAg==
X-Received: by 2002:a37:9f96:0:b0:69e:abd9:f68b with SMTP id i144-20020a379f96000000b0069eabd9f68bmr1985315qke.773.1650620028121;
        Fri, 22 Apr 2022 02:33:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c136-20020a379a8e000000b0069e5df9d953sm687610qke.34.2022.04.22.02.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:33:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     nsaenz@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, dave.stevenson@raspberrypi.com,
        gascoar@gmail.com, ran.jianping@zte.com.cn,
        xkernel.wang@foxmail.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: vchiq:remove unneeded flush_workqueue
Date:   Fri, 22 Apr 2022 09:33:40 +0000
Message-Id: <20220422093340.2781311-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

All work currently pending will be done first by calling destroy_workqueue,
so there is no need to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 70c9d5544b56..249dd3e30c2f 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1841,7 +1841,6 @@ int vchiq_mmal_finalise(struct vchiq_mmal_instance *instance)
 	mutex_unlock(&instance->vchiq_mutex);
 
 	vchiq_shutdown(instance->vchiq_instance);
-	flush_workqueue(instance->bulk_wq);
 	destroy_workqueue(instance->bulk_wq);
 
 	idr_destroy(&instance->context_map);
-- 
2.25.1

