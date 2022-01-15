Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F0948F6C9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiAOM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:27:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47506
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230483AbiAOM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:27:02 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B0B0402A9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642249617;
        bh=YRVG1n1vJA0XrL2lVGuLt3uwESm9x/YKDmWmaL4GYfI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=H3CMewKeO69OXAD8wdQuU4iFH6ILu5Dmvzh5ssQmTv30Kjg+AZiyAXWtLULNrqvDD
         XOU82J2C9PA4xVhi2rE8aJ/HoequCobV3KOA3B1DKyZ/wb8+hfs33nMinzJq5kTP7R
         GSaxb+Uyl1LRHsF2eC5Zbb/MGMrrrvurfWKg+R/lcF1nv8N0E2U3zqQTjYDnW+CKlC
         rjFuneMVKfujNxcmUGsAVF3yAEfl5jlPXhuyVqrzCEjpOkCjS6me0h81LC6A+zPZy+
         lN4rMRsbKzRZNbXayaloWEn/d2o8sWqAXckUu4g2sxRQlBmRGADdRXHYiMHWO25RT/
         h87ZSCu5Q9dOw==
Received: by mail-wm1-f71.google.com with SMTP id w5-20020a1cf605000000b0034b8cb1f55eso845094wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 04:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRVG1n1vJA0XrL2lVGuLt3uwESm9x/YKDmWmaL4GYfI=;
        b=i3p8W/v9MGv01hH87zUKpTCDTsGoEvh9AMxIeSqyEnrNOqYM5Q77310QYBAoQuqoBa
         g6J+5NHtn1Y7tkHPD0gPO3EV6yS63AgKyrgU7yOCK3pl6bXMT02hrM+ghOLhSisaKGsA
         F5S/Y3+Udmamq/jxL+Ma13sNd7K+cTaMvkDetgww5VVsDGW+nzyGxknYQNVVr2WFJu2X
         PhFqOsBtsozZGVZJrkp17L1yF/MiUWe5vEVLJIaPd4vit/wrKxJF+KTNteE6Ume41YFr
         Ik7o+BpjBYkzkOGQGKrBAB2dz2DFSZMyX9EpEGRUYspXuErcfeEcLnSFnvs0B+sNvk0H
         CdIw==
X-Gm-Message-State: AOAM533bIrryc8pmnQtnLfuF4CYh7o0euS9yDR/4oezSajrh7ZqQOvDW
        ftwWgMRVQxwIqyMTiGYYMwsrlgCAySD1Kr1oXF2w2CfYqwReXsc6aXj3T1826zASPqAIsX5xnVw
        dwU75H7ZJUqTY0WsFkvFfH7rfZHGaIt0boGh88C0d+A==
X-Received: by 2002:adf:f390:: with SMTP id m16mr12347879wro.651.1642249617121;
        Sat, 15 Jan 2022 04:26:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzprxD4q8/vHQKRv14tzXFqCdIRim3TyjTiDo4rumIOols5/nb1r4v0oXNQ6oWEsRXBRZ4EzQ==
X-Received: by 2002:adf:f390:: with SMTP id m16mr12347873wro.651.1642249616997;
        Sat, 15 Jan 2022 04:26:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bk17sm7878476wrb.105.2022.01.15.04.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 04:26:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] nfc: llcp: nullify llcp_sock->dev on connect() error paths
Date:   Sat, 15 Jan 2022 13:26:45 +0100
Message-Id: <20220115122650.128182-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
References: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nullify the llcp_sock->dev on llcp_sock_connect() error paths,
symmetrically to the code llcp_sock_bind().  The non-NULL value of
llcp_sock->dev is used in a few places to check whether the socket is
still valid.

There was no particular issue observed with missing NULL assignment in
connect() error path, however an similar case - in the bind() error path
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

