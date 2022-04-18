Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A27505AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbiDRPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiDRPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CE62CD31C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650291530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rU+BOzU7OFMdCRKMQTeeqDo4Ukzfu12ch4PVunTJ6T0=;
        b=SOWoSxqfdfmf3s7M+iOSP4ZH2chazVfbkm1GQ6+N8wW0PMN//vypNHciUKNYrTPS+aePz1
        oDCvpffFiquk+yvY7W1PHP1QnIDKhGxNZeriOkeSLGFSSfS2oQ64GTfXz9pG7VkEyRVSlR
        29r5UvgYf8AACDqHvQPzJkO+oyANZUk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-5kK5dh2tOVGKrVWxpHE6sg-1; Mon, 18 Apr 2022 10:18:49 -0400
X-MC-Unique: 5kK5dh2tOVGKrVWxpHE6sg-1
Received: by mail-qv1-f70.google.com with SMTP id b8-20020a056214002800b0044666054d36so1157306qvr.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rU+BOzU7OFMdCRKMQTeeqDo4Ukzfu12ch4PVunTJ6T0=;
        b=AramC/L8vtM12KQWZD5tZd1hcxHVCShI0z7T6dj0M5W6bUqpzl+KKktwje9/DWAIAk
         wx1wUBh42ppwV6W1P15dhmKLQ4diRw1XzG3yUdpreH6zS0cvwskJpSJ+Mvkqv2pghpdP
         NJSqdnIYKaav3mkgo2pI6R6oL/RZAojNqMRnfvbm/fcBIawY3Xt5zN6AwUg0p4k8qCrg
         4kocZwBcPE2xJBu4CINxlXXP3Nf6k+0ksmp6DPmNaOPPyrerCroRHPUIuY2+KblJNiD3
         4S0bfy0oMcqAZVkqijhDkv0LHvvFdlt1KSawP5Pft185mywLqL9jMiIoU+btM/M8o7Bk
         ioxA==
X-Gm-Message-State: AOAM531lR8Wdi/v5mfeliBEoTnvEa9pmSQlfAOzuFIbZaxSVPZX5c+Oq
        BZpSiSumD7GfYwA3YHh2PT+iBWiR3RuM3NOrY3tWdUs3UYOgdClOjGxWQP1GGsz+B00KLNQhv/M
        X1Z87pcqBa66ambmt9X1m5KBE
X-Received: by 2002:ac8:7f06:0:b0:2f1:f823:856a with SMTP id f6-20020ac87f06000000b002f1f823856amr5665524qtk.623.1650291528866;
        Mon, 18 Apr 2022 07:18:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/SQVkTBbtpx6NFVq6KE6yRW7/GHXsA0oi2d+LEGg7hhPI3vQ5/gmQ8L/2ysPbdvyDIKURNQ==
X-Received: by 2002:ac8:7f06:0:b0:2f1:f823:856a with SMTP id f6-20020ac87f06000000b002f1f823856amr5665514qtk.623.1650291528603;
        Mon, 18 Apr 2022 07:18:48 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85ac2000000b002e1cc2d363asm7785952qtd.24.2022.04.18.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:18:48 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau: change base917c_format from global to static
Date:   Mon, 18 Apr 2022 10:18:42 -0400
Message-Id: <20220418141842.296386-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
base917c.c:26:1: warning: symbol 'base917c_format'
  was not declared. Should it be static?

base917c_format is only used in base917.c.  Single
file variables should not be global so change
base917c_format's storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/base917c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/base917c.c b/drivers/gpu/drm/nouveau/dispnv50/base917c.c
index a1baed4fe0e9..ca260509a4f1 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/base917c.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/base917c.c
@@ -22,7 +22,7 @@
 #include "base.h"
 #include "atom.h"
 
-const u32
+static const u32
 base917c_format[] = {
 	DRM_FORMAT_C8,
 	DRM_FORMAT_XRGB8888,
-- 
2.27.0

