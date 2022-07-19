Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69B57909F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiGSCMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiGSCM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:12:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED4F3C16B;
        Mon, 18 Jul 2022 19:12:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f65so12210885pgc.12;
        Mon, 18 Jul 2022 19:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRhy8Rk7/1ZItozla3K22lKSfcD7M6tNI4z2lxDBidw=;
        b=OcB/nGiC9Q4g9bPiZkQigDsUj0YDFnIk6LzaBks2JsoWbl8lRAYxDG6PYhQ6zmlv1e
         q91Rv31ftu5qB+3xQ25SPc7y1+WfPH0CsIs5Ls+8iS5bjRzo4OBfMnZlo7kz9okvShgd
         pcDqF4BDacSS3GrGSc9ngwLozVCIFoIbtye/NP0LmVa8vawbj8vxQMe2Eaw1xYG7YjrY
         BJo3ChcFRtZT2DBu/+U0KzQKRXtlat5ElflgTI2zIvxPhfx9VDYpy/XQkVGCnAcwzv95
         rNP7dQToYYXBuXjO/cnj4AIAmVfmozGblDpKC285h/TWjmoqaGh6048E5kCvP15Tln/+
         HS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRhy8Rk7/1ZItozla3K22lKSfcD7M6tNI4z2lxDBidw=;
        b=MThsG2g/WnsqXW2e4Ngw2Dr94L8jr3+Fx1zUbf/caSUsHskll1pSKeaiZy3Y5rFhTp
         z6L5G8/KAfHHw6F1ipIFGqt2J1e9HsoxmPOwaOUvxZqVz4Gy27BXbZzLDNPG0uwV5rvs
         DQHCNS9883F+FFSoQ1Hp7PZhc+WPJsInabmxhWQe5blSNMsFoJP7P2Kc5OJsBUoBZtBS
         OHa2z/oh9R+h1PHTmpPg9gjPmkhJXg4o5cEJOo+QtSJiDekqxfAMVnQOnyztKfP2sl7O
         3yeSBvkyX5mQKV48rlVTaDym0fS9TV+euUE8ZXzjrWuvPb6URgXg0x9Ah2XvTT1Ia/MT
         1eDw==
X-Gm-Message-State: AJIora8KFlP0TUAZuZjKaxrqTukdzoWjRxWx96RGD8zunDef8ThQ8Ipc
        LUk7gplMmx32+0vNM29qt+8=
X-Google-Smtp-Source: AGRyM1sbhhHUQLbU0d4KdR1mTQEY20diT4IuABSzVSFi6zYCigkwV8JnNUSAgjEkCC9FORrFpGQgkA==
X-Received: by 2002:a65:6bc8:0:b0:412:9b2c:1700 with SMTP id e8-20020a656bc8000000b004129b2c1700mr27028216pgw.8.1658196747238;
        Mon, 18 Jul 2022 19:12:27 -0700 (PDT)
Received: from localhost.localdomain ([122.171.73.195])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709027e0900b0016be9d498d0sm340779plm.211.2022.07.18.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 19:12:26 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] apparmor: Mark alloc_unconfined() as static
Date:   Tue, 19 Jul 2022 07:42:18 +0530
Message-Id: <20220719021218.6807-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws below warning ->
security/apparmor/policy_ns.c:83:20: warning: no previous prototype
for function 'alloc_unconfined' [-Wmissing-prototypes]

Mark it as static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 security/apparmor/policy_ns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 300953a02a24..4f6e9b3c24e6 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -80,7 +80,7 @@ const char *aa_ns_name(struct aa_ns *curr, struct aa_ns *view, bool subns)
 	return aa_hidden_ns_name;
 }
 
-struct aa_profile *alloc_unconfined(const char *name)
+static struct aa_profile *alloc_unconfined(const char *name)
 {
 	struct aa_profile *profile;
 
-- 
2.25.1

