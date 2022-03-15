Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39C4DA64A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352600AbiCOXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiCOXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:31:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782765DA56
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:30:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so1137082lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=NyNPoKbL808w7OY7R26NhmVWgd4nJ+fEBE5S54TvM4Y=;
        b=ClQlVsiqHu9L/Ayp4tl1EoPkxMAILRksImAfnZhFb3C/UfNi1t+Lgs4u0kzumA+VAO
         xQ7g9CR/oFB1BeDNpg2mv5WdmhruMNsJ4V1qxZzlOySPl9mILwqRVkoXLByH+aZb8cPl
         80/V3j5N3OhRDGYzJUqc/z1lUCn0J/uIo3mvf0pbm3SQjcMYqbQGYU5dyuFINidOGZvt
         fcyL0/oXA54vp1qo61GWECXyFFXNqbyTAPKoumMU2Q/tEQOrZl0g2I42DvYKfs28iwuQ
         6DeUaCtZvW7nZ8R6jzInhvBRdw40uU2rJH++zEp/GfX3I3N3OAiuvJEyxfdOpNWoSOKK
         p+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=NyNPoKbL808w7OY7R26NhmVWgd4nJ+fEBE5S54TvM4Y=;
        b=P0oJ/tWDu8goYkgsGHpZwbeGQGHAAsFkYS+zTQKny59xs0aNIvyh+0xrtQd6oNElFO
         PDdsxf+9/mMFzEZDDM6SIhVg64a086efz705/eDb/9rbHvGLsoZT4goUo5DX95N/r6+J
         vT5MXKroibhKQoXmamyPizJwpW5blqwr/ca200Uhsk4AKVxb08FLPi1yjfRFjgBYqJmj
         67GOoZ2W5hCwzK7TF4J+Yqqf3da9p75meVfeiqCOizH9fandDA5FS8763pKyzAx4eEHW
         oz5VAlOfFdudHElftG3ouaKp0zXk6sye2ZF7icZ/dgSxZ3tFiDTVjDRztA9Om/tBHt5y
         Za1Q==
X-Gm-Message-State: AOAM533f3lg3Oer13wGDElx9k/e9di6ldrzDZ24fqb0wALMl1dD24ylb
        1PC2SbBlBTLBWnrQIZeo1D2phw==
X-Google-Smtp-Source: ABdhPJyc+AwfeDN6S+N36JN+QR1+D+RvkhYlnaRVzApgQ8yTVkgbC1T5pBA4MC4ppM2MzsE8BRJNpA==
X-Received: by 2002:a05:6512:3741:b0:443:d5c1:404b with SMTP id a1-20020a056512374100b00443d5c1404bmr17561653lfs.565.1647387040798;
        Tue, 15 Mar 2022 16:30:40 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id 10-20020a2e080a000000b00247f82bbc6fsm35312lji.54.2022.03.15.16.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 16:30:40 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next] net: dsa: Never offload FDB entries on standalone ports
Date:   Wed, 16 Mar 2022 00:30:33 +0100
Message-Id: <20220315233033.1468071-1-tobias@waldekranz.com>
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

Previously, for host addresses, we would eventually end up in
dsa_port_bridge_host_fdb_add, which would unconditionally dereference
dp->bridge and cause a segfault.

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

