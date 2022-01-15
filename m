Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA59048F6CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiAOM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:27:26 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47532
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231168AbiAOM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:27:04 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C543440045
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642249618;
        bh=ePWS8huBNB8mOLwzP5l9zhhnqwr/R2aV/N6dfRb+pkA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vnd9YjeTAkXxpN3SWdBQaa337/49tJieZIqgKEBiUQHWsuzpNxPY34sQ/iKaPtIuy
         kftQO22UqiTrGMG/MxJhOPjcVk7bvbyyiyfnHPadRsVUnmVuVyzekYEg6y0pSpNseh
         UjijZ9YXB3JbAhYa1ceOkL/G50f/h+jenmGykR92DiqW09cjMLhSDFVujHC3cD4/t+
         upyEjk3kN5x12CDupekVUT5Iyc5RByF5b2rOo9AC2sUWd2t2Dty9qc1oHxsm3mp+RE
         20e5f0hNC88RcwqBVUJMuuIt1OEzULtpV4MaY2hfytZ1WWHFVvmX7TTDyzLTwJgS1O
         wpHmt3U1o0LUg==
Received: by mail-wm1-f72.google.com with SMTP id p14-20020a1c544e000000b003490705086bso3429328wmi.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 04:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePWS8huBNB8mOLwzP5l9zhhnqwr/R2aV/N6dfRb+pkA=;
        b=7FqXabpZ8cewaOUqH7biFqkx9iE8Yxof0Noz2Du2tG5mCbmllKTamOE67AeR0QsZFV
         ermU1UoYxymQ1aHlysmGvp/gbUfyEsHJR9YHIohOd1Vcw/KuirsE+piw6nYw6H2q67Hf
         E5tXmTQ4sone6N4W8rcXH9dW7PLb/NxR/2oFPqxRRxug4gzE2l5Y4bMCNo1Wba7anppK
         izmhT2oe5D3IxJxlKIbPzocCxVXr1R0VamiGM/ifDSsK2jIYHurb2OVM8f4pX931Lljt
         aMn5GbCn6r7C9ibRvMY8RjaWzNLrjNTrm+nzB95BcInyuXaP2X2akRKEBuTbekJFnoNF
         FGSg==
X-Gm-Message-State: AOAM532zlRJsPYcJgHtR/DyG7EuY5v522J030lc2tmbZ+niFi4MwwiJ2
        myHKJ4J6p9KokPS9dqPHq32FaNz3XPosc3AM+NwjwAQsNJg6CpXoEJ0BEeuK9pR/BQ5DIA6JUsY
        ag3RRwLmStlUaEzilVgp2tlK09LaXAJniM+OqCALtaw==
X-Received: by 2002:a5d:6f0a:: with SMTP id ay10mr12121174wrb.191.1642249618562;
        Sat, 15 Jan 2022 04:26:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbQP4Q1giAJ4uAlzrN0vo+MIFiQCq0DOWWfo4iYlUpIw0pSA9ah1HXa5NlBGI3l4j4jOixug==
X-Received: by 2002:a5d:6f0a:: with SMTP id ay10mr12121168wrb.191.1642249618445;
        Sat, 15 Jan 2022 04:26:58 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bk17sm7878476wrb.105.2022.01.15.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 04:26:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] nfc: llcp: simplify llcp_sock_connect() error paths
Date:   Sat, 15 Jan 2022 13:26:46 +0100
Message-Id: <20220115122650.128182-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
References: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
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

