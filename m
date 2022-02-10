Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B994B17F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiBJWKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:10:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbiBJWKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:10:03 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018ACF5B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:10:03 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i21so11273564pfd.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPFE4Zp5rbm2IQyqlfm7NXsxDl+45f9FHKMcmltWZhM=;
        b=BecGAhNqQKYBtuSt99I5RDK+OvickszP+NeK3ijUCL77o0dlQTbAy7BggM8aX4IETb
         cEpXpjKIFS7AJLjIwvKdvmPWB1Vni6UAFNlCB40EP1Whtvmhh9PIcbfuDUk0IFMrGJH6
         2EHsAlEV0bVFb7TTxLd5m4MQ9wwFizcKa4RZrAa5ryY4J0yi9PA/55ewUkwp4ZN5yYOK
         sjGtR6sq1gFrg6cmc34y6GDB5jXmh8Q9riwznb6bhB59llLXYVHLRFQJgpUj+3tVFAy3
         SauljF+zxpTbCj5Mau4X2QEY4vf3By6ULIoM+4mnpYOJHKZrlXdCLxRdPPCwzL4TvPmK
         Ks6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPFE4Zp5rbm2IQyqlfm7NXsxDl+45f9FHKMcmltWZhM=;
        b=U2q3og5oOrPqqtm4fLX0xHLE7tQMyxzDqVZ7bv7rWr+Lgt2R/GrtncmBQbu04DUOcf
         Ta0x0vZ7OdBU+vPsMRiJWZEFKp5DqNEdF3vHJEQNxyw/3Lev7hKEGKoba1VsuQAfATeo
         lzhoROiBkFC+GONZQat3AryQLGADNFzW5EluDiwEakNuhsZ6nir1gAUmSDLG7HCTt7zE
         YAPYbuLe0KQmMEtekr/+Sj9OK9CK4yM0Nafpfr99O4KidJadSaj5AUeM1+CK44xrQhvO
         433Aj6Bo0dsm7QPPXpoqd6ZzcPRC6KsqAAKV98dXKSPa7APQ84V5bzQ3VVSBk74zyad1
         6iKQ==
X-Gm-Message-State: AOAM533zMQ8WdrrtlhtoQocvqxBLtk6RT3+SF+lKBetXV5Z23vZ1DI0f
        epdemjvy9tnDhp63Bxk2m8cyaA==
X-Google-Smtp-Source: ABdhPJy/6kfvRUGKsTucEgxDqPV2QGBA53s+SzuHMp3+/NwS5tGBIzsr2EtjnYA0ie6BtvIfuitpDQ==
X-Received: by 2002:a62:86cd:: with SMTP id x196mr5610683pfd.26.1644531002471;
        Thu, 10 Feb 2022 14:10:02 -0800 (PST)
Received: from kalash.aristanetworks.com ([64.180.125.150])
        by smtp.googlemail.com with ESMTPSA id c4sm12470147pfl.131.2022.02.10.14.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:10:01 -0800 (PST)
From:   Kalash Nainwal <kalash@arista.com>
To:     netdev@vger.kernel.org
Cc:     fruggeri@arista.com, kalash@arista.com, dsahern@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Generate netlink notification when default IPv6 route preference changes
Date:   Thu, 10 Feb 2022 14:09:35 -0800
Message-Id: <20220210220935.21139-1-kalash@arista.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Generate RTM_NEWROUTE netlink notification when the route preference
 changes on an existing kernel generated default route in response to
 RA messages. Currently netlink notifications are generated only when
 this route is added or deleted but not when the route preference
 changes, which can cause userspace routing application state to go
 out of sync with kernel.

Signed-off-by: Kalash Nainwal <kalash@arista.com>
---
 net/ipv6/ndisc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f03b597e4121..1c06d0cd02f7 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1337,8 +1337,12 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 			return;
 		}
 		neigh->flags |= NTF_ROUTER;
-	} else if (rt) {
+	} else if (rt && IPV6_EXTRACT_PREF(rt->fib6_flags) != pref) {
+		struct nl_info nlinfo = {
+			.nl_net = net,
+		};
 		rt->fib6_flags = (rt->fib6_flags & ~RTF_PREF_MASK) | RTF_PREF(pref);
+		inet6_rt_notify(RTM_NEWROUTE, rt, &nlinfo, NLM_F_REPLACE);
 	}
 
 	if (rt)
-- 
2.30.1 (Apple Git-130)

