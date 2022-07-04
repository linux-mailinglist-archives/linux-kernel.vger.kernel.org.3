Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69735565CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiGDRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiGDRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6C3F11C0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656955032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKnKGcPQx2M8z8doipgVBVXWw9daoK1UODE6Y0G/spw=;
        b=APwHpzRLemvWDKpjK3QENGhFkSDSyuWH9h/A4Teak2K3oPQYcX+wCUUZVS4nWAues81fyt
        6bxxJ2q3RrRecJmqzZI7WGInkLEjtoL+W9XJmS0VBOgJrWNbRrnSfhVvVPpN37yCJPMblr
        RyJibm8/hCklc/JKyEc69yWuiCndU9g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-G7f2sKYtOY2hUEkfeCU9DQ-1; Mon, 04 Jul 2022 13:17:11 -0400
X-MC-Unique: G7f2sKYtOY2hUEkfeCU9DQ-1
Received: by mail-qt1-f198.google.com with SMTP id e8-20020ac84148000000b00319f55b2657so7307755qtm.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKnKGcPQx2M8z8doipgVBVXWw9daoK1UODE6Y0G/spw=;
        b=j2lJRjSTWdOhCa3aO4D9TW7dO93DpM8wgVD7xjsOVs81HgnC/N9lAghB/yz6TiJYoG
         CS1DlqV/MB/Ls4FLxKVkC9MMO3ELbDkkapbtEjHPYXI9XLgNYgGetZCVgCal+bRgsIPL
         5nucYoilfxw/NjJKMAVJ8LRGxijew/r2RiHoQdFQ7NchFu5iwRpREpcvNhDJ0pGGioOG
         mm3W1/xTGkGvjuYTzTD+k6jqlmHzsNSJ15XDiJrk9kxIsVuGWf3Dn7xIoGe6XL3CNBRp
         D1hV7U5Pjd8bBvhTVTW04W4bzkXk/j2LaPJUwG2lYt36LB2mDy2vR5ZNuIEOKAb5vbgt
         HLsw==
X-Gm-Message-State: AJIora+YQ0I0crgtVGwIkDMj2OXW112W+WSxr269gnLfD/ivISPTSebQ
        Oq736/7uen/4hMw6SQ9leMmyF7qCdLnSE8d/t1Q/CkD5hpKnyTak/U45Xo7dmSpES9IWOz2+C5s
        5IwpuOO/hsgtQGozWn2O3DEKf
X-Received: by 2002:a05:620a:f89:b0:6ae:d418:f478 with SMTP id b9-20020a05620a0f8900b006aed418f478mr20154053qkn.344.1656955031102;
        Mon, 04 Jul 2022 10:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v5kru0aGtinN6uCz+3PHhaYe1+jzHnVC9+Cwzy5758LJyRQ9emh0kO9BDMsxacR8UMuY7ZQw==
X-Received: by 2002:a05:620a:f89:b0:6ae:d418:f478 with SMTP id b9-20020a05620a0f8900b006aed418f478mr20154038qkn.344.1656955030805;
        Mon, 04 Jul 2022 10:17:10 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:17:10 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 2/6] vhost_test: add $(srctree) on the included path
Date:   Mon,  4 Jul 2022 19:16:57 +0200
Message-Id: <20220704171701.127665-3-sgarzare@redhat.com>
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

Adding $(srctree) on the included path we can build vhost_test
also when the kernel is not built in the source tree (make O=...).

Use of EXTRA_CFLAGS is deprecated, so let's use ccflags-y.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/vhost_test/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/vhost_test/Makefile b/tools/virtio/vhost_test/Makefile
index 94d3aff987dc..df5ad39e2520 100644
--- a/tools/virtio/vhost_test/Makefile
+++ b/tools/virtio/vhost_test/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-m += vhost_test.o
-EXTRA_CFLAGS += -Idrivers/vhost
+ccflags-y += -I$(srctree)/drivers/vhost
-- 
2.36.1

