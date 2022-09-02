Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017295AB965
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIBUW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIBUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:22:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5A0E831B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:22:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k126-20020a253d84000000b0068bb342010dso2496720yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=xnNw4h+1x9dq83s26Tf8lbiVviNPYGfPgO8xDA3lW/E=;
        b=VSaLzp60A14BKXWQYAdgyEjHfY4ivtSD6ZEgT0b2sa84cJxGrpDGFqGz7/iGxGnnGQ
         47Bb2ESB41X7MAWf1HKZ1V9cfjsUrSfGlJyHiKBLN1A9YezRM5cL4h72h+7e4UyFulC8
         POAN8XEYV5S1KUoVACIkLvl2mj5eNUqZldND7sbVukol4zPKxEWgkwe33sPp8PsfBTE/
         gcT/O2MS+ucQFIYjB6P6jJXm1wXlclyTnft0m9Z2s/x+bZLdeeV542RcBzSRhuVlYasD
         a6i9D7E02rK7OCQwuLeRoR1TNVb4FTcRfFfGqol1L4WM72dNHN0xFYyZQYWF0YUgvMkd
         +Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xnNw4h+1x9dq83s26Tf8lbiVviNPYGfPgO8xDA3lW/E=;
        b=6x9nTqWNL1PE7kfraeP3KV9JpPkxLJef8XHmgocl/dS3MfWnowYu80Sa+i06zB7LwT
         UGRnwusX6oCNepZ4z8T487ID+evD8SjtQ4FQjaM+Fp35wdYQqSHLeN6MilpZt8+z0hBX
         /e5URWNbTZumibUH9LzWwTI++VwqZrNJaklZNlkU66QSheV/l1zlE5h3zf9qXk2FS1O+
         diDD/OD1CRpvmXbe4n20XS/57OIV2T9FSl3maLOFOuLiVTu9nINwYjY3BuUwYIE+o5SN
         T4KTyfvpnfRHIa2sIQSWCkjwDsLwm0hxefmnRHN+gAoQme6RZP4c/7Gjn6b8D4PYXNNB
         MC1Q==
X-Gm-Message-State: ACgBeo0H9rp/6XGv2mktpcAfWl0jVfOurRrWhxW12ZpmeYwnhJG+yoW1
        b8weHIUgbNZQ7kUtoEy8RIPqlSKDcAMGcA==
X-Google-Smtp-Source: AA6agR7nAgRUZZ2MM2xcqgZTkzRymuhvkX6NhL2UE3dS+8RjK8OK2N1J8zQJCNwYI31qsKZ8fR46uizHOxTxZg==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a81:4b86:0:b0:341:98fa:33b8 with SMTP id
 y128-20020a814b86000000b0034198fa33b8mr16783641ywa.77.1662150172230; Fri, 02
 Sep 2022 13:22:52 -0700 (PDT)
Date:   Fri,  2 Sep 2022 13:22:47 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902202248.3061262-1-dlatypov@google.com>
Subject: [PATCH 1/2] kunit: tool: remove UML specific options from all_tests_uml.config
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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

Commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
made it so we enable these options by default for UML.
Specifying them here is now redundant.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/configs/all_tests_uml.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
index bdee36bef4a3..f990cbb73250 100644
--- a/tools/testing/kunit/configs/all_tests_uml.config
+++ b/tools/testing/kunit/configs/all_tests_uml.config
@@ -16,8 +16,6 @@ CONFIG_EXT4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 
-CONFIG_VIRTIO_UML=y
-CONFIG_UML_PCI_OVER_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_USB4=y
 

base-commit: 0b3acd1cc0222953035d18176b1e4aa06624fd6e
-- 
2.37.2.789.g6183377224-goog

