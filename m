Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E653B134
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiFBBMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiFBBMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:12:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7EC128142
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:12:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w21so3480736pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=X2ieJMGlzcaHYK99zy4O4rgZqpHj0MIlPUsyySv/jig=;
        b=WAJNsnTQTnLlQTwXRbmYJVNioljwUHZ1Z0T7bvtRBgAzunZgyiZCuJvchhSQD/34Qs
         +5uo0zNsEoH3EPJQrQkr+02cxslNn1SkBgyn6iKetTeCHb2/TCmpeCKQnb0pwIHC41g7
         L60OA2pcpBGtPxFoIVmYWv0YAuvbQc48d0ffKOv7uaeUBzY1FewzbjZUk6ruNJQLie+W
         ieQtgXF6jsXZC3GGf7KPmtaaPzb1OP0UIwRd9EoKlr0ByWe8SNiNegvzWLDL2Phu3Tk/
         +6BCxvDtCruSKKu+Y4BFPA/tu/dE32CVIDCzKwpehJXDppeZNrZbUhHtm1BoZsM+TVlC
         x4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X2ieJMGlzcaHYK99zy4O4rgZqpHj0MIlPUsyySv/jig=;
        b=LZ+1lUt0WKeJ7DWHxx+OnzsPE0lCmw67ifc1SRnbZrYiPwrFrela+2wmxLg0Gu3b4E
         BYH+pJw4ZUUhkN3g9IIcAdA9yIHZ4c+Ms7wREQs4T0M85u1sJ73CtpIY5kOCL8ZznKLd
         TrkrFHNi1WlwMaYAdTbn3vbH+gmk7fE4egkN2UfVKm4FNtMIXLI20zaRSNRC5Sj5Z8ef
         mm7WqtqN2ykSqrZy2L3z4N2skX9Hz6oanek0gBxmH0W9jpge3+zPNj4ITYf9E4Or4Vqe
         x/0OeXayHDKJsSrjerhPVP3/53N9EpZT6M4luQIiClmzsmqkhhg6xyOE8Nahgw+6tbGu
         RDwQ==
X-Gm-Message-State: AOAM533FPBgS1SYbL5XFjb64yN/XpXTaxLPvXRdiSH9kwpa5MNUHDdcs
        KuVl3Qu4QTtm71NqXjKFBFA=
X-Google-Smtp-Source: ABdhPJyaG5V6z6gxNedqJo9ojAnzAe5IkX6r7knIvqhRd313m5j5s6anp39u1re8qhBfU1S6EtjGcg==
X-Received: by 2002:a62:be14:0:b0:505:a43b:cf6e with SMTP id l20-20020a62be14000000b00505a43bcf6emr69455849pff.33.1654132330347;
        Wed, 01 Jun 2022 18:12:10 -0700 (PDT)
Received: from 192.168.3.10 ([111.202.144.35])
        by smtp.gmail.com with ESMTPSA id fa23-20020a17090af0d700b001e2ff3a1221sm1940288pjb.33.2022.06.01.18.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2022 18:12:08 -0700 (PDT)
From:   chengkaitao <pilgrimtao@gmail.com>
X-Google-Original-From: chengkaitao <chengkaitao@didiglobal.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, smcdef@gmail.com,
        chengkaitao <pilgrimtao@gmail.com>
Subject: [PATCH] virtio-mmio: fix missing put_device() when vm_cmdline_parent registration failed
Date:   Thu,  2 Jun 2022 08:55:42 +0800
Message-Id: <20220602005542.16489-1-chengkaitao@didiglobal.com>
X-Mailer: git-send-email 2.14.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chengkaitao <pilgrimtao@gmail.com>

The reference must be released when device_register(&vm_cmdline_parent)
failed. Add the corresponding 'put_device()' in the error handling path.

Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
---
 drivers/virtio/virtio_mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..1dd396d4bebb 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -688,6 +688,7 @@ static int vm_cmdline_set(const char *device,
 	if (!vm_cmdline_parent_registered) {
 		err = device_register(&vm_cmdline_parent);
 		if (err) {
+			put_device(&vm_cmdline_parent);
 			pr_err("Failed to register parent device!\n");
 			return err;
 		}
-- 
2.14.1

