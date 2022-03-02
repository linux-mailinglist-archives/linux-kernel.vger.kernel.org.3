Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84D24CAEA5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiCBT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiCBT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:26:16 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C3CC12CA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:25:32 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8376A3F5F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249130;
        bh=ePWS8huBNB8mOLwzP5l9zhhnqwr/R2aV/N6dfRb+pkA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=OqDB+l+JRV4MPEmDj4lf32cqG+Pt9SxR6kg7Ds+fid5NhbPhKD2YmaOcgycudK/jb
         AHMMF+l7d1/ic2htSTd8NfnotJGKiyLYH5GDXu29JSrNsoJxIEbaW5IbfoHoQ08+s0
         Iw+ZvwLnEijCMPmyuSp6qyXE6dsBNVsrxCiCNUCd+EseiO9/b491j39JmkA7ohEmp8
         y2XvzR+0ebxKudBRT87KoIvZD3RAgT9Bz7LEXfwoUsTfP+OKVVV+T4brfWKceAsdIT
         ROCqOZOebBsUTko+zdZ3rEymQl8VUdMsw3qZtnuK0Tw1sBHFX8S/9bQww2u/5bk5Z3
         2XiDAZLP9bk5w==
Received: by mail-ed1-f69.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso1554307edh.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePWS8huBNB8mOLwzP5l9zhhnqwr/R2aV/N6dfRb+pkA=;
        b=GHJKLFdKZjVxHQS/zGSbeaSrVdo4ZW/KfXP0r9tznb1VIgVNqOhsMJzZtDJOXDtZTl
         uRbPQXVvRlwSck6biR8c/KAe+NfT6hoOdKjmSxdKuB7F+cpf6JuDe9GIvFMooz/mtHk3
         NbMToVTC7sKfSw3TOpo2QyHaxFIe7t4Jsd1jqNVacKLYSo5TZ2F+QSwL73RWINbHoSYh
         kMizZptRSE7qZQj10lFy1Ooz0ffPjtMmvH3GMZ2mLGQ7Hhb9CZI3X4yKq6G04Dlu55F4
         NVKsSeb1xB+0c4TqeSdhGrE+xHjpS/NjDSXIl2I/v3AJ5LsczRpTfoICcCJYiSwBKf+S
         7r+A==
X-Gm-Message-State: AOAM533fwMdlaxhZfomYTmwigBdKQZH7Ghg8vgW8Np1jeImIJWJljtsL
        VFJWsWcShrXi+Z21/2tIOEySzv3WzHtF139aOexY0Rc/IFUuHh6meiwYkyKYIXPImXNpFimwaA4
        vpu3SH/Oe+oeatFMv/F2ZPH36iemZt3ffPse22vvS9Q==
X-Received: by 2002:aa7:d706:0:b0:415:a00b:4ee with SMTP id t6-20020aa7d706000000b00415a00b04eemr7325276edq.373.1646249129876;
        Wed, 02 Mar 2022 11:25:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFEFY4wLULZr/eBfkoQpBWjtr5OGYAVw5KfG35wQ8ZmBORByJ1wBNLn5MUEWgSX4YDGpFhpg==
X-Received: by 2002:aa7:d706:0:b0:415:a00b:4ee with SMTP id t6-20020aa7d706000000b00415a00b04eemr7325252edq.373.1646249129662;
        Wed, 02 Mar 2022 11:25:29 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm1482765edk.42.2022.03.02.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:25:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/6] nfc: llcp: simplify llcp_sock_connect() error paths
Date:   Wed,  2 Mar 2022 20:25:19 +0100
Message-Id: <20220302192523.57444-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
References: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The llcp_sock_connect() error paths were using a mixed way of central
exit (goto) and cleanup

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_sock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index e92440c0c4c7..fdf0856182c6 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -712,10 +712,8 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 	llcp_sock->local = nfc_llcp_local_get(local);
 	llcp_sock->ssap = nfc_llcp_get_local_ssap(local);
 	if (llcp_sock->ssap == LLCP_SAP_MAX) {
-		nfc_llcp_local_put(llcp_sock->local);
-		llcp_sock->local = NULL;
 		ret = -ENOMEM;
-		goto put_dev;
+		goto sock_llcp_put_local;
 	}
 
 	llcp_sock->reserved_ssap = llcp_sock->ssap;
@@ -760,11 +758,13 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 
 sock_llcp_release:
 	nfc_llcp_put_ssap(local, llcp_sock->ssap);
+
+sock_llcp_put_local:
 	nfc_llcp_local_put(llcp_sock->local);
 	llcp_sock->local = NULL;
+	llcp_sock->dev = NULL;
 
 put_dev:
-	llcp_sock->dev = NULL;
 	nfc_put_device(dev);
 
 error:
-- 
2.32.0

