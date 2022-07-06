Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D80568895
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiGFMok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiGFMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 884AB201AA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657111473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=PIS0/RbuT0M3BEFkPO/IWO82lqWMCd0aUMiebFiveIFvB2sFjSj7R39WDRWDJ+5gQVTVa9
        cE6ogaijOe7Zk1VOmNyiWic5H/aQxtUV7ItI/r1mP2N5qi21hXVbf2SFP2Rc6YfIdpB+Zq
        xHbiWeZHBXUYdHo0CC0haOhGARQSB5U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-GFcNFYbpMfScy-1jIDtKeA-1; Wed, 06 Jul 2022 08:44:32 -0400
X-MC-Unique: GFcNFYbpMfScy-1jIDtKeA-1
Received: by mail-ej1-f71.google.com with SMTP id oz40-20020a1709077da800b00722ef1e93bdso3735908ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=AXFbb4I5fJbRuxzP+nOGjA3PYbOambwfC24XH8b9lvaPkizlq2xEE5lodoYSi+b65J
         z/69WIUEz4P3HgF3lOGwTi1Z/DwhW2L8p3/jIEowe4IkRpsibm1akCzm1MEsrLxvDKs/
         V2hIuXhkJqxqLeVA9tekrsFzdXm8kt1xlnJi3ZDkox8T58Bjj50J3wGVmRIZ4+2G0N9N
         cOVykx/nauGUgFq2EVVxWMq9tHEyaDaRqpb1k551I41alhaGb6XWwPHsLrfFzwaqbxwR
         YczETjzsyHvLM/vHTBs9HZEPKVe6xM9hv7EV9rYYRjksq6rdVu6k3ya7LNdt10oZJNLe
         FAsg==
X-Gm-Message-State: AJIora8TGa1rrmakPTxBTydNIY8FaQNHMQjHI7tWUBGFj4Zf18DS9cDH
        n85cFMXSjLVAEt1/FbfxYLBIDTYiY5JX8XFKnpq32bi545QRZuwcwmWAt37v9pzff8cAdiRepMP
        Y1vPfDOhdicyDp9vgB8Y0bOJ0
X-Received: by 2002:a05:6402:1658:b0:43a:91cd:2ffb with SMTP id s24-20020a056402165800b0043a91cd2ffbmr459586edx.277.1657111471409;
        Wed, 06 Jul 2022 05:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sNbRQdcFT62rYEzaX/EvrotCf4gZzHWeg3W7E6zJXd3feLLSU75jqqitJZtUgKkWVymUsYfw==
X-Received: by 2002:a05:6402:1658:b0:43a:91cd:2ffb with SMTP id s24-20020a056402165800b0043a91cd2ffbmr459570edx.277.1657111471253;
        Wed, 06 Jul 2022 05:44:31 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b00705f6dab05bsm17237433ejq.183.2022.07.06.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:44:29 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 4/4] drm/todo: remove task to rename CMA helpers
Date:   Wed,  6 Jul 2022 14:43:52 +0200
Message-Id: <20220706124352.874528-5-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706124352.874528-1-dakr@redhat.com>
References: <20220706124352.874528-1-dakr@redhat.com>
MIME-Version: 1.0
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

Both, GEM and FB, CMA helpers were renamed to "GEM DMA" and "FB DMA",
hence the task can be removed.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/gpu/todo.rst | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 10bfb50908d1..fd5b3f2fb19e 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -343,19 +343,6 @@ converted, except for struct drm_driver.gem_prime_mmap.
 
 Level: Intermediate
 
-Rename CMA helpers to DMA helpers
----------------------------------
-
-CMA (standing for contiguous memory allocator) is really a bit an accident of
-what these were used for first, a much better name would be DMA helpers. In the
-text these should even be called coherent DMA memory helpers (so maybe CDM, but
-no one knows what that means) since underneath they just use dma_alloc_coherent.
-
-Contact: Laurent Pinchart, Daniel Vetter
-
-Level: Intermediate (mostly because it is a huge tasks without good partial
-milestones, not technically itself that challenging)
-
 connector register/unregister fixes
 -----------------------------------
 
-- 
2.36.1

