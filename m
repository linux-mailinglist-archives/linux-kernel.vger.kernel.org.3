Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F15B0B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIGRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:39:12 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E16A9264
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:39:11 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id dt8-20020a0565122a8800b00492f7025810so3769147lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=BmEi8gIwQcUUQptKaHcLNwXSjRU/vHM6B2OOTGvVDXE=;
        b=dko2SfaLeLucDtojaFxk9/p0aOv1qZKDkQKYFaggxikX8hhzEizTQ417LdYHh6nTox
         KDsBAknOJ+6Eo/ArssQbhLT+hoJlNuokKbDReVVCeU5JfNFLZSWj2hEF93uJqVRs8qmp
         lvDIZ16cH/V5ix87Ny61ePlKOnhFeqzEC5UpHbxUkB8zmnIBp7wYvj5lf+KySeFV7968
         QDkJYZCZJRxhS/PFq3Sp8wTOns+YvZmZs4EybbydI/wuFSFXa3hnu1TVuEncjt6j2LBS
         Vj/MxCuENHCle3qb5gvg0+znGmCJa5a5CTiKTD7LkwA6mid05caT6rvJtJO4hJBaPKir
         kzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=BmEi8gIwQcUUQptKaHcLNwXSjRU/vHM6B2OOTGvVDXE=;
        b=6mYeRlluut/1CA+RSxEzyiyz/GmqqTWX7rlYlAhrXwPOR1pFoDX055XujAZ3HoR8Su
         NlbinU0+ttmJHxE5GtOCdgcXyqid5cj38ertVzznjyTpGuzy+ReXVbyD0bUddxBv8D6s
         c20S30jdtXrcOttZrr88PfhDitutBPmEN55EWwll6x5QDFJm420CZViPyoiFjNEIlip+
         UrStw6clXvDThllYsBPSf26RMyJ1WIuJng6G5nzCCWPX2/jOoTPhnPK8iLrES6UlWLFb
         hr+LnEa15gplcNIbrqS3OvVsBnZVooHs8vYdmWtuW1/17/wmuldo3gRHnpEhty+jcPG5
         UwnA==
X-Gm-Message-State: ACgBeo1PuPGWGfHa0HV/RvGCgNcDp+EoaiCrKmQKq62SdZ5gXhWlRu7C
        WWtvjwoEdSg/VRIx1raVl00LbT7NBA==
X-Google-Smtp-Source: AA6agR5egxwtxjD+OnVXZYPoC3wFjV2aF+IAhyqkuqSkuJ//nrmP6TRx2UYFpIsZzh6M2wys1t9NiZGavQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:ba52:c371:837f:3864])
 (user=elver job=sendgmr) by 2002:ac2:5ece:0:b0:497:acb3:a6f5 with SMTP id
 d14-20020ac25ece000000b00497acb3a6f5mr554128lfq.112.1662572349920; Wed, 07
 Sep 2022 10:39:09 -0700 (PDT)
Date:   Wed,  7 Sep 2022 19:39:03 +0200
In-Reply-To: <20220907173903.2268161-1-elver@google.com>
Mime-Version: 1.0
References: <20220907173903.2268161-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907173903.2268161-2-elver@google.com>
Subject: [PATCH 2/2] objtool, kcsan: Add volatile read/write instrumentation
 to whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds KCSAN's volatile barrier instrumentation to objtool's uaccess
whitelist.

Recent kernel change have shown that this was missing from the uaccess
whitelist (since the first upstreamed version of KCSAN):

  mm/gup.o: warning: objtool: fault_in_readable+0x101: call to __tsan_volatile_write1() with UACCESS enabled

Fixes: 75d75b7a4d54 ("kcsan: Support distinguishing volatile accesses")
Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a..67afdce3421f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -999,6 +999,16 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_read_write4",
 	"__tsan_read_write8",
 	"__tsan_read_write16",
+	"__tsan_volatile_read1",
+	"__tsan_volatile_read2",
+	"__tsan_volatile_read4",
+	"__tsan_volatile_read8",
+	"__tsan_volatile_read16",
+	"__tsan_volatile_write1",
+	"__tsan_volatile_write2",
+	"__tsan_volatile_write4",
+	"__tsan_volatile_write8",
+	"__tsan_volatile_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
-- 
2.37.2.789.g6183377224-goog

