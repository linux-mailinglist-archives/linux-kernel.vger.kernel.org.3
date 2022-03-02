Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288584CAEA4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiCBT0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiCBT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:26:13 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD3C1176
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:25:30 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 052A63F610
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646249129;
        bh=KE7cA2DH2YKQP2Gc57E040M9nuLXTd4XcLilkBUwOrw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=M6+ZmeyUa0f9+qsyxIBFU6jul8m1gPi4EUzBxgT0hpNFpLlotPV7LFVG71tQORM7v
         93xIiTGcmH75SA8wTKY9ZHbma9l4S3VgFI189B/bRip1q/4DsOQCYDAhvAEZyrF3YR
         LkvNmsyW4oYRk32QLlgGy4K4QfxNNv9fTkuFfOfjGc1EbXRebm7acFemMKe223MFIc
         QYa52nRgj2wUkBzGiboa5Lzkokb/wJBJSxuo6zxyrNwOf+NdY6kqr/J/gUa07rtQiP
         2B1/iNdMIS1Ln8wTCHmnBvE9BrIDBaN07+HjQXU8krDjTxBDOTDKhK+pXiCXIb0PIe
         Y+pVKo4LdeZXg==
Received: by mail-ej1-f69.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso1480331ejc.18
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KE7cA2DH2YKQP2Gc57E040M9nuLXTd4XcLilkBUwOrw=;
        b=JeqCsgls6guqY+hrmE4B6TF9WT2310p1OLtDxN2zbaYtdJHtwiXh6egg/et3OOdEcA
         nBcfuy5QzE1x315IkW/OvZ88J1wQAhtM9sFxOiLNaelYUNPyPTpepgu/ocv+PDqSA9Lr
         /kO4i1Uk0XLMsYb71bJYe4todI9kW/gmdwGR0pz59h2VJgogvvJt5FPTzkGxnRJyn6LW
         9DiokWbxCB44L1g+2pDZjIchkMkortV9lcfHs7SsMzLG/rOz7ix3tduFZJcYzq8ELPCK
         NeiYMBuy3Or6S1EtkGnJ+j51pkS4uh0A7EYYQx+hN2z3bKQvqFCVji5j9DhGJmevVzwn
         ysMw==
X-Gm-Message-State: AOAM533ac37qr2W5ztChYTG0Cd0KQMukaXot+gdcBbiwOROOko4jubJl
        t2yRhlqI5fOUE7Z+Inh4FFBQ5ilFwmGtrZTRwCo00dpHyUTtmNG0tvZAYXqOUDe1cgby9bmC22H
        NPCELnfHwU5c4kTBLJPRndSLo3CUqIxGFzfGToAXn0A==
X-Received: by 2002:a05:6402:369c:b0:413:2bc0:3f00 with SMTP id ej28-20020a056402369c00b004132bc03f00mr30801302edb.126.1646249128344;
        Wed, 02 Mar 2022 11:25:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzj6ncNvbB8cHRaUtjFkSKVI4lc6ShTlpArR4gywnj3ywk9IVqiotnQYISrRs1enqnteey6vg==
X-Received: by 2002:a05:6402:369c:b0:413:2bc0:3f00 with SMTP id ej28-20020a056402369c00b004132bc03f00mr30801289edb.126.1646249128190;
        Wed, 02 Mar 2022 11:25:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b00415b0730921sm1482765edk.42.2022.03.02.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:25:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 1/6] nfc: llcp: nullify llcp_sock->dev on connect() error paths
Date:   Wed,  2 Mar 2022 20:25:18 +0100
Message-Id: <20220302192523.57444-2-krzysztof.kozlowski@canonical.com>
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

Nullify the llcp_sock->dev on llcp_sock_connect() error paths,
symmetrically to the code llcp_sock_bind().  The non-NULL value of
llcp_sock->dev is used in a few places to check whether the socket is
still valid.

There was no particular issue observed with missing NULL assignment in
connect() error path, however a similar case - in the bind() error path
- was triggereable.  That one was fixed in commit 4ac06a1e013c ("nfc:
fix NULL ptr dereference in llcp_sock_getname() after failed connect"),
so the change here seems logical as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 0b93a17b9f11..e92440c0c4c7 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -764,6 +764,7 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 	llcp_sock->local = NULL;
 
 put_dev:
+	llcp_sock->dev = NULL;
 	nfc_put_device(dev);
 
 error:
-- 
2.32.0

