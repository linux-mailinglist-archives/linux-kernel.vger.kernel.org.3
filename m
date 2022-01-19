Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6E4935D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352223AbiASHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:53:11 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55286
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239507AbiASHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:08 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D89583F1C9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578786;
        bh=hsf4OWBu8gj1asXGvoAW6jPDrjEeTDLfH6tpVV1berI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GSCtUKGASfbtRPDVyA0rTmThe+PRyvirX6vXY5JhIv28katS3/EgnYRHgglCJ02Bx
         z4BF9oY5I9BzsIEEG6tx7HuE1CoHOAjfaA6gWcvFdjRouK3VT+uvcWgQJwY36v4LwT
         TUjoETmqj18QspSSo4YYsP/TmQ+Mj/0nGf0oUGyUsD2a2Dh+cXRbK5PEA44wLoB0s6
         AcorzZcZCdNjP7YtzaNW+uu/Gm6UrkxgfOGxlpm/G5HRjHfcDR/LUhRS0/bfd/DNsN
         LSLU9tnEVobjpyhSgR7C4i2brOemkDSuy9waimICV8lq7azEb1Rk0VpkuaMHmrf+iF
         hkzRREogM1h7A==
Received: by mail-ed1-f69.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so1470616edt.15
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsf4OWBu8gj1asXGvoAW6jPDrjEeTDLfH6tpVV1berI=;
        b=1wCirI97p4MSuddY/85hcve7pqHkolSlZfBe98G7jNr8IGLyRZPfWaHM8qFz1JFZ2c
         cYqDz5Em/QylVOBHuRUo++Vtkhvtod6TqeEUcsejWrPXD09fVzpmXGBCUtaobQ0BSvql
         DQtUwg4NLKGPZMUH6FYnLxxmB+Szarxz9fx2dClfwzK6t3NymrU+RB0QJoOF2N0/lDLh
         xAp8lwZ9JZvtsQmKAoWQBnW/H/X200PcskxzabMyDXoYEyzOBmXZsWj6LB8e2oYt/gbS
         qi9Bbj0vn/TQhbBKR+rNlzn/rPUMX8SZn0EPEXlHz6qTjWcOWiuuVp01hCNGQwG++205
         qUfA==
X-Gm-Message-State: AOAM530Oq5kBCl6kiATuoe3nIC7dffko434pC/WDTtPgmIsAIeV83ehh
        FqeppVtTQNV82GkW02z+uvKFoAGowujGXdKtGoH9CTJyVI9eTqAk8LzDna85feM6AE6O57ZXTC/
        I6qsuRwp6OP/u93bjXxTKJSVFJaPIzR26Z5xNAHxnVw==
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr28608487edw.385.1642578786590;
        Tue, 18 Jan 2022 23:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyns4WRsOdrGoSiLkUgMsRyEIUWZN7UKVXPDT+SQgr4x790RZ4Ep5Cqmw1oA9YvBvJZNQYpwg==
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr28608483edw.385.1642578786471;
        Tue, 18 Jan 2022 23:53:06 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w17sm805286edr.68.2022.01.18.23.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] nfc: llcp: simplify llcp_sock_connect() error paths
Date:   Wed, 19 Jan 2022 08:52:57 +0100
Message-Id: <20220119075301.7346-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
References: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index d951d4f0c87f..a1b245b399f8 100644
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

