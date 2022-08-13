Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B60591C59
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiHMSx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHMSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:53:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1670E13F09
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:53:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 202so3378463pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ogTKxn7gTffibaoNZi5K6LKCMlrCzImpFtSY9mf4kPA=;
        b=h9DNdvK3pGgonlcqCpcn9R+2+Tqofh3UlKp4j5hsLumvXUTrqZoHh4JDj7jv0ou+nq
         qMRfz6UD2otLo4GvBSPNsNaiRltSDAKXdVvyglIf3sexzv1ROyZFC98iNnjEpPlk30mw
         jItnzVqwEFUgO5uqPMQrVXA+BPIt8yVFg4xN9jEhP/p1leNetIZkM6X3qkXQ3TjqzkYb
         nzxK1jOBRi/BohWUwS51AoyBbgtDPnFs++p4Oja2CggYLBkTHzv/BS+NxCRL7RcVCIlp
         U9GKAiXHxHf7NYW9bGsthmfsfpvEyS/NJx2kTjRBgZvLoqTvgAka4Dw5v1kEwWHBh+Hq
         VdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ogTKxn7gTffibaoNZi5K6LKCMlrCzImpFtSY9mf4kPA=;
        b=xMecz6ituN4YpijBeZgBNMICrlpIWd6f3kXWMqTJivGnqMVYYykBjt96OrXehFCTCU
         QRO+0rL3wrJqK2cHfpqhlRXBhgwmIJbwfTgfnvfIUyZHQqGlwQxf1/nr5qnZE10FKB8X
         1Z+CK8DcDGqS4t+lR5xN3i1+X6mx8qyYt04pp/vVs/rEEOrWDWnYynHY/ObUHI6Zu3KC
         qpK4OQ8iuURmWfWpWJaqgrubj2o8pDW57gV+pjkLgvT3Ajb0MejGqw2EfkGzOvdV640a
         ObGM20vEtfAvyr4LIx9gdGhqjgq3T90vH0a6vFvleP7Jlueo5RLurEtAiXLHFofolb1p
         Nv2A==
X-Gm-Message-State: ACgBeo2QbjvwbFMn5Kb5V9tbEijmXYCsUOMP423j0RWwZtY0NB8QHQwe
        IKelyALMCkeI5kEmTlZUVQG8aA==
X-Google-Smtp-Source: AA6agR4iT8oUqaaXbfwj70Kf4V2bMH7FXexRAIe7Bf1T6eIQU+EhAts5F20rrZoKor5+UFSTMZeMfA==
X-Received: by 2002:a63:450:0:b0:41e:1bbc:37b6 with SMTP id 77-20020a630450000000b0041e1bbc37b6mr7626541pge.327.1660416834547;
        Sat, 13 Aug 2022 11:53:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:a07f:e6ac::1c])
        by smtp.gmail.com with ESMTPSA id fs1-20020a17090af28100b001f246f2a423sm1972183pjb.17.2022.08.13.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 11:53:54 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net
Subject: [PATCH v3 0/3] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Sat, 13 Aug 2022 11:53:40 -0700
Message-Id: <20220813185343.2306-1-nate@yocom.org>
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
 - The controller has an additional "Layer" button with 4 active states,
   which this change maps to an Axis control with 4 possible values

Patch series adds device to the supported table, adds support for the
Layer button, and adds support for the X-Box button as distinct changes.

Signed-off-by: Nate Yocom <nate@yocom.org>

Nate Yocom (3):
  Input: joystick: xpad: Add X-Box Adaptive Controller support
  Input: joystick: xpad: Add X-Box Adaptive Controller Layer button
  Input: joystick: xpad: Add X-Box Adaptive Controller XBox button

 v2: Fix warning Reported-by: kernel test robot <lkp@intel.com>
 v3: Break into multi-part and remove VID/PID check for XBox button

 drivers/input/joystick/xpad.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


base-commit: 15205c2829ca2cbb5ece5ceaafe1171a8470e62b
-- 
2.30.2

