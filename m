Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0257B51FDC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiEINNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiEINNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90C1E2A7688
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652101742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9C8drEYqngKOm3nncV9RRJ4ZJYInBOQKfqINsG0BQFA=;
        b=WTWlWkUqRPMyTrEfzmeQjHaZBU3j8KbueY6mLhWF8iNg8r787smSwLsTQnuRBH+0Rxef7k
        s9d8BEd8lPoKeiLE7lsBSizdEL3W9o5FfDMxjf45oIlc9AjTbGpNHe4JpjvkU0W7jJjqoZ
        5heN4khFypWH8x7QU77gK7JWIszfUEo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-KQMTzUUtOm211bSr8Hp74w-1; Mon, 09 May 2022 09:09:01 -0400
X-MC-Unique: KQMTzUUtOm211bSr8Hp74w-1
Received: by mail-wm1-f71.google.com with SMTP id p24-20020a1c5458000000b003945d2ffc6eso4242201wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 06:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9C8drEYqngKOm3nncV9RRJ4ZJYInBOQKfqINsG0BQFA=;
        b=5bkqkXyOKJAGjUdybF+wTQNzOVg6Komt8WHVc+VEH87J/eIzn4xsh5uomTdsNIq+Ve
         paFSZTw5/2l/qAIybqOf3ymcglZyDQfa9292SbDAVsKnp5pFqxLkzyrBTeBBv3OCYCIF
         bWmu41bJzmpvOuGiyBtu7s7ENgQgM4lBWj5ZGhM+GpoMnb6n7JzmxWgSR8bhZYbuQE/L
         pqVEGPHifKQajaRPgtgbabJPK/iddXsz4jhMJI2drJPg765/raV03GkPMmqWCQvYqMcv
         tXy2T9tc747ojqQpqMoQy7kqCaUsN2UoGzW95R1c+2g5YVvWij8LGR/gOEPhzjWg+MMy
         4ipg==
X-Gm-Message-State: AOAM530lmi/gsoIB/xN0+oOIdULuvizle2epBZ7pQ0vRDDKRd182SWqn
        KNf5LTpxid8RnzMWgBIZHmyXBBbPBQHoJ7XVaOl/a+ZGbUki34PU03iK6W+s+MLEdYnSJeR4c/9
        1m4OSmA3rb46yGtclI4ZrYDNmgu3V+bRvzCjAdYDGMbK70UJwjjAQAyUPs8QVc1G4qSWtCVgOnC
        k=
X-Received: by 2002:a05:6000:1869:b0:20c:5362:1295 with SMTP id d9-20020a056000186900b0020c53621295mr14079759wri.700.1652101740457;
        Mon, 09 May 2022 06:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDG6lbGPaq84WzEwCdXcOkQUQu+pRyyBz43QQu3IUWtgwSbAp0rMkkKwCQUS43pMkFMDHl0A==
X-Received: by 2002:a05:6000:1869:b0:20c:5362:1295 with SMTP id d9-20020a056000186900b0020c53621295mr14079728wri.700.1652101740162;
        Mon, 09 May 2022 06:09:00 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c0a1600b003942a244eddsm13120297wmp.34.2022.05.09.06.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 06:08:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH] drm/todo: Add entry for converting kselftests to kunit
Date:   Mon,  9 May 2022 15:08:46 +0200
Message-Id: <20220509130846.694397-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the kselftests in DRM can be converted to kunit tests instead,
since that framework is more suitable for unit testing.

Suggested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 Documentation/gpu/todo.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 10bfb50908d1..513b20ccef1e 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -617,6 +617,17 @@ Contact: Javier Martinez Canillas <javierm@redhat.com>
 
 Level: Intermediate
 
+Convert Kernel Selftests (kselftest) to KUnit tests when appropriate
+--------------------------------------------------------------------
+
+Many of the `Kselftest <https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html>`_
+tests in DRM could be converted to Kunit tests instead, since that framework
+is more suitable for unit testing.
+
+Contact: Javier Martinez Canillas <javierm@redhat.com>
+
+Level: Starter
+
 Enable trinity for DRM
 ----------------------
 
-- 
2.35.1

