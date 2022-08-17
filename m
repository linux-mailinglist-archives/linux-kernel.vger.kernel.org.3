Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7D597479
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiHQQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiHQQtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:49:02 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D322ED6B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:48:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r74-20020a632b4d000000b0041bc393913eso5482274pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=MW91VJ8ooYkfI24AARzli0vrC+fjCBUcIuDZQqsMweU=;
        b=HrM/4oadRpLuauE3wfAhlaUa6h/4/tqPiPftlRa28vjD29S1Z03AdGrUS4icg55lzz
         mdpH2/sGlO2S9hGKQFkGWyi/+LVFp8SKN+o6Ufdri1Eo5EiI1GtkyohqsoqWrCooUrse
         01YZDaUiHfWsM07FJSgKOCdzFo+AJYOJjv7VIiA5cipO7Feu9OQL1v9EGOc1gBLW2ftE
         CRW3hP9j6pl8p24dzm74p7zY1Q4Jds3YgzU0HKP0wjd7gBMYe3dQzpfHuhWRGVgNQdK/
         WBFuR2RUpFhIfIxXtE4hLpAVk/sIf+JpGOy5CJv1KNh1u6zrH/AyvJkzSkrKjk9fttAo
         OZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=MW91VJ8ooYkfI24AARzli0vrC+fjCBUcIuDZQqsMweU=;
        b=NSfTioirbP0vFl58IgK1SW1tIOl+64CeC2xIA7doK+GdpuYocoLrdJM2mA1LysXeOf
         jeddU+QiTQelbO/fjun+kSN56UIDzSxOwOdUv5KkJRyYpvtaMsHWufEdjO/2vdNYCLaK
         clOjjJZHUpf0nAuailQ6OWvjRVVVMZYyUfxaCowW3TzlxMyxZgWPlMTv/eqRvSJXLsoo
         EV8iwe6cNDfYlYbGwR4lqqTkIX/ExhQ/e4wdABHE9bgcDKDyWGLXXfR/RKd4+/sFySgv
         lGt2gRcMGydB/4ulse36BIa/UXzwJHF7ZM1kwWY05GEhbOQqYOC38yes45UjrkCgZfcn
         eIaQ==
X-Gm-Message-State: ACgBeo3qwrkyTk9oKz/xOC9QBwvf05wsIQftsaECKNvCdVsWWfRu+3uo
        wRjqDT6JkiALscccLxelVNN/oVX/zawH+RU=
X-Google-Smtp-Source: AA6agR6y+L8VlLV7KWNAda2DVBCB6L15iKXqNuYwyuRdvEBZaSkyCIdiCZgjXsXIhCGDLLwYBeZKePR4XVHjcqw2
X-Received: from joefradley-custom-96.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:831])
 (user=joefradley job=sendgmr) by 2002:a17:90a:3e48:b0:1fa:99af:d881 with SMTP
 id t8-20020a17090a3e4800b001fa99afd881mr4647698pjm.243.1660754935326; Wed, 17
 Aug 2022 09:48:55 -0700 (PDT)
Date:   Wed, 17 Aug 2022 09:48:48 -0700
Message-Id: <20220817164851.3574140-1-joefradley@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH 0/2] kunit: add boot time parameter to enable KUnit
From:   Joe Fradley <joefradley@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Joe Fradley <joefradley@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

There are some use cases where the kernel binary is desired to be the same
for both production and testing. This poses a problem for users of KUnit
as built-in tests will automatically run at startup and test modules
can still be loaded leaving the kernel in an unsafe state. There is a
"test" taint flag that gets set if a test runs but nothing to prevent
the execution.

This patch adds the kunit.enable module parameter that will need to be
set to true in addition to KUNIT being enabled for KUnit tests to run.
The default value is true giving backwards compatibility. However, for
the production+testing use case the new config option
KUNIT_ENABLE_DEFAULT_DISABLED can be enabled to default kunit.enable to
false requiring the tester to opt-in by passing kunit.enable=1 to
the kernel.

Joe Fradley (2):
  kunit: add kunit.enable to enable/disable KUnit test
  kunit: no longer call module_info(test, "Y") for kunit modules

 .../admin-guide/kernel-parameters.txt         |  6 ++++++
 include/kunit/test.h                          |  1 -
 lib/kunit/Kconfig                             |  8 ++++++++
 lib/kunit/test.c                              | 20 +++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.37.1.595.g718a3a8f04-goog

