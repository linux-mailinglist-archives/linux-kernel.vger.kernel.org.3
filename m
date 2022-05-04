Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5951991D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbiEDIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345990AbiEDIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61DAB1FCDB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651651338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7zXu34IG6COwbjtsWuh3VVUA+veouEEkv29/Xam+Los=;
        b=C9jGrW4lA1SV6NO/jBdBOk6TgC2WxH5H45PFESxaHLOoWXNzSBorXcd0QqzQuhs4csfb/n
        hGj/fhvdGb4nF4DKgGqFyhw6I2ivx8OymeNOQAHIfFb3y3+U64INgh0oRRI+oEiap6q8ss
        ouUgTTexFMPKyQHfxckdei9NgFIE+20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-9ce1y4s4O_aoTmWcu1ronQ-1; Wed, 04 May 2022 04:02:17 -0400
X-MC-Unique: 9ce1y4s4O_aoTmWcu1ronQ-1
Received: by mail-wm1-f70.google.com with SMTP id p32-20020a05600c1da000b00393fbf9ab6eso2653037wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zXu34IG6COwbjtsWuh3VVUA+veouEEkv29/Xam+Los=;
        b=4HdKsf00rz7WI7X/XFgDfHiTo7jARSkRmyEH+cC8q9giiMlPn+xEkdv8DPYaYH5UXu
         epgASSRMZWNtLO680ebRyntontqcvTulLrsdMAi/QPaCztZvuu1JUoW6mCJ8iecrCmf8
         z3/E1gcRgyeJ8ZUp9XoXnUZKqLmqxrBdHaVqEb1ogr1aPgt0RIZLx3Jlnz45/ny7bcqh
         ZAZ3T3mzuDD0eGssPB0JlLVnYWd0eQBDYTfaHfruB6SW2OsMpxPssMajpWkK0FEIavDT
         bbAdGXjiD8a39YuaXVI5Z8WRvxU+gwBCPlOiEUjQ+DHdlrsjQOR55V6GcdXvGz/Bff7J
         wLFw==
X-Gm-Message-State: AOAM531TGjUOilvRkT2naV/2CGuFMOMXsd0/PqpYJ92/CHWU0fy+5ySi
        TZHKlrJTpmr9Aw6HNTLGCk+gNFhaDZ9pLkXMx7ktd9i9t5XyfYbQs/qjsg1sHkTZxlDy8ppfSTm
        E5YBkEtLNRRayl8Q0Byy/0GCUpqolWAK9ZTLTiP9sFFhDDcPjiEcF9HK7zGRtuGq6isl5Jqya7/
        w=
X-Received: by 2002:a05:600c:281:b0:394:1075:fe3e with SMTP id 1-20020a05600c028100b003941075fe3emr6526502wmk.155.1651651336108;
        Wed, 04 May 2022 01:02:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN1muJJMfdooSCi4Oc6vFk6sijHuLsxaZY4H7nGBDH4+1JhjDY7R1Xp0Vb46jIg79cFINiwA==
X-Received: by 2002:a05:600c:281:b0:394:1075:fe3e with SMTP id 1-20020a05600c028100b003941075fe3emr6526478wmk.155.1651651335844;
        Wed, 04 May 2022 01:02:15 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c10-20020adfa30a000000b0020c5253d8f4sm10872601wrb.64.2022.05.04.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:02:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH] drm/todo: Add entry for using kunit in the subsystem
Date:   Wed,  4 May 2022 10:02:12 +0200
Message-Id: <20220504080212.713275-1-javierm@redhat.com>
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

The Kernel Unit Testing (KUnit) framework provides a common framework for
unit tests within the Linux kernel. Having a test suite would allow to
identify regressions earlier.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 Documentation/gpu/todo.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 127e76ee0b2d..10bfb50908d1 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -603,6 +603,20 @@ Level: Advanced
 Better Testing
 ==============
 
+Add unit tests using the Kernel Unit Testing (KUnit) framework
+--------------------------------------------------------------
+
+The `KUnit <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
+provides a common framework for unit tests within the Linux kernel. Having a
+test suite would allow to identify regressions earlier.
+
+A good candidate for the first unit tests are the format-conversion helpers in
+``drm_format_helper.c``.
+
+Contact: Javier Martinez Canillas <javierm@redhat.com>
+
+Level: Intermediate
+
 Enable trinity for DRM
 ----------------------
 
-- 
2.35.1

