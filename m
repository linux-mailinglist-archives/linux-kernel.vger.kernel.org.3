Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFD486931
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbiAFRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242380AbiAFRu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:50:28 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D56C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:50:27 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id u6so5884566uaq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S83gmKJRxga8KxgoTETTyTXBpVOJ+3/hmOtKLK+avWs=;
        b=XpjP3vG7EcRJL+aACAtzRzmKttuB/qwkhoyevL79eIdEViN8G2kxEkms8m2aKOK1pL
         CWUGhGDBsGi26Bk0HdZt/cL0TukxbumzFHRb3VHTygc7EoVh9wh4yMgxiJz/13GD4PkT
         v31Ib8gakyzuwGrv+4HxmumSTggyDcYWSt12392Oh37D8LS7OSS4Pmn4XZu1dOl52erk
         jvtvz7+86+J7IzM8C4tpwNxhhdBPMBRj9Ri+NHfQd/7Ch26/lEqTB7/esgNhs7pAfM90
         HI6DUdSaFt3pEsY+6XqvlpFNjyQJsBdFDwCRAapWS9u7Ry77PX50FXyQTUvIrzEcfTUw
         80jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S83gmKJRxga8KxgoTETTyTXBpVOJ+3/hmOtKLK+avWs=;
        b=JF7fBO/yUsSqZRv4i1oRkBtXW121V3JVaiQtFnFOfZeDvAJC2D06Sm9GFlNLOlewFn
         bznp9YDNy3yU47gY1xjFh2QPDXSvQNYN5cTkngH0Dk/MboXkbkqMqYA9Mig+KvigkFdH
         aK6ENFIM5KiY6YgNv6kQZPnXFZtYLfZUhl/8LSBcIx2U4IrPCsqGM2qNk8U63OjjtCHV
         3EIClWEcOmgIyw1She215Xuvj3uFkxuEK5aFw3In0Vq8STeJUhZHzbsP1kLqsRRBO9RH
         mpH7IPIf7O69KJBxtpwcQ93Pv7WtEzSodvGRsdANHlm1ndQM2jIaB3/SS2CXacJwdquL
         Ec8w==
X-Gm-Message-State: AOAM5311QhlsiRmReLiGYZFZupdWcFyZr69sUTDtlhl2cJNS8fr12L+E
        rk5f0+Yc5t1MIFAks5QqvXDHoX7oH0I=
X-Google-Smtp-Source: ABdhPJzrRje7YaTLedRE35KL9FoDlPAkmevAD6ytIrg+CT2LsNe/YBjedHy4S1rBS7zXO7jr/hVM8Q==
X-Received: by 2002:a67:e94f:: with SMTP id p15mr18990364vso.11.1641491426947;
        Thu, 06 Jan 2022 09:50:26 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:504a:2169:9589:878d:2b28])
        by smtp.gmail.com with ESMTPSA id az22sm1608061vkb.15.2022.01.06.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:50:26 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     matthias.schiffer@ew.tq-group.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
Date:   Thu,  6 Jan 2022 14:50:19 -0300
Message-Id: <20220106175019.3116389-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error message is seen when booting an imx6q-sabresd:

debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' already present!

The reason for the duplicate name is that map->debugfs_name is never freed,
which can cause a directory to be created with the same name used in the
previous debugfs entry allocation.

Fix this problem by freeing map->debugfs_name and setting it to NULL
after its usage.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Avoid use after free (Mark).

 drivers/base/regmap/regmap-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2da..e1017ca65be0 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -605,6 +605,9 @@ void regmap_debugfs_init(struct regmap *map)
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 
+	kfree(map->debugfs_name);
+	map->debugfs_name = NULL;
+
 	debugfs_create_file("name", 0400, map->debugfs,
 			    map, &regmap_name_fops);
 
-- 
2.25.1

