Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCEE4935E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352268AbiASHxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:53:21 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38550
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352224AbiASHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:12 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E79A23F323
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578790;
        bh=x/F9VAvKkrKoejYalm8chWtX9s0cqmjTeJU4WHXRJwU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JKpb4944cZlA4PYTH9/LWoHrEnXq1EUmhagnDfq0P3t6XKPMFE0XwEUm/9G2V+Jbc
         Rfp0X5zN+mFXBOPWGNgIpQ+LkaW2+oprsLMBPAfiYqpppxqDPEEiQ4FgQbDhbBwnbE
         X6vsiF3aulCy2pN+sBjEPVFFlf4RLkZ1XB2XQvG1BVNcKxw+xw+iKm19an1r7XiIXS
         l+JDJ5K1nSpWN1zue5xS1zb7haGd4bgte/hXU3q3is883ZmW84EOmLNuVaA3IKwgJA
         SeYSwsClxWoxsTfjIrI/mtZ+kf2GXhy/BK4BgWFGtGvanr21hqlb49BmZiVGHqc7NW
         58YoVC+Qd2WYw==
Received: by mail-ed1-f70.google.com with SMTP id a18-20020aa7d752000000b00403d18712beso1465997eds.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/F9VAvKkrKoejYalm8chWtX9s0cqmjTeJU4WHXRJwU=;
        b=VDEz5DRU4HsvvMtXQiQswqWFSu20muvzwoDt/RixsDaRbMjzRaX6/1frjVKtPR+tcO
         IMMeMo9u4WFouUCxm+ph0mOgVIWsrjqHqiW1ywZwUrZLVcHJOgr26axjK9e6TQY+he94
         KQSaxVxGXbLp/Sw28dtWCL8k34ux2KF0H8qT4yOHLOagpwvBPXZwh2jSYC62fo63VgoS
         U3GzKl95oyyrxskKbVpvz3MDdwNc5epbGbV8wzGiuBtBVN8kjAN2escqqrBEcYJiLviN
         wvkbLDVHZsLOO/IX4qwy6PCkphsjj2bWB9wiQeBW5IgjowxkaDSVez+Gug1wEQ1biSAX
         Am2A==
X-Gm-Message-State: AOAM533J0PuR1XrWWB6iEszGqycsi+IiM/KZ1tWHjYcrJznzuhPmsomV
        7UU68IPLbR5V83ldTaHS+R53YMBJ+eNT51F9y9wOsBQIIxlCBBEv3ZtHYydyl/ffgFqRLXDjZlv
        aEDyJ7gsC+/P4ygU79/OFRn7swDpR5Ugg+tJd2p9WWQ==
X-Received: by 2002:a17:907:1c11:: with SMTP id nc17mr23091258ejc.513.1642578790594;
        Tue, 18 Jan 2022 23:53:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLf3PxsIJN+w6STqoYgFU25Yxbhg0DD3ySt4Ezlf7rmSa4y3Co29oIvpjwl5lROKrswnJnbA==
X-Received: by 2002:a17:907:1c11:: with SMTP id nc17mr23091253ejc.513.1642578790409;
        Tue, 18 Jan 2022 23:53:10 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w17sm805286edr.68.2022.01.18.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] nfc: llcp: Revert "NFC: Keep socket alive until the DISC PDU is actually sent"
Date:   Wed, 19 Jan 2022 08:53:01 +0100
Message-Id: <20220119075301.7346-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
References: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 17f7ae16aef1f58bc4af4c7a16b8778a91a30255.

The commit brought a new socket state LLCP_DISCONNECTING, which was
never set, only read, so socket could never set to such state.

Remove the dead code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp.h      | 1 -
 net/nfc/llcp_core.c | 7 -------
 net/nfc/llcp_sock.c | 7 -------
 3 files changed, 15 deletions(-)

diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index d49d4bf2e37c..c1d9be636933 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -6,7 +6,6 @@
 enum llcp_state {
 	LLCP_CONNECTED = 1, /* wait_for_packet() wants that */
 	LLCP_CONNECTING,
-	LLCP_DISCONNECTING,
 	LLCP_CLOSED,
 	LLCP_BOUND,
 	LLCP_LISTEN,
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index b70d5042bf74..3364caabef8b 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -737,13 +737,6 @@ static void nfc_llcp_tx_work(struct work_struct *work)
 			print_hex_dump_debug("LLCP Tx: ", DUMP_PREFIX_OFFSET,
 					     16, 1, skb->data, skb->len, true);
 
-			if (ptype == LLCP_PDU_DISC && sk != NULL &&
-			    sk->sk_state == LLCP_DISCONNECTING) {
-				nfc_llcp_sock_unlink(&local->sockets, sk);
-				sock_orphan(sk);
-				sock_put(sk);
-			}
-
 			if (ptype == LLCP_PDU_I)
 				copy_skb = skb_copy(skb, GFP_ATOMIC);
 
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 2d4cdce88a54..14afed5916d1 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -641,13 +641,6 @@ static int llcp_sock_release(struct socket *sock)
 
 	release_sock(sk);
 
-	/* Keep this sock alive and therefore do not remove it from the sockets
-	 * list until the DISC PDU has been actually sent. Otherwise we would
-	 * reply with DM PDUs before sending the DISC one.
-	 */
-	if (sk->sk_state == LLCP_DISCONNECTING)
-		return err;
-
 out:
 	sock_orphan(sk);
 	sock_put(sk);
-- 
2.32.0

