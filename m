Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA45569B65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiGGHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGGHRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:17:34 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F82F675
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=n8PvFMQUUSfzGQ+gJzXclFTDPEAZYFvuaAtijT7/nJQ=; b=ODCWoAi7Kve1tOXlyruTEfgKdk
        91395hzSrra9MvNzbxrJPO8sqO5Xn8cN4X8bRokWOd+7VUEsykrzLasF2zhSEw3+XEDBo9gs+6Nzy
        CQ2iDlnVNyw5/VA5MdZ38ArgwEIQMmkusjvONA5DS5xYoJwVDUt6dZSD7WnWkqFClsPvnrycUw2oS
        ZFGONuWodzUUsD119U3WMrbTrD+kNHjADRo8vocgWmPJ4h0GjylIW366HbEn1/BWGr5CBU4JOBIPL
        Vo9xCjc21eMctfFww7hAW7/saTrZ/LGJosEbj9QBTBGoXTxWghE+zOvQ8zJ/xxYP/0RkzVRD0Xtah
        ARqbReoA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1o9LlS-0007JP-5N; Thu, 07 Jul 2022 09:17:30 +0200
Received: from [2001:a61:2a49:8301:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1o9LlR-000PXX-VN; Thu, 07 Jul 2022 09:17:29 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] phy: cadence-torrent: Remove unused `regmap` field from state struct
Date:   Thu,  7 Jul 2022 09:17:22 +0200
Message-Id: <20220707071722.44201-2-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707071722.44201-1-lars@metafoo.de>
References: <20220707071722.44201-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26595/Wed Jul  6 09:53:23 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver state struct for the sierra PHY driver has a field named
`regmap` that is never referenced. Remove it since it is unused.

Not that there are separate fields of type `struct regmap` for the
individual sections of the device's register map. These other regmaps are
used and not affected by the patch.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7c4b8050485f..f099053c583c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -331,7 +331,6 @@ struct cdns_torrent_phy {
 	struct cdns_torrent_inst phys[MAX_NUM_LANES];
 	int nsubnodes;
 	const struct cdns_torrent_data *init_data;
-	struct regmap *regmap;
 	struct regmap *regmap_common_cdb;
 	struct regmap *regmap_phy_pcs_common_cdb;
 	struct regmap *regmap_phy_pma_common_cdb;
-- 
2.30.2

