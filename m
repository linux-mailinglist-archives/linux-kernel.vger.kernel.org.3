Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6F48F6CF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiAOM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:27:28 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47526
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231183AbiAOM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:27:04 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D349C40749
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642249621;
        bh=yrlNFOS5f9IRjvA5fm0IVEgclHgNp68QGUe5Q3pp8Vc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dSB/yMdQR6IlRBkuJgYdjY9Dx8Cpa3WyPSaY2J3Y7zQoIG7n/3jzZR+qI+yMlzd26
         4prvK9O9bdCVJCiWwYo+POkVYyFVNZE1gfyxjTtbHZTP37kszSTru8VOyL200shyHU
         OPxga1FKS6OPXIlHLkklgsQ/ruj/gxkii7oJylv+1IkD9Zwk9zFd3aPy6qieOC+Wby
         DVOQJpfnTTTLItgnZktSbjFIoMAtBdpLiSaOSUop2NPQJ8xFZDVmBe5H0DysB6K/mF
         80z6NCjKgYUs5TXKQabpgKYG+i0UZvVLhG7k/pJCUL2ifM2+0W/WHDXnlMZ+1KNNkN
         nWuphciUco64A==
Received: by mail-wm1-f72.google.com with SMTP id o3-20020a05600c4fc300b0034aee9534bdso2624948wmq.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 04:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrlNFOS5f9IRjvA5fm0IVEgclHgNp68QGUe5Q3pp8Vc=;
        b=r5kNPRM5QVvSHJwkisYxJzlGkZi2p+HTw3PZEuzY5PA6qDwdLZSKoAjipNsjX7yzMR
         ujWSGAnH3HDyzsuvOJpi7WIuP5WgZZLFIOt3ieZ90SIWEGhD/nxU8eWg3w/cstehsJtl
         Z1an0R6p8EgY0Gbr4cXHi/RbFOC9Hix+q4/OniZ/K9Vx8ruX4G9S0tKl3tnPrH7xhJbd
         gsZRZxHo83AxtfPXoRLMSL5Yp43iH5tUbH304uBC31omil/+GlvsbL3J9LUJybNlHwVC
         5txMDsjrYaJWcD9feoq0pgfT4pw+NfXvFU96TbErYotY3eBIaSMy0YMYQbpNvmcS0tzv
         Y2oA==
X-Gm-Message-State: AOAM530hIw1xdiSGLbWSwcRXKaufj51gcGyX8C3kXEh9FUbjhU8dCSvn
        zQu2/v31yRGxK6xcGKRzk+YknJnLyN9Na2fp59V8E+IylMJoBlwtPcxjsbC6EplH5zy9fTUtxEM
        MMnvpEFPCRQzu+Ok6gTR8Oc6vk+wQrM6GNQMbA+7DUg==
X-Received: by 2002:adf:f0d1:: with SMTP id x17mr12129016wro.223.1642249621083;
        Sat, 15 Jan 2022 04:27:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuosj48Z96wc9CpVVg353GMRvCJEBxDaoKE+PY1MPfJ8vkd7s+FLfB9jQET/3Y31fE7LgFfQ==
X-Received: by 2002:adf:f0d1:: with SMTP id x17mr12129002wro.223.1642249620903;
        Sat, 15 Jan 2022 04:27:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bk17sm7878476wrb.105.2022.01.15.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 04:27:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] nfc: llcp: use test_bit()
Date:   Sat, 15 Jan 2022 13:26:48 +0100
Message-Id: <20220115122650.128182-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
References: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use test_bit() instead of open-coding it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 5ad5157aa9c5..b70d5042bf74 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -383,7 +383,7 @@ u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 			pr_debug("WKS %d\n", ssap);
 
 			/* This is a WKS, let's check if it's free */
-			if (local->local_wks & BIT(ssap)) {
+			if (test_bit(ssap, &local->local_wks)) {
 				mutex_unlock(&local->sdp_lock);
 
 				return LLCP_SAP_MAX;
-- 
2.32.0

