Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03D8502F69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349370AbiDOTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiDOTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:54:41 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE123606FE;
        Fri, 15 Apr 2022 12:52:11 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e2afb80550so8898103fac.1;
        Fri, 15 Apr 2022 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Su+WQbxMXrM+OhvwH5m5NIoIdi7+bcOuNz7k20oxO8=;
        b=hV31H4GIKDe1FUOWsNZLWg75tgQJHCXdLrn3KDSuE2Kzmx88TM5H+oC8Vq/OHpVNjj
         1FzgD5qpROIwiMMXWitW6jq6SdZKNI22BpyYpWcQdZOPopz5E64DQGF7Edh9QHTbydvR
         i+0fPSQwZWKgs09Gnc96CguYkzV9X0TbfCnZEoYaWytFgJO83e+M0YoB8Zkv78IMbf1b
         9dV8NOVouDw5cjX9gOCy5icxq5mycwTwvptp80+wPP47blV46Q7gTnhzpKmwDreVnny/
         xxF9MLtpfHGUL4zNTEFg9A4L7HFtbb5sm0Ha2nwlGw79LU1WVzmg5T6NXIb2sfi4bOuH
         4q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Su+WQbxMXrM+OhvwH5m5NIoIdi7+bcOuNz7k20oxO8=;
        b=MaOGNdKJY7AijcRhmO4rLS2H2EhxzyvYxgZo9BSylMjYZxjY16uKQ+6BLRFTEfgrie
         X3D7KnIM+x70GrnvYqissYXhQJNi3fkXb+AaUSps2T4PL1VokMk0L+9J6Lv1E9n8Vge/
         cmB1xD7VGgd7u2BgumFt6XTwr64lYIQxkDO/STHULbTy1MM1wRu6ysmDQm6YtH4xBQrF
         1wwlG8isiQNvOAKtCksti6ZHQZDDtPo3+u3KvERvH/McuEve7WFC4PXZL6rCRBdIPUL3
         18gjQqdAQD/kQK/OVLIM8739wTaUYX3yN2vUf7FpVDi256Pm/KgCGDXYQn7JBY/Rx4ED
         KOWA==
X-Gm-Message-State: AOAM533VAXtX9OIlvzNjukMLNW47y3mFJPDajsxUZwaYdlu89HOdQ5oq
        dhp67GAefoCgeQAFwJYqS3U=
X-Google-Smtp-Source: ABdhPJzvv6gcmeVAdWroqSq6Wxi3b/FlcuW63p6fWik33qgg/97LvEtlOvFCCEpJrcCnCTNFem9YOA==
X-Received: by 2002:a05:6870:15c9:b0:dd:e6db:cfce with SMTP id k9-20020a05687015c900b000dde6dbcfcemr2018666oad.269.1650052331073;
        Fri, 15 Apr 2022 12:52:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b:dcc3:45ee:2581:b4cb])
        by smtp.gmail.com with ESMTPSA id c20-20020a4a2854000000b00329d3f076aasm1436532oof.24.2022.04.15.12.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 12:52:10 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH 1/2] Documentation/gpu: Add entries to amdgpu glossary
Date:   Fri, 15 Apr 2022 16:50:26 -0300
Message-Id: <20220415195027.305019-2-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415195027.305019-1-tales.aparecida@gmail.com>
References: <20220415195027.305019-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing acronyms to the amdgppu glossary.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1939#note_1309737
Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 859dcec6c6f9..48829d097f40 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -8,12 +8,19 @@ we have a dedicated glossary for Display Core at
 
 .. glossary::
 
+    active_cu_number
+      The number of CUs that are active on the system.  The number of active
+      CUs may be less than SE * SH * CU depending on the board configuration.
+
     CP
       Command Processor
 
     CPLIB
       Content Protection Library
 
+    CU
+      Compute unit
+
     DFS
       Digital Frequency Synthesizer
 
@@ -74,6 +81,12 @@ we have a dedicated glossary for Display Core at
     SDMA
       System DMA
 
+    SE
+      Shader Engine
+
+    SH
+      SHader array
+
     SMU
       System Management Unit
 
-- 
2.35.1

