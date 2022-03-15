Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459DE4D9B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348398AbiCOMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiCOMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1571D31207
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647348117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L8qSvNcazquKGgqZpfRwZOK5T4G+V/7nPQSKEnK7vHo=;
        b=GYjAdNkpiPI7aD7p2UZk1mWt/J+J2WY1j3htNOI0iof4RzuDpILSWF92Sv7c888IyoeR4/
        WcTqpPtxNSVY251gzpllzBZNZW5hE/UL6vbMnlArWkdBAEuAfEm/gqd9tsGMblOV/gxT7B
        LnERTm5ESjoJ0K8EtdkjzSTG3VyX9BU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-qG6vepp7O9emXuKbiup0tw-1; Tue, 15 Mar 2022 08:41:55 -0400
X-MC-Unique: qG6vepp7O9emXuKbiup0tw-1
Received: by mail-oo1-f72.google.com with SMTP id r63-20020a4a3742000000b00320d9025595so15417385oor.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8qSvNcazquKGgqZpfRwZOK5T4G+V/7nPQSKEnK7vHo=;
        b=NcZDCzuZ04wUhZB72nWzoP6VfKhpvcCifoVt8Up8nbsWwd+OO9JTMv7t6eIrytMsiv
         6ItJ79heWUep4JOVJsjb4boQHUsJaIMUkZeEtFU5TDCgjLilRKiPZK9A3T+iwQaOx8Nl
         3iRo7LHYvlGSFK/xIH6hd7iUbh+ATH6bvDIY753HAtgRrvAMcx/NmxqmoA2PvO4LfQ9+
         cSJrvrjYXqIP/fCWt2zJNOhrSERVxJHdCDrKUYp16wSDKlIGJ5ffLTVzUIbnTgBzCrbQ
         lPJWafstPKovSsPMX6jvFPq2LlDiUe7G/q8CKrCctNKKRbJJ/dpeS7hXIV+g/UtCnJOr
         TD3A==
X-Gm-Message-State: AOAM531AGhc3qXGA7aSkIDVDlcwKdNJZHjNq6P+VJhYlM/viEJIIN9/l
        exeSZHT+LU1kZ6pLJQlriV3Gml1f+R4imluTa0D4nsKrSWNaWAM7H+T2U1/IafzZlkBhY4bwiqh
        5ECPreNK/izgNv9jNmNNbUgB9
X-Received: by 2002:a05:6830:2a13:b0:5b2:4818:9e47 with SMTP id y19-20020a0568302a1300b005b248189e47mr12799092otu.246.1647348115058;
        Tue, 15 Mar 2022 05:41:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcpL+Gz6iIXjMEkxLwJ/eu0PZYTQsZg4Pa8CgHWGB+zJNMcXTr1+Z1m4WKMcLCOWc4CCmSkw==
X-Received: by 2002:a05:6830:2a13:b0:5b2:4818:9e47 with SMTP id y19-20020a0568302a1300b005b248189e47mr12799084otu.246.1647348114840;
        Tue, 15 Mar 2022 05:41:54 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id y15-20020a056870b00f00b000d75f1d9b81sm7762654oae.46.2022.03.15.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 05:41:54 -0700 (PDT)
From:   trix@redhat.com
To:     mst@redhat.com, jasowang@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, lingshan.zhu@intel.com,
        sgarzare@redhat.com, xieyongji@bytedance.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] vDPA/ifcvf: match pointer check to use
Date:   Tue, 15 Mar 2022 05:41:30 -0700
Message-Id: <20220315124130.1710030-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
ifcvf_main.c:49:4: warning: Called function
  pointer is null (null dereference)
  vf->vring->cb.callback(vring->cb.private);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The check
  vring = &vf->vring[i];
  if (vring->cb.callback)

Does not match the use.  Change dereference so they match.

Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 3b48e717e89f7..4366320fb68d3 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
 	for (i = 0; i < vf->nr_vring; i++) {
 		vring = &vf->vring[i];
 		if (vring->cb.callback)
-			vf->vring->cb.callback(vring->cb.private);
+			vring->cb.callback(vring->cb.private);
 	}
 
 	return IRQ_HANDLED;
-- 
2.26.3

