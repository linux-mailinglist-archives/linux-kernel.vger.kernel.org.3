Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFC55DE38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiF0VAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiF0U75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B25F5FBF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656363595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P2ALvax4QLHT/PRvyeFgcmdY6fh0+YOux9iV3/Np/Vk=;
        b=dglIoFwONywXiBsQNPkFgD7rgqJWbBTTemHaKD966xhSGTqBANRzKiiinL2trbGS++GDJK
        Gb9fjUbWBQLe0KPh2doGYI+zC58RdBCS/7bBptT7r52zOi1y2aL0ya9WTWOWdOVtgW5uPk
        wIFpk54CDCJyvyCT4cwtUl38u810Aug=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-fw-lYOQWOSKY2vJq6gFlig-1; Mon, 27 Jun 2022 16:59:51 -0400
X-MC-Unique: fw-lYOQWOSKY2vJq6gFlig-1
Received: by mail-qv1-f72.google.com with SMTP id v13-20020ad4528d000000b004707f3f4683so10444354qvr.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2ALvax4QLHT/PRvyeFgcmdY6fh0+YOux9iV3/Np/Vk=;
        b=LNP//5SneknvKckRPtG4Wk6FtwaL+3lbfhfL4DJJy43WsjKYABEtnd0kIQIHCFaodV
         1DNYxoshQUcebBUmAr6lh5rLoEjBPYJ3L9rkbU2+pljFBR5SBkocxtq5p+h6jOObYToB
         YKoix1WyJxlyoRqI5XxycWn1SerlXYpYf8GdfiBdPKzp4+0Gzktj4AlRTTePVqtsZiGa
         aSrW5inPvsRKPOBFZb9mJXHVEp8L+SXpL7oeH3zCcAmr6nqI9O+cxscnFGRC0GOkiZn4
         olJk1iSp7xV6F2n9+4+5NiJQRBERHhnlYFYPj1aih8H/PYYVL5O8Pv9+BpQOwevnLAzZ
         rVMQ==
X-Gm-Message-State: AJIora+y1/Ys0/sukVsDU+/sruaIF0n8IH8cst+wy8sbJqENeePeLNPh
        ZRPkxoMuZ/iHc2rCcSIRNiMStJobIcW6HfvNuHvEbB8OL3cYpUjNrn3M17EcsdijS0Sb5sG5pzK
        HdfVbr52wv/Hh4Dga8k4sC3CW
X-Received: by 2002:ad4:4ee4:0:b0:472:7778:ff86 with SMTP id dv4-20020ad44ee4000000b004727778ff86mr1162013qvb.109.1656363591488;
        Mon, 27 Jun 2022 13:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOGQ37j2Gu0CzjFIVikcF7haS9EBEvbksI9EbPMv+s+mbkvrI4aOi6vEzPyMNbkPK8eNqn+g==
X-Received: by 2002:ad4:4ee4:0:b0:472:7778:ff86 with SMTP id dv4-20020ad44ee4000000b004727778ff86mr1162003qvb.109.1656363591235;
        Mon, 27 Jun 2022 13:59:51 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006a708baa069sm1787831qkp.101.2022.06.27.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:59:50 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lewis.hanly@microchip.com, conor.dooley@microchip.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        daire.mcnamara@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] rtc: remove 'pending' variable from mpfs_rtc_wakeup_irq_handler()
Date:   Mon, 27 Jun 2022 16:59:43 -0400
Message-Id: <20220627205943.2075043-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
[drivers/rtc/rtc-mpfs.c:219]: (style) Variable 'pending' is assigned a value that is never used.

The fetched CONTROL_REG stored in pending is unused and partially
duplicates the functionality of the later call to mpfs_rtc_clear().  This looks
like leftover development code, so remove pending.

Fixes: 0b31d703598d ("rtc: Add driver for Microchip PolarFire SoC")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/rtc/rtc-mpfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
index db9c638e50f7..f14d1925e0c9 100644
--- a/drivers/rtc/rtc-mpfs.c
+++ b/drivers/rtc/rtc-mpfs.c
@@ -213,10 +213,7 @@ static inline struct clk *mpfs_rtc_init_clk(struct device *dev)
 static irqreturn_t mpfs_rtc_wakeup_irq_handler(int irq, void *dev)
 {
 	struct mpfs_rtc_dev *rtcdev = dev;
-	unsigned long pending;
 
-	pending = readl(rtcdev->base + CONTROL_REG);
-	pending &= CONTROL_ALARM_ON_BIT;
 	mpfs_rtc_clear_irq(rtcdev);
 
 	rtc_update_irq(rtcdev->rtc, 1, RTC_IRQF | RTC_AF);
-- 
2.27.0

