Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8850A47A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390235AbiDUPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348309AbiDUPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B37E2FE4A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650555602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S9DMw1QVObZXzp5ejmL5d1FwtHhPc8XTYmN4X9Dq3O0=;
        b=hXZGlethubjqRAQ5wj2M1pNDeC2VLDAJrH2rdhP5MNi2VWBMAEgp4kUF1bhZbkk5agWcIf
        bwYjsJ1FG/qL21C2/6kNCg9pwLjwx7Io0pAjT7IrNo7zaeGA4gVUxY3kGox6o5uCNTWeQd
        pjrBJjt8Uct72BajonfdQGl7ge3mnOU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-ELeyo7YsNF-usjRsY-i0Cg-1; Thu, 21 Apr 2022 11:40:01 -0400
X-MC-Unique: ELeyo7YsNF-usjRsY-i0Cg-1
Received: by mail-qv1-f72.google.com with SMTP id gy6-20020a056214242600b0044656c198b0so4209018qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S9DMw1QVObZXzp5ejmL5d1FwtHhPc8XTYmN4X9Dq3O0=;
        b=NvEN46t/WaoLBzLNVaw+0yNQqem490V26Vd0YReJZ8q5ik6PV6i/8majfXuxyrunye
         0QETpcyKgYPG/SLe8dBfK/z4DsY4Fxy+bLCrP4SnsLYjDdPAWqEk4ERSB2dwqaTot1Lm
         G+QXvt6SszhTS2PWe4puJ9xxmaZ3aItR3svhQfOenMjeZfabuttSzMeDrsW9uf76XOEk
         q2GDEMbpt/m3zNsro6cBR7FkayZQ9P6pInt/cyv/p8NiVf1EJio/uaNvWxNh8CUvbnph
         ZjEWzjuqWd+9O4yJxLZjzCmFnmBhEQN0dPjNv+THfhIsfeJxhahh+Olih+USYxA6y8Ii
         GkvA==
X-Gm-Message-State: AOAM533KL+mKJEsJT8PojhkyPxqBDGTy0+ggDOscH29CyTmn9JoJyJbY
        p5YIu2RzcKkeVFtvRfIR19EMMcih9Fy6KdwkGXk38PiwRP1YAWAzJ+G8rCcoU13HvcTxC121PVU
        4+2mBJLhGve1a2SCJQR3FoBrJ
X-Received: by 2002:a05:620a:2489:b0:69e:996d:7940 with SMTP id i9-20020a05620a248900b0069e996d7940mr12470766qkn.553.1650555599182;
        Thu, 21 Apr 2022 08:39:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCwL51TZHhleKjAOtyVvVuDn5ubOOLwr4iM0Tlnqh/J1qgACgnab0k7LSIjuU6d2UPFyXdzA==
X-Received: by 2002:a05:620a:2489:b0:69e:996d:7940 with SMTP id i9-20020a05620a248900b0069e996d7940mr12470746qkn.553.1650555598818;
        Thu, 21 Apr 2022 08:39:58 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k14-20020ac85fce000000b002f344fc0e0bsm2401950qta.38.2022.04.21.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:39:58 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] libnvdimm/security: change __nvdimm_security_overwrite_query from global to static
Date:   Thu, 21 Apr 2022 11:39:51 -0400
Message-Id: <20220421153951.35792-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
security.c:416:6: warning: symbol '__nvdimm_security_overwrite_query' was not declared. Should it be static?

__nvdimm_security_overwrite_query is only used in security.c so change
its storage-class specifier to static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4b80150e4afa..d3e782662bf4 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -413,7 +413,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	return rc;
 }
 
-void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
+static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nvdimm->dev);
 	int rc;
-- 
2.27.0

