Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D43D529472
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350177AbiEPW6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349925AbiEPW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07A42EFC;
        Mon, 16 May 2022 15:57:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m6so17635985iob.4;
        Mon, 16 May 2022 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MiJjjZdxaha67CSMTI1r0BLom3ol2jA6WSWjlEZ1BTo=;
        b=j1OPvP3C9jzXimCIyP8PoqRmxw+BRCMFtN3Kc98fXUqazTR8W99pYA0kCZDMXLOLJp
         +oKyHJsCC6GTmZKC8UHw5tKkI2nbsmIVzY7pic2mn4wdDsjnCh6KCE5yKjVzDgizKEXb
         V3v9TU4a1CZ0xaEdkmhZV9JCIy/2uJtBGE4KztwXV0xXvP00wJo6EJgx3XrgcmCEjvDB
         mHakjZoZWxRSjEBcGXCCfFXU5ecCp+sOoXTR/H9XJxden/M+lBntak5Xol5WL17PMKh5
         fn6faaYJtp/pPNfh6627Fd/dGtn8PSYKoRU5O5s3eXW0TPxxlmwJGHlpmuBKvnl2hB8Q
         tu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MiJjjZdxaha67CSMTI1r0BLom3ol2jA6WSWjlEZ1BTo=;
        b=6KbtO+aWWiqZCjDsBtjQyURA5UrTwrz+nnaftcgZNcN5GK2K7J+FEdSyWyvoh/on2a
         HqvY91wsQGb9aXd81x7O5MNUe33nmuFJLS8rEQQlCwE+L/trb5xFsGGs8GP3EgHrbxez
         sMFTiObEraQkVuePukTTo4fAm6y9Sa2Iyy0e3fUF1pyDzlL5JzPowgzsqm1fICOr0L9D
         Xd6jS3/fFfZQyIjktDSBlw1gSEaQzXY7P6Sn6U6De3VDCgEXox/9xYChd9R57quliLh5
         Vk5QTmMhbM8JDvR+fEVhfnG9ByM0xntIIuWQLfenZggfXwo0gKH/aCJ3IgrfaxPRxpxA
         fiDQ==
X-Gm-Message-State: AOAM5300I+vWnS7Rnhw6jz5hj8hpcXutLNSRJFyNXwSyAWUbCylckWPV
        Jm/dUKIIxInHJjC6P4i9KNM=
X-Google-Smtp-Source: ABdhPJzg3E6Dvu2xvvEgwlGLUhvaUBtxTTam4Jtwh7ic+r/MBjnynyLt4vZbjaxcZ8EUCArbYeUCRw==
X-Received: by 2002:a05:6638:616:b0:32e:614:9c4b with SMTP id g22-20020a056638061600b0032e06149c4bmr8948820jar.203.1652741831372;
        Mon, 16 May 2022 15:57:11 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:11 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v2 09/27] Doc/dyndbg: document new class class_name query support
Date:   Mon, 16 May 2022 16:56:22 -0600
Message-Id: <20220516225640.3102269-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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

The added paragraph is slightly process oriented, rather than in
language of guarantees; I thought the implications were clear enough.

It does perhaps undersell the selectivity gained with string
class_names; only drm/* would sanely register DRM_UT_CORE etc, so
doing multiple "module {drm*,amdgpu,i915}" queries is unnecessary.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index a89cfa083155..01ca6f635dcc 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -35,6 +35,7 @@ Dynamic debug has even more useful features:
    - line number (including ranges of line numbers)
    - module name
    - format string
+   - class string (as known by each module)
 
  * Provides a debugfs control file: ``<debugfs>/dynamic_debug/control``
    which can be read to display the complete list of known debug
@@ -142,6 +143,7 @@ against.  Possible keywords are:::
 		 'file' string |
 		 'module' string |
 		 'format' string |
+		 'class' string |
 		 'line' line-range
 
   line-range ::= lineno |
@@ -203,6 +205,15 @@ format
 	format "nfsd: SETATTR"  // a neater way to match a format with whitespace
 	format 'nfsd: SETATTR'  // yet another way to match a format with whitespace
 
+class
+    The given class_name is validated against each module, which may
+    have registered a list of known class_names.  If the class_name is
+    found for a module, callsite matching and adjustment proceeds.
+    Examples::
+
+	class DRM_UT_KMS	# unless DRM wants different
+	class JUNK		# silent non-match
+
 line
     The given line number or range of line numbers is compared
     against the line number of each ``pr_debug()`` callsite.  A single
-- 
2.35.3

