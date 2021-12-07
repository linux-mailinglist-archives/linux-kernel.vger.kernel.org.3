Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020A846BB6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhLGMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbhLGMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:40:07 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE006C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:36:36 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id x17-20020a5d6511000000b0019838caab88so2907692wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 04:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=x46zOR8LTnf2zn3iy3IJEpl7ojPoSuxdNAclWSV2WCE=;
        b=lrBu1OR3FHdb1i5ChRqi9NtsxN8V/oMMVdxf3dJzsEj2fmyhuCFLyqDx90X0F6LALq
         zRRNQ0+2cKRDOUXdAizVhOpx87dIYKp5yZikcWHj4u8UQVK7yfbmVmIlcL9B81Ez2YUZ
         TzyN7DZOP++GjoBlhczpGzVBUHrVTC1qn9udmbfKgB8pxpn7nKQ1Uqkt9tMl/R+l43qd
         sf/Ja0R52ExvkHg0Wa1CO7wmWTeXzbOzxbonaZBBnAuohQvymUjY0p8rmYkXvyuTYvQc
         VSq/tLSMENXD+x6/zNjtAsZutfN2iIVCCCBuBLqYJN0ePtk9IxUARyc35jcgYhd3IV1X
         Iq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=x46zOR8LTnf2zn3iy3IJEpl7ojPoSuxdNAclWSV2WCE=;
        b=BL2E9EtcZj4SmoCC2HjDoKVSNLGkT/NzW4CjLTgrbU0zpUgTg5lv+NGZCCQf4CrGFv
         4lMIwmtE2m3evs4pqYJ7DMx9Xc8TkYBE3aEWvTSES57d4d8SiOir0uSuO6U/AsZgE0ea
         swWaHd0P+8OzfkZx3hatPOfCAPckorlf5YuGobEXe4mubuQcaTEhP6lg8ygVcqFU50l5
         dIN1gFizwAnaxP2h8jAHVf7k70d+l+yHSOus4H+0QGUH2KQwljWZ5y105mDRI/Av3K6t
         sicrHeP3OV9slDohN3gxjmOZd2GrgU2EpVTabT8BP1VQ7trF5bT21U64C+B1ECQ4WVG6
         YNaQ==
X-Gm-Message-State: AOAM533dEaU3S+vxhTdGds/Tq7bDVUmrt94i5+J8iH7aomL/h75KX/ts
        MJfYKd+Nc5kFVLYogub+BNjPAFOIpr1HMw==
X-Google-Smtp-Source: ABdhPJzsolbRhyKp+pryLDXdETwIA8wD1ZgFomo2XVyem7NhpLO9j3TKznoUscTKM4bpTiRSDYdKWWGujtwDKA==
X-Received: from dbrazdil.lon.corp.google.com ([2a00:79e0:d:209:cb8b:b013:316d:b2f1])
 (user=dbrazdil job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr896548wms.1.1638880594902; Tue, 07 Dec 2021 04:36:34 -0800 (PST)
Date:   Tue,  7 Dec 2021 12:36:15 +0000
Message-Id: <20211207123617.3040177-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 0/2] Driver for Open Profile for DICE
From:   David Brazdil <dbrazdil@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Brazdil <dbrazdil@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open Profile for DICE is a secret derivation protocol used by some
Android devices. The firmware/bootloader generates the secrets and hands
them over to Linux in a reserved memory region.

This patchset adds the corresponding DeviceTree bindings and a driver
that takes ownership of the memory region and exposes it to userspace
via a character device. It is currently under drivers/misc but perhaps
a better location would be drivers/firmware. Let me know what you think.

The patches are based on top of v5.16-rc4 and can also be found here:
  https://android-kvm.googlesource.com/linux topic/dice_v1

David Brazdil (2):
  dt-bindings: firmware: Add Open Profile for DICE
  misc: dice: Add driver to forward secrets to userspace

 .../devicetree/bindings/firmware/dice.yaml    |  51 ++++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/dice.c                           | 254 ++++++++++++++++++
 include/uapi/linux/dice.h                     |  14 +
 6 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/dice.yaml
 create mode 100644 drivers/misc/dice.c
 create mode 100644 include/uapi/linux/dice.h

-- 
2.34.1.400.ga245620fadb-goog

