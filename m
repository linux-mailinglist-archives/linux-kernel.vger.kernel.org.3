Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D72500E11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbiDNMxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243669AbiDNMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:52:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4443BA5F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:50:18 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF03D3F1D8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649940616;
        bh=bTCDWQhb/1DFg7xNAlf4FlZ/NVtJhvcaYxbzMFY3GtY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JrokDFhRAGT2obCK0XRaukspmq0ETxl/W66diqC5F7ov56min5Yo9aXSKT5NWlWaf
         e8JIplBgStRkJd67cen4CIw69OiqAmDx6lOP4rn+jE6i567/1Sna187EtciHIFfLai
         ousgtGefLkE1mtZpdaCjMtuUzEdXueiJV8AbpUDFbaP+ol38u+OJ6YK6IlFETg5A/8
         9eknd9rRifmt4ExLAdhR/Ze8UmAOrLlNK1UyOHVTe/l8DS6bWi7Sr1xgF59P5g4xlI
         hHStyE8Vlpkz5hH4yfp/aA+FNoYkQR41A+z+SLs/uU5yrb/WN+0MmVjNscFFJ/XkOq
         vAFhP6SBWwPcA==
Received: by mail-wm1-f69.google.com with SMTP id l41-20020a05600c1d2900b0038ec007ac7fso4466113wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTCDWQhb/1DFg7xNAlf4FlZ/NVtJhvcaYxbzMFY3GtY=;
        b=NsUcFuRfuu6OohEcL6mrRSSS9rWgCVkT1lOSycQvr2fMDq7REkO+VbeXuMj9Zs56iV
         GFQ+/HaFOl+cXiT0YJJLtKk/bW53P9KVvIzK9VTHmgA7MniunOBwZ0VdDdhVBrdE8Np3
         LDTu4eNoQaWAUKIZ1XmX7uKFp9IXQgbxdCpM1Jlb5Pre20r6xJ3AjhBSO85v3Ppand4e
         PKuZvqF9kX0jm/AlTRbaK7t7QCq1dxawe94pCucZBOkRPJ+zbEF4O+/6bqw/9FKHImpp
         pc88qj5CLiwKP0i3xJdTOxkSnQDvpEJuzLgowSfUmvhOHrhwjHVIxP2KWRQofwxL568d
         y/oQ==
X-Gm-Message-State: AOAM533KP/NZbLEwShXHf9bma/7d6wIiRbfyVSnKo6ndu9FvaRoUfHV0
        i2YvTmPPr9p13V7zxDeaBKrEYjaadArVSWN0V/vPgowfrQEsLgK9cQEztQNNtDOsmPPu4mu+KVG
        EurORGtZmry1xJtlRsqGhNyP+q4x4E1Gjl1pYyOjo5A==
X-Received: by 2002:a05:6000:1c3:b0:207:9dba:1e67 with SMTP id t3-20020a05600001c300b002079dba1e67mr2046596wrx.53.1649940616439;
        Thu, 14 Apr 2022 05:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBr7ainIS4hSDxZB3IehkNUt6QxAAGHI1dLSyiZ/1zGA/soh/hPDwFI4TjU4Y0E3Ki0LjRgg==
X-Received: by 2002:a05:6000:1c3:b0:207:9dba:1e67 with SMTP id t3-20020a05600001c300b002079dba1e67mr2046583wrx.53.1649940616219;
        Thu, 14 Apr 2022 05:50:16 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:415c])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm1974415wmc.25.2022.04.14.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:50:15 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cfg80211: declare MODULE_FIRMWARE for regulatory.db
Date:   Thu, 14 Apr 2022 13:50:03 +0100
Message-Id: <20220414125004.267819-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_FIRMWARE declarations for regulatory.db and
regulatory.db.p7s such that userspace tooling can discover and include
these files.

Cc: stable@vger.kernel.org
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 net/wireless/reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 795e86b371..54c13ea7d9 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -806,6 +806,8 @@ static int __init load_builtin_regdb_keys(void)
 	return 0;
 }
 
+MODULE_FIRMWARE("regulatory.db.p7s");
+
 static bool regdb_has_valid_signature(const u8 *data, unsigned int size)
 {
 	const struct firmware *sig;
@@ -1077,6 +1079,8 @@ static void regdb_fw_cb(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }
 
+MODULE_FIRMWARE("regulatory.db");
+
 static int query_regdb_file(const char *alpha2)
 {
 	ASSERT_RTNL();
-- 
2.32.0

