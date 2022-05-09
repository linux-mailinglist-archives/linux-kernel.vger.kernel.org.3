Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE4520280
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiEIQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiEIQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:37:08 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A628E4CC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:33:13 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3462B3F21C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652113991;
        bh=G0fQK34FSbU838pd4orLwIr99mE4R02XgVm1RsaYD5M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=auClownzNcnmpUmLpLadnrtTZrtQKN5Vcauqfw957+r7h9vQDp/luYlC6rjXHztZY
         wGTu/lcn65ZtUT7zXXU4WJOZO9rbjal+6ImLAdhnWNFhnk7vjiYm71d396amPr5gzV
         B36ygKSx20IG9+ajBaR7Z7bjSfl9lZq7UXbvZv5vOVx2F8INEeAsJMcTJd+8+IOyVP
         P38eUq1n/c2X8lPZHu9HiZyRGTZRLG8OY9wKYlnDrhe0kRbkxJQze4Cj144ythYx6c
         zWUrW5UJdMET/HHHQRz2naTjXDXv8pBUXHRoUaasOBP7wUZmS6coaykvcJG0eyiw1c
         E/+fnMt0UV3Yg==
Received: by mail-wr1-f70.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so5994985wra.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0fQK34FSbU838pd4orLwIr99mE4R02XgVm1RsaYD5M=;
        b=u7W/ePjU5TiGLxaGkaiRI8It5i/OzMaFio6Syz6wxh5/ALK+MTmu0ApwmZquar8hAt
         9uirN2zOyw0j91QLYNtu3DTOSb2gynPvpPyZ2OaWZQpRtFqyQEueaYuyqxvlfExHNLUl
         nBixAxwDi/qARBf202IiDb3/uj4O+AI+UmkGNSD57/UjXyuYRnODxPIaOLgZ9NMY1JLJ
         I0fIjXeWK9UWQoyCmvWak/iieKOEwwK6UWbd3N+uvyCkDM22/LNXVvDt7ld4mzqyMmUr
         brFkk80gmhaiYVmQQu/WdRQKrDL+nQWRgYUNye/zKOhJ2wS1cyt4MvLMSGC4cTX3OMbi
         mzew==
X-Gm-Message-State: AOAM5312YNyOMdP+btQRg1KAiv4wf76Obt8eQfEupFxHYwMh87g95MLm
        30gG618Ul3BajNNVm9siZd1imkplmtCW/JUefMlhsow7nD8QdourDnBulJrj10SRgcyHLqn9j05
        u13UNK2T4P06SI5NUOA3TIEVCVxP5xPu14NsFtOeZtg==
X-Received: by 2002:a5d:4090:0:b0:20c:8b91:3b17 with SMTP id o16-20020a5d4090000000b0020c8b913b17mr14421290wrp.348.1652113990233;
        Mon, 09 May 2022 09:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxYfsuILOQFrqnaxz7RV4eyZtu3B70E+bGIbCOUWW6WYzKsmOs5GHdqY3YkpYeDWJEN6W0JQ==
X-Received: by 2002:a5d:4090:0:b0:20c:8b91:3b17 with SMTP id o16-20020a5d4090000000b0020c8b913b17mr14421261wrp.348.1652113989903;
        Mon, 09 May 2022 09:33:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:4359:3fb2:1bdd:60fe])
        by smtp.gmail.com with ESMTPSA id m65-20020a1ca344000000b003943558a976sm13210503wme.29.2022.05.09.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:33:09 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Correctly declare all module firmware files.
Date:   Mon,  9 May 2022 17:32:59 +0100
Message-Id: <20220509163259.1513242-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correctly declare wildcard of module firmwares to include, as the
driver & linux-firmware ship many sfi/ddc files for many different
devices which are dynamically calculated and loaded by the driver.

This especially affects environments that only install firmware files
declared and referenced by the kernel module. In such environments,
only the declared firmware files were copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 drivers/bluetooth/btintel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 06514ed66022..9f5fc1ab154d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2654,7 +2654,5 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+MODULE_FIRMWARE("intel/ibt-*.sfi");
+MODULE_FIRMWARE("intel/ibt-*.ddc");
-- 
2.32.0

