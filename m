Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82AB47EFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353048AbhLXPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 10:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352999AbhLXPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 10:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640358468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BF/YCJv1AAKRhV+98m4TlzO0qSIWH7hI7+kRVcFAOVU=;
        b=i7/Atew6y9h5MykFu3pskTZEbcV6nekdXTfG8f08of57FzQBFXV38ZJa5aYL5DSEWdBeAr
        YVCq7E6L8S5eRCYn4N0dRQ96dA2K8mU/S/LekOu/c/4Rpy0KyNEw2MgvhNB0Hfgg8AAWM9
        AcUivQ0BqQs9LIDivkRnZi3aAeYisHM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-j71JIiMNP4qF9jMJG0P5xw-1; Fri, 24 Dec 2021 10:07:45 -0500
X-MC-Unique: j71JIiMNP4qF9jMJG0P5xw-1
Received: by mail-qk1-f199.google.com with SMTP id bi22-20020a05620a319600b00468606d7e7fso6850462qkb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 07:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BF/YCJv1AAKRhV+98m4TlzO0qSIWH7hI7+kRVcFAOVU=;
        b=Hj78/fRAnmoRQkdwpUjoR1qIMU2+cjWR9KVpGHVyH3BjosCzx+jNGFVMsubzqtUGPD
         K9K7/RmXPOJkWnDXDkC90h9RoK8LkI9M7VuOYPs2ggaF5FhAUCzlA/qSZFmZ8D4aZk1n
         1r7Ne3Qv7Ea08j+qNVFCtxEpp+lvb8ONhpU5kMnA9SV1dCAswnyVVexx5uKrm0dt/8yR
         KEu6alGvs+JFU+jzC4Pt0qO+pzw4PSOOuibb4UdLfVNW8RKs2eOu+iDgeEsqfFo13LWv
         2mjPA0RNwiHSNNEPbyjr5tl6QF20EJ0w06hUtj/ZaMYIbnIkby8yKD36sOc7fSTuEjU7
         9Myw==
X-Gm-Message-State: AOAM5319aH863GGn0f6hrW0KsU1rvA/+JYCfc3c1o6GYAAAljcpfgVtY
        BT+oiYtXdCMOPrAaeuIt/9pI00KsIHRktqREUrwrZbqHJqYgIc2JcNQV+2bmhhGdE8vgfT/zPq+
        hLMmEJXUTcJH8V11UqIpD2+Xv
X-Received: by 2002:a05:620a:809:: with SMTP id s9mr4863326qks.156.1640358464963;
        Fri, 24 Dec 2021 07:07:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1pKHrG4CVFHlqnEQE1caIilyx7SPxj7M2T/jSxcp1oBjfTGs3uB+F1wC/sUIYc89L4aGXzg==
X-Received: by 2002:a05:620a:809:: with SMTP id s9mr4863309qks.156.1640358464728;
        Fri, 24 Dec 2021 07:07:44 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id bl8sm7314148qkb.38.2021.12.24.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 07:07:44 -0800 (PST)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] selinux: initialize proto variable in selinux_ip_postroute_compat()
Date:   Fri, 24 Dec 2021 07:07:39 -0800
Message-Id: <20211224150739.3278019-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this warning

hooks.c:5765:6: warning: 4th function call argument is an uninitialized value
        if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

selinux_parse_skb() can return ok without setting proto.  The later call
to selinux_xfrm_postroute_last() does an early check of proto and can
return ok is the garbage proto value matches.  So initialize proto.

Fixes: eef9b41622f2 ("selinux: cleanup selinux_xfrm_sock_rcv_skb() and selinux_xfrm_postroute_last()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e2a6d0f5c47af..fd7a0e9e26647 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5742,7 +5742,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct sk_security_struct *sksec;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
-	u8 proto;
+	u8 proto = 0;
 
 	sk = skb_to_full_sk(skb);
 	if (sk == NULL)
-- 
2.26.3

