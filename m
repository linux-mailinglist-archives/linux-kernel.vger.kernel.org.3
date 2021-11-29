Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15664611CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbhK2KL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhK2KJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65B1C0698C5;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B2E61256;
        Mon, 29 Nov 2021 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20459C8CFC3;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179277;
        bh=50op9YAtX0/PCCZuHHAdCtTsRwW2P9kyuSBk3Zk50fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oki8XiQlbzy0bzjG3M7lzh+UspuiW0aj+E0AudObl3VBhss3bB8v3WrDKSjA8Ld/Z
         aNvZvy9NXWEZ3Adm2/S16ADKTH1MGJ3PC6UZc7aNlMTGOKozWz8oRSe1BSRomjbePZ
         PmWDVXyBr03dy2eDubT4kEY5bQScrvOPYF7METmZ1UoG+UUdII+3+P+7+Hg3AQN3su
         E9Oxf+G4F4WGNwWIZqKA5C3UqgPrzYlfhKZWRIfOi7SMS/agARzf9LvyiOQAgGbz9k
         bsn9vTwcQJn6uz23kO3ELjb6FLqKddPr7895vs/w7gv0CM5GWuyL6QABnjsTcxpaTr
         gyCnfSIRMC5Cw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGN-000RC2-0a; Mon, 29 Nov 2021 10:47:55 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 18/20] media: mtk-mdp: address a clang warning
Date:   Mon, 29 Nov 2021 10:47:50 +0100
Message-Id: <c6e2bedaa593ba764d3cafbe7940005e6b0b594c.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typecasts at the dvb-core generate clang warnings when W=1
is enabled.

Such warning is harmless, but it causes the build to break with
CONFIG_WERROR and W=1 with clang, so do the cast on a way that
it won't produce warnings anymore.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 976aa1f4829b..3d38793aaa25 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -148,7 +148,7 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		comp_type = (enum mtk_mdp_comp_type)of_id->data;
+		comp_type = (uintptr_t)of_id->data;
 
 		comp = devm_kzalloc(dev, sizeof(*comp), GFP_KERNEL);
 		if (!comp) {
-- 
2.33.1

