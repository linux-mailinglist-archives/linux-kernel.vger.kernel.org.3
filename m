Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC852F2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352708AbiETSeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbiETSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD65FF06;
        Fri, 20 May 2022 11:34:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so12575953wrg.12;
        Fri, 20 May 2022 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bvgb2lQC/lXU1/Ce5R2fdk8VVqr9ldd55Cmvb2FG04=;
        b=Tnva1bxMWOKs2UqctZ678Ff8MWwyt7pQaseYZ2MDJ+3GyUDgF5viImh1detkoBd1B6
         YKxC2awW4A830XVPDuHwTJzGCWo5E0WuetPzvkDotXPqQoIQQ2R01ix3CfOo5IJRIBqP
         XSSHC7PvHXaXIlGLSs5ynFI6qWX6T6z4PULIstgeURmE66hXexdQ5grYvSjjTtrIRuOC
         vr0vjR/KZ9jN8yNIsgbWc2iC9BuqA9A1DTbdNpTw1mlifrqOOYzwn5qLjnwf+vOVSzEB
         KIA4LEsDxpaKCsAi1DrvxKEuxCWB9S2GpwicMCBI8uO+RxCEbwhA/o/Gic7TRjNO0lLn
         ELIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Bvgb2lQC/lXU1/Ce5R2fdk8VVqr9ldd55Cmvb2FG04=;
        b=YDRJafk1kipNmVZul7qw7uvFARymDtoa2U53yjfB/WZAkwTlOBt5OVEngO99VRwyVN
         kuUuSIT5BSg7+D5kq9M2XR49qOXJ3KII5/AwsNeCT8ttUNZ7YYC1xgMY3Egse2uswxxT
         jluIvRqt+zsheema38J3bJ4Sj4TtdtTI+QJZym6B5ew/KpSxtovNDk+yACRnM1uAjZxP
         1moSjgtFQdXpYZSCBNmqp4QJEBxSzODn4tcr5fc/tty+fusP9bR0j84VxcTn5sFCR+Sk
         i75oT3c2W0pBqL79CQd73VNSz9G7ZXwHF2/JyHz0Uop9UOYpqFhFUk3ecEyLbMBeeZe5
         rYvQ==
X-Gm-Message-State: AOAM5303IbthLmJKhwyYCLuQmUBdFtYN19m919MC0GNqIv5IDybyGN/6
        S3cGZ7sSqLbhDE6upkBZ190=
X-Google-Smtp-Source: ABdhPJzBFOybRHQwepl7PhKKrktyPRT15xK3/W3FnElF3Q2IZ9Mk0too/QOoL1RiYQkCDtTGxdHPOw==
X-Received: by 2002:a5d:68cf:0:b0:20c:ff58:37b with SMTP id p15-20020a5d68cf000000b0020cff58037bmr9412390wrw.448.1653071680604;
        Fri, 20 May 2022 11:34:40 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:40 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] platform/surface: aggregator: Add support for client hot-removal
Date:   Fri, 20 May 2022 20:34:12 +0200
Message-Id: <20220520183422.7185-1-luzmaximilian@gmail.com>
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

This series adds support for the type cover of the Surface Pro 8. On the
Pro 8, the type cover is (unlike on previous generations) handled via
the Surface System Aggregator Module (SSAM). As the type cover is
detachable, care needs to be taken and the respective SSAM (HID) client
devices need to be properly removed when detached and re-initialized
when attached.

Therefore, this series does three things:

 1. Improve hot-removal support for SSAM client devices. When
    hot-removing clients, subsequent communication may time out.

    In the worst case, this can lead to problems when devices are
    detached and re-attached quickly, before we can remove their
    respective kernel representations. This can then lead to devices
    being in an uninitialized state, preventing, for example, touchpad
    gestures from working properly as the required HID feature report
    has not been sent.

    Therefore, handle hot-removal of devices more gracefully by avoiding
    communication once it has been detected and ensure that devices are
    actually removed.
 
 2. Generify SSAM subsystem hubs and add a KIP hub. On the Surface Pro
    8, the KIP subsystem (only that abbreviation is known) is
    responsible for managing type-cover devices. This hub acts as the
    controller for device removal similar to the BAS (detachable base)
    subsystem hub on the Surface Book 3 (therefore we can share most of
    the code between them).

 3. Add the (HID) type-cover clients of the Surface Pro 8 to the
    aggregator registry.

Regards,
Max


Maximilian Luz (10):
  platform/surface: aggregator: Allow devices to be marked as
    hot-removed
  platform/surface: aggregator: Allow notifiers to avoid communication
    on unregistering
  platform/surface: aggregator_registry: Use client device wrappers for
    notifier registration
  power/supply: surface_charger: Use client device wrappers for notifier
    registration
  power/supply: surface_battery: Use client device wrappers for notifier
    registration
  HID: surface-hid: Add support for hot-removal
  platform/surface: aggregator: Add comment for KIP subsystem category
  platform/surface: aggregator_registry: Generify subsystem hub
    functionality
  platform/surface: aggregator_registry: Add KIP device hub
  platform/surface: aggregator_registry: Add support for keyboard cover
    on Surface Pro 8

 .../driver-api/surface_aggregator/client.rst  |   6 +-
 drivers/hid/surface-hid/surface_hid_core.c    |  38 +-
 .../platform/surface/aggregator/controller.c  |  53 ++-
 .../surface/surface_aggregator_registry.c     | 401 +++++++++++++-----
 drivers/power/supply/surface_battery.c        |   4 +-
 drivers/power/supply/surface_charger.c        |   4 +-
 include/linux/surface_aggregator/controller.h |  24 +-
 include/linux/surface_aggregator/device.h     | 114 ++++-
 include/linux/surface_aggregator/serial_hub.h |   2 +-
 9 files changed, 501 insertions(+), 145 deletions(-)

-- 
2.36.1

