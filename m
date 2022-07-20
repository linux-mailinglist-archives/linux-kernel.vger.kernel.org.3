Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD8557B781
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiGTN3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiGTN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD98459241
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1+/TuaGVCtg6aZ6ugNH+AX/gcs1Sy7JNQEZshG7+6s=;
        b=AWBiPM2wvLb/5HFj8wjXBdykDPMGzFGv9gw3rbyfHEW5ZnKHwe7uTqpBHCoi5s2J3uN3E1
        1qtCAxEFpfTjInEYlnuPaWAVN4AxWvG/DhvKTlrm5Su9xkCyZDk0R1K66f948TSuCF81Ve
        fMaZ7995Y+onLqiuKoDVpUeSVwhdh5s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-3-DPLhaxNsS_2bJpJyu2dQ-1; Wed, 20 Jul 2022 09:28:46 -0400
X-MC-Unique: 3-DPLhaxNsS_2bJpJyu2dQ-1
Received: by mail-ed1-f69.google.com with SMTP id w13-20020a05640234cd00b0043a991fb3f3so12027865edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1+/TuaGVCtg6aZ6ugNH+AX/gcs1Sy7JNQEZshG7+6s=;
        b=hmgokBOkUoY8E6RzjX1ihCikhInneK1OblCbhSslRMt2v8iwurdC0SlqLwvr+VfiEc
         LsCpjaxCqdALN+I/7d/a504IEeTnoTPmpYn5NFOSkEl3AasXCygebo2tk12X9yutPU9/
         uFoxt2n1i4dauHtDNlgfLlDIn3L8q5ROHdPA33BvRt3rA1JcVIVE6IhdKzHIBWt+AU7T
         tBIM93NE/ZxqIlkAxrRLxmDmdtX3M1oCwuJzpGfYTw3AQvir5A1VXdOb1ol+Q/Ot22VO
         TR6Mx6TebkKI+FM2StnkZUXNC55H015UyxUwIrKj839kWkITgB5Gf6qsuMkDtN2S7fQq
         IHsg==
X-Gm-Message-State: AJIora96bKBGoE5pYqxfRvLLSFTHWIRCW9WAgMQDqGM/aSH+bTdiunO5
        vDi6B+q8i5dy4b1nLbY+kAA0AWjNxwv1WzbOBBChKh2NKbLpR9/jo/D1dsIklo9DSntEiuSObgh
        p2B+hgedH/2KRqizAhTFYYmbL
X-Received: by 2002:a05:6402:370c:b0:435:cb14:9aa8 with SMTP id ek12-20020a056402370c00b00435cb149aa8mr50011219edb.35.1658323725632;
        Wed, 20 Jul 2022 06:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6VDktN4Zp0svFCntEPMgCQyXq13LyGGTZPFEFlsUVznoeu82FYaWBUuOCXg43IcOly3Xphw==
X-Received: by 2002:a05:6402:370c:b0:435:cb14:9aa8 with SMTP id ek12-20020a056402370c00b00435cb149aa8mr50011210edb.35.1658323725500;
        Wed, 20 Jul 2022 06:28:45 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:44 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 10/10] drm/todo: remove task for idr_init_base()
Date:   Wed, 20 Jul 2022 15:28:30 +0200
Message-Id: <20220720132830.193747-11-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720132830.193747-1-dakr@redhat.com>
References: <20220720132830.193747-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All IDRs in the DRM core and drivers which are applicable for using
idr_init_base() over idr_init() should be set up to use a proper base in
order to avoid unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 Documentation/gpu/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 10bfb50908d1..de226ccc2c54 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -322,18 +322,6 @@ Contact: Daniel Vetter, Noralf Tronnes
 
 Level: Advanced
 
-idr_init_base()
----------------
-
-DRM core&drivers uses a lot of idr (integer lookup directories) for mapping
-userspace IDs to internal objects, and in most places ID=0 means NULL and hence
-is never used. Switching to idr_init_base() for these would make the idr more
-efficient.
-
-Contact: Daniel Vetter
-
-Level: Starter
-
 struct drm_gem_object_funcs
 ---------------------------
 
-- 
2.36.1

