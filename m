Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C52525E58
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378618AbiEMIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378638AbiEMIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:51:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405B54684
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:51:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so67053217b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ogkiciib/RsRhAqfGoo2vDrriNiFsttxrZQ5YNjWEI0=;
        b=bS7n+AukRnAUU513mYC294Cf8qvSX1SGa68AIFAl5nnKbMaGMrmcUWkFzGuq6QJeFk
         YXDecED/n95KUg1dN68x1KMI1x53SW/LH/ZgWDeajbJritTOGvlNUzurd3lRPsyajMY9
         exDSZW3rBh1iyWpuh2HR7GNmoWXUqhP4Z2PpxuhD/oQPGG9WOX3pXoUBjgMo6UUz/KmE
         CWEnsqnrskHLoY2Pg5xdCVgF/xeDms6Vo18FGIKzqK0wDGxB5fTeQDRR2gs3FliVvP6R
         bNjdnXN8+7yn6gywt/PlIVqlH35RTwcqAs2A2QVEg27yfTabnZ9JOc7fOmyoAdFWaViA
         myqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ogkiciib/RsRhAqfGoo2vDrriNiFsttxrZQ5YNjWEI0=;
        b=lCWAyK4YSv1WSLShBvlym1UdTNCwQdSec+UyJbc02eJ3AQV629NS19Rzb3CVPEZfS8
         gPAgbY2OPPtO0UO/53IW99/+Jr4sh1Jkoe73dx6q7gOZGR1flsuSVl3po3ZJG+v6nei6
         yiPWbrq/bjBvFAFJYRzuWMJMXuN+otb3aoaIgT+DKj7KIs9VRo4vsYZ1SBXAsa1mfcAz
         9T0Zt+vtmUUnedLBXBDDkYznGnFOOL4nzvLdH752kEHD26IpKc2UmCKx5i6XUSwSo3xd
         urCkPIwgFZJlyQ2ZjupB9JD4U11qfRzWnZ8MW+UhNXUc9suS+AaT58/n/b2BsoMNhzgX
         F/CQ==
X-Gm-Message-State: AOAM532u+14vV7PI10PHvTBD3PikL13fGtaT+88OvsP7Mau8moIlSEqZ
        em8j+b7sfDuHBYvyXneSH9vqLW+xyz2XmQ==
X-Google-Smtp-Source: ABdhPJzp3yI7OZJ/tfM4kGbjDbgboSKe10uoAItfLbvfPEIl5FDcs9Sc0+JzktHJQETpmgVJHY7TnMtLUffYQg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:4bd5:0:b0:2fb:8277:98d8 with SMTP id
 y204-20020a814bd5000000b002fb827798d8mr4518250ywa.376.1652431874729; Fri, 13
 May 2022 01:51:14 -0700 (PDT)
Date:   Fri, 13 May 2022 16:51:08 +0800
Message-Id: <20220513085108.3567310-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] kunit: tool: Use qemu-system-i386 for i386 runs
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

We're currently using the x86_64 qemu for i386 builds. While this is not
incorrect, it's probably more sensible to use the i386 one, which will
at least fail properly if we accidentally were to build a 64-bit kernel.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/qemu_configs/i386.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/i386.py b/tools/testing/kunit/qemu_configs/i386.py
index 52b80be40e4b..4463ebefd567 100644
--- a/tools/testing/kunit/qemu_configs/i386.py
+++ b/tools/testing/kunit/qemu_configs/i386.py
@@ -4,7 +4,7 @@ QEMU_ARCH = QemuArchParams(linux_arch='i386',
 			   kconfig='''
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y''',
-			   qemu_arch='x86_64',
+			   qemu_arch='i386',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
 			   extra_qemu_params=[])
-- 
2.36.0.550.gb090851708-goog

