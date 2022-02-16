Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6F64B7F87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiBPEhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:37:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiBPEhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:37:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C325EBBAD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:36:51 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id f2-20020a17090a4a8200b001b7dac53bd6so721575pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JgRTlFw8++kyf5ZSG/NEY0qnd4+2DMvg2lXX0xsMQJI=;
        b=VG2vcH/tSu2S3ORYoluC8fi+F9edyN/vKsOjZx3LCLD6vaDPIfMq5ziR5ni6kEZADU
         T92YVumGy29n+opxo8wtrWzxX3ACAo26qUDE0ISQffyaFtl4AO5KkjwNZetm3H9dsOeN
         KfRA1KMhyn6ek9jVfuns3icvtU48qSCBBiqZ+59/539bA2w4O4+fwEjQW/3KTE5Vv61C
         kc73NWY1WxnWU2B51rNCAvpLqt8kbdgmGcmfhLfMBJqUyUVw0VGY/k6CwVkYXLfOd4Ul
         2HolZa0jVrRri93aZs2bnWL3aArfG5NuOY7wBUOkP9xapZgRnmpZYM2qAoWyysMBwoZH
         EGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JgRTlFw8++kyf5ZSG/NEY0qnd4+2DMvg2lXX0xsMQJI=;
        b=zyaagTAINKAg7CHCRtPgnOe8UMTFbP8qfTEIA/hp1ahoIvh0WewsIXVU7+nZIS92Hs
         YjSu+T5ahdt5oPDZmHqEj+42wl1YpP9OtxgIz2Pm/az3JkEZJSG81a4SnF2KDaxIkUcs
         jJblcwtLZPZnkvEjCLvl2g1xSMjoGsxcQbr4NzPB3NsBdQ2TBwVpRyGEF9KxS546T7jJ
         MPPnU0RLS4nilVS+iGHmmIpQ56ThRh757j/ttIWGzsHur/SKuCMGvToK2DX2Me6JQkoY
         FNfGBhD2lUSw/+C19/z45aX9pM71EQmZwKKnL22gggiTKg7Obay95Q7VW+JAZ+PsibC5
         g2wg==
X-Gm-Message-State: AOAM532Z74Bqlw/sN1xKeRC0EmKiOGxO94GnRbX51Kytf9qK32gav/+A
        VU6zKwIWujHZhgUi9knJo4RxslQK3DJC
X-Google-Smtp-Source: ABdhPJz6LOCv+7yHmcbOHyo1VZ93g2kOY12xH4CJ8jvUN6udfQDKwsKCW10DMS1iwib22RM6hx+Sa2W/HBLt
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a62:8c44:0:b0:4c4:8072:e588 with SMTP id
 m65-20020a628c44000000b004c48072e588mr1244438pfd.11.1644986210942; Tue, 15
 Feb 2022 20:36:50 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:34 +0800
Message-Id: <20220216043639.3839185-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v4 0/5] platform/chrome: cros_ec: miscellaneous cleanups
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        pmalani@chromium.org, linux-kernel@vger.kernel.org
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

The 1st patch fixes unhandled undos in error handling path.

The rest of patches cleans drivers/platform/chrome/cros_ec.c.

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220209095703.517608-1-tzungbi@google.com/)
- Drop "platform/chrome: cros_ec: don't initialize `err` in cros_ec_register()".
- Rename the 3rd patch's title.

Changes from v2:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220209045035.380615-1-tzungbi@google.com/)
- Fix review comments in 1st and 2nd patch.

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit messages.
- Use IS_ERR_OR_NULL() in 1st patch.

Tzung-Bi Shih (5):
  platform/chrome: cros_ec: fix error handling in cros_ec_register()
  platform/chrome: cros_ec: remove unused variable `was_wake_device`
  platform/chrome: cros_ec: initialize `wake_enabled` in
    cros_ec_register()
  platform/chrome: cros_ec: sort header inclusion alphabetically
  platform/chrome: cros_ec: append newline to all logs

 drivers/platform/chrome/cros_ec.c           | 35 +++++++++++----------
 include/linux/platform_data/cros_ec_proto.h |  3 --
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog

