Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4DE5B24F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiIHRlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiIHRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:40:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3810F6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:39:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso3082185pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rU5trKe3Yoy2Ehis4NGQlVoaD7BHhUK/1S8Lg+uYpCo=;
        b=TGRoxee7ib22Hu/bEhSHvSDvJVsO5n0bOkdRVANYV3o29bn+BOe5CM798GhVk4wcho
         4+rd0dTJ5zhfYqmXNgw047iHF1tA2ZZCc3PSoA/5KW9+DM5zvtbGmgyi4SxiA0OfONH2
         3kg2I38HZWHdwY0JFwZcor+HuiYF2gIYXwmVcPKWgGW098UehwcVQMrNxxivQBo2Fp9P
         O/7XJf5e1fsSjDXdaKaSp9cYt3Qqt8c4Fwhgv/6Kzwwf7py2XIGugghgC/xUcFM0NUTB
         Q2xCH+DOQNChuHvPTy/EN7xrvzAR8HlMcfiwqw61QZ+vh3rlu6QhMT/XpiH96+lHDZXA
         MaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rU5trKe3Yoy2Ehis4NGQlVoaD7BHhUK/1S8Lg+uYpCo=;
        b=Nx8FC5r0W7WvzLZUXcEbhKV233WwX//0UNF+/9YOxPXNzC3KMhWXHVFke9Kp1+f28g
         SzNHb1DV2YtCn/C+HRmUrFEjW94OpErCw8r/c77HLe9QLF961mBakdmwZh0yQkpCYzcg
         UNTz+4hZ2XOn/KEVGWbh89WpQv4KdUwvJeDxcIyNtB6PhqjLPH1WdYA7F3iE4CrotnWI
         /3l6gI2bZAUzTH0Lc7319dwQHKSBG9e5b3QV7DS004zBMzcntc1GFkczZf77DVhDtROK
         MBHgWT1sP473tMJQnf77bfdTykyYKkZ/Ukn/khNM0JFstEh3gprb3EZdAuHcZdNW7P3T
         xsjQ==
X-Gm-Message-State: ACgBeo3fq+ou+3LYJFwoIsi+lN/mewwgZBOYW5ebXrauO3xcj2p+jsQX
        JtjD2nS5uGfDEeTlCXePbnxveA==
X-Google-Smtp-Source: AA6agR4UXvmZTkIPHXdo3TexkqBBdQT9rCCVFrsBsPlZp+rXOZ56j1lHaj2cWA+P2vg76kn7b78m1w==
X-Received: by 2002:a17:90a:74c5:b0:200:2d89:ef13 with SMTP id p5-20020a17090a74c500b002002d89ef13mr5295554pjl.81.1662658773528;
        Thu, 08 Sep 2022 10:39:33 -0700 (PDT)
Received: from ghaven-kernel.yocom.org.beta.tailscale.net ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id x76-20020a62864f000000b0052d4b0d0c74sm15166767pfd.70.2022.09.08.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:39:33 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        benjamin.tissoires@redhat.com
Subject: [PATCH v6 0/5] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Thu,  8 Sep 2022 10:39:25 -0700
Message-Id: <20220908173930.28940-1-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the X-Box Adaptive Controller, which is protocol
compatible with the XTYPE_XBOXONE support in the driver with two deltas:

 - The X-Box button sets 0x02 as its activation ID, where others set
   0x01
 - The controller has an additional Profile button with 4 active states,
   which this change maps to an Axis control with 4 possible values

Patch series adds device to the supported table, adds support for the
Profile button, and adds support for the X-Box button as distinct
changes.

Signed-off-by: Nate Yocom <nate@yocom.org>

Nate Yocom (5):
  Input: joystick: xpad: Add X-Box Adaptive support
  Input: joystick: xpad: Add X-Box Adaptive XBox button
  Input: joystick: xpad: Add ABS_PROFILE to uapi
  Input: joystick: xpad: Add ABS_PROFILE to Docs
  Input: joystick: xpad: Add X-Box Adaptive Profile button

 v2: Fix warning Reported-by: kernel test robot <lkp@intel.com>
 v3: Break into multi-part and remove VID/PID check for XBox button
 v4: Rename Layer -> Profile as suggested by Bastien Nocera
 v5: Add new ABS_PROFILE axis to uapi and use it for the profile button
 v6: Add ABS_PROFILE to absolutes array and docs as requested by Dmitry

 Documentation/input/event-codes.rst    |  6 ++++++
 Documentation/input/gamepad.rst        |  6 ++++++
 drivers/hid/hid-debug.c                |  3 ++-
 drivers/input/joystick/xpad.c          | 15 ++++++++++++++-
 include/uapi/linux/input-event-codes.h |  1 +
 5 files changed, 29 insertions(+), 2 deletions(-)


base-commit: 26b1224903b3fb66e8aa564868d0d57648c32b15
-- 
2.30.2

