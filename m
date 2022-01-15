Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042E48F6CC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiAOM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:27:17 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47534
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231196AbiAOM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:27:04 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D57640033
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642249623;
        bh=k1fbxXsPvGzkuFTuMvPObzXkHdaiukX+p5UqHJ6OWe0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=poQbZEyY4AWHzx1Uj4SC3kJ+foLMeOU5cVPr7phuMdBE/DZ43UXdqOkHS8zb8gRSA
         2qu9Mmy65kv09aid8aHnXsgJkGkxZTp4F/YL17qfafxThmGS3tPwq/UJzrowpZbj4S
         UErkSQ+5lk+3ML1CX3krNBfizZOlV6Uda+hd9s9fwO6ioqV0VV+Rzc4Rvi9cJIAGc5
         H02Oy2wkCt22Oiu+yOAdKo6rvewdaanq2xgzMSb/bpSUC2Fe/6Y5id5BF89erRN80e
         quC+E10XngVQ1ZQaUsY8XuRtVAnu6suBgTNK0ITWWa8Vf58ux3bSEVHaz6/BD4lbB9
         eLKCt3FwOiRzw==
Received: by mail-wm1-f71.google.com with SMTP id a3-20020a05600c348300b0034a0dfc86aaso7203730wmq.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 04:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1fbxXsPvGzkuFTuMvPObzXkHdaiukX+p5UqHJ6OWe0=;
        b=bosc7csdmGmg6Tmkp8q9V5Gw79qeA1corn52x6WYYESkgx6t7G+HXKQqh4BBqCMheP
         m7Kre6kezeAlYMdvojz654WEp4t2wy4+ssGz7NjGMxoAgrB3uNCg4dD4qkhI4GOfHUWK
         VWgSWPXAhEc1lFvEsVfn8hvCyLenfs0/tOb4FCU1BvbrtJeRi+l6vLCgvRp0CgQFFgJK
         fyFXWWt1MpDhjBjCvfIPq3EyXUiprpSdsehZZovtCUnklHUUW6KWy5cmx/tPVNZiwhAO
         ZT3kjkInDJF8QP203fO97fEy0FqibKIszhrTS8t5MZ4aQBMPLzs3dxYcpyW9ZAmxouPq
         C4Zg==
X-Gm-Message-State: AOAM532Yl0sOqgOepihO5XW3nWP1jFdbyYvPZXz3EXInDaH3kfesrU/4
        +dNXRpuNULdiUyO+NqHUhvHbu9vbEhA+oMM2YDk3Bzk5/L8b9Q1iHhWve5RxbpHP2RPrOzgvWCs
        TJI7MCpcDWB1O0IVkRByNaFXT1vCoo9tojzFZsScFdg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr12363538wrr.106.1642249622376;
        Sat, 15 Jan 2022 04:27:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXCX9qNHfjpMa31u9yvOahIXiFLP9Aqa1v2s/wcOF8lsTtZYY/Ms1xdIFV/FMREuwupnobnw==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr12363520wrr.106.1642249622169;
        Sat, 15 Jan 2022 04:27:02 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bk17sm7878476wrb.105.2022.01.15.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 04:27:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] nfc: llcp: protect nfc_llcp_sock_unlink() calls
Date:   Sat, 15 Jan 2022 13:26:49 +0100
Message-Id: <20220115122650.128182-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
References: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nfc_llcp_sock_link() is called in all paths (bind/connect) as a last
action, still protected with lock_sock().  When cleaning up in
llcp_sock_release(), call nfc_llcp_sock_unlink() in a mirrored way:
earlier and still under the lock_sock().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index c9d5c427f035..5c5705f5028b 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -631,6 +631,11 @@ static int llcp_sock_release(struct socket *sock)
 		}
 	}
 
+	if (sock->type == SOCK_RAW)
+		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
+	else
+		nfc_llcp_sock_unlink(&local->sockets, sk);
+
 	if (llcp_sock->reserved_ssap < LLCP_SAP_MAX)
 		nfc_llcp_put_ssap(llcp_sock->local, llcp_sock->ssap);
 
@@ -643,11 +648,6 @@ static int llcp_sock_release(struct socket *sock)
 	if (sk->sk_state == LLCP_DISCONNECTING)
 		return err;
 
-	if (sock->type == SOCK_RAW)
-		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
-	else
-		nfc_llcp_sock_unlink(&local->sockets, sk);
-
 out:
 	sock_orphan(sk);
 	sock_put(sk);
-- 
2.32.0

