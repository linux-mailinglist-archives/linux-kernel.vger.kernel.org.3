Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095E45905ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiHKRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiHKRfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:35:50 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C86A48D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q124so15196498iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JTIw/WG05XoLkTadd0S479zZDBDUHfyPokMut/KFehU=;
        b=alQ8YnT9WWSgcXku7dMfT3dg6UwGtfLJJrBfkbYHHdtH6IdFm+qBrggozXkzoKglG9
         ZuCw9d7LNHK9op50Ok0ou6jDsuEZGYRcf5CoBmIOHsgBKtNWRq8UEvprk1E5p63Vw2+P
         1EMYMRyBXyDx/RBDUru86TRR8bZjBFiMbB++zcLbscgWN8Fd/4KCtdQkuBUmj20xlJYO
         FCvYp4Gf8tCUM/Mjpzq+WcpVJI63EQPXH3gI23gR/3uH6ySMFaaIUAsmon8vGGfC1aoI
         sUacH3BvtqRocmKwR55/njf62KOK+syoE4dgZc5bKxsL++Rxn4aOkb0Y3I0KSO3HjK7W
         XVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JTIw/WG05XoLkTadd0S479zZDBDUHfyPokMut/KFehU=;
        b=XqMf1GPcJy7f50i53T0X1nOFd/FV7GdktUCbPHj0msO0FxKC++wEPYgxxkwS9+BNyS
         4/C2dUo8LS6YaQ9dD8dX04f86fiGJTAre0X/YuEHU0l4rJnEZ5Lz1VYpJjke3aD3TM4A
         akxty4+FakZyGVY6s3vgFWew7RQHuYVcad8I/c8oD9g7ZfZMyuG5iPfRFxXSxPGYufaV
         PzK660tgN06HsEreILMP9rfKCOHdHZSP7lwKjLa2ocqWj4UFy8brxnXJ5x8nzRpsWL+8
         5h/B5qRTuLOPBkhQ7tJ5Wk5fTg+4X/AOSvxKveNiA2ypUUwUbyGsnBeOxJ2wycC5cXi0
         +R0w==
X-Gm-Message-State: ACgBeo01QiDg7RpYK2ON5v7w9YmlGoPwNr3DMS7W4h2I5yg/7St8utPa
        jsxLVPTs2E7ZHwtKj9ynfsg0kZoDabU=
X-Google-Smtp-Source: AA6agR4y0bh9mNUVmNm7jyBkJQNAmemYLnqSnEmfW4vmFCYlMLkqzQEC9tOCCelybRoc6oJE2DP3qg==
X-Received: by 2002:a6b:f214:0:b0:684:4af0:8b40 with SMTP id q20-20020a6bf214000000b006844af08b40mr159423ioh.104.1660239347569;
        Thu, 11 Aug 2022 10:35:47 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 00/11] DYNAMIC_DEBUG for this cycle
Date:   Thu, 11 Aug 2022 11:35:30 -0600
Message-Id: <20220811173541.2901122-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Hi Greg, Jason,

Please consider these for this rc-cycle.
  - 1-9 have Jason's Ack,
  - 9th removes unused EXPORTed fn.
  - 10 is simple var cleanup
  - 11 is a partial decoupling of dyndbg from kernel/module

Jim Cromie (11):
  dyndbg: fix static_branch manipulation
  dyndbg: fix module.dyndbg handling
  dyndbg: show both old and new in change-info
  dyndbg: reverse module walk in cat control
  dyndbg: reverse module.callsite walk in cat control
  dyndbg: use ESCAPE_SPACE for cat control
  dyndbg: let query-modname override actual module name
  dyndbg: add test_dynamic_debug module
  dyndbg: drop EXPORTed dynamic_debug_exec_queries
  dyndbg: cleanup auto vars in dynamic_debug_init
  dyndbg: create and use struct _ddebug_info

 MAINTAINERS                   |   2 +
 include/linux/dynamic_debug.h |  22 ++----
 kernel/module/internal.h      |   4 +-
 kernel/module/main.c          |  18 ++---
 lib/Kconfig.debug             |  10 +++
 lib/Makefile                  |   1 +
 lib/dynamic_debug.c           | 141 +++++++++++++++++-----------------
 lib/test_dynamic_debug.c      |  70 +++++++++++++++++
 8 files changed, 172 insertions(+), 96 deletions(-)
 create mode 100644 lib/test_dynamic_debug.c

-- 
2.37.1

