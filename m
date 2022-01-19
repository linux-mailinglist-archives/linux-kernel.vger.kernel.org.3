Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E634935E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352316AbiASHx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:53:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55308
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352214AbiASHxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:11 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 66BAE40028
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578790;
        bh=RM6CEuGCpivOsBpPPs3hkt8u1ijpOzgu/V3oCSO4jiM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=i5640jDJPxzSuiGDI4gVndNP6EUe++3auAwl/g0RpCSNuJIeoAud63AVIJPy5Vnvy
         rah3DL8Ahb5Pt7BTxMVsmo6B9m7jMYF/yCMg/oOFs+jvSelTKXTBOPnWmMsyMx6Ruf
         zdqt/MqmqaRq90CS0Ix6CAzXZN/poo1o1y+6ab6UrWKpywTr8gWldsVQX+NlgXq0iw
         85quq8fPSdOZIXhlzHxsYyEcuhG+ms6St5wYTJHxZaCD2YSo/dCRmM7Nq97zVdYCEN
         sfDqD/oYk8RP5k4tysbbDqVbFcAiAZv/nL/PyXIpgTykYIXvrlhdHGaEUQaB1Y84UH
         JePBQLS7RYNog==
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso1483893ede.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RM6CEuGCpivOsBpPPs3hkt8u1ijpOzgu/V3oCSO4jiM=;
        b=RKQ9sktHSLR/fXOSkMVyBPqZKph6d9ltGHiuoB5Pk5JNNjDLctKa5y8SmEFNQwaQxY
         txFNshVTlIWI/pEoM8ZfFyNBK6iV/xf30xn1M61zT4ck4lWuwP5kZFuxplepngP1bRkP
         AIozopdBjDmCFewBYJPQdL9za4zDgV9On14YADZbw5vf2s05zw/C2K9fHUzWZ404TakX
         2/31EMvMi3qUF5oerl2LcmBDCRkrea3IyyuYlt+J3t0SQegRWX50UMNa0sGMRMwLEPV+
         lHnKzt+UAwzsz+NwHHAT2SG7OeophGS8Ewv7UjHaTzpbXRV0yA30/FSdxByAumbFJdXK
         qtNA==
X-Gm-Message-State: AOAM5301tr4WgVA7A/LL7sGMAhpKsgRwd0TAUSzeZLOQmdfD4cBAS90V
        Bamk16PdSK8DHTKqopWnV+DJrALGs1WK8lOF5HSTEj5kMYUw4GV23wEfiLKO13O2h+nTDxeBl3n
        hvs2RhWLEOLLYZqI3JEBFrsMj1RYnpW/jvBGwpspX0w==
X-Received: by 2002:a17:907:e93:: with SMTP id ho19mr11025874ejc.168.1642578789631;
        Tue, 18 Jan 2022 23:53:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJEcV3S0JFKK4d5B6hmyTEOPZMdJTa8RrL6S17NZ6W29g8Vt3dq4Dv7WMzhmOsFjUA/eVO+g==
X-Received: by 2002:a17:907:e93:: with SMTP id ho19mr11025863ejc.168.1642578789450;
        Tue, 18 Jan 2022 23:53:09 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w17sm805286edr.68.2022.01.18.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] nfc: llcp: protect nfc_llcp_sock_unlink() calls
Date:   Wed, 19 Jan 2022 08:53:00 +0100
Message-Id: <20220119075301.7346-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
References: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
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
index 60985d1834a5..2d4cdce88a54 100644
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

