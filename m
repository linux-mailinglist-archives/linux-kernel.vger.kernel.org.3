Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFAA50DD18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiDYJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiDYJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:50:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29C1B7B2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:47:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j4so645011lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12bowfPFjwbARfkmx2Lj5itOqm+ynirWNW7FVK7hniI=;
        b=5Y/fV5bOlbqRIvTU4g3XwwujxodwP2tMuGQVgD3u9elIt0TqXiF3oqa2mnik0Zttdv
         aZgti99zrcwqy5e5Rj8utsjOykGuZWcnGWUrOSpy8c3p8YglUEPqr3RNargC3rJORTGi
         3zKlaYJRyQ73MRrEh+CyKy95nlxz4ZNMPMKTpon/cFPkrdAoNUdRcdR5c+z/L5EuNNOT
         /tJHgEGq+rOfjKdbyUcHmJxPRNvDNN8hSYn8EMO1Jw+5sXJN0AIJF4Gu0RYN0sJFeCTj
         eBVctoXecac1j5xLhvRoUSJFEilk5G6gtmWPJ2fI5TUwXV31oZRma1qkCvhy2GNAuaX9
         2o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12bowfPFjwbARfkmx2Lj5itOqm+ynirWNW7FVK7hniI=;
        b=l864pSUvCoW1wbyW1WQb4UJhU0fa7qRl7J15zdLBG/AA0xTJD5bGSVK1fXVJQasStU
         Usu3QzGBXpHq6Vu6HyBvoG0clKgpnRlfUoKZBozqjLW+oyg5sP2sAh1N8uay+4muDKri
         MUBmfxlyzrWhtNgGYcygU+78j8eO6M6nRxWLUdIUWCSqDXMa4fv2fsY+VYG+qGyf1oJw
         5yPTonjRO1BvubEvur8+Ruy6uWBjLv44XHx3CZeytavaFW2nRASM9ZdXimrrQKqPv1k2
         QHlr9amUReyHmvIe3wH+pzPERwnTxJTAgL2oiA2V6Hp9wk7LcWr2kjmN9NSuaLu+f9pw
         3nsQ==
X-Gm-Message-State: AOAM5300wnp09H+QI273tHawPs++s/StSDjgAACVkQJRVZJ+5XsJyx00
        zkcFM+FHCmKSprDkDOylF0lrA1LZKanJgg==
X-Google-Smtp-Source: ABdhPJy+BLf37kTsRJOVJ6zYJPX/6I9IDvT8ExiG0JHseh4nu7wY5hSvs12AUI/r1ijSFGAv0aJqRA==
X-Received: by 2002:a05:6512:1083:b0:472:1013:aad1 with SMTP id j3-20020a056512108300b004721013aad1mr339738lfg.52.1650880051163;
        Mon, 25 Apr 2022 02:47:31 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id o6-20020ac25b86000000b0047204edfedcsm458336lfn.138.2022.04.25.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:47:30 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        upstream@semihalf.com, Marcin Wojtas <mw@semihalf.com>
Subject: [net: PATCH] net: dsa: add missing refcount decrementation
Date:   Mon, 25 Apr 2022 11:47:08 +0200
Message-Id: <20220425094708.2769275-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After obtaining the "phy-handle" node, decrementing
refcount is required. Fix that.

Fixes: a20f997010c4 ("net: dsa: Don't instantiate phylink for CPU/DSA ports unless needed")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 net/dsa/port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 32d472a82241..cdc56ba11f52 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1620,8 +1620,10 @@ int dsa_port_link_register_of(struct dsa_port *dp)
 			if (ds->ops->phylink_mac_link_down)
 				ds->ops->phylink_mac_link_down(ds, port,
 					MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
+			of_node_put(phy_np);
 			return dsa_port_phylink_register(dp);
 		}
+		of_node_put(phy_np);
 		return 0;
 	}
 
-- 
2.29.0

