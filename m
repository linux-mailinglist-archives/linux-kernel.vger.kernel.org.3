Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B48565CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiGDRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiGDRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C3F91114A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656955030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
        b=cjU8wuQ4NDW5GShDIBDWY5xbCgKIGczF9Rt9/bwoGqb5zr+W6Lr08PB5r7XUwJgX2Njij1
        aMESe2VAqSW34vDa/RcmjES4ptFgJ0KA5a6aTYEP223tYuxri7oLfECi2ElspmK9lFJWho
        HSWLqtELk88+VTELCdeqnGuGn6aCRKo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-i211Smq5ODeL1Xny1W4XEA-1; Mon, 04 Jul 2022 13:17:08 -0400
X-MC-Unique: i211Smq5ODeL1Xny1W4XEA-1
Received: by mail-qk1-f198.google.com with SMTP id z9-20020a376509000000b006af1048e0caso9224026qkb.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
        b=32JtieuJOb989G1EcOC1nI8kKrmCNwRzXP/RYZRaMbaArUM/2jo8Qu+zT4b/tpT8HJ
         288mEjoasRTHBvYimPtKE5O0r1GDLG348CEskojnORiZ/oLpgi6WQtOD5rW3v37ge3Jo
         gImMRpKZYmPEBF1nPkdQmzrWeNp8NegBBd2a+5wrO8TnetdOGawtklDKJBqnXvLT55Lq
         ERyiQKnE6DjjMX2tIyWz6n/pu736IqFheTbSs7pi3s/RJYKz78Fk+ITjWcBB/HfIzlCb
         WU6Q+uby3ZbL0velU/SieT0sCi8ZmqE2H65d+jRq5u2FdLQHaSaB6k/TIVd3nD3RYCiT
         WCHQ==
X-Gm-Message-State: AJIora+p85r19UQyRPNRnnexCSiHhjujuaEJtFdK0eRd5oqi3kFHDh3n
        nIK+87bvEgJ7X+LNiCQDP9sR3fh5TP0GquPZaQCv/T/tLVarCsWbUNiG1zsd2WKQlKgXbwGSeoA
        4OtuEvucfUr1SE9ufEFy9AMCH
X-Received: by 2002:a05:620a:469e:b0:6b0:e66a:6bd with SMTP id bq30-20020a05620a469e00b006b0e66a06bdmr19691308qkb.285.1656955028388;
        Mon, 04 Jul 2022 10:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1um6olL36YJnCCSnK21iQMhdkBq5wN6w2T59beszRdcjnFkROIHM2UBY5D60rK6HejU80TvYQ==
X-Received: by 2002:a05:620a:469e:b0:6b0:e66a:6bd with SMTP id bq30-20020a05620a469e00b006b0e66a06bdmr19691298qkb.285.1656955028170;
        Mon, 04 Jul 2022 10:17:08 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:17:07 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 1/6] tools/virtio: fix build
Date:   Mon,  4 Jul 2022 19:16:56 +0200
Message-Id: <20220704171701.127665-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build caused by the following changes:
- phys_addr_t is now defined in tools/include/linux/types.h
- dev_warn_once() is used in drivers/virtio/virtio_ring.c
- linux/uio.h included by vringh.h use INT_MAX defined in limits.h

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/linux/kernel.h | 2 +-
 tools/virtio/linux/vringh.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 0b493542e61a..21593bf97755 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -29,7 +29,6 @@
 #define READ                    0
 #define WRITE                   1
 
-typedef unsigned long long phys_addr_t;
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
 typedef unsigned int __wsum;
@@ -136,6 +135,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
 #endif
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
+#define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
diff --git a/tools/virtio/linux/vringh.h b/tools/virtio/linux/vringh.h
index 9348957be56e..e11c6aece734 100644
--- a/tools/virtio/linux/vringh.h
+++ b/tools/virtio/linux/vringh.h
@@ -1 +1,2 @@
+#include <limits.h>
 #include "../../../include/linux/vringh.h"
-- 
2.36.1

