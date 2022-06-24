Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB055A32D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiFXU6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiFXU6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:58:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36D31A3BB;
        Fri, 24 Jun 2022 13:58:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t5so7115678eje.1;
        Fri, 24 Jun 2022 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIgY3FeoHMf+aDlAZ/zhoODzy0zddGpMaimt54u9oe0=;
        b=cB6/aNC07c5ZUrnCKh6xVfURtO23mkpV1NWKPLkDa0FncdfL9QMGLTdG+szuj+f+04
         6n10dcl14mMvmJwBuVGsTHS45SsA9JLiVQuiQ9z54LCYf67P2MVBV4wYpH1r9BTJR1yY
         oiXuyzP9zi09Jqr9yNzxTDmOkJwkq9UU0Zu8EDW7NWF5Eg42Pjaizgo4vj7biykQsUfB
         5OaJr98VDUCGKp1777Bqk1a6V/ppakGoCG8FZZ29c1kaDACSyuXhY5DR0QCUfZEbqtCh
         o7fwEdBHMeYN9JZ7mwEaVJbJXFZABEcTopAWCKOCwoZ2yri/oHvo52S3hSHFa6iBUdx/
         DPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIgY3FeoHMf+aDlAZ/zhoODzy0zddGpMaimt54u9oe0=;
        b=Imogtfjt42jyLC3hlGLAddjTtMleWRaZtgGvYxJUwjYgDQMfOxFUCfXwXX3iM9s9wS
         0xz8Fn+zvc6oUPW9s5mrHFZz0kmrhUAmsK76e9G4Kx/AFhBl/IHpbkkyzLpeqj0Seta2
         31M2F3yeSE+rmVlt2lo2f2NXJKPP355yPnIl6427fbBnYEkjqg20rChGpVTylO79Hb7r
         1YYzrvGYDIv0ppdfbRfLstdRir9p50rQqDqjOZi8qfLwsLgmJrNEojer4BsmgcqyZqcV
         AsxAbCNz0nhSCDXATffMKxD2HmAUvt+JHj7o2zpGCD4IxSpd9Czwsf+1+qE9nMNSI9JP
         EOEA==
X-Gm-Message-State: AJIora8uJ10H4sDoja45ZSTrg5PDm92frzncwC2O9KRe9JwnL8OickNs
        gYBx54QXWoJECT3u/T5oA44=
X-Google-Smtp-Source: AGRyM1u4d0aMsBv1S7Cj8ckLuj7VBJ2ysil1FL+0quRgD3bxm62sVZK50zb6x1o1KXIZQosmgAUpIQ==
X-Received: by 2002:a17:906:14d:b0:711:ff36:b1af with SMTP id 13-20020a170906014d00b00711ff36b1afmr928612ejh.422.1656104287800;
        Fri, 24 Jun 2022 13:58:07 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709061e4500b006feb6dee4absm1672666ejj.137.2022.06.24.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:58:07 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/3] platform/surface: Move Surface Aggregator client hubs to their own modules
Date:   Fri, 24 Jun 2022 22:57:57 +0200
Message-Id: <20220624205800.1355621-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
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

This series moves the Surface Aggregator client device hubs from the
Surface Aggregator registry to their own modules. While, at the moment,
client device hubs are exclusively instantiated by the registry platform
hub driver, this will change in the future. In particular, with the
introduction of DT/OF support, which is required for the Surface Pro X.
Therefore, this series also slightly restructures the functions used for
software-node-based device instantiation, essentially acting as
preparation for that.

In addition, this series follows-up "platform/surface: aggregator: Add
support for client hot-removal" and further removes some code
duplication by consolidating more parts of the hub drivers. While at it,
also ensure proper handling of firmware node lifetimes and update the
copyright year of various files.

Maximilian Luz (3):
  platform/surface: aggregator: Move device registry helper functions to
    core module
  platform/surface: aggregator: Move subsystem hub drivers to their own
    module
  platform/surface: Update copyright year of various drivers

 MAINTAINERS                                   |   6 +
 drivers/platform/surface/Kconfig              |  35 +-
 drivers/platform/surface/Makefile             |   1 +
 drivers/platform/surface/aggregator/Kconfig   |   2 +-
 drivers/platform/surface/aggregator/Makefile  |   2 +-
 drivers/platform/surface/aggregator/bus.c     | 151 +++++-
 drivers/platform/surface/aggregator/bus.h     |   2 +-
 .../platform/surface/aggregator/controller.c  |   2 +-
 .../platform/surface/aggregator/controller.h  |   2 +-
 drivers/platform/surface/aggregator/core.c    |   2 +-
 .../platform/surface/aggregator/ssh_msgb.h    |   2 +-
 .../surface/aggregator/ssh_packet_layer.c     |   2 +-
 .../surface/aggregator/ssh_packet_layer.h     |   2 +-
 .../platform/surface/aggregator/ssh_parser.c  |   2 +-
 .../platform/surface/aggregator/ssh_parser.h  |   2 +-
 .../surface/aggregator/ssh_request_layer.c    |   2 +-
 .../surface/aggregator/ssh_request_layer.h    |   2 +-
 drivers/platform/surface/aggregator/trace.h   |   2 +-
 .../platform/surface/surface_acpi_notify.c    |   2 +-
 .../surface/surface_aggregator_cdev.c         |   2 +-
 .../platform/surface/surface_aggregator_hub.c | 371 +++++++++++++++
 .../surface/surface_aggregator_registry.c     | 446 +-----------------
 drivers/platform/surface/surface_dtx.c        |   2 +-
 drivers/platform/surface/surface_gpe.c        |   2 +-
 drivers/platform/surface/surface_hotplug.c    |   2 +-
 .../surface/surface_platform_profile.c        |   2 +-
 include/linux/surface_aggregator/device.h     |  52 ++
 27 files changed, 618 insertions(+), 484 deletions(-)
 create mode 100644 drivers/platform/surface/surface_aggregator_hub.c

-- 
2.36.1

