Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5CE57CB26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiGUNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiGUNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB61A74366
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658408505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOmD7nAs9F7OxSkYkzWTSYR+3/R6/fZia8Dt8fL8A6I=;
        b=ifqUd7B2wHVWSgrMz0utn5lxQK85otBjXx+3BhPbxBVzmru8quMWJF0+c/X9+pGu718Rom
        uMHS4l0og4x95jqgjty6LnSHTavlkI1ovHEUhT45c5TeFEkTkTqQQJQvPKnHUbtce1K/nN
        kHx/sme+Uk9RVO+Ms1gXyBmhIWeIdj4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602--VL01H60NdqaFKTRWdXGnQ-1; Thu, 21 Jul 2022 09:01:44 -0400
X-MC-Unique: -VL01H60NdqaFKTRWdXGnQ-1
Received: by mail-ed1-f71.google.com with SMTP id b7-20020a056402350700b0043baadc4a58so1084960edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOmD7nAs9F7OxSkYkzWTSYR+3/R6/fZia8Dt8fL8A6I=;
        b=K6eGrf0+H3Jx4BLYMaeNp04H9s1VdVj4f+IS5gdglQl2etzEPnXjYdae63g0bPAUXc
         lYEYtBUjZUppunisYoO1Y0xelCcZMpA6lMc9VITIMw4nXAJ8FlD0EcqEGivZxhZ2EVE5
         bhrbeECFHrvJzk8l8abWfuoexerQ7xgeSntXVVI3EgTpvzTRyWrBy8IrOO1ZVueZ3Rva
         qfng0S7yi7BUZ2cjH+FKtWoiQgqBVsxPxTeB2Sr5Hax2VhFnhe+WAEtmg+oxYFgesfVp
         Deo/IDUdIjw7QDdDilEtHemmZ4veDa+i0PBEgGZD0wuJY2XLrCIr0JYADHy9rD0ojbVE
         rEyw==
X-Gm-Message-State: AJIora9XE5uyDDAa7PhzySQZ3rh6iC7EL+2D2CGMqYDNi8e+2KlM+5HU
        PHq2cS2k+wNh+UK75gvRxKo2Bn97hY9mRarvUMUQbBm0NXYeyz8h6V+9uVCwA8CAsUu5xN5+Q46
        EAwolhdYQCJPzxCmR9+fMZ4f6
X-Received: by 2002:a17:907:72cb:b0:72b:820a:f09b with SMTP id du11-20020a17090772cb00b0072b820af09bmr39522181ejc.335.1658408502921;
        Thu, 21 Jul 2022 06:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sTUDkfMV6+YjMFSbP85j+wYdLmnn3J2tOEDOg7E2zpHSnQC642s42tXrtJSN+xVDV7Brl/cw==
X-Received: by 2002:a17:907:72cb:b0:72b:820a:f09b with SMTP id du11-20020a17090772cb00b0072b820af09bmr39522151ejc.335.1658408502564;
        Thu, 21 Jul 2022 06:01:42 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id dk20-20020a0564021d9400b0043a71775903sm955826edb.39.2022.07.21.06.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:01:42 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v6 5/5] drm/todo: remove task to rename CMA helpers
Date:   Thu, 21 Jul 2022 15:01:33 +0200
Message-Id: <20220721130133.829693-6-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721130133.829693-1-dakr@redhat.com>
References: <20220721130133.829693-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both, GEM and FB, CMA helpers were renamed to "GEM DMA" and "FB DMA",
hence the task can be removed.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
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

