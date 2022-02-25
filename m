Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65C4C47E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbiBYOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiBYOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:52:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5967DAAB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:52:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v21so4901600wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWNJFv+kMEnE9Dxh62unLUJ0LcsDnY4dVicW9EOH0i4=;
        b=iZMhV5/QELmvIeOH2Qgx9n3aAlYGyRzw6kaLem4I7NHZibnbQNWq7ekm7teCLFhyEM
         QWiyDMzasNIuIgPd7K54xumaEiLiXTQKy3aNY+WH6slTE2JtvOaPIaZ3rgig/mLPTz6K
         oonmLPYnZkjUtjqzJbhBymwlMj/tYaGikGLwsGWPEAJgmoNxJ8WMiCtE2Wnth+uUx4A4
         1xM2UN22xJljXMsS1gTkYfmx8U8pXo5PnF+4QaDMCCarCqGs02IZN1kK10pCyoRUEQpe
         NcluEC/zbQV1cbGqxbMcKTVSzcuUjngBjnkNZBxucYUgKczwtOO5TqFnJWCdLWCRJqFm
         QzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWNJFv+kMEnE9Dxh62unLUJ0LcsDnY4dVicW9EOH0i4=;
        b=yAkw1EHRve6/zNGxjUgGYcVFu4zkvg/MqD2NdoYFptpywSAdnZo0nKN1gx6ZyEJq/N
         63SG18uVu60YZwCRaA0Zngai2gDWw+CtyaRo8Gm1sw3tOhf0m7PUqsBQWO9rWq7ZNOnt
         4OOI97yH266yAR1fCechOMN21rXDPQLcnkXcTFRFIa8DTFmIa86zA5f3ArOtUbmHF4Ef
         GlJjfu30TkdXfai+OEcn3pS14v8TKA5zdcUgCgs+5zBuZjiw3AS+/4yCKzoAP+oXkBbI
         hjvA6xnQldnTTJxSijP3MBFg90fkRUnIGZu3BWazkOGzCk4dFUhhyTnXF+feYIp9BbpU
         TI+A==
X-Gm-Message-State: AOAM530tb6bonZ8BMezKY137mIvua+rLsyjFwQUR2EPTrbFuGstTbkxv
        wiSVlS8owGcSLomGEdqVuQ9Umv2tyy/JvQ==
X-Google-Smtp-Source: ABdhPJzBkXlOmGJJ9f+XilDRbI4gd1rN8x8QBewSSUpIv1rpNiD1PWlxhirrYPz94vUXUi4e5N6MQw==
X-Received: by 2002:a5d:5889:0:b0:1e3:3ef9:213 with SMTP id n9-20020a5d5889000000b001e33ef90213mr6392019wrf.324.1645800728589;
        Fri, 25 Feb 2022 06:52:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm2527700wrh.87.2022.02.25.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:52:08 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Mobashshera Rasool <mobash.rasool.linux@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH net-next v2] net/ip6mr: Fix build with !CONFIG_IPV6_PIMSM_V2
Date:   Fri, 25 Feb 2022 14:52:06 +0000
Message-Id: <20220225145206.561409-1-dima@arista.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build-error on my config:
net/ipv6/ip6mr.c: In function ‘ip6_mroute_setsockopt’:
net/ipv6/ip6mr.c:1656:14: error: unused variable ‘do_wrmifwhole’ [-Werror=unused-variable]
 1656 |         bool do_wrmifwhole;
      |              ^

Cc: Mobashshera Rasool <mobash.rasool.linux@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Fixes: 4b340a5a726d
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
v2: move the (v == MRT6MSG_WRMIFWHOLE) check under if (v != mrt->mroute_do_pim)

 net/ipv6/ip6mr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a9775c830194..9292f067c829 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1653,7 +1653,6 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	mifi_t mifi;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
-	bool do_wrmifwhole;
 
 	if (sk->sk_type != SOCK_RAW ||
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
@@ -1761,6 +1760,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 #ifdef CONFIG_IPV6_PIMSM_V2
 	case MRT6_PIM:
 	{
+		bool do_pim;
 		int v;
 
 		if (optlen != sizeof(v))
@@ -1768,14 +1768,14 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&v, optval, sizeof(v)))
 			return -EFAULT;
 
-		do_wrmifwhole = (v == MRT6MSG_WRMIFWHOLE);
-		v = !!v;
+		do_pim = !!v;
+
 		rtnl_lock();
 		ret = 0;
-		if (v != mrt->mroute_do_pim) {
-			mrt->mroute_do_pim = v;
-			mrt->mroute_do_assert = v;
-			mrt->mroute_do_wrvifwhole = do_wrmifwhole;
+		if (do_pim != mrt->mroute_do_pim) {
+			mrt->mroute_do_pim = do_pim;
+			mrt->mroute_do_assert = do_pim;
+			mrt->mroute_do_wrvifwhole = (v == MRT6MSG_WRMIFWHOLE);
 		}
 		rtnl_unlock();
 		return ret;
-- 
2.35.1

