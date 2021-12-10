Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA646FB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhLJHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhLJHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:11:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7AAC061746;
        Thu,  9 Dec 2021 23:08:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id o4so7629930pfp.13;
        Thu, 09 Dec 2021 23:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TSkC9LiJWh4XTkaGlPB/rmDBv5Wy05nA//9hmVUPnbY=;
        b=Rha6XlOas1aOzbODMI4qEvT0B26gjECUdFyIQVqbEX3HEe5LfX6VOIW+DpNvCLPbXb
         2sHlVLw0dO2a3OqEmy7+Btv9Ov1J21oStxN+JpaaIozzNn3kJ5ncz9COiWc3ogrKEMqq
         6A0JbqAwJTihmu/P42CkrFOacsakF/U1CVjoy9S1sm9kmMSo38Y3nqJh7axBfK1GQaSZ
         Mo12hRBLMAiuPRAG8QGUSiOgUBQVM3APxbo1ITOuQOUa7RkjbB2Fzcr7pqjledTL5kZu
         T6S82GH2/XMWy8uDfPLnqAhvVsOSTvlU+y9BLrry4iYU9Xyeb8W8D7QbzHhKFgF9bTZG
         +r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TSkC9LiJWh4XTkaGlPB/rmDBv5Wy05nA//9hmVUPnbY=;
        b=ISnqJZVPI02iy4ncwisVysCAxu2sjMJlADUx3nrVtP6a0UpST86MQpE94oJnQwyk/s
         CfOD5PmnB4l7Bl6KSbiWCnA8y/xJqSrrhmRzwHjyb9KPaIHao3L210eF2FSSQo/k58z2
         KZB+U38LvcrLV7eA2z+5lDX6DBClqTcmKSYV6uvoQv91SG59HMxSKcVIeDdymaEePT9G
         77cor0c9xCTtmwe7BMYXISB71DMdTUJZC7pRkr7ALpX0LogWFhBCVlsh8w6hfdPLc4Jv
         DX5RtrDQ3pdSKHo1E2riYDWtqldR4j/fS8L8frmHYuUPd7FovARC6gGj58hk+vJEDmg6
         qEWw==
X-Gm-Message-State: AOAM533lIchtWUHDJCH9xiqKYl+qBojh8qApKbh2EZWEMRVabx3aeyR/
        C1SoeVtSM1q0HN4Y/rbj5hc=
X-Google-Smtp-Source: ABdhPJytdt0Z+YZYlytcizfNg4H3Sdf3LJPLySbbzVo4T+dn+MQ7fXrlpmoTLFFRBUH/paih85yE3Q==
X-Received: by 2002:a05:6a00:23c8:b0:49f:e054:84d7 with SMTP id g8-20020a056a0023c800b0049fe05484d7mr16495329pfc.50.1639120091016;
        Thu, 09 Dec 2021 23:08:11 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j36sm1620665pgi.8.2021.12.09.23.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 23:08:10 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/mellanox: mlxbf-pmc: Fix an IS_ERR() vs NULL bug in mlxbf_pmc_map_counters
Date:   Fri, 10 Dec 2021 07:07:53 +0000
Message-Id: <20211210070753.10761-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap() function returns NULL on error, it doesn't return
error pointers. Also according to doc of device_property_read_u64_array,
values in info array are properties of device or NULL.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 04bc3b50aa7a..65b4a819f1bd 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1374,8 +1374,8 @@ static int mlxbf_pmc_map_counters(struct device *dev)
 		pmc->block[i].counters = info[2];
 		pmc->block[i].type = info[3];
 
-		if (IS_ERR(pmc->block[i].mmio_base))
-			return PTR_ERR(pmc->block[i].mmio_base);
+		if (!pmc->block[i].mmio_base)
+			return -ENOMEM;
 
 		ret = mlxbf_pmc_create_groups(dev, i);
 		if (ret)
-- 
2.17.1

