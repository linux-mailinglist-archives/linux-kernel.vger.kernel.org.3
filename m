Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964224F7EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiDGMMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiDGMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:12:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82880118606
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:10:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso8709514pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-iitr-ac-in.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=aqpPueWPNxzXBHHxJyXiIz6ra+hEX3sVHFaudIBqTWU=;
        b=2DL2TMXKvODXCmBbujyS6l/pZDnDTZc+ey2Xnf1zD2wEV4IlFyH8lvtx01eKv9x+rG
         aD1N4AxqGK60pgBuRZ58NSTZx2eif3LUcDa6VRNUUMKEkdT/WL3aJ3XNDWZkeW5YlP4E
         NlQXsptgN3eguxnvyin1IuUbY53mboBwxfArTY6MvXZgvDvcg8zo/QBDXEk58i2jY90u
         +E9gLXAG5efmwlHs9OiKpUsf56h8TH0G3ZrE3wRGusLay/pYz852c5kbLmjYB/2ixEAw
         7rSYxvH2ZGjm5TY/OPSbC4ikUIwTlTawealj7jFEI2czS7lTw79w+peUvUEhIynlFNgi
         XOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aqpPueWPNxzXBHHxJyXiIz6ra+hEX3sVHFaudIBqTWU=;
        b=xj7awYgCatxS9oE9WSD050HCrHmCcqtuAoNWEtw73iDayV+c0IxitbmcpjB73i5eUS
         rySLsDPd0QXLGbxI48v/ra0mU/YQe7h67XX+fB4YF7+xXDqzzUfNh8zYDdr0zA4qk/Ew
         kfjD/z1WsALc6I5YuHblYFKxtjQxiH6qrQ1eQdp7F/Z7BuqxzEIkbQyXAT5TlNi9nb94
         4JbI0abOtnGH8VOOm217ns5RyXedD76Snb0QzDAmOo6TnqX1Vtm1v7cJikILNHIx+tnK
         dFijLsGV+t7rSTmmMtg3urxnbZlmwCWIJSLBnDL2FnvCCFyb/jk1LF32/PphkTzxwjaN
         H3zQ==
X-Gm-Message-State: AOAM532BTXVOp/gbEBsT97fCnV52PrOodl9rv26YA7bEGHK3Bh3iDESG
        +dJgOOndgI1Ur7DZC+TPuMJpyg==
X-Google-Smtp-Source: ABdhPJxygEAgUieNSz9kdAgidLjC5IHFf7mloWvF+BsA1T7rAwdhmOSZZQSW29M5jes+IkmxOj1RDw==
X-Received: by 2002:a17:90b:38c7:b0:1c7:6afb:fac6 with SMTP id nn7-20020a17090b38c700b001c76afbfac6mr15455966pjb.198.1649333446047;
        Thu, 07 Apr 2022 05:10:46 -0700 (PDT)
Received: from mahak-Inspiron-7570.iitr.ac.in ([103.37.201.168])
        by smtp.googlemail.com with ESMTPSA id t14-20020a056a00138e00b004fb1d833668sm24095458pfg.33.2022.04.07.05.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:10:45 -0700 (PDT)
From:   Mahak Gupta <mahak_g@cs.iitr.ac.in>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Cc:     Mahak Gupta <mahak_g@cs.iitr.ac.in>
Subject: [PATCH] staging: rtl8712: fix camel case in function r8712_generate_ie
Date:   Thu,  7 Apr 2022 17:39:45 +0530
Message-Id: <20220407120945.31030-1-mahak_g@cs.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux kernel coding style.

Reported by checkpatch:

CHECK: Avoid CamelCase: <beaconPeriod>

Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
---
 drivers/staging/rtl8712/ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index f926809b1021..7d8f1a29d18a 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -162,13 +162,13 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
 	uint sz = 0;
 	struct wlan_bssid_ex *dev_network = &registrypriv->dev_network;
 	u8 *ie = dev_network->IEs;
-	u16 beaconPeriod = (u16)dev_network->Configuration.BeaconPeriod;
+	u16 beacon_period = (u16)dev_network->Configuration.BeaconPeriod;
 
 	/*timestamp will be inserted by hardware*/
 	sz += 8;
 	ie += sz;
 	/*beacon interval : 2bytes*/
-	*(__le16 *)ie = cpu_to_le16(beaconPeriod);
+	*(__le16 *)ie = cpu_to_le16(beacon_period);
 	sz += 2;
 	ie += 2;
 	/*capability info*/
-- 
2.17.1

