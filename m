Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4F58FB04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiHKK6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:58:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633CC9353D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:58:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso2475836wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JH5UaZbddQ4g4VUs9BSRG0P6JVrmr5wmmT+eZNqz3KY=;
        b=dvPqJvgtVa9djXx82FFMURarilTzXwJ2dvudwGnAfeJT5qF3cNY+I7iByszlPMzqwU
         83c8iXIJTXV+kUGHBQ5WYMJ+gyTaCMubzI2mhElRdMtUzEOimL+8GImzmeQgM3kXJ3YQ
         ewGY1AWUZHzo/3tMkZJQKFoJ6BCa8wmY2EU9GRTXp+yCBnJlHitM/QtJqyji7+kE/Edi
         GJu/Lupb0Y6NvEmTTs6iUTMBv60PYoX9auwHJXPx+5yru/rfF68fHRs39ZF8a3p/78go
         KbPoZtDDBM4nQgUiWLNWPiVUPTnh2CZ/xV087ZIqwCV25i83Mr9zVeKu2Mrb70bhYmWp
         tWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JH5UaZbddQ4g4VUs9BSRG0P6JVrmr5wmmT+eZNqz3KY=;
        b=1nzH50ZzO3pWBW9YWTTdZ7R39GHpLVOuRhIUXGszyaD0GnIxJoxa9Hfx/K64mf/DAi
         ktcqk/WRDkSJki+qwNL5o7gS7Dg03TKBH8OpIOT7HoKM2lfem3bLNb9oLxSA0HSq40wO
         umNneOCFzjwaR8J6NKcB+xIG9PlvIeSsFCWevg7AtJ2LtJcYQVAYmyo1bRoy+7qy6Fo+
         0kn1Z0mxOqHO9uuUuprchHZguzq3dzWPDD+pcM4nvOtRgbRgQjaSlYFI5+0vjSVlZZux
         A8F9tFynrkQs9legysHIucUpZfuftGWT1ImBWp6nZrpJOxMmMOGNWLaodYJnOrpwFo8o
         5rsg==
X-Gm-Message-State: ACgBeo0PkWJczltJPJoEWChVn5ZI/hyP0wIglrsyk318CLp8EWEZMT8H
        4irlawDJRbZfmtP6c2STxGk=
X-Google-Smtp-Source: AA6agR6Yg8UMDUmlVWnLvoXXKJmynwJ+Hqvl01x91NOO6VprUtkTrq/E3/SClpgI7rwB/UEPmsxhLg==
X-Received: by 2002:a05:600c:3593:b0:3a3:3a49:41a3 with SMTP id p19-20020a05600c359300b003a33a4941a3mr5362128wmq.166.1660215510923;
        Thu, 11 Aug 2022 03:58:30 -0700 (PDT)
Received: from dpk0r.fritz.box ([83.221.247.50])
        by smtp.googlemail.com with ESMTPSA id g10-20020a05600c4eca00b003a3199c243bsm8745992wmq.0.2022.08.11.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:58:30 -0700 (PDT)
From:   "Dennis P. Kliem" <dpkliem@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Dennis P. Kliem" <dpkliem@gmail.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70
Date:   Thu, 11 Aug 2022 12:56:57 +0200
Message-Id: <20220811105657.9493-1-dpkliem@gmail.com>
X-Mailer: git-send-email 2.37.1
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

ADATA XPG GAMMIX S70 reports bogus eui64 values that appear to be the same
across all drives. Quirk them out so they are not marked as "non globally
unique" duplicates.

Signed-off-by: Dennis P. Kliem <dpkliem@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index de1b44631..3a1c37f32 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3511,6 +3511,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-- 
2.37.1

