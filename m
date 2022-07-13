Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACF572A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiGMAwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiGMAwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:52:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61ABDB97
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:52:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31d3f067919so82136457b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IBBthWT9u4UyqwX/3AheGhzcyiFLeqqA+WnxRGpF0DM=;
        b=XtraHLVXVA8Q6rk2B0/mqyPO5tmI/GN09VHw9Jf2QsZFNymE9Gklp34Po5wmBkyH4o
         5MN4giuBFiOSKIHN6ar6lcpcvtIx43YA93hNOq1NKSx61TIvEo5/8ydelhCplS1w7Mnj
         Nogt/4wrqMKnPx2HLqNg2zLTcFLKNOeLHnH0cCMOgOI9WIlPDnUmK5S61LpZ25I9aJl3
         gbOTt6ItboRu00B3vjNg3Z77Q7YkCzyjb39RvdjVXZtK3tTx5kiu8trcCSlNBB9Ma5YD
         w16Me6jHQpRZ2/6V8FGtQdzIe0HE2b5IMGUECRDasyDV3WkqtxJWnFLtjbqL7KFdCcjl
         gGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IBBthWT9u4UyqwX/3AheGhzcyiFLeqqA+WnxRGpF0DM=;
        b=SXET1gy7izXqmeWdFXkQk2ldh7Gom0kZa3m5ATN1s+EqAZlQTVi26d/Et2oo8+xC2q
         D0/yxyRk4rKixBaofc/rrxdXYVWnT6n699K8+oeXNPgp8i41QoQG4cj1P7NPe5fy7mji
         TK8IDONVMS2rXDj1LAtqy1Psv2S1IerQw29xsCHFBlvE+HqPfNUQclY8vYOq9ToxaCYB
         i7/eK2OPoq8yY07OTgs0grNj0Fl1Y2Rz0uyFt0zqskS9ONIi1Bg/YAXrncPhefwUH1fk
         Wto/5dIhFlmezBbgfQZnVgI9EIIEHGtxQGBrGTu6HRaLj2cytG84ya83MKoVkZU7rzZa
         BTqg==
X-Gm-Message-State: AJIora+MHp801gNizYynH681WrPp3AkdKgAbiNBLDVJMAQl9iriQv4rQ
        5gWCe4Km+u2MAfQfCvJPPsx6/qOn2b3SbQ==
X-Google-Smtp-Source: AGRyM1tNeaI0uRA4XyHMmAsxk/ZwGTuVu3qI8Hv1n5Q0nkKc8YdOCBEsVUhM8hAZSzrZt0BG2Y3xc5OX9fvGhA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:cb0e:0:b0:66f:7b31:3563 with SMTP id
 b14-20020a25cb0e000000b0066f7b313563mr1141957ybg.85.1657673548486; Tue, 12
 Jul 2022 17:52:28 -0700 (PDT)
Date:   Wed, 13 Jul 2022 08:52:20 +0800
Message-Id: <20220713005221.1926290-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     David Gow <davidgow@google.com>, linux-modules@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new KUnit module handling has KUnit test suites listed in a
.kunit_test_suites section of each module. This should be loaded when
the module is, but at the moment this only happens if KUnit is built-in.

Also load this when KUnit is enabled as a module: it'll not be usable
unless KUnit is loaded, but such modules are likely to depend on KUnit
anyway, so it's unlikely to ever be loaded needlessly.

Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
Signed-off-by: David Gow <davidgow@google.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 324a770f789c..222a0b7263b6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2094,7 +2094,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->static_call_sites),
 					      &mod->num_static_call_sites);
 #endif
-#ifdef CONFIG_KUNIT
+#if IS_ENABLED(CONFIG_KUNIT)
 	mod->kunit_suites = section_objs(info, ".kunit_test_suites",
 					      sizeof(*mod->kunit_suites),
 					      &mod->num_kunit_suites);
-- 
2.37.0.144.g8ac04bfd2-goog

