Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFAB4935D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352205AbiASHxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:53:09 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38478
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352159AbiASHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:07 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D4623F313
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578786;
        bh=5w/EAxi3BWNa4bEEDcXXXFqwUZVzXL/jpIlNMT11cAw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=OSpdxSV//4TUVCUjNrLDf3cDGIXeu+DXjAGJv8zQKBJKGS1Bf0Ko8WQhQKBqn/x1Z
         r3KSdBAvyL2vLSkknnIRHqb+YJ9ONX+1xKKyf1l+5bUUcesKeiFIfVzGedROqA/2pX
         bDINgAaNkDr9kCzRm2sTmR7JCJxiYytoMZIBuwgKXlEiILYKk0QwJX5cimOwV/g+DL
         XTtx8rtloKtqMDXpRc04BL4cIlB6kzfiFHWHWahRQj1fWWUu/dy6nPWXLpbRrpmUd8
         7HlrAyahEutkcPfYar+a6zJiG5Yh04+iiu3qlK60FyRbqwElxwJFQhq03ExoXyqh1A
         orBk+Bwt/e+MA==
Received: by mail-ed1-f69.google.com with SMTP id o10-20020a056402438a00b00403212b6b1aso1464857edc.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5w/EAxi3BWNa4bEEDcXXXFqwUZVzXL/jpIlNMT11cAw=;
        b=yJ0VX4td4epx6BWNNaHRg0vfghKD3SP+rVUrk/lKjnZEbMjoIr+cf9fLQrM/cBVPDt
         T3SAyErnmcplN04tQ2f8mh9n3JpzR1hV4WPg2i0NLDtdL0FtMkkp/soaKNKE82QI+ED8
         yOKjsuTUgTKNkipgErSP3ry4lX0rmr2my5Nc5MdTZlNjlUCzCvkNQEdVEYNrB1oroGPK
         VOxlbVMilOckZS+qcekiJt+5vqItUQaL3vY1UQIuX3wa4LuYjglHHNTX/mV+TU5PA78R
         UWnLpxsUXIiJJ1dprLbei2+tG187ndrX16gv+r/4fs0Bn9qTILAXrp4vj/qNgaVQQw0u
         ft8A==
X-Gm-Message-State: AOAM530CfzRtP1lmz2JAZtYGM3EdsK7I9zuzGGwf9SDlrGRDBID+otYK
        bNSBmVyqf9Jfwpr7hAHSA8oZe8ZPaQwCZp2YGmxheDC+XjJZyzKDnd+z9ZTFCGlZrZmzWvAWis3
        vdoqCDBestD3U0hZEJUUdFr3JXTYenRFd/oBbtBwLAQ==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr6483612edb.271.1642578785495;
        Tue, 18 Jan 2022 23:53:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYUDYe5Iu0UOqAPwEgNesa55/g4cd+jnk3TlZFlICHhPfLFfLvKw8cfJ2BVa1of970eRb/Ng==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr6483602edb.271.1642578785369;
        Tue, 18 Jan 2022 23:53:05 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w17sm805286edr.68.2022.01.18.23.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] nfc: llcp: nullify llcp_sock->dev on connect() error paths
Date:   Wed, 19 Jan 2022 08:52:56 +0100
Message-Id: <20220119075301.7346-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
References: <20220119075301.7346-1-krzysztof.kozlowski@canonical.com>
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
connect() error path, however a similar case - in the bind() error path
- was triggereable.  That one was fixed in commit 4ac06a1e013c ("nfc:
fix NULL ptr dereference in llcp_sock_getname() after failed connect"),
so the change here seems logical as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/llcp_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 6cfd30fc0798..d951d4f0c87f 100644
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

