Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC14E4CAEA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiCBT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiCBT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:26:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDAC12E0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:25:32 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 594953F5FC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249131;
        bh=XW443xLXNMd7fKnAwsj5MsweNUN/P9g1RwySZfWsL7A=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=njcbGLZ4kf+fLgTrGYraZCpASRIabOzayBz6S43a31LaCLpFdZkimOAeSyrpr4iWc
         hp22Nt8CizcKquzO6O0xCuoF3BpGEUTXjZnFIBe0wZBA8KgGdahgQ2O1Hg8IET7hT7
         HCK9eQA5Bd2sswYtD+vto2ep11gx9Dn+DKdlbuunUyCcNwHT2I554VwVo5P57EBEN/
         IsfvIUdI/s3k5WeQlYVUu95HUgFxoYqMR3vZs5duMK1i1vXzHWy/iubMLxmCr2jbCJ
         8tZ877ko+Eq3aNVDA0IBOJxxRTNIg7znQSFf2VfFsJUl937+V7nsy26VLtPgPMbHGT
         OM0+1FTqnDHbA==
Received: by mail-ej1-f72.google.com with SMTP id m4-20020a170906160400b006be3f85906eso1475952ejd.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XW443xLXNMd7fKnAwsj5MsweNUN/P9g1RwySZfWsL7A=;
        b=iG/r1xSb6by+oQc2GkR/vwo0r0/uyV4C+wjszI8h88AkkCP4PbGeQYcn2fV0nbcFfL
         2WG03ai9+l6hEkyifWCYvREEjY62Bhe8cQDF4bXCyxvlhvYrB2wdEXUEaQc+D61xKTts
         KoB11zVyXIYRPLK/uj3TAwfJlWLY/lfaVPp6oGv1SYXe6JEewhBkH11Jhe9/9zICOBKs
         MwQSJS8P+2zsF48uoV6RneghM8blgPv20+FmFgwHUQIhgreE3CD2wITsArLhT3c4zBoz
         busNKtAixt+OHWeVeOJQUcgQau7CUihhj96NUE61UTRt5lXQfMU+1o4zyFP8q4aPMHsb
         mLxw==
X-Gm-Message-State: AOAM531wYemleT/yf/SL08McIRt6QzTci9K4x9ZpolfPXsKomYuIDXNz
        xfcTalyVgv8xibm/tMJuKigve/a8jNIr+l6zSz3K7TKXyWRLIsRdmGux6RLsye5djN6tx9eE2vm
        A48qNBeLbxtE6CYLjBejiACLFjBYiHPAWMXj+irl+aA==
X-Received: by 2002:a17:906:2f97:b0:6ce:3ef6:94be with SMTP id w23-20020a1709062f9700b006ce3ef694bemr24638073eji.136.1646249131052;
        Wed, 02 Mar 2022 11:25:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsRBR/F3xyyehjGQgAe0B+0iZQvBRbcdylldzaOvYG3TOQZ1QZiyO7oXqhYToX9C8yGar/7A==
X-Received: by 2002:a17:906:2f97:b0:6ce:3ef6:94be with SMTP id w23-20020a1709062f9700b006ce3ef694bemr24638059eji.136.1646249130844;
        Wed, 02 Mar 2022 11:25:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm1482765edk.42.2022.03.02.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:25:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 3/6] nfc: llcp: use centralized exiting of bind on errors
Date:   Wed,  2 Mar 2022 20:25:20 +0100
Message-Id: <20220302192523.57444-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
References: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style encourages centralized exiting of functions, so rewrite
llcp_sock_bind() error paths to use such pattern.  This reduces the
duplicated cleanup code, make success path visually shorter and also
cleans up the errors in proper order (in reversed way from
initialization).

No functional impact expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_sock.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index fdf0856182c6..c9d5c427f035 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -108,21 +108,13 @@ static int llcp_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 					  llcp_sock->service_name_len,
 					  GFP_KERNEL);
 	if (!llcp_sock->service_name) {
-		nfc_llcp_local_put(llcp_sock->local);
-		llcp_sock->local = NULL;
-		llcp_sock->dev = NULL;
 		ret = -ENOMEM;
-		goto put_dev;
+		goto sock_llcp_put_local;
 	}
 	llcp_sock->ssap = nfc_llcp_get_sdp_ssap(local, llcp_sock);
 	if (llcp_sock->ssap == LLCP_SAP_MAX) {
-		nfc_llcp_local_put(llcp_sock->local);
-		llcp_sock->local = NULL;
-		kfree(llcp_sock->service_name);
-		llcp_sock->service_name = NULL;
-		llcp_sock->dev = NULL;
 		ret = -EADDRINUSE;
-		goto put_dev;
+		goto free_service_name;
 	}
 
 	llcp_sock->reserved_ssap = llcp_sock->ssap;
@@ -132,6 +124,19 @@ static int llcp_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	pr_debug("Socket bound to SAP %d\n", llcp_sock->ssap);
 
 	sk->sk_state = LLCP_BOUND;
+	nfc_put_device(dev);
+	release_sock(sk);
+
+	return 0;
+
+free_service_name:
+	kfree(llcp_sock->service_name);
+	llcp_sock->service_name = NULL;
+
+sock_llcp_put_local:
+	nfc_llcp_local_put(llcp_sock->local);
+	llcp_sock->local = NULL;
+	llcp_sock->dev = NULL;
 
 put_dev:
 	nfc_put_device(dev);
-- 
2.32.0

