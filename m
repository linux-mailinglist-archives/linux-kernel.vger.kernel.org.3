Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD555500FA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383064AbiFQX4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiFQX4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482B53B41
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c13so3581275eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIj4Q0gRsP/qN9h13QLqgVMhBgoL9NgHslA6rsRH+yo=;
        b=bOrLXJjr6zGSJp2lEZK+5dKKWqdz3y2YaTUIII3tHj6GlYeRG/3HUIyJhPUGWSdxcz
         R2emx0w7W47RmLyYCKb/Ma9YF1BMyorM0Aq3s3ts5hAg8OPtXFf2fYWuetVslu/yCsNT
         YgHtRgJwhRn+9VvftUg0Wl2A63ukAKhQWInGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIj4Q0gRsP/qN9h13QLqgVMhBgoL9NgHslA6rsRH+yo=;
        b=CNz3ceT9D+7nejyYgGPinG3E7Yy7AZEyEjhkyxRwmbcbIV0FCG34u1rEWVVfvY/HPg
         OgWwTnirMa3I6bIzbqblAmsu5PD1zMkDFpuH9xDaQH0FNur6RIZmJOJ9Ts27fEw34YRf
         IpH7FbB6BwdsjHk45RsgMEDLBoOqdJpxxi6y6t2phMb50+KQbV+3+GGXu1yEVuUKOPDL
         Bcu7+uYcKoIGRs6g7kX1mZAhxOzcipk1hZghbKEo8Dlzvxk7rmVaDJj2iF8Z9Q9XwnKy
         BOhsV1/q09JHTGGNjzE1aAqya/yCwtN0TXqgVv5sYVSYPD1ButM89KlbcGtT/kZTM+J8
         Pecw==
X-Gm-Message-State: AJIora9xLOEvHyaJQ/YgrqkASzXQFRNB8Ai/4vS3915Bc1WxaikA9JhR
        6q8IEP6ysiRg8lgJnhB+Zchb7WgUGw1W1XUx
X-Google-Smtp-Source: AGRyM1veVfA+htShsJoAzeaZDyoZuFtawNzB6PUPDdJ3dW8aPJaQTO5ghRGsuIJkwVT1Jn/lOTWQPg==
X-Received: by 2002:aa7:dd46:0:b0:435:2a52:3395 with SMTP id o6-20020aa7dd46000000b004352a523395mr15393255edw.252.1655510172017;
        Fri, 17 Jun 2022 16:56:12 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:11 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 0/8] uvcvideo: Fix handling of power_line_frequency
Date:   Sat, 18 Jun 2022 01:56:01 +0200
Message-Id: <20220617235610.321917-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is a new version of "[PATCH v3 0/7] uvcvideo: Fix handling
of power_line_frequency", with an attempt to generalize the
UVC_QUIRK_LIMITED_POWERLINE quirk that it introduced and turn it into a
control mappings override mechanism.

The goal is still to support the UVC 1.5 power line frequency control
extra option (patch 1/7), and work around an issue with devices that do
not implement support for disabling the power line frequency (patches
2/7 to 7/7).

Changelog v8:
- media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
  New patch
- media: uvcvideo: Use standard names for menus
  New patch

Changelog v7:
- Support minimum for V4L2_CTRL_TYPE_MENU
  Fix uvc_query_v4l2_menu

Changelog v6:
- Add support for per-device control mapping overrides
  Fix invalid memory access
- Support minimum for V4L2_CTRL_TYPE_MENU
  New patch
- Limit power line control for Quanta UVC Webcam
  Fix id

Ricardo Ribalda (9):
  media: uvcvideo: Add missing value for power_line_frequency
  media: uvcvideo: Add support for per-device control mapping overrides
  media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
  media: uvcvideo: Use standard names for menus
  media: uvcvideo: Limit power line control for Quanta UVC Webcam
  media: uvcvideo: Limit power line control for Chicony Easycamera
  media: uvcvideo: Limit power line control for Chicony Easycamera
  media: uvcvideo: Limit power line control for Quanta cameras
  media: uvcvideo: Limit power line control for Acer EasyCamera

 drivers/media/usb/uvc/uvc_ctrl.c   | 208 ++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvc_driver.c |  81 +++++++++++
 drivers/media/usb/uvc/uvc_v4l2.c   |  77 ++++++++---
 drivers/media/usb/uvc/uvcvideo.h   |   6 +-
 include/uapi/linux/uvcvideo.h      |   3 +-
 5 files changed, 303 insertions(+), 72 deletions(-)

-- 
2.37.0.rc0.104.g0611611a94-goog

