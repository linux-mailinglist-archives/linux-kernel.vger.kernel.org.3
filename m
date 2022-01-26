Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E7349D5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiAZXMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiAZXMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:12:51 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B7C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:12:51 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so518298wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=afub0EKWar+O2rT5NV08msMQ7IULuTGawHMp/Eu85tE=;
        b=hsahS5MWP6ZfA+JAyGe1bUPWod8iHigb6InikUwozT7PtWvIgun8vHXH/GgrP0O/x+
         UR0R7g9TQY3Xfpi0LdobYKyggOLAtnz4h6WAGX0eLtgOCehrLp1gfN/VAsJP8D9zNdWB
         G4LtUfz19VvgCVb1FuQ5px90e4l8JIirmyXEjviHq1QA5VQ7I5NqPgjuJTWJdh9nfKgX
         UtBcNQTKRTsYr7hEbb6gHpUPqO3PH7U7yUEr6ES04nfut1vpKs+/Qcf+7ZbLAa3Pa3UJ
         EmVGSSkAeFveLnnlpWUrugqHy7F2sooKa6j/ojMJlG7JFRkl3hFHGs+C9KGGKN2+Hb1N
         1H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=afub0EKWar+O2rT5NV08msMQ7IULuTGawHMp/Eu85tE=;
        b=b3VcIrbd/5KCyIqrNlRGCSG+oK5iGzWJnFSCvzcKVGqz/HkYZAWkxbB/90OqVmPwkE
         YosJ81lrBl4sLhjKVyDNOMZsFNuXCWM4A8Lzl5wd3pyFJkRsXp3OQm7YIg1H7ad76VGc
         avQocU3ph51QrlFJMZ9tk6m04GyqXPY74a/xQGQjSY9yk9V1ETtfwH6A3YxtBlB2CWVM
         S7bM3UxWIuIAof56gEgwvWsUV4Nbnkbv2GE3yUNeKUxLb3LrNZiUzqvBu7vwtwSl35GZ
         3tdnHFKf7FbIUwGUYoirGSI7qmRgRr/zuVEd2PnLyfNqSQd0Ni/Xu0OyYhJwMPnHumGU
         sVvw==
X-Gm-Message-State: AOAM533Jc6T8IahYlDpuLEB45D3kkdRB6BOlRcRFL0W6yzIBzD4Wgp1N
        lSMF+RUBLVyJwTTdQohBqO2kRXsnJdRalA==
X-Google-Smtp-Source: ABdhPJxnDtZBiuCtftlONEZOLUnkhNFDLji1bJlcK6soxOnHkC5B6Jr3BIEr6nv3uwlBp08PWvPuOp+kgZqyqA==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:bd2e:4d3b:b065:fa46])
 (user=dbrazdil job=sendgmr) by 2002:a05:600c:68b:: with SMTP id
 a11mr451590wmn.1.1643238769937; Wed, 26 Jan 2022 15:12:49 -0800 (PST)
Date:   Wed, 26 Jan 2022 23:12:35 +0000
Message-Id: <20220126231237.529308-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 0/2] Driver for Open Profile for DICE
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

The patches are based on top of v5.17-rc1 and can also be found here:
  https://android-kvm.googlesource.com/linux topic/dice_v7

Changes since v6:
  * replace spinlock with mutex because devm_memremap can sleep
  * prevent write+shared mapping via mprotect/mremap
  * fail gracefully when no instances found
  * no-map required in DT bindings to ensure mem region not treated as RAM

Changes since v5:
  * replaced 'additionalProperties' with 'unevaluatedProperties' in DT YAML

Changes since v4:
  * registered compatible in 'reserved_mem_matches'
  * removed unnecessary DT node, only reserved-memory
  * fixed typos in comments

Changes since v3:
  * align with semantics of read/write
  * fix kerneldoc warnings
  * fix printf format warnings

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
  dt-bindings: reserved-memory: Open Profile for DICE
  misc: open-dice: Add driver to expose DICE data to userspace

 .../reserved-memory/google,open-dice.yaml     |  46 ++++
 drivers/misc/Kconfig                          |  12 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/open-dice.c                      | 208 ++++++++++++++++++
 drivers/of/platform.c                         |   1 +
 5 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
 create mode 100644 drivers/misc/open-dice.c

--
2.35.0.rc0.227.g00780c9af4-goog
