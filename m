Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D848A1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbiAJVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbiAJVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:18:43 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3235BC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:18:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x15-20020a17090a46cf00b001b35ee9643fso398189pjg.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7XDHIQkhsAFmNz1F7Z7Ne/ZIuNNWSEpngowKx7s8JYs=;
        b=nUk9kjwMdR6qRzfl3wzfyUkxYmuly83tWgqFOJw1pLxvoQ7hKuYQrOXBdfRkY14d5H
         6gwaZjRcQlBg1RFdGkHEyliqLcbmeDadjLud6TZ3darksPzY2a6AWhuIBCXKgBg0/dgf
         kXxZcKHxe7YYXGjm6tmKomEupSCE6PoTt2Mozk3sQvBzsreBa1ja+6vgEqy5L0fK3fw9
         t9So7qgOFY+Y/T6cdzspDLjgdHagb9AjDSfMPEy/up45WVbyJqzwRfLNfN80UNlE8oAh
         toS2BUm84IfuM/oIzCyURBHMnXJPJkxuPth0/qDkHG+1INxNuE1UbE7qSKEkmA2F5x2O
         Yd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7XDHIQkhsAFmNz1F7Z7Ne/ZIuNNWSEpngowKx7s8JYs=;
        b=uEg8PMSVrnQRa/a8HP9gi1OKXgW5bh+FVICqMf1vkyVQYs30xIWerlwXnU8MeKq1n5
         VqmGJLCtwviO1r9Z8YW4F3aqfIvJv6AqKMLt9RG59HJmwoESNOXzuhp0/l5K9eo5yETw
         dEgqv6e8ck5d0j3tIIHdqUNdHQMEj86Np9lwauCn3l4FX3gRACs8QpfLVq562/ZFA7yH
         PZTZPAr1Y2QajEswlDGWYY2Jbb+1kc7n27PJekHSeCuY5g1uxjSDh/aTRB3h82UIARDw
         8dDwO1JcMWTMNjvmPUAtGpLgqUN/Z45WtxsHp6qp3b6OS1uvF+C4hR+ocKpONULVWJgc
         EmSg==
X-Gm-Message-State: AOAM533Q4vMrgOVWocYp1tRu6yqz7iddfbrdra2uMeu4/xSUEjcZLn7P
        30HsR6s2mahnJU1mO8XPSjzcMeHkrDHmycxfNYR1+0KVCg8oQuGX7qh4n3PGnhHWhkB7EChnJUX
        S8wZcbaifGj7h7JAfWXBq20fA7e9VXkuo558f3pLnn1+JIqDy0UMA1VcJBGFakEdQk0kc0A==
X-Google-Smtp-Source: ABdhPJxbSopsi0gXi+ocn3Abe3Eflcm38jSOAXrIUMpZRH0GunsY706DD7saQA4+IIYI8telNGDfhpjl/vo=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:4f78:6ed1:42d2:b0a7])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:22d2:b0:4bb:721:7337 with SMTP id
 f18-20020a056a0022d200b004bb07217337mr1418074pfj.76.1641849522551; Mon, 10
 Jan 2022 13:18:42 -0800 (PST)
Date:   Mon, 10 Jan 2022 13:18:37 -0800
Message-Id: <20220110211837.1442964-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH] crypto: ccp - Ensure psp_ret is always init'd in __sev_platform_init_locked()
From:   Peter Gonda <pgonda@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize psp_ret inside of __sev_platform_init_locked() because there
are many failure paths with PSP initialization that do not set
__sev_do_cmd_locked().

Fixes: e423b9d75e77: ("crypto: ccp - Move SEV_INIT retry for corrupted data")

Signed-off-by: Peter Gonda <pgonda@google.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 8fd774a10edc..6ab93dfd478a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -413,7 +413,7 @@ static int __sev_platform_init_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
-	int rc, psp_ret;
+	int rc, psp_ret = -1;
 	int (*init_function)(int *error);
 
 	if (!psp || !psp->sev_data)
-- 
2.34.1.575.g55b058a8bb-goog

