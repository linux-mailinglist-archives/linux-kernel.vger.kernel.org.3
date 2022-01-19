Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB104935DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352222AbiASHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:53:14 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55292
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352192AbiASHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:09 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EEB5A40515
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578787;
        bh=OSgZIsl6KSiVLFhGjCsmJG0C27mMplYwxlAMHo9H3Hk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=K8R4oEEUAG56UHxcaB7aVa7foTauihQB1qgzuXFsA2TU+FgJIJ8oiE1q9zMPeIoNF
         65fthwD/kpgjqAmWD92aZf2tQFBOKvKLydMtw8PaabhFz1Kjtu88zAui4eE79DO/3n
         il7KRZ/+loFJTicc1ga7H4Wp44aI8JsGRjl5VrxemeITTOoMCssI/StNv0+hk5v+ST
         ze/g65EpMIYKnK/LDIAtupICDnjWCynMxrHssFm48/bGea1Hh8xFBajE8MHv/4NyJx
         TcJSGGxD91Ycg3rzHkq6tF8oY4l+1nkG55W14oCuXSAPHuQ6MFwniqFDt8RKBj1OFQ
         E7/pR40NQsVWA==
Received: by mail-ed1-f71.google.com with SMTP id z6-20020a50eb46000000b00403a7687b5bso1500981edp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSgZIsl6KSiVLFhGjCsmJG0C27mMplYwxlAMHo9H3Hk=;
        b=5FUxZrvwhy0YCZikddCzwhn/JqH4+5IbIuRPNezUyo3YeRPysTH4IWA4zS5CaS9Ynr
         l7UVIejiCO32BO8uL5uPFXHXs8g70s/8nmJNuwy+qQmO783EqBI7h5Wnd3Jys1lG/40f
         n2nbFnEOQBVOWB2SYYMOEVCyscR9q+oH0c0jlROHoSsZjeMseTtz/WZ4xuooFzyb58It
         CvSsGDy5eqioQDiXmBaCCyw5jnl21s0O8Xf6lPh/+DgnhGGOyTqzEkkwJidGCGTwtKhx
         Kgwa567rCFEmCG973i+QueuVB6GO6pCA/0f/fvGdWT68gfzTAm7769ZP9ZJ09iE8wRFv
         LpVQ==
X-Gm-Message-State: AOAM533O72qNAUTvmHaQDgY8v6FIiGzxeb2biBk2XbZkgoJWlJHhJ3cg
        l3unpkwlsBepmR8pISnYOy2LCZDQ9+ZyiPrmizZdHF/5TP5vIZBOeXKkZvURcXIHP1wvLuJ9dJt
        4zZ15BqRFhAkRhw9oD48SqjNEcK2iylteLbAT738Jng==
X-Received: by 2002:a05:6402:3591:: with SMTP id y17mr29760632edc.386.1642578787481;
        Tue, 18 Jan 2022 23:53:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9+Xw3bqoaTUBpvw/QShf3ZRnJ6GIKmG4TS+FJXRB9XTPyk9rcHOG6g0FjU5rSXoXNUEWc/Q==
X-Received: by 2002:a05:6402:3591:: with SMTP id y17mr29760621edc.386.1642578787366;
        Tue, 18 Jan 2022 23:53:07 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w17sm805286edr.68.2022.01.18.23.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] nfc: llcp: use centralized exiting of bind on errors
Date:   Wed, 19 Jan 2022 08:52:58 +0100
Message-Id: <20220119075301.7346-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
References: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index a1b245b399f8..60985d1834a5 100644
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

