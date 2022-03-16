Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A84DB4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357241AbiCPPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357166AbiCPPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:20:26 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6762A2B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:19:12 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9212D3F07E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443951;
        bh=l6KBwGM0uiIwlc1rKLa9ZFBDgTPatr0zsqNmkU7zEfs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=hnBMVm5NuJPHWUriNwJEAOlygXoDV5wbnmaQGBeNGuOR2ufAhiBRhADZ5jGjxW/jN
         5AadvsvS3O5L9v3mhL0W7zT/03qdMNrR9nubb7I/Jnk6gxQEBVH81vvgjTYrhxMD5k
         Yf672IqY3tzqVH8QZqAdY/9H4IswTQUNZ/ZK4ucawyxfyJEYyellQdPdklM7BTEPrn
         SfYY/WVrSYopzf2S96gnPaU//uWNVxHm6QdBCDwdveD5046ANkOu/SiQeQ2/lFPzfR
         qrgAGstoNxy+CkqxX7F3jPh6xaQv6SjA8ljmGNhXTEps1X7qGtiSzKVqqL38Myac3q
         ZFMLp+AuaQ8oQ==
Received: by mail-ej1-f71.google.com with SMTP id my14-20020a1709065a4e00b006df7cbf896cso1194670ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6KBwGM0uiIwlc1rKLa9ZFBDgTPatr0zsqNmkU7zEfs=;
        b=H3yhh7DDt4sSmlxLeaQ0ywLXqZs+YWcnbzncUMz8/t0NQaAaIMh0NxUvK35+8Yy1C6
         wgVbLyvqKcAS+HNxe59Yvjsca6eYxnrl7Wrt0jJagjCpSLXgN9+kHnm4dkHccHIuqg+X
         e1QCjqdBf1NNXjuGMjODJpvUoainDUFK5GNAhoAk+bO8lL17h80M9sCTifndfX866AFJ
         OYioe4h+n9PhMSTnQBHicYAnSw01Phm46g+cU9q1oqaWHeEHT/xNe8x2HAkpBrzFbI1W
         uc+14NKzioLlsgg9Sdjt+QSGmf+Dl/YMgn/5t0Z4uatOrFFomLDKp+HonxzHzWdaewm/
         VQyA==
X-Gm-Message-State: AOAM530L5Myq6WQDYnVJshRipyOQ0HBoru02GaDeCIS04TMyfHYvlMrj
        RvDldq+RkG036mYoKLVRAHlN1U5VrvFYd310o5oVKoGqyrBD+wGAz3h2HV3lIbT+ZI5EynGB6YV
        d+SqdSFyRSV7u2FgcwOj0QxnboC5XiVNZtq77uXuMtQ==
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id e18-20020a17090658d200b006dab635fbf3mr432682ejs.40.1647443951296;
        Wed, 16 Mar 2022 08:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoPSUJMHOAL6T3mNLew5/+8ilp8MWnQTCLDeDxeKP/9TPhEl9ftEH1knZ3RViNX+M9VfXG4g==
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id e18-20020a17090658d200b006dab635fbf3mr432665ejs.40.1647443951025;
        Wed, 16 Mar 2022 08:19:11 -0700 (PDT)
Received: from localhost.localdomain ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906640800b006d5853081b7sm1016788ejm.70.2022.03.16.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:19:10 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] net: phy: mscc: Add MODULE_FIRMWARE macros
Date:   Wed, 16 Mar 2022 16:18:35 +0100
Message-Id: <20220316151835.88765-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver requires firmware so define MODULE_FIRMWARE so that modinfo
provides the details.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/net/phy/mscc/mscc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index ebfeeb3c67c1..7e3017e7a1c0 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2685,3 +2685,6 @@ MODULE_DEVICE_TABLE(mdio, vsc85xx_tbl);
 MODULE_DESCRIPTION("Microsemi VSC85xx PHY driver");
 MODULE_AUTHOR("Nagaraju Lakkaraju");
 MODULE_LICENSE("Dual MIT/GPL");
+
+MODULE_FIRMWARE(MSCC_VSC8584_REVB_INT8051_FW);
+MODULE_FIRMWARE(MSCC_VSC8574_REVB_INT8051_FW);
-- 
2.32.0

