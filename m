Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1954DE600
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiCSEpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiCSEpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:45:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9282FE6F;
        Fri, 18 Mar 2022 21:44:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t187so6424734pgb.1;
        Fri, 18 Mar 2022 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ePtpQVr2/xAxWdpNXmu4SCKmYKeBJUhhz3S5bqyfLKU=;
        b=EG1wDIRdERFcS6rtxwyxLTBB6svh5CPPWQdMfQI+XSxBmUMIKmRYMq/zH5/4vLa+gx
         DI1Pn6b400nSXUuDiOnrisn9P7BXv7NG6SU7vRbQzHidcu2xbsK14JrkT9JgqnG7h5Av
         enYIgTcxTdJIqQDQPLtsFze/RIbTs2cOlvHLx4A+y5wXDROiixLNoiK0AnupGWpndGqo
         LNGtnQlLfjcAcgtlnlkpz/qThYhOKB3JJJ5HVht/Gtl4ffLOeRwQwd65Kcmtp4eZRGEX
         OuBlI88RokcQCshQ+pfXivIrz2UEzD73qzyHQfqdAFHGskXWoZr/oE5vaycvMXH2j78f
         mAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ePtpQVr2/xAxWdpNXmu4SCKmYKeBJUhhz3S5bqyfLKU=;
        b=IGSgGYapdhe+JCkifNT/ERMx4pCWPUovbDaAcorE3Tnd1DvMILkndsDI9GvXOdS2mb
         luInlvey24P9zetM1AgJqXz2GX+Okui61ro1z6lyDveRudFrqqCI6o5jP7B1vB+6M09y
         Ysma/KFklnvR3LEv+CTHkTizqIcZbsaXUBqsS9hvk+B31V3nT926FW/4iJfzPyVxazGj
         iptXVEtwJdpf1HhbCvlA747BaiF5WtZduOxEh9caZc5S/mgkHhaI0OsMwIOyl0MN+u5Z
         Vu560eIpqRynd0OHB7bj1XAWTecQE74ZCPa66JF4mD0dLu6aZLVJ8eKvIARkUcbvcB1e
         S92Q==
X-Gm-Message-State: AOAM531qADoPtaUl+jzPaGqfCJl1GS++N6R53le5agkDIEVDRAH/gj4y
        eW7ZV2jtqqQg/PM+skW9W2lGwPLqLL4YqQ==
X-Google-Smtp-Source: ABdhPJy7w74S5F0bIJTpM5fYznOxplyhk67otI6Uy9j8OyryERB8URYw+DyD067E3TaCC+XrvuDLKw==
X-Received: by 2002:a63:710f:0:b0:378:c35a:3c3 with SMTP id m15-20020a63710f000000b00378c35a03c3mr10377084pgc.535.1647665065783;
        Fri, 18 Mar 2022 21:44:25 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id nu4-20020a17090b1b0400b001bf497a9324sm14301019pjb.31.2022.03.18.21.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 21:44:25 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jassisinghbrar@gmail.com
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] mailbox: remove an unneeded NULL check on list iterator
Date:   Sat, 19 Mar 2022 12:44:16 +0800
Message-Id: <20220319044416.24242-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list iterator is always non-NULL so it doesn't need to be checked.
Thus just remove the unnecessary NULL check.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/mailbox/tegra-hsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index acd0675da681..64eaee089b03 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -799,7 +799,7 @@ static int __maybe_unused tegra_hsp_resume(struct device *dev)
 	struct tegra_hsp_doorbell *db;
 
 	list_for_each_entry(db, &hsp->doorbells, list) {
-		if (db && db->channel.chan)
+		if (db->channel.chan)
 			tegra_hsp_doorbell_startup(db->channel.chan);
 	}
 
-- 
2.17.1

