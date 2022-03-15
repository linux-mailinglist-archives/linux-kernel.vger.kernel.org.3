Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA60C4DA5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbiCOW5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbiCOW5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:57:08 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E95D5E1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:55:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u7so854454ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=353ErsK+RGDyNPxQky3skb4+jiks6X7CPsq9uRQTVb4=;
        b=L6/T4rpw8WvPr3573NYwtD1rNDtLBVQhNsCYrmwLv+NkgCN7Yw4pp3lP8uplbUZojD
         pyOf8RRVzciVkb8rIBMWXnSu/Xr5Qx8oSbLjdj5lhNu4rQL+2SSQ+R9TeYG0Omq1TgFL
         Sii7aIxy9lb0SUxbnzNauaFAEQNgf0B/Atzv6snv1iKF231IHrSfU3ln8FgGC+lJ7Y5o
         yI1bUvJcYJjuDulZmw4h2tCHsEsLUqGOzXNrsKFVLaFfns29ns6pRL3CbFlLFbt7Wm+J
         Ynt80jfSlsdVM54NIs/Ozbb8dzMfmcAzmImF4BO39/GRakEEr9yQRdnIvqTspZKxvClS
         IdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=353ErsK+RGDyNPxQky3skb4+jiks6X7CPsq9uRQTVb4=;
        b=2ZNVoaCA5m9VUjOWMu9Ia9hBtvaSEjfWXu9SO96ugfiWt8+w3Pw/KKoLEc/4wWcLhy
         YnrwqmxqHPWgea7qrnpDIo4xDhD5qdmuCQCWRVHExeGW8bKh9b/PCv1jXVEFXh4I8WBu
         DvVjv8urefZlRGD8gPjy7fP8ZswickVax7XjikmsCNKaO2suuy5CtjWp9j4pMCEnRMoX
         vuhu0x1D5IaGVNzdImhTubNgDwdqcK2O6syRsO2wDa5iHGX5NJ7CcYi66HXMYWk3jbqI
         XycxUmyFJ/3PPY3TECXt83wMmHSrjKXMw6iHnERiFb9TYF7Ka0pNPZxHpMzz9b0awFyP
         xV1w==
X-Gm-Message-State: AOAM530B2CCXvYR/QEASgWUUkXKeOJFuK2MmDA6tC7bCh93w4EDNV2Ny
        ZXMISM1PXqW98NJz9qZIvMp7Ag==
X-Google-Smtp-Source: ABdhPJzYA7g7r6z6hBDKdXhfFziYg1jj95qbG394ogx9KGZh1RJJ+T13V3Dd1E6WLqyyb5F/FAlF/w==
X-Received: by 2002:a2e:b0f5:0:b0:249:2986:4fa8 with SMTP id h21-20020a2eb0f5000000b0024929864fa8mr10504755ljl.128.1647384953430;
        Tue, 15 Mar 2022 15:55:53 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id 5-20020a2e1445000000b002491768821asm29445lju.49.2022.03.15.15.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:55:52 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: Never offload FDB entries on standalone ports
Date:   Tue, 15 Mar 2022 23:50:18 +0100
Message-Id: <20220315225018.1399269-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a port joins a bridge that it can't offload, it will fallback to
standalone mode and software bridging. In this case, we never want to
offload any FDB entries to hardware either.

Fixes: c26933639b54 ("net: dsa: request drivers to perform FDB isolation")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/dsa/slave.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index f9cecda791d5..d24b6bf845c1 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2847,6 +2847,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 	if (ctx && ctx != dp)
 		return 0;
 
+	if (!dp->bridge)
+		return 0;
+
 	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
 		if (dsa_port_offloads_bridge_port(dp, orig_dev))
 			return 0;
-- 
2.25.1

