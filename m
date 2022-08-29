Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1CC5A47E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiH2LCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiH2LBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:01:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D42AC5C;
        Mon, 29 Aug 2022 04:01:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r69so7388538pgr.2;
        Mon, 29 Aug 2022 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=TioeFYjE8HcT3g2Vj0iS9lMouj/gwWFHnvZzq/SpV4U=;
        b=W89wPTlzGFwuGEyclAjs+gkVcw3yIia/nuLfg8kCAgPcKngXeWGp/LoSHesALiDklj
         3tWCqPgUq8XJAG+mMPhLGEDVAnX8WYYRruBsPNs/7mmJ46o8IUHBAiIogsFsX1R19jU7
         iw5YjHKJZPLRcB93p59ppAp2S6oGFL7j7oSquPFUierVItlo9Omif5oisB1YBGPn2Uuk
         0moPy9A4xsfGVRjH3osJpvJTRtchmm0Ai2rpX2V6+U1HT0kge5Do7nBB2pI9exVObAwZ
         h18K/bQ8ed7t2kK9U+GcD/IaHR9FdGpYF2nTXVX+GBgIuX8cEXJgiF6L1j5BpkPjEnWr
         HO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=TioeFYjE8HcT3g2Vj0iS9lMouj/gwWFHnvZzq/SpV4U=;
        b=pG4LMvaP5peZggKbrY+vJw/OoiPEmhfxSXdyondIJrnl8pY7dgSqYLFZbiS96UFoio
         uT69nRzi1qMSnLgLE7GAqL1Ml6FHCVT1V0O6JRw3+51PhWzHaiRPbXZWggfLn4qSM4DA
         7f4lB8g1GKibA+zeecAgB/iOI9gFOftzJUP58nkaKzmj6j+CETKnFDWXldFNItiyhnB1
         fpN6Mxl8u6k0jWJZjXhwWzirISidr1L5ZKKmw5X/zk0dKfL+0wgVb6NKi067vBF4mewX
         Sbbswf6Ximiqri2ziez2Zn5MrYyRCJMKkevdnx1fWd/tALZIdJ8nc+5hO9eW/1H4cJs+
         sPEA==
X-Gm-Message-State: ACgBeo1kiMfiH+l3AcFPhTwFJXHUGQxVXoKqy8hxO+Zc26Onj6uX11n0
        e0F5G/NAQOY6TVIUpFgUT6g=
X-Google-Smtp-Source: AA6agR5UdxPs77+zOqXyVnTbr4j64rU9PoGQmXpUq5i9KUoe+KNFlsNOrC+Dj/Jimt3EjeF3/hfZwg==
X-Received: by 2002:a63:2a49:0:b0:41d:95d8:3d3d with SMTP id q70-20020a632a49000000b0041d95d83d3dmr13365765pgq.43.1661770902812;
        Mon, 29 Aug 2022 04:01:42 -0700 (PDT)
Received: from fanta-arch.localdomain ([2406:da14:61c:6101:4112:4d1:fe7:5105])
        by smtp.gmail.com with ESMTPSA id x187-20020a6263c4000000b0052dc12cded3sm6834387pfb.196.2022.08.29.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 04:01:42 -0700 (PDT)
From:   Letu Ren <fantasquex@gmail.com>
To:     aradford@gmail.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Letu Ren <fantasquex@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] scsi/3w-9xxx: Avoid disabling device if failing to enable it
Date:   Mon, 29 Aug 2022 19:01:15 +0800
Message-Id: <20220829110115.38789-1-fantasquex@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The original code will goto out_disable_device and `pci_disable_device`
if `pci_enable_device` fails. Kernel will generate a warning message
"3w-9xxx 0000:00:05.0: disabling already-disabled device". We shouldn't
disable a failed to enable device. A simple return is fine.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Letu Ren <fantasquex@gmail.com>
---
 drivers/scsi/3w-9xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index cd823ff5deab..6cb9cca9565b 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2006,7 +2006,7 @@ static int twa_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	retval = pci_enable_device(pdev);
 	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x34, "Failed to enable pci device");
-		goto out_disable_device;
+		return -ENODEV;
 	}
 
 	pci_set_master(pdev);
-- 
2.37.2

