Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D26B56794F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiGEV1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiGEV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11300DF3C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657056442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EL5Y6xobY6nNfLFyUJpZNgTfVBKuW8H+SSOn+M8vu8=;
        b=NmQ9ZHPZSyOsuYIt3P/LrG0KOvLJ5LDhnV+qHymvciM9KTA7Gf94bTV7FG4xueMAMtJAUa
        +GWw7EVqfFtMQmmoZ64hOAgp9XDZ8qzzsPO+HMuSIbLZBV2zqHyrZZ4cJZMWhhSwFubhdO
        2lb9GkOUmgPXWi5dL//+K1ceYNYjAk8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-gGQsX0YJPpuduzgyLhdy7A-1; Tue, 05 Jul 2022 17:27:21 -0400
X-MC-Unique: gGQsX0YJPpuduzgyLhdy7A-1
Received: by mail-ej1-f71.google.com with SMTP id sb34-20020a1709076da200b00722f4a9865bso3150381ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EL5Y6xobY6nNfLFyUJpZNgTfVBKuW8H+SSOn+M8vu8=;
        b=rCnZ24ZCz7Wovhis2YuyAGdjN0SnLyxS/jKo9zgnuTV59CMycUqI8FC+j+LX2RUwJd
         KQIWvHkTxnvCNaRABm41xsC81Vy0LCK4Bnnl/h6kKTlg3EEa9kTHKlmoVko1eqWyk5HT
         RffEFWLP7PJzFCUF82Yo3ivNECVQQMrVU9mVmdUiVlzyCyjDi3UiikvooDCAcde4Tjxw
         joh9P4d2aIHR20XubHTCDLLj+Sn/alAH5xgQfu45kV9Kb2Ob+zWj9D+5GT7Oh35pUg1h
         P+RwIAu3I1ROjd+/Rb7tbFJJDlcuMyaEKI6kDwFdvUmDvin0MDCSYU1AH1svzIIkRcGS
         V0aA==
X-Gm-Message-State: AJIora+DS0sN/HPiLwzayfhqcoYEXGK7GBuYcjBhzzj28cfa2o9piQcv
        ck3tD4SIiTlh8V0ggwoHRmJdoNwUKs4Mn4xdxllQUykLdJa+sFo//nlTb38gNFcfa25W+NwhFSk
        fSU638qKlj57yIDrTknbiS5+F
X-Received: by 2002:a17:907:60cb:b0:726:a69a:c7a with SMTP id hv11-20020a17090760cb00b00726a69a0c7amr37053674ejc.156.1657056440087;
        Tue, 05 Jul 2022 14:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzQJwVsCU8Fs0s93xgADFfs3aqJVtQWqMGOvtd3I2FLsQKPRShxC0aA0MP6NzMHQF/FsZ/Dg==
X-Received: by 2002:a17:907:60cb:b0:726:a69a:c7a with SMTP id hv11-20020a17090760cb00b00726a69a0c7amr37053656ejc.156.1657056439860;
        Tue, 05 Jul 2022 14:27:19 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ez24-20020a056402451800b0043a3b90748asm6213319edb.26.2022.07.05.14.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:27:19 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 3/3] drm/todo: remove task to rename CMA helpers
Date:   Tue,  5 Jul 2022 23:26:13 +0200
Message-Id: <20220705212613.732039-4-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705212613.732039-1-dakr@redhat.com>
References: <20220705212613.732039-1-dakr@redhat.com>
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

