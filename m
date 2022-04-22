Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4A50C01C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiDVTGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiDVTFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C7EB184F28
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650653701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hxCPWA8afO+/nG6bVigx+oLOlYxnjtDB8EbEFgDn4q4=;
        b=G3gWgYE/Z+GdHrNs/U2abs2KzdJi7PDzkNY09mqRKyPNzZsbRWAndD70kOIc5BE2R5ezvC
        2EW4w6mlBEY4xGj/5mnCI23Sm9Ni2H1JaPCJ7wX7M9LbNrTVjMHOuX97WeIryV7WS2jkgf
        UH4IiAiboHDXmUG/HDMbtORkMDhy/6Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-bdXHWAZYNO-wvAtqgPYGxg-1; Fri, 22 Apr 2022 14:51:39 -0400
X-MC-Unique: bdXHWAZYNO-wvAtqgPYGxg-1
Received: by mail-qt1-f199.google.com with SMTP id o2-20020ac86982000000b002f1d71c97b8so5574760qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxCPWA8afO+/nG6bVigx+oLOlYxnjtDB8EbEFgDn4q4=;
        b=GeA9d+vcqkN1eLQpYXdS5e7Jv9TqZh19joFHu832D8+dw2volyEJ8pP5kdSEk7gZX+
         rtSliBYx9qGWKc7O+yZuJg/eVUSQNGXqZ20d7cUGt821upGKZTHOUGEKPGY8pJb960j8
         Fz96nelPtxk4RGkPer92wxtc6ANi+yp1TxEQsMJupF3h8GpIUJtH5L/R5GJg68I1uV1y
         aenKCFS2EnJC9RE71dQ776pIc5HRQkHki8UpWuTOVL1wr9/IweNfYxc4Wg/i49Te2yyv
         JVaUsoEPKULD3o3WpNjvVQLACHjtpO20QQ6ONFqPmA2INWwahYIaUE0bh3R6RWMiJUiN
         +chA==
X-Gm-Message-State: AOAM531CMb7xf+sEk5f/DFDzoHVi6uBWdanNNNavlN/XMrW4zE1fZEIM
        0yD84XXMjLbcCrOu4cdtBP61qHqM2AnnQjTvsUr7/Xg7jWkp+h6jrEnKInFaq6VI307pSjxU11x
        TaJ2UIJLTInozOdG2mxVljjH4
X-Received: by 2002:ac8:594c:0:b0:2f3:3fd2:3ccf with SMTP id 12-20020ac8594c000000b002f33fd23ccfmr4348323qtz.610.1650653499044;
        Fri, 22 Apr 2022 11:51:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoT4/XMYJdxpa4GMbbGlHtzbN4fpVF+tFJqN9scdq+SUM9VTkRJ4SJtkWZHXMzlvMYxYQFqg==
X-Received: by 2002:ac8:594c:0:b0:2f3:3fd2:3ccf with SMTP id 12-20020ac8594c000000b002f33fd23ccfmr4348312qtz.610.1650653498849;
        Fri, 22 Apr 2022 11:51:38 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87f88000000b002e1cecad0e4sm1693729qtj.33.2022.04.22.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:51:38 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/kms/gv100: use static for gv100_disp_core_mthd_[base|sor]
Date:   Fri, 22 Apr 2022 14:51:32 -0400
Message-Id: <20220422185132.3163248-1-trix@redhat.com>
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

Sparse reports these issues
coregv100.c:27:1: warning: symbol 'gv100_disp_core_mthd_base' was not declared. Should it be static?
coregv100.c:43:1: warning: symbol 'gv100_disp_core_mthd_sor' was not declared. Should it be static?

These variables are only used in coregv100.c.  Single file use
variables should be static, so add static to their storage-class specifier.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
index 448a515057c7..1d333c484a49 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregv100.c
@@ -23,7 +23,7 @@
 
 #include <subdev/timer.h>
 
-const struct nv50_disp_mthd_list
+static const struct nv50_disp_mthd_list
 gv100_disp_core_mthd_base = {
 	.mthd = 0x0000,
 	.addr = 0x000000,
@@ -39,7 +39,7 @@ gv100_disp_core_mthd_base = {
 	}
 };
 
-const struct nv50_disp_mthd_list
+static const struct nv50_disp_mthd_list
 gv100_disp_core_mthd_sor = {
 	.mthd = 0x0020,
 	.addr = 0x000020,
-- 
2.27.0

