Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D274E47C537
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbhLURpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbhLURpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:45:08 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8DAC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:45:08 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id x20-20020adfbb54000000b001a0d044e20fso4912967wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VjatereYfnzO4gYzRQESA1sZlZCS8l4dnCDeXkn9csc=;
        b=Utk9fFO5QB7tmjibwK7iCTQLae5b+kxlje+awT2FzfTVN2z/PN3z599ERUHaQnS84B
         ydq+yebLnsPK6f6sb8fIPhj1fz68uCNpWjxS8dKQlcil/+DHyxwEvj3gZg1H0p1RbR5X
         iTK5Q/LB1QInNu1MSLN64rTLlKhQCYNsusLG/dXCdITNe/vwoEDIWeQ8A/l8zG51wMFs
         T7DUxeyWXOhAD9onwFyeq6L9aYUGQul9bSYeYP9Wu1ptcGMpJUgf3S6b3fzsKXnv9iuk
         UJXpYZR9AObOVAj2WuC1/UspT31uGsvsmIQCuJcknKEFmVrQfafAcgKUZx2I9fS3oHRk
         cMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VjatereYfnzO4gYzRQESA1sZlZCS8l4dnCDeXkn9csc=;
        b=aOWyBrfe7ihnyStv/zs6OpJpMVkpYiHZWptF5OtTFH2frYodMXmMpodaabGOD0hyj9
         DTnWF8i1NdpcqbIN3tdfGol5uyCzW1TYo9PnAgCMaf07rR3X8ZGa9S3zFg2Fx0WjkvwA
         qHO5PBhwTJ7E8QiZ8VKN7tlL8jp9F/kHWO6d0dq++b37hVf9GSynOMpg5RVFj28vgr2P
         +0uEbvZKaOoPk2yO5BYXXZVtzOSBVn19evqKqrxz/w5jnxDjv62VgJvRSVL1GZastWBc
         Rjq+g1dVbyBkpx8S8U0bRDPmmuNzUv6rN428uKecPjZgZZ92uUAsqGJfXYkrAYjqZZzG
         K/cQ==
X-Gm-Message-State: AOAM531mIvr8MvQOXoDHDkCns4uO8Ii6m6zJbMapSB2DLOnoymrjtF+2
        TPhoXWRm2WXHnDhVBZjknxF5gBYJJ3iMCg==
X-Google-Smtp-Source: ABdhPJz7dlCVP0QUW3LQw3gvCk/JLSxUewLW62hOI6to+QWBo4GwOb6d+Womi1kdQVtlzFDhsoozV/i+wplu/g==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:4a23:42ad:dc71:62e9])
 (user=dbrazdil job=sendgmr) by 2002:adf:fa81:: with SMTP id
 h1mr3426398wrr.27.1640108706808; Tue, 21 Dec 2021 09:45:06 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:45:00 +0000
Message-Id: <20211221174502.63891-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v5 0/2] Driver for Open Profile for DICE
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
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

The patches are based on top of v5.16-rc6 and can also be found here:
  https://android-kvm.googlesource.com/linux topic/dice_v5

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

 .../reserved-memory/google,open-dice.yaml     |  45 +++++
 drivers/misc/Kconfig                          |  12 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/open-dice.c                      | 188 ++++++++++++++++++
 drivers/of/platform.c                         |   1 +
 5 files changed, 247 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,open-dice.yaml
 create mode 100644 drivers/misc/open-dice.c

--
2.34.1.307.g9b7440fafd-goog
