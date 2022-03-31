Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239F4EE129
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiCaS5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiCaS46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 038731728A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648752910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k0Z1jeCIKmFnHUAVH1qnoY3Db0lyY6IzDGCak9lVPA4=;
        b=cziEvkkpxAFnlpxRkXhZA6tL13QAQGEEQWfepQC8yhdCM823ZlxYRiSZY/3f4hQOuTLEug
        u7N0U38srwfR4wKSKRuTsPQAuMSUIf0nrUh3WJe964tyB8ZXS12XQ/PbnrelReNARx1xjT
        vUlv8HtVDv8I8w2KCwifKpeojVV6r50=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-RHOqctRwM3uT_RP5V-p2GA-1; Thu, 31 Mar 2022 14:55:08 -0400
X-MC-Unique: RHOqctRwM3uT_RP5V-p2GA-1
Received: by mail-qt1-f200.google.com with SMTP id f22-20020ac840d6000000b002dd4d87de21so197857qtm.23
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0Z1jeCIKmFnHUAVH1qnoY3Db0lyY6IzDGCak9lVPA4=;
        b=HjqF3RmZsU9C8DacDPhnI3bc+8sQ7hHb6PhiCW2tY3mpPJ/oy3nYijqpjBc8mIEM7X
         uvjKRZZNGEvf5L3NRraEGVUG0PuwHCrB0GoCwFzLwhF0ZBn/XHc7M0Ie1SBFaULTJMdE
         DFoR0XBZLK0YKqp/YBcxlZX+atuRAicN7q4l0KGviz3sew8v5dKDHdyr6FBYwqNxyqBF
         QJzchL57YelwmD47VD9F5XZIu3rRKWYbUFNM0aQXHiVemSWZPyIDanW2U3ZKKLcn3Drh
         cVNw64oOCwNPUoOsEGeK4M2T7jyVAC6zLqkCtFGwtf5OPgd0SxCNJ6bPZ9FhNfJRpyAO
         bMsQ==
X-Gm-Message-State: AOAM532TlGTNCwWv6uiXmBAFMCVEnrMOKaQ/1y4u/ORmra5ttTVMD5Ju
        DFkGR2OXMAEgCL6SMnjwWuvfsoHVBzJ0w3uFF1K2hqy0pVxtQdnLexrdzFhvWVirElBVKEWX/g+
        A2uDTbwSooXgREjfwK8VJnU8F
X-Received: by 2002:a05:622a:30c:b0:2eb:871f:be08 with SMTP id q12-20020a05622a030c00b002eb871fbe08mr5653194qtw.128.1648752908001;
        Thu, 31 Mar 2022 11:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOfSfgjRpynVUGU6NUsEVov2wHm6Z2q5VA2LwjDD2FsuUZ0dBiyT2QVfsvS200T/64ZPCA0g==
X-Received: by 2002:a05:622a:30c:b0:2eb:871f:be08 with SMTP id q12-20020a05622a030c00b002eb871fbe08mr5653182qtw.128.1648752907803;
        Thu, 31 Mar 2022 11:55:07 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bk15-20020a05620a1a0f00b0067e5bd7a9ccsm68289qkb.50.2022.03.31.11.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:55:07 -0700 (PDT)
From:   trix@redhat.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] blk-wbt: remove wbt_track stub
Date:   Thu, 31 Mar 2022 11:54:58 -0700
Message-Id: <20220331185458.3427454-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

cppcheck returns this warning
[block/blk-wbt.h:104] -> [block/blk-wbt.c:592]:
  (warning) Function 'wbt_track' argument order different:
  declaration 'rq, flags, ' definition 'rqos, rq, bio'

In commit c1c80384c8f4 ("block: remove external dependency on wbt_flags")
wbt_track was removed for the real declaration, its stub should
have been as well.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/blk-wbt.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 2eb01becde8c..7e44eccc676d 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -101,9 +101,6 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
-static inline void wbt_track(struct request *rq, enum wbt_flags flags)
-{
-}
 static inline int wbt_init(struct request_queue *q)
 {
 	return -EINVAL;
-- 
2.26.3

