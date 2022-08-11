Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C992D58F730
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 07:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiHKFHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 01:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHKFG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:06:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB72760F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:06:57 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 491713FB98
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660194416;
        bh=Kh+l9msGhn7mWAxPmpY/gaB6opRq+mjhr2ErkHQrNjQ=;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID;
        b=FP+uKJINFNw0r7Q/G2x6OEyyU2zdAWZHSZ75t9rKMS0v4gFweolrdFLZ0eVVBCv/K
         A71A69OD50lThGs9gwo1N2jsfFfRueklBTbVt1EE4cP2modAcGoesaVQvoWLt0Hnb5
         q3hrjC/FEaPujE3OnhGKzEZrE3HMhkqcwoxhuPYLwPUHBbxHcRtYaMwvmQLJXPCn/L
         QWEIPQIAqLZnO2wNZIo/+lhiZhCBAQ2ePRsnAglts4wpXdbWfiXSHlte2QaroGa6Bw
         wQr+cJWNeWZERlJtEBtynaP1W0W4S4Z+29Gog+sUn+CnL/qNWQ37kg/aLHcKq9+nw0
         jsAkx+ECFIAyA==
Received: by mail-pl1-f200.google.com with SMTP id u10-20020a170902e5ca00b0016f091c4b6bso10907495plf.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Kh+l9msGhn7mWAxPmpY/gaB6opRq+mjhr2ErkHQrNjQ=;
        b=p8+91Ol8cuix69TGfWh+ea3zOiQxbFV4JSer6MhPIWclEUDqi61oW8Q/Z7GvafvZdy
         T2oe/9zpfwEBwrBT7d2Y38sv5g6ZCNWPSBvBp8V5Y63WXEsKAd9NjjbqAnJz0eDJ/Zns
         faJ1+t3EYYoWHVRjjwDWxkpRhx2h26m/EPmZupvMiwCqpXPDtGTpAPRpbDBPlNly+JCv
         0jhirIZowgsobwl/DG5d/JqRfmaph1inwZW8dt0+aeR1XO+4h9raqPXVDOaoU0ph/AjY
         OG3LD7L8uusJOkc7VEW0DsKJArzE4HukYE85CFPHqmWlyFEicZfd75lIEdzZXDXk1FFG
         AW5A==
X-Gm-Message-State: ACgBeo0cEz4hmqK3fw94R/rKXt+1ELHBMEhXEIh0aqaBa09HfN13N1hJ
        FPauDABu6fb1NeySyeVmD9hz68UsSMSTZ6Pjf6TRSFiwWPpC/0e+g1Zvl/DO+oB04TUtaFNvmho
        LbKafUrcFllE8q6c1qNvSU58m2MnEyRNZ1Lo8CSdJYw==
X-Received: by 2002:a63:d006:0:b0:419:b272:9e6d with SMTP id z6-20020a63d006000000b00419b2729e6dmr25132855pgf.608.1660194414111;
        Wed, 10 Aug 2022 22:06:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5hVrM4mGwjHlQTrcGOMzvOjjJAGiErxEPzeqguWkhn6+og5d4lKaROawLHMRWzY9PWLjthcA==
X-Received: by 2002:a63:d006:0:b0:419:b272:9e6d with SMTP id z6-20020a63d006000000b00419b2729e6dmr25132838pgf.608.1660194413810;
        Wed, 10 Aug 2022 22:06:53 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.157])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0016cf3f124e5sm14074191plr.131.2022.08.10.22.06.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Aug 2022 22:06:53 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 139086119B; Wed, 10 Aug 2022 22:06:53 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 0C9089FA79;
        Wed, 10 Aug 2022 22:06:53 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     netdev@vger.kernel.org, sunshouxin@chinatelecom.cn
Cc:     vfalico@gmail.com, andy@greyhouse.net, razor@blackwall.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        huyd12@chinatelecom.cn
Subject: [PATCH net] bonding: fix reference count leak in balance-alb mode
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26757.1660194413.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Aug 2022 22:06:53 -0700
Message-ID: <26758.1660194413@famine>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Commit d5410ac7b0ba ("net:bonding:support balance-alb interface
with vlan to bridge") introduced a reference count leak by not releasing
the reference acquired by ip_dev_find().  Remedy this by insuring the
reference is released.

Fixes: d5410ac7b0ba ("net:bonding:support balance-alb interface with vlan =
to bridge")
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>

---
 drivers/net/bonding/bond_alb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb=
.c
index 60cb9a0225aa..b9dbad3a8af8 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -668,8 +668,11 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb=
, struct bonding *bond)
 =

 	dev =3D ip_dev_find(dev_net(bond->dev), arp->ip_src);
 	if (dev) {
-		if (netif_is_bridge_master(dev))
+		if (netif_is_bridge_master(dev)) {
+			dev_put(dev);
 			return NULL;
+		}
+		dev_put(dev);
 	}
 =

 	if (arp->op_code =3D=3D htons(ARPOP_REPLY)) {
-- =

2.17.1

