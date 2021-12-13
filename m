Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D498473566
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbhLMT6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbhLMT6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:58:39 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB59C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:58:38 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso14956836edt.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=udaKVaiMgUS12kFr9msWra26CoDr7HydSsff/jVCEA8=;
        b=cCkegL7xdBlYOrXrpsJvD3x/wwOLT8/KCoEFGlV5YjOoOcJXDP+pyahia4y5Zr93Bs
         nEp9DD4NQ6pzZhGn/uXATEi14JGqh4wO1KJyU0NRusimI1G077wvD01qiTeX/C76R3JT
         4zFJvs2/ty+l4bvrJXy4L4GzqC0qxh5U4KfojQy1xrEgYn8YMS/LOIR4D5VfatVJgDOu
         BQAksxnRKVddshJ+BLgppBZegu4YifOMxerTkY2ddlOrJQFdL2osQEqDJ2BgO6YQupND
         poI5R3WNRWo/8xC/Xl4SgL6LdyuGL7mkVgd2rOwlo8VSk8wL3Uo/8FKaKpnp6Fr8HJGJ
         OX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=udaKVaiMgUS12kFr9msWra26CoDr7HydSsff/jVCEA8=;
        b=hCH1p2tOkeiVbSAUxAl1EdJwoZuPYyRaVZOp7ok9Un7/Ml9uPO2AsgOBfxu/Rupgs5
         e3bUKM5nEQ/y935lGLolJvw8oaUOOLenszeipeEFiOiG1cB1XvLzgCzvD7LmEOS8gjhZ
         UPD4nMnOf9tUufcep9+5PKCLqc24VloMeK/a4GFJJyvJdg80djj4zMUbGuOTuBBsrrA+
         kJpyhWawTf2L+NscKLz2r+e/rPIB+h+AolaA+poDOL4aORKIf00mdhgccSucZwK6N+sr
         Vj5H5CYIJwXziHH6bQjbwVg2I/b18qWnzIZ3W/7qQpq3e+5T0FPOvfPSgDI5CdseO8mo
         YOvQ==
X-Gm-Message-State: AOAM530Lh9csi6df5lQMPMpPgIQdaUDGYy1jkSEytcX3f0Zs7FcZtf7g
        vyZ3suEc7D1X7PQ/Z7tTKZPiD0L/tRs/ew==
X-Google-Smtp-Source: ABdhPJx2xxRPbwTb61GuOX1MaGlWRA74KF441oqpKfnTeSymc3P+1m4i/8e/XKZ/eCS3994S+IEGe4orQCJO9g==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:3e63:6f60:9fab:4549])
 (user=dbrazdil job=sendgmr) by 2002:a17:907:3e22:: with SMTP id
 hp34mr465308ejc.491.1639425517186; Mon, 13 Dec 2021 11:58:37 -0800 (PST)
Date:   Mon, 13 Dec 2021 19:58:31 +0000
Message-Id: <20211213195833.772892-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 0/2] Driver for Open Profile for DICE
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open Profile for DICE is an open protocol for measured boot compatible
with the Trusted Computing Group's Device Identifier Composition
Engine (DICE) specification. The generated Compound Device Identifier
(CDI) certificates represent the measured hardware/software combination
and can be used by userspace for remote attestation and sealing.

This patchset adds DeviceTree bindings for the DICE device referencing
a reserved memory region containing the CDIs, and a driver that exposes
the memory region to userspace via a misc device.

See https://pigweed.googlesource.com/open-dice for more details.

The patches are based on top of v5.16-rc5 and can also be found here:
  https://android-kvm.googlesource.com/linux topic/dice_v3

Changes since v2:
  * renamed from 'dice' to 'open-dice'
  * replaced ioctls with read/write
  * replaced memzero_explicit with memset
  * allowed multiple instances
  * expanded Kconfig description

Changes since v1:
  * converted to miscdevice
  * all mappings now write-combine to simplify semantics
  * removed atomic state, any attempt at exclusive access
  * simplified wipe, applied on ioctl, not on release
  * fixed ioctl return value

David Brazdil (2):
  dt-bindings: firmware: Add Open Profile for DICE
  misc: open-dice: Add driver to expose DICE data to userspace

 .../bindings/firmware/google,open-dice.yaml   |  51 +++++
 drivers/misc/Kconfig                          |  12 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/open-dice.c                      | 197 ++++++++++++++++++
 4 files changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/google,open-dice.yaml
 create mode 100644 drivers/misc/open-dice.c

--
2.34.1.173.g76aa8bc2d0-goog
